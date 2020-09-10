local Talents = require "engine.interface.ActorTalents"

local _M = loadPrevious(...)
local rush = Talents.talents_def['T_RUSH']

if rush then
    local baseGetEnergy = rush.getEnergy
    rush.getEnergy = function(self, t)
        local energy = 1
        if baseGetEnergy then
            energy = baseGetEnergy(self, t)
        end
        if self.T_STEAMROLLER and self:knowTalent(self.T_STEAMROLLER) then return energy / 4 end
        return energy
    end
end

return _M