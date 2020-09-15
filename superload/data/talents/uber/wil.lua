local Talents = require "engine.interface.ActorTalents"

local _M = loadPrevious(...)
local tyranny = Talents.talents_def['T_MENTAL_TYRANNY']
if tyranny then
    tyranny.cooldown = nil
    tyranny.mode = 'passive'
    tyranny.activate = nil
    tyranny.deactivate = nil
    tyranny.info = function(self, t)
        return ([[Transcend the physical and rule over all with an iron will!
        Your mind attack cannot be resisted by mental save any more.
        Any foe who fails to resist your mind attack will suffer 20%% more damage, and may get brainlocked for 2 turns if it is a critical strike.
        ]]):tformat()
    end
end

local uw = Talents.talents_def['T_UNBREAKABLE_WILL']
if uw then
    uw.not_listed = true
end

local sf = Talents.talents_def['T_SPELL_FEEDBACK']
if sf then
    sf.callbackOnTakeDamageBeforeResists = function(self, t, src, x, y, type, dam, state)
        local source_talent = src.__projecting_for and src.__projecting_for.project_type and (src.__projecting_for.project_type.talent_id or src.__projecting_for.project_type.talent) and src.getTalentFromId and src:getTalentFromId(src.__projecting_for.project_type.talent or src.__projecting_for.project_type.talent_id)
        if dam > 0 and source_talent and source_talent.is_spell then
            local reduce = dam * 0.15
            local finaldam = dam - reduce
            game:delayedLogDamage(src or self, self, 0, ("#ORANGE#(%d soften)#LAST#"):format(reduce), nil)
            return {dam = finaldam}
        end
    end
    sf.info = function(self, t)
        return ([[Your will is a shield against assaults from crazed arcane users.
        You take 15%% less damage from spell.
        Each time that you take damage from a spell, you punish the spellcaster with %0.2f mind damage.
        Also, they will suffer a 35%% spell failure chance (with duration equal to the cooldown of the spell they used on you).
        Note: the punishment has a cooldown.]])
        :tformat(damDesc(self, DamageType.MIND, 20 + self:getWil() * 2))
    end
end

uberTalent {
    name = "Determination",  image = "talents/unbreakable_will.png",
    mode = "passive",
    callbackPriorities = { callbackOnTemporaryEffect = 1 }, -- should later than most callbacks
    callbackOnTemporaryEffect = function(self, t, eff_id, e_def, eff)
        if e_def.type == "other" then return end
        if e_def.status == "detrimental" then
            eff.dur = math.floor(eff.dur * 0.75 - 1)
        else
            eff.dur = math.ceil(eff.dur * 1.25 + 1)
        end
    end,
    info = function(self, t)
        return ([[You are filled with determination, negating negative effects and empowering positive effects.
        This increases the duration of new beneficial effects and reduces the duration of new negative effects applied to you by 25%% + 1 rounded up.
        ]]):tformat()
    end
}


return _M