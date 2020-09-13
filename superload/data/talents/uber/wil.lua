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
    uw.on_learn = function(self, t)
        self:incIncStat(self.STAT_WIL, 30)
    end
    uw.on_unlearn = function(self, t)
        self:incIncStat(self.STAT_WIL, -30)
    end
    uw.info = function(self, t)
        return ([[Your will is so strong, you gain extra 30 willpower, and you may simply ignore mental effects used against you.
        This effect can only occur once every 5 turns.]])
        :tformat()
    end
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
return _M