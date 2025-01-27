import BigWorld
from Avatar import PlayerAvatar
from constants import ARENA_PERIOD
from gui.Scaleform.daapi.view.battle.shared.indicators import SixthSenseIndicator

from xfw.events import registerEvent
from xfw_actionscript.python import *
from xvm_main.python.logger import *

timer = -1
timerBegin = 0


def currentTime():
    global timer
    timer -= 1
    if timer >= 0:
        BigWorld.callback(1, currentTime)
    as_event('ON_SIXTH_SENSE_SHOW')


@registerEvent(SixthSenseIndicator, '_SixthSenseIndicator__show')
def show(self):
    global timer
    timer = timerBegin
    BigWorld.callback(1, currentTime)
    as_event('ON_SIXTH_SENSE_SHOW')


@registerEvent(PlayerAvatar, '_PlayerAvatar__onArenaPeriodChange')
def __onArenaPeriodChange(self, period, periodEndTime, periodLength, periodAdditionalInfo):
    global timer
    if period == ARENA_PERIOD.AFTERBATTLE:
        timer = -1


@registerEvent(PlayerAvatar, '_PlayerAvatar__destroyGUI')
def destroyGUI(self):
    global timer
    timer = -1


@xvm.export('xvm.sixthSenseTimer', deterministic=False)
def xvm_sixthSenseTimer(tb=10):
    global timerBegin
    timerBegin = tb
    return timer if timer >= 0 else None

