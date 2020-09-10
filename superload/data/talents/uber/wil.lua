local Talents = require "engine.interface.ActorTalents"

local _M = loadPrevious(...)
local tyranny = Talents.talents_def['T_MENTAL_TYRANNY']
if tyranny then
    tyranny.cooldown = nil
    tyranny.mode = 'passive'
    tyranny.activate = nil
    tyranny.deactivate = nil
    tyranny.info = function(self, t)
        return ([[Transcend the physical and rule over all with an iron will!
        Your mind attack cannot be resisted by mental save any more.
        Any foe who fails to resist your mind attack will suffer 20%% more damage, and may get brainlocked for 2 turns if it is a critical strike.
        ]]):tformat()
    end
end

return _M