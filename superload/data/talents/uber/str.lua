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
local titan = Talents.talents_def['T_TITAN_S_SMASH']
if titan then
    titan.require = { special={desc=_t"Have dug at least 30 walls/trees/etc. and have dealt over 50000 damage with two-handed weapons", fct=function(self) return
          		self.dug_times and self.dug_times >= 30 and
          		self.damage_log and self.damage_log.weapon.twohanded and self.damage_log.weapon.twohanded >= 50000
          	end},
          	 special2={desc=_t"Be of size category 'big' or larger. This is also required to use it.", fct=function(self) return self.size_category and self.size_category >= 4 end}
          	 }
    titan.action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y, target = self:getTarget(tg)
		if not target or not self:canProject(tg, x, y) then return nil end

		local dx, dy = (target.x - self.x), (target.y - self.y)
		local dir = util.coordToDir(dx, dy, 0)
		local sides = util.dirSides(dir, 0)

        local destroyed = false

		target:knockback(self.x, self.y, 5, function(t2, x, y)
			if sides then
				local d = rng.chance(2) and sides.hard_left or sides.hard_right
				local sx, sy = util.coordAddDir(t2.x, t2.y, d)
				local destroyed2 = false
				t2:knockback(sx, sy, 2, function(t3) return true end)
			end
			if t2:canBe("stun") then t2:setEffect(t2.EFF_STUNNED, 3, {}) end
			t2:setEffect(target.EFF_COUNTERSTRIKE, 2, {power=20, no_ct_effect=true, src=self, nb=1})
		end,  function(g, x, y)
            if g:attr("dig") and not destroyed then
             	DamageType:get(DamageType.DIG).projector(self, x, y, DamageType.DIG, 1)
             	destroyed = true
            end
        end)
		if target:canBe("stun") then target:setEffect(target.EFF_STUNNED, 3, {}) end
		if self:attackTarget(target, nil, 3.5 + 0.8 * (self.size_category - 4) + (destroyed and 1.5 or 0), true) then
            target:setEffect(target.EFF_COUNTERSTRIKE, 2, {power=20, no_ct_effect=true, src=self, nb=1})
        end
        if destroyed then
            target:setEffect(target.EFF_DAZED, 5, {})
        end
        target:crossTierEffect(target.EFF_OFFBALANCE, self:combatPhysicalpower())
		return true
	end
    titan.info = function(self, t)
        return ([[You deal a massive blow to your foe, smashing it for 350%% weapon damage, knocking it back 5 tiles, and knocking aside all foes in its path.
        All targets affected are stunned for 3 turns and applied the Counterstrike effect.
        If the knockback makes it hit a wall, it will smash down the wall, deal additional 150%% weapon damage and daze the target for 5 turns, this ignores daze immunities.
        For each size category over 'big' you gain an additional +80%% weapon damage.]])
        :tformat()
    end
end
return _M