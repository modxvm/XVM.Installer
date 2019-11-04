import traceback

import BattleReplay
import BigWorld
from Avatar import PlayerAvatar
from AvatarInputHandler.AimingSystems import CollisionStrategy, getCappedShotTargetInfos
from Math import Vector3, Vector2
from Vehicle import Vehicle
from VehicleGunRotator import VehicleGunRotator
from gui.Scaleform.daapi.view.battle.classic.stats_exchange import FragsCollectableStats

import xvm_battle.python.battle as battle
import xvm_main.python.config as config
from xfw import *
from xfw_actionscript.python import *
from xvm_main.python.logger import *

currentDistance = None
vehicle = None
player = None
camera = None
timeFlight = None
timeAIM = None
cameraHeight = None


@registerEvent(FragsCollectableStats, 'addVehicleStatusUpdate')
def FragsCollectableStats_addVehicleStatusUpdate(self, vInfoVO):
    if config.get('sight/enabled', True) and battle.isBattleTypeSupported:
        if (not vInfoVO.isAlive()) and (vehicle is not None) and (vehicle.id == vInfoVO.vehicleID):
            global currentDistance, timeFlight, cameraHeight
            currentDistance = None
            timeFlight = None
            cameraHeight = None
            as_event('ON_MARKER_POSITION')


@registerEvent(PlayerAvatar, 'onBecomePlayer')
def PlayerAvatar_onBecomePlayer(self):
    global player, camera
    player = BigWorld.player()
    camera = BigWorld.camera()


@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def sight_destroyGUI(self):
    global player, camera
    player = None
    camera = None


@registerEvent(Vehicle, 'onEnterWorld')
def Vehicle_onEnterWorld(self, prereqs):
    if self.isPlayerVehicle and config.get('sight/enabled', True):
        global vehicle, currentDistance, timeFlight, cameraHeight, camera, player
        currentDistance = None
        timeFlight = None
        cameraHeight = None
        player = BigWorld.player()
        camera = BigWorld.camera()
        if battle.isBattleTypeSupported:
            vehicle = self


@overrideMethod(VehicleGunRotator, '_VehicleGunRotator__getGunMarkerPosition')
def _VehicleGunRotator__getGunMarkerPosition(base, self, shotPos, shotVec, dispersionAngles):
    if not (config.get('sight/enabled', True) and battle.isBattleTypeSupported):
        return base(self, shotPos, shotVec, dispersionAngles)
    try:
        global timeFlight, currentDistance, cameraHeight
        prevTimeFlight, prevCurrentDistance, prevCameraHeight = timeFlight, currentDistance, cameraHeight
        shotDescr = player.getVehicleDescriptor().shot
        gravity = Vector3(0.0, -shotDescr.gravity, 0.0)
        testVehicleID = self.getAttachedVehicleID()
        collisionStrategy = CollisionStrategy.COLLIDE_DYNAMIC_AND_STATIC
        minBounds, maxBounds = player.arena.getSpaceBB()
        endPos, direction, collData, usedMaxDistance = getCappedShotTargetInfos(shotPos, shotVec, gravity, shotDescr, testVehicleID, minBounds, maxBounds, collisionStrategy)
        distance = shotDescr.maxDistance if usedMaxDistance else (endPos - shotPos).length
        dispersAngle, idealDispersAngle = dispersionAngles
        doubleDistance = distance + distance
        markerDiameter = doubleDistance * dispersAngle
        idealMarkerDiameter = doubleDistance * idealDispersAngle
        replayCtrl = BattleReplay.g_replayCtrl
        if replayCtrl.isPlaying and replayCtrl.isClientReady:
            markerDiameter, endPos, direction = replayCtrl.getGunMarkerParams(endPos, direction)

        shotVecXZ = Vector2(shotVec.x, shotVec.z)
        delta = Vector2(endPos.x - shotPos.x, endPos.z - shotPos.z)
        timeFlight = delta.length / shotVecXZ.length
        cameraHeight = camera.position.y - endPos.y
        currentDistance = distance
        try:
            update = not (-0.01 < (prevTimeFlight - timeFlight) < 0.01)
            update = update or not (-0.01 < (prevCurrentDistance - currentDistance) < 0.01)
            update = update or not (-0.01 < (prevCameraHeight - cameraHeight) < 0.01)
        except Exception:
            update = True
        if update:
            as_event('ON_MARKER_POSITION')

    except Exception as ex:
        err(traceback.format_exc())
        return base(self, shotPos, shotVec, dispersionAngles)
    return endPos, direction, markerDiameter, idealMarkerDiameter, collData


@xvm.export('sight.distance', deterministic=False)
def sight_distance():
    return currentDistance


@xvm.export('sight.timeFlight', deterministic=False)
def sight_timeFlight():
    return timeFlight


@xvm.export('sight.cameraHeight', deterministic=False)
def sight_cameraHeight():
    return cameraHeight
