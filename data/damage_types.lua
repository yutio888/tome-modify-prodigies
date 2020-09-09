local useImplicitCrit = DamageType.useImplicitCrit
local initState = DamageType.initState
newDamageType{
	name = _t"mind", type = "MIND", text_color = "#ORANGE#",
	death_message = {_t"psyched", _t"mentally tortured", _t"mindraped"},
    projector = function(src, x, y, type, dam, state)
         state = initState(state)
         useImplicitCrit(src, state)
         local target = game.level.map(x, y, Map.ACTOR)
         local thought_form
         if target and src and target.summoner and target.summoner == src and target.type and target.type == "thought-form" then thought_form = true end
         local tyranny = false
         if src and src.T_MENTAL_TYRANNY and src.__is_actor and src:knowTalent(src.T_MENTAL_TYRANNY) then
            tyranny = true
         end
         if target and not thought_form then
         	local mindpower, mentalresist, alwaysHit, crossTierChance
         	if _G.type(dam) == "table" then dam, mindpower, mentalresist, alwaysHit, crossTierChance = dam.dam, dam.mindpower, dam.mentalresist, dam.alwaysHit, dam.crossTierChance end
         	local hit_power = mindpower or src:combatMindpower()
         	if alwaysHit or target:checkHit(hit_power, mentalresist or target:combatMentalResist(), 0, 95, 15) then
         		if crossTierChance and rng.percent(crossTierChance) then
         			target:crossTierEffect(target.EFF_BRAINLOCKED, src:combatMindpower())
         		end
         		if tyranny then
         		    dam = dam * 1.2
                    local eff = target:hasEffect(target.EFF_BRAINLOCKED)
         		    if not eff or eff.dur < 2 then
         		        target:setEffect(target.EFF_BRAINLOCKED, 2, {})
         		    end
         		end
         		return DamageType.defaultProjector(src, x, y, type, dam, state)
         	else
         	    if not tyranny then
         	        dam = dam / 2
         	    end
         		--game.logSeen(target, "%s resists the mind attack!", target:getName():capitalize())
         		return DamageType.defaultProjector(src, x, y, type, dam, state)
         	end
         end
         return 0
    end,
}