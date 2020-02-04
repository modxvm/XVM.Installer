import BigWorld
from account_helpers.settings_core.options import InterfaceScaleSetting
from Avatar import PlayerAvatar
from AvatarInputHandler.AimingSystems.ArcadeAimingSystem import ArcadeAimingSystem
from AvatarInputHandler.AimingSystems.SniperAimingSystem import SniperAimingSystem
from AvatarInputHandler.AimingSystems.StrategicAimingSystem import StrategicAimingSystem

from xfw.events import registerEvent
import xvm_battle.python.battle as battle
from xfw_actionscript.python import *
from xvm_main.python.logger import *

ARCADE_MODE = 'arc'
SNIPER_MODE = 'sn'
STRATEGIC_MODE = 'str'
SHIFT = 0.0775


aimMode = ARCADE_MODE
y = 0.0


@registerEvent(ArcadeAimingSystem, 'enable')
def ArcadeAimingSystem_enable(self, targetPos, turretYaw=None, gunPitch=None):
    if battle.isBattleTypeSupported:
        global y, aimMode
        y = - BigWorld.screenHeight() * SHIFT
        aimMode = ARCADE_MODE
        as_event('ON_AIM_MODE')


@registerEvent(SniperAimingSystem, 'enable')
def SniperAimingSystem_enable(self, targetPos, playerGunMatFunction):
    if battle.isBattleTypeSupported:
        global y, aimMode
        y = 0.0
        aimMode = SNIPER_MODE
        as_event('ON_AIM_MODE')


@registerEvent(StrategicAimingSystem, 'enable')
def StrategicAimingSystem_enable(self, targetPos):
    if battle.isBattleTypeSupported:
        global y, aimMode
        y = 0.0
        aimMode = STRATEGIC_MODE
        as_event('ON_AIM_MODE')


@registerEvent(InterfaceScaleSetting, 'setSystemValue')
def InterfaceScaleSetting_setSystemValue(self, value):
    if battle.isBattleTypeSupported:
        global y
        y = - BigWorld.screenHeight() * SHIFT if aimMode == ARCADE_MODE else 0.0
        as_event('ON_AIM_MODE')


@registerEvent(PlayerAvatar, 'onEnterWorld')
def Vehicle_onEnterWorld(self, prereqs):
    global y, aimMode
    if battle.isBattleTypeSupported:
        y = - BigWorld.screenHeight() * SHIFT
        aimMode = ARCADE_MODE
        as_event('ON_AIM_MODE')


@xvm.export('aim.mode', deterministic=False)
def aim_mode(arc=ARCADE_MODE, sn=SNIPER_MODE, strat=STRATEGIC_MODE):
    if aimMode == ARCADE_MODE:
        return arc
    elif aimMode == SNIPER_MODE:
        return sn
    elif aimMode == STRATEGIC_MODE:
        return strat


@xvm.export('aim.y', deterministic=False)
def aim_y(shift=0.0):
    return int(y + shift)
