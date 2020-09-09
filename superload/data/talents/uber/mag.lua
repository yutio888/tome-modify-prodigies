local Talents = require "engine.interface.ActorTalents"

local _M = loadPrevious(...)
Talents.talents_def['T_ARCANE_MIGHT'] = nil
uberTalent {
    name = "Arcane Might", short_name = "ARCANE_MIGHT_TEST", image = "talents/arcane_might.png",
	mode = "passive",
	getIncrease = function(self, t) return 20 end,
	passives = function(self, t, tmptable)
	        self:talentTemporaryValue(tmptable, "inc_damage", {[DamageType.ARCANE] = t.getIncrease(self, t)})
	        self:talentTemporaryValue(tmptable, "resists_pen", {[DamageType.ARCANE] = t.getIncrease(self, t)})
	        self:talentTemporaryValue(tmptable, "force_melee_damage_type", DamageType.ARCANE)
    	end,
	info = function(self, t)
		return ([[You have learned to harness your latent arcane powers, channeling them through your weapon.
        This has the following effects:
        All your weapon damage modifier will be converted to Magic.
        Your APR is increased by 100%% of your SpellPower;
        Your weapon damage is converted to arcane (Note that talents with specific damage type will not be changed);
        Your arcane damage and arcane resistance penetration is increated by %d%%.]])
		:tformat(t.getIncrease(self, t))
	end,
}

return _M