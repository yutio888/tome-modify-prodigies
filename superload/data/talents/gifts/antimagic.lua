local Talents = require "engine.interface.ActorTalents"

local _M = loadPrevious(...)
local am = Talents.talents_def['T_ANTIMAGIC_SHIELD']

if am then
    local base_no_energy = am.no_energy
    am.no_energy = function(self, t)
        return base_no_energy and base_no_energy(self, t) or self.T_ANTIMAGIC_AURA and self:knowTalent(self.T_ANTIMAGIC_AURA)
    end
end

return _M