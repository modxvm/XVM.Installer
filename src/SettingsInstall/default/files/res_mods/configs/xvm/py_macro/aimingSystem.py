import BigWorld
from Avatar import PlayerAvatar
from AvatarInputHandler.AimingSystems.ArcadeAimingSystem import ArcadeAimingSystem
from AvatarInputHandler.AimingSystems.SniperAimingSystem import SniperAimingSystem
from AvatarInputHandler.AimingSystems.StrategicAimingSystem import StrategicAimingSystem
from AvatarInputHandler.commands.siege_mode_control import SiegeModeControl
from account_helpers.settings_core.options import InterfaceScaleSetting

from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config
from xfw_actionscript.python import *


cameraMode = None
siegeMode = None
y = 0.0


@registerEvent(ArcadeAimingSystem, 'enable')
def ArcadeAimingSystem_enable(self, targetPos, turretYaw=None, gunPitch=None):
    if config.get('sight/enabled', True):
        global y, cameraMode
        y = - BigWorld.screenHeight() * 0.0775
        cameraMode = 'arc'
        as_event('ON_CAMERA_MODE')


@registerEvent(SniperAimingSystem, 'enable')
def SniperAimingSystem_enable(self, targetPos, playerGunMatFunction):
    if config.get('sight/enabled', True):
        global y, cameraMode
        y = 0.0
        cameraMode = 'sn'
        as_event('ON_CAMERA_MODE')


@registerEvent(StrategicAimingSystem, 'enable')
def StrategicAimingSystem_enable(self, targetPos):
    if config.get('sight/enabled', True):
        global y, cameraMode
        y = 0.0
        cameraMode = 'str'
        as_event('ON_CAMERA_MODE')


@registerEvent(SiegeModeControl, 'notifySiegeModeChanged')
def SiegeModeControl_notifySiegeModeChanged(self, vehicle, newState, timeToNextMode):
    if config.get('sight/enabled', True):
        global siegeMode
        if not vehicle.isPlayerVehicle:
            return
        prev_siegeMode = siegeMode
        siegeMode = 'siege' if newState == 2 else None
        if prev_siegeMode != siegeMode:
            as_event('ON_CAMERA_MODE')


@registerEvent(InterfaceScaleSetting, 'setSystemValue')
def InterfaceScaleSetting_setSystemValue(self, value):
    if config.get('sight/enabled', True):
        global y
        y = - BigWorld.screenHeight() * 0.0775 if cameraMode == 'arc' else 0.0
        as_event('ON_CAMERA_MODE')


@registerEvent(PlayerAvatar, 'onEnterWorld')
def Vehicle_onEnterWorld(self, prereqs):
    global y, cameraMode, siegeMode
    if config.get('sight/enabled', True):
        y = - BigWorld.screenHeight() * 0.0775
        cameraMode = 'arc'
        siegeMode = None
        as_event('ON_CAMERA_MODE')


@xvm.export('sight.siegeMode', deterministic=False)
def sight_siegeMode():
    return siegeMode


@xvm.export('sight.cameraMode', deterministic=False)
def sight_cameraMode():
    return cameraMode


@xvm.export('sight.sight_y', deterministic=False)
def sight_sight_y(shift=0):
    return int(y + shift)
