local Talents = require "engine.interface.ActorTalents"

local _M = loadPrevious(...)
local sun = Talents.talents_def['T_IRRESISTIBLE_SUN']
if sun then
    sun.cooldown = 12
end