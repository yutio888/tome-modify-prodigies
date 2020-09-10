local Talents = require "engine.interface.ActorTalents"

local _M = loadPrevious(...)
local sun = Talents.talents_def['T_IRRESISTIBLE_SUN']
if sun then
    sun.cooldown = 16
end

local rush = Talents.talents_def['T_STEAMROLLER']
if rush then
    rush.info = function(self, t)
        return ([[When you rush, the creature you rush to is marked. If you kill it in the next 2 turns then your rush cooldown is reset.
		Each time you rush, you gain a stacking +20%% damage buff for 2 turns, up to 100%%.
		Rush now takes 25%% time to use, and only costs 2 stamina.]]):tformat()
    end
end

return _M