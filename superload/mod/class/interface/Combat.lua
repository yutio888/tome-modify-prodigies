require "engine.class"
local _M = loadPrevious(...)

local baseGetDammod = _M.getDammod
function _M:getDammod(combat)
    local dammod = baseGetDammod(self, combat)
    if self.T_ARCANE_MIGHT_TEST and self:knowTalent(self.T_ARCANE_MIGHT_TEST) then
        local all = 0
            all = all + (dammod['str'] or 0)
            all = all + (dammod['dex'] or 0)
            all = all + (dammod['con'] or 0)
            all = all + (dammod['mag'] or 0)
            all = all + (dammod['wil'] or 0)
            all = all + (dammod['cun'] or 0)
        return {mag = all}
    end
    return dammod
end

local baseAPR = _M.combatAPR
function _M:combatAPR(weapon)
	local apr = baseAPR(self, weapon)
	if self.T_ARCANE_MIGHT_TEST and self:knowTalent(self.T_ARCANE_MIGHT_TEST) then
	    return apr + self:combatSpellpower()
	else return apr
	end
end

return _M