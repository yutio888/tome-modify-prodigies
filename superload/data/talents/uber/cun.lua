local Talents = require "engine.interface.ActorTalents"
local damDesc = Talents.main_env.damDesc

local _M = loadPrevious(...)
local tricks = Talents.talents_def['T_TRICKS_OF_THE_TRADE']
if tricks then
    tricks.on_learn = nil
    tricks.callbackOnDealDamage = function(self, t, value, target, dead, death_node)
    		if dead or self:attr("dont_tricks") or self:attr("dont_raze") then return end
    		if not self:canSee(target) or not self:hasLOS(target.x, target.y) then return end
    		if target.__is_actor and target.T_TRICKS_OF_THE_TRADE and target:knowTalent(T_TRICKS_OF_THE_TRADE) then return end
    		local mh, oh = self:hasDualWeapon()
                if (mh and oh) and oh.subtype == "dagger" then
                local times = target.turn_procs.tricks or 0
                local percent = 1 - 0.05 * times
                if percent <= 0 then return end
    		    self:attr("dont_tricks",1)
    		    DamageType:get(DamageType.PHYSICAL).projector(self, target.x, target.y, DamageType.PHYSICAL, t.getDamage(self, t) * percent)
    		    self:attr("dont_tricks",-1)
    		    target.turn_procs.tricks = times + 1
    		end
    	end
    tricks.getDamage = function(self, t)
        return self:combatScale(self:getCun() * self.level, 40, 1250, 90, 5000)
        --total dam:lv 25 * cun50 * 50%phys inc -> 600;  lv 50 * cun100 * 100%phys inc-> 1800
    end
    tricks.info = function(self, t)
        return ([[You have friends in low places and have learned some underhanded tricks.
        While holding dagger in offhand, whenever you inflict damage to a target in your sight, you deal an additional %.2f physical damage.
        The target will gain resistance to this effect if it triggers more than one times in a single turn, decresing 5%% per trigger.
        The damage scales with your level and cunning.
        Also learning this talent will grant you immunity to others' Tricks of the Trade effect.
        ]]):tformat(damDesc(self, DamageType.PHYSICAL, t.getDamage(self, t)))
    end
end
return _M