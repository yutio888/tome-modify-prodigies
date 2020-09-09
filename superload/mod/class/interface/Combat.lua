require "engine.class"
local _M = loadPrevious(...)

local baseGetDammod = _M.getDammod
function _M:getDammod(combat)
    local dammod = baseGetDammod(self, combat)
    if self.T_ARCANE_MIGHT and self:knowTalent(self.T_ARCANE_MIGHT) then
        local all = 0
            all = all + (dammod['str'] or 0)
            all = all + (dammod['dex'] or 0)
            all = all + (dammod['con'] or 0)
            all = all + (dammod['mag'] or 0) - 0.5
            all = all + (dammod['wil'] or 0)
            all = all + (dammod['cun'] or 0)
        return {mag = all}
    end
    return dammod
end

local baseCrit = _M.combatCrit
function _M:combatCrit(weapon)
    local crit = baseCrit(self, weapon)
    if self.T_ARCANE_MIGHT and self:knowTalent(self.T_ARCANE_MIGHT) then
        crit = crit - 0.25 * self.combat_spellcrit
    end
    return math.max(crit, 0)
end

function _M:combatPhysicalpower(mod, weapon, add)
    mod = mod or 1
    local d = self:combatPhysicalpowerRaw(weapon, add)
    return self:rescaleCombatStats(d) * mod
end

local baseAPR = _M.combatAPR
function _M:combatAPR(weapon)
	local apr = baseAPR(self, weapon)
	if self.T_ARCANE_MIGHT and self:knowTalent(self.T_ARCANE_MIGHT) then
	    return apr + self:getMag()
	else return apr
	end
end

return _M