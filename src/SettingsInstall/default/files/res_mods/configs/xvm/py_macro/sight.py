import traceback

import BattleReplay
import BigWorld
import gui.Scaleform.daapi.view.battle.shared.crosshair.plugins as plug
import math
from Avatar import PlayerAvatar
from AvatarInputHandler.AimingSystems import CollisionStrategy, getCappedShotTargetInfos
from Math import Vector3, Vector2
from Vehicle import Vehicle
from VehicleGunRotator import VehicleGunRotator
from gui.Scaleform.daapi.view.battle.classic.stats_exchange import FragsCollectableStats
from gui.Scaleform.daapi.view.meta.CrosshairPanelContainerMeta import CrosshairPanelContainerMeta
from gui.Scaleform.genConsts.CROSSHAIR_CONSTANTS import CROSSHAIR_CONSTANTS
from gui.battle_control.battle_constants import CROSSHAIR_VIEW_ID
from gui.battle_control.controllers.consumables.ammo_ctrl import AmmoReplayPlayer

import xvm_battle.python.battle as battle
import xvm_main.python.config as config
from xfw import *
from xfw_actionscript.python import *
from xvm_main.python.logger import *


VEHICLE_CLASSES = {'mediumTank': 'MT', 'lightTank': 'LT', 'heavyTank': 'HT', 'AT-SPG': 'TD', 'SPG': 'SPG'}

currentDistance = None
vehicle = None
player = None
camera = None
timeFlight = None
timeAIM = None
sphere = None
_explosionRadius = None
isDisplaySphere = False
isDownHotkey = True
cameraHeight = None
isAlive = False


def explosionRadius():
    global _explosionRadius
    if vehicle is None or not hasattr(vehicle, 'typeDescriptor'):
        return
    _type = vehicle.typeDescriptor.shot.shell.type
    _explosionRadius = _type.explosionRadius if hasattr(_type, 'explosionRadius') else None


@registerEvent(plug.AmmoPlugin, '_AmmoPlugin__onGunAutoReloadTimeSet')
def _AmmoPlugin__onGunAutoReloadTimeSet(self, state, stunned):
    if config.get('sight/enabled', True) and battle.isBattleTypeSupported:
        explosionRadius()


@registerEvent(AmmoReplayPlayer, 'setGunReloadTime')
def AmmoReplayPlayer_setGunReloadTime(self, timeLeft, baseTime):
    if config.get('sight/enabled', True) and battle.isBattleTypeSupported:
        explosionRadius()


@registerEvent(CrosshairPanelContainerMeta, 'as_setReloadingS')
def CrosshairPanelContainerMeta_as_setReloadingS(self, duration, baseTime, startTime, isReloading):
    if config.get('sight/enabled', True) and battle.isBattleTypeSupported:
        explosionRadius()


@registerEvent(FragsCollectableStats, 'addVehicleStatusUpdate')
def FragsCollectableStats_addVehicleStatusUpdate(self, vInfoVO):
    if config.get('sight/enabled', True) and battle.isBattleTypeSupported:
        if (not vInfoVO.isAlive()) and (vehicle is not None) and (vehicle.id == vInfoVO.vehicleID):
            global currentDistance, timeFlight, timeAIM, cameraHeight, isAlive
            global _explosionRadius, isDisplaySphere, isDownHotkey
            _explosionRadius = None
            currentDistance = None
            timeFlight = None
            timeAIM = None
            isDisplaySphere = False
            isDownHotkey = False
            cameraHeight = None
            isAlive = False
            as_event('ON_MARKER_POSITION')


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


@registerEvent(plug.SiegeModePlugin, '_SiegeModePlugin__updateView')
def SiegeModePlugin__updateView(self):
    if config.get('sight/enabled', True):
        vStateCtrl = self.sessionProvider.shared.vehicleState
        vehicle = vStateCtrl.getControllingVehicle()
        if vehicle is not None:
            vTypeDescr = vehicle.typeDescriptor
            if vTypeDescr.isWheeledVehicle or vTypeDescr.hasAutoSiegeMode:
                self._parentObj.as_setNetVisibleS(CROSSHAIR_CONSTANTS.VISIBLE_NET)
    return


@overrideMethod(CrosshairPanelContainerMeta, 'as_setViewS')
def CrosshairPanelContainerMeta_as_setViewS(base, self, viewId, settingId):
    isHide = viewId == CROSSHAIR_VIEW_ID.POSTMORTEM and config.get('sight/hideSightAfterDeath', False) and config.get('sight/enabled', True)
    return base(self, viewId, settingId) if not isHide else base(self, -1, -1)


@overrideMethod(plug, '_makeSettingsVO')
def plugins_makeSettingsVO(base, settingsCore, *keys):
    data = base(settingsCore, *keys)
    if config.get('sight/enabled', True) and battle.isBattleTypeSupported:
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
        global vehicle, currentDistance, timeFlight, timeAIM, cameraHeight, camera
        global _explosionRadius, isDisplaySphere, isDownHotkey, player, isAlive
        _explosionRadius = None
        currentDistance = None
        timeFlight = None
        timeAIM = None
        cameraHeight = None
        player = BigWorld.player()
        camera = BigWorld.camera()
        # isNotEvent = player.arenaGuiType not in [ARENA_GUI_TYPE.EPIC_BATTLE, ARENA_GUI_TYPE.EVENT_BATTLES]
        # isNotEvent = True
        if battle.isBattleTypeSupported:
            isAlive = self.isAlive
            vehicle = self
            td = self.typeDescriptor
            _type = td.type
            vehClass = VEHICLE_CLASSES[list(_type.tags.intersection(VEHICLE_CLASSES.keys()))[0]]
            isDisplaySphere = config.get('sight/sphereDispersion/enabled', False) and (vehClass in config.get('sight/sphereDispersion/vtype', ['SPG']))
            isDownHotkey = not config.get('sight/sphereDispersion/hotkey/enabled', False)


@registerEvent(Vehicle, 'onHealthChanged')
def onHealthChanged(self, newHealth, attackerID, attackReasonID):
    if self.isPlayerVehicle and config.get('sight/enabled', True) and battle.isBattleTypeSupported:
        isAlive = self.isAlive()
        if (not isAlive) and (sphere in BigWorld.models()):
            BigWorld.delModel(sphere)


def update_sphere(position):
    global sphere
    if sphere is None:
        sphere = BigWorld.Model('objects/misc/bbox/sphere1.model')
    elif sphere in BigWorld.models():
        BigWorld.delModel(sphere)
    if (_explosionRadius is not None) and isAlive and isDownHotkey:
        sphere.position = position
        sphere.scale = Vector3(_explosionRadius, _explosionRadius, _explosionRadius)
        BigWorld.addModel(sphere)


@overrideMethod(VehicleGunRotator, '_VehicleGunRotator__getGunMarkerPosition')
def _VehicleGunRotator__getGunMarkerPosition(base, self, shotPos, shotVec, dispersionAngles):
    if not (config.get('sight/enabled', True) and battle.isBattleTypeSupported):
        return base(self, shotPos, shotVec, dispersionAngles)
    try:
        global timeFlight, currentDistance, timeAIM, cameraHeight
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
        aimingStartTime, aimingFactor, shotDispMultiplierFactor, _1, _2, _3, aimingTime = player._PlayerAvatar__aimingInfo
        # aimingStartTime = aimingInfo[0]
        # aimingFactor = aimingInfo[1]
        # shotDispMultiplierFactor = aimingInfo[2]
        # unShotDispersionFactorsTurretRotation = aimingInfo[3]
        # chassisShotDispersionFactorsMovement = aimingInfo[4]
        # chassisShotDispersionFactorsRotation = aimingInfo[5]
        # aimingTime = aimingInfo[6]
        aimingTimeAll = math.log(aimingFactor / shotDispMultiplierFactor) * aimingTime
        aimingFinishTime = aimingTimeAll + aimingStartTime
        timeAIM = max(0.0, aimingFinishTime - BigWorld.time())
        cameraHeight = camera.position.y - endPos.y
        currentDistance = distance
        as_event('ON_MARKER_POSITION')
        if isDisplaySphere:
            update_sphere(endPos)

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


@xvm.export('sight.timeAIM', deterministic=False)
def sight_timeAIM():
    return timeAIM


@xvm.export('sight.cameraHeight', deterministic=False)
def sight_cameraHeight():
    return cameraHeight
