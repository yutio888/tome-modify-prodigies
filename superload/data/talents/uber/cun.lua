local Talents = require "engine.interface.ActorTalents"

local _M = loadPrevious(...)
local tricks = Talents.talents_def['T_TRICKS_OF_THE_TRADE']
if tricks then
    tricks.on_learn = nil
    tricks.callbackOnDealDamage = function(self, t, value, target, dead, death_node)
    		if dead or self:attr("dont_tricks") then return end
    		if not self:canSee(target) or not self:hasLOS(target.x, target.y) then return end
    		local mh, oh = self:hasDualWeapon()
                if (mh and oh) and oh.subtype ~= "mindstar" then
                if target.turn_procs.tricks and target.turn_procs.tricks >= 15 then return end
    		    self:attr("dont_tricks",1)
    		    DamageType:get(DamageType.PHYSICAL).projector(self, target.x, target.y, DamageType.PHYSICAL, t.getDamage(self, t))
    		    self:attr("dont_tricks",-1)
    		    target.turn_procs.tricks = target.turn_procs.tricks or 0
                target.turn_procs.tricks = target.turn_procs.tricks + 1
    		end
    	end
    tricks.getDamage = function(self, t)
        return self:combatScale(self:getCun() * self.level, 25, 1250, 75, 6000)
    end
    tricks.info = function(self, t)
        return ([[You have friends in low places and have learned some underhanded tricks.
        While holding dagger in offhand, whenever you inflict damage to a target in your sight, you deal an additional %.2f physical damage.
        You cannot trigger more than 10 times on the same target each turn.
        The damage scales with your level and cunning.
        ]]):tformat(t.getDamage(self, t))
    end
end
return _M