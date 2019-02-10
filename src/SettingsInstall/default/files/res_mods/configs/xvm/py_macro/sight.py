import traceback
import BigWorld
import Math
import math
import ProjectileMover
import BattleReplay
from projectile_trajectory import computeProjectileTrajectory
from constants import SERVER_TICK_LENGTH, SHELL_TRAJECTORY_EPSILON_CLIENT, ARENA_GUI_TYPE
from Vehicle import Vehicle
from Avatar import PlayerAvatar
from gui.Scaleform.daapi.view.meta.CrosshairPanelContainerMeta import CrosshairPanelContainerMeta
from VehicleGunRotator import VehicleGunRotator
from ClientArena import CollisionResult
from gui.battle_control.controllers.consumables.ammo_ctrl import AmmoReplayPlayer
import gui.Scaleform.daapi.view.battle.shared.crosshair.plugins as plug
from gui.Scaleform.daapi.view.battle.shared.crosshair.plugins import AmmoPlugin
from gui.Scaleform.daapi.view.battle.classic.stats_exchange import FragsCollectableStats
from gui.battle_control.battle_constants import CROSSHAIR_VIEW_ID

from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config
from xvm import utils
from xfw_actionscript.python import *


VEHICLE_CLASSES = {'mediumTank': 'MT', 'lightTank': 'LT', 'heavyTank': 'HT', 'AT-SPG': 'TD', 'SPG': 'SPG'}


currentDistance = None
vehicle = None
player = None
timeFlight = None
timeAIM = None
sphere = None
_explosionRadius = None
isDisplaySphere = False
isDownHotkey = True
shellType = None
cameraHeight = None
isAlive = False

isNotEvent = False


def explosionRadius():
    global _explosionRadius
    if vehicle is None or not hasattr(vehicle, 'typeDescriptor'):
        return
    _type = vehicle.typeDescriptor.shot.shell.type
    _explosionRadius = _type.explosionRadius if hasattr(_type, 'explosionRadius') else None


@registerEvent(AmmoPlugin, '_AmmoPlugin__onGunAutoReloadTimeSet')
def _AmmoPlugin__onGunAutoReloadTimeSet(self, state, stunned):
    if config.get('sight/enabled', True) and isNotEvent:
        explosionRadius()


@registerEvent(AmmoReplayPlayer, 'setGunReloadTime')
def AmmoReplayPlayer_setGunReloadTime(self, timeLeft, baseTime):
    if config.get('sight/enabled', True) and isNotEvent:
        explosionRadius()


@registerEvent(CrosshairPanelContainerMeta, 'as_setReloadingS')
def CrosshairPanelContainerMeta_as_setReloadingS(self, duration, baseTime, startTime, isReloading):
    if config.get('sight/enabled', True) and isNotEvent:
        explosionRadius()


@registerEvent(FragsCollectableStats, 'addVehicleStatusUpdate')
def FragsCollectableStats_addVehicleStatusUpdate(self, vInfoVO):
    if config.get('sight/enabled', True) and isNotEvent:
        if (not vInfoVO.isAlive()) and (vehicle is not None) and (vehicle.id == vInfoVO.vehicleID):
            setValueDead()


@registerEvent(PlayerAvatar, 'handleKey')
def handleKey(self, isDown, key, mods):
    if config.get('sight/enabled', True):# and isNotEvent:
        global isDownHotkey
        hotkey = config.get('sight/sphereDispersion/hotkey', None)
        if hotkey is not None and hotkey['enabled'] and (key == hotkey['keyCode']):
            if isDown:
                if hotkey['onHold']:
                    if not isDownHotkey:
                        isDownHotkey = True
                else:
                    isDownHotkey = not isDownHotkey
            else:
                if hotkey['onHold']:
                    if isDownHotkey:
                        isDownHotkey = False


@overrideMethod(CrosshairPanelContainerMeta, 'as_setDistanceS')
def CrosshairPanelContainerMeta_as_setDistanceS(base, self, dist):
    if not (config.get('sight/enabled', True) and config.get('sight/removeDistance', False)):
        return base(self, dist)


@overrideMethod(CrosshairPanelContainerMeta, 'as_setNetVisibleS')
def CrosshairPanelContainerMeta_as_setNetVisibleS(base, self, mask):
    if config.get('sight/enabled', True):
        if config.get('sight/removeIndicator', False):
            mask &= 2
        if config.get('sight/removeQuantityShells', False):
            mask &= 1
    return base(self, mask)


@overrideMethod(CrosshairPanelContainerMeta, 'as_setViewS')
# @overrideMethodInBattle
def CrosshairPanelContainerMeta_as_setViewS(base, self, viewId, settingId):
    return base(self, viewId, settingId) if viewId != CROSSHAIR_VIEW_ID.POSTMORTEM or not config.get('sight/hideSightAfterDeath', False) else base(self, -1, -1)
@overrideMethod(plug, '_makeSettingsVO')
def plugins_makeSettingsVO(base, settingsCore, *keys):
    data = base(settingsCore, *keys)
    if config.get('sight/enabled', True) and isNotEvent:
        for mode in data:
            if config.get('sight/removeCentralMarker', False) and ('centerAlphaValue' in data[mode]):
                data[mode]['centerAlphaValue'] = 0
            if config.get('sight/removeIndicator', False) and config.get('sight/removeQuantityShells', False) and ('netAlphaValue' in data[mode]):
                data[mode]['netAlphaValue'] = 0
            if config.get('sight/removeLoad', False) and ('reloaderAlphaValue' in data[mode]):
                data[mode]['reloaderAlphaValue'] = 0
            if config.get('sight/removeCondition', False) and ('conditionAlphaValue' in data[mode]):
                data[mode]['conditionAlphaValue'] = 0
            if config.get('sight/removeContainers', False) and ('cassetteAlphaValue' in data[mode]):
                data[mode]['cassetteAlphaValue'] = 0
            if config.get('sight/removeLoadingTimer', False) and ('reloaderTimerAlphaValue' in data[mode]):
                data[mode]['reloaderTimerAlphaValue'] = 0
            if config.get('sight/removeZoomIndicator', False) and ('zoomIndicatorAlphaValue' in data[mode]):
                data[mode]['zoomIndicatorAlphaValue'] = 0
    return data


@registerEvent(PlayerAvatar, 'onBecomePlayer')
def PlayerAvatar_onBecomePlayer(self):
    global player
    player = BigWorld.player()


@registerEvent(Vehicle, 'onEnterWorld')
def Vehicle_onEnterWorld(self, prereqs):
    if self.isPlayerVehicle and config.get('sight/enabled', True):
        global isNotEvent, vehicle, currentDistance, timeFlight, timeAIM, cameraHeight
        global _explosionRadius, isDisplaySphere, isDownHotkey, player, isAlive
        _explosionRadius = None
        currentDistance = None
        timeFlight = None
        timeAIM = None
        cameraHeight = None
        player = BigWorld.player()
        isNotEvent = player.arenaGuiType not in [ARENA_GUI_TYPE.EPIC_BATTLE, ARENA_GUI_TYPE.EVENT_BATTLES]
        # isNotEvent = True
        if isNotEvent:
            isAlive = self.isAlive and self.isCrewActive
            vehicle = self
            td = self.typeDescriptor
            _type = td.type
            vehClass = VEHICLE_CLASSES[list(_type.tags.intersection(VEHICLE_CLASSES.keys()))[0]]
            isDisplaySphere = config.get('sight/sphereDispersion/enabled', False) and (vehClass in config.get('sight/sphereDispersion/vtype', ['SPG']))
            isDownHotkey = not config.get('sight/sphereDispersion/hotkey/enabled', False)


def setValueDead():
    global currentDistance, timeFlight, timeAIM
    global _explosionRadius, isDisplaySphere, isDownHotkey
    global cameraHeight, isAlive
    _explosionRadius = None
    currentDistance = None
    timeFlight = None
    timeAIM = None
    isDisplaySphere = False
    isDownHotkey = False
    cameraHeight = None
    isAlive = False
    as_event('ON_MARKER_POSITION')


@registerEvent(Vehicle, 'onHealthChanged')
def onHealthChanged(self, newHealth, attackerID, attackReasonID):
    if self.isPlayerVehicle and config.get('sight/enabled', True) and isNotEvent:
        isAlive = (newHealth > 0) and bool(vehicle.isCrewActive)
        if (not isAlive) and (sphere in BigWorld.models()):
            BigWorld.delModel(sphere)


def update_sphere(position):
    global sphere
    if sphere is None:
        sphere = BigWorld.Model('objects/misc/bbox/sphere1.model')
        # log('sphere = %s' % (filter(lambda x: not x.startswith('__'), dir(sphere))))
        # sphere = BigWorld.Model('content/Interface/Arrow/normal/lod0/arrow.model')
    elif sphere in BigWorld.models():
        BigWorld.delModel(sphere)
    if (_explosionRadius is not None) and isAlive and isDownHotkey:
        sphere.position = position
        sphere.scale = Math.Vector3(_explosionRadius, _explosionRadius, _explosionRadius)
        BigWorld.addModel(sphere)


@overrideMethod(VehicleGunRotator, '_VehicleGunRotator__getGunMarkerPosition')
def _VehicleGunRotator__getGunMarkerPosition(base, self, shotPos, shotVec, dispersionAngles):
    if not (config.get('sight/enabled', True) and isNotEvent):
        return base(self, shotPos, shotVec, dispersionAngles)
    try:
        global timeFlight, currentDistance, timeAIM, cameraHeight
        shotDescr = self._VehicleGunRotator__avatar.getVehicleDescriptor().shot
        gravity = Math.Vector3(0.0, -shotDescr.gravity, 0.0)
        maxDist = shotDescr.maxDistance
        testVehicleID = self.getAttachedVehicleID()
        collideVehiclesAndStaticScene = ProjectileMover.collideDynamicAndStatic
        collideWithSpaceBB = self._VehicleGunRotator__avatar.arena.collideWithSpaceBB
        prevPos = shotPos
        endPos = shotPos
        direction = endPos - prevPos
        prevVelocity = shotVec
        dt = 0.0
        maxDistCheckFlag = False
        while True:
            dt += SERVER_TICK_LENGTH
            checkPoints = computeProjectileTrajectory(prevPos, prevVelocity, gravity, SERVER_TICK_LENGTH, SHELL_TRAJECTORY_EPSILON_CLIENT)
            prevCheckPoint = prevPos
            bBreak = False
            for curCheckPoint in checkPoints:
                testRes = collideVehiclesAndStaticScene(prevCheckPoint, curCheckPoint, (testVehicleID,))
                if testRes is not None:
                    collData = testRes[1]
                    if collData is not None and not collData.isVehicle():
                        collData = None
                    direction = testRes[0] - prevCheckPoint
                    endPos = testRes[0]
                    timeFlight = dt if (curCheckPoint - prevCheckPoint).length < direction.length * 2 else dt - SERVER_TICK_LENGTH
                    bBreak = True
                    break
                collisionResult, intersection = collideWithSpaceBB(prevCheckPoint, curCheckPoint)
                if collisionResult is CollisionResult.INTERSECTION:
                    collData = None
                    maxDistCheckFlag = True
                    direction = intersection - prevCheckPoint
                    timeFlight = dt if (curCheckPoint - prevCheckPoint).length < direction.length * 2 else dt - SERVER_TICK_LENGTH
                    endPos = intersection
                    bBreak = True
                    break
                elif collisionResult is CollisionResult.OUTSIDE:
                    collData = None
                    maxDistCheckFlag = True
                    direction = prevVelocity
                    endPos = prevPos + prevVelocity
                    bBreak = True
                prevCheckPoint = curCheckPoint

            if bBreak:
                break
            prevPos = shotPos + shotVec.scale(dt) + gravity.scale(dt * dt * 0.5)
            prevVelocity = shotVec + gravity.scale(dt)

        direction.normalise()
        cameraHeight = BigWorld.camera().position.y - endPos.y
        distance = (endPos - shotPos).length
        markerDiameter = 2.0 * distance * dispersionAngles[0]
        idealMarkerDiameter = 2.0 * distance * dispersionAngles[1]
        if maxDistCheckFlag:
            if endPos.distTo(shotPos) >= maxDist:
                direction = endPos - shotPos
                direction.normalise()
                endPos = shotPos + direction.scale(maxDist)
                distance = maxDist
                markerDiameter = 2.0 * distance * dispersionAngles[0]
                idealMarkerDiameter = 2.0 * distance * dispersionAngles[1]
        replayCtrl = BattleReplay.g_replayCtrl
        if replayCtrl.isPlaying and replayCtrl.isClientReady:
            markerDiameter, endPos, direction = replayCtrl.getGunMarkerParams(endPos, direction)
        currentDistance = distance
        aimingInfo = player._PlayerAvatar__aimingInfo
        aimingStartTime = aimingInfo[0]
        aimingFactor = aimingInfo[1]
        shotDispMultiplierFactor = aimingInfo[2]
        # unShotDispersionFactorsTurretRotation = aimingInfo[3]
        # chassisShotDispersionFactorsMovement = aimingInfo[4]
        # chassisShotDispersionFactorsRotation = aimingInfo[5]
        # chassisShotDispersionFactorsRotation = aimingInfo[5]
        aimingTime = aimingInfo[6]
        aimingTimeAll = math.log(aimingFactor / shotDispMultiplierFactor) * aimingTime
        aimingFinishTime = aimingTimeAll + aimingStartTime
        timeAIM = max(0.0, aimingFinishTime - BigWorld.time())
        as_event('ON_MARKER_POSITION')
        if isDisplaySphere:
            update_sphere(endPos)
        return endPos, direction, markerDiameter, idealMarkerDiameter, collData
    except Exception as ex:
        err(traceback.format_exc())
        return base(self, shotPos, shotVec, dispersionAngles)


@xvm.export('sight.distance', deterministic=False)
def sight_distance():
    return currentDistance


@xvm.export('sight.timeFlight', deterministic=False)
def sight_timeFlight():
    return timeFlight


@xvm.export('sight.timeAIM', deterministic=False)
def sight_timeAIM():
    return timeAIM


@xvm.export('sight.cameraHeight', deterministic=False)
def sight_cameraHeight():
    return cameraHeight


@xvm.export('sight.dynamic_colorRGB')
def smooth_transition_colorRGB(color_100, color_0, percent=None, maximum=100):
    if percent is None:
        return None
    else:
        return utils.smooth_transition_color('RGB', color_100, color_0, percent, maximum)


@xvm.export('sight.dynamic_colorRBG')
def smooth_transition_colorRBG(color_100, color_0, percent=None, maximum=100):
    if percent is None:
        return None
    else:
        return utils.smooth_transition_color('RBG', color_100, color_0, percent, maximum)


@xvm.export('sight.dynamic_colorGRB')
def smooth_transition_colorGRB(color_100, color_0, percent=None, maximum=100):
    if percent is None:
        return None
    else:
        return utils.smooth_transition_color('GRB', color_100, color_0, percent, maximum)


@xvm.export('sight.dynamic_colorGBR')
def smooth_transition_colorGBR(color_100, color_0, percent=None, maximum=100):
    if percent is None:
        return None
    else:
        return utils.smooth_transition_color('GBR', color_100, color_0, percent, maximum)


@xvm.export('sight.dynamic_colorBRG')
def smooth_transition_colorBRG(color_100, color_0, percent=None, maximum=100):
    if percent is None:
        return None
    else:
        return utils.smooth_transition_color('BRG', color_100, color_0, percent, maximum)


@xvm.export('sight.dynamic_colorBGR')
def smooth_transition_colorBGR(color_100, color_0, percent=None, maximum=100):
    if percent is None:
        return None
    else:
        return utils.smooth_transition_color('BGR', color_100, color_0, percent, maximum)
