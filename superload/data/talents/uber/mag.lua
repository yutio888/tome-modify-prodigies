local Talents = require "engine.interface.ActorTalents"

local _M = loadPrevious(...)
local am = Talents.talents_def['T_ARCANE_MIGHT']
if am then
    am.getIncrease = function(self, t) return 25 end
    am.passives = function(self, t, tmptable)
        self:talentTemporaryValue(tmptable, "inc_damage", {[DamageType.ARCANE] = t.getIncrease(self, t)})
        self:talentTemporaryValue(tmptable, "resists_pen", {[DamageType.ARCANE] = t.getIncrease(self, t)})
        self:talentTemporaryValue(tmptable, "force_melee_damtype", DamageType.ARCANE)
    end
    am.info = function(self, t)
       return ([[You have learned to harness your latent arcane powers, channeling them through your weapon.
       This has the following effects:
       All your weapon damage modifier will be converted to Magic.
       Your APR is increased by 100%% of your Magic.
       Your weapon always deals arcane damage;
       Your arcane damage and arcane resistance penetration is increated by %d%%.
       ]]):tformat(t.getIncrease(self, t))
    end
end
return _M