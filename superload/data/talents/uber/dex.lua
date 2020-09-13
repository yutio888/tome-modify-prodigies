local Talents = require "engine.interface.ActorTalents"

local _M = loadPrevious(...)
local roll = Talents.talents_def['T_ROLL_WITH_IT']
if roll then
    roll.type[1] = "uber/other"
end
uberTalent {
    name = "Faster Than Light",  image = "talents/fast_as_lightning.png",
    mode = "activated",
    require = { special={desc=_t"Faster than 800% movement speed NOW", fct=function(self)
    		if self:combatMovementSpeed() < 0.125 then return true
    		else return false
    		end
    	end} },
    cooldown = 12,
    no_energy = true,
    getMult = function(self, t) return 1 end,
    callbackOnMove = function(self, eff, moved, force, ox, oy)
        if not moved or force or (self.x == ox and self.y == oy) then return end
        local steps = self:attr("ftl_moves")
        if self:combatMovementSpeed() >= 0.125 then
            if steps then self:attr("ftl_moves", -1) end
            return
        end
        if not steps then self:attr("ftl_moves", 1)
        else self:attr("ftl_moves", -1) return
        end
        local tx, ty = util.findFreeGrid(ox, oy, 1, true, {[Map.ACTOR]=true})
        if not tx then return end
        local NPC = require "mod.class.NPC"
        local image = NPC.new{
            name = ("Mirror Image (%s)"):tformat(self:getName()),
            type = "image", subtype = "light",
            color=colors.GRAY, shader = "shadow_simulacrum",
            shader_args = { color = {0.3, 0.3, 0.3}, base = 0.3, time_factor = 4000 },
            ai = "summoned", ai_real = nil, ai_state = { talent_in=1, }, ai_target = {actor=nil},
            desc = _t"A blurred image.",
            image = self.image,
            add_mos = table.clone(self.add_mos, true),
            exp_worth=0,
            level_range = {self.level, self.level},
            level = self.level,
            size_category = self.size_category,
            global_speed = self.global_speed,
            global_speed_add = self.global_speed_add,
            global_speed_base = self.global_speed_base,
            combat_spellspeed = self.combat_spellspeed,
            combat_def = self.level * 4,
            combat_armor = 0,
            max_mana = 10000,
            mana = 10000,
            rank = self.rank,
            difficulty_boosted = 1,
            max_life = 1,
            die_at = 0,
            life_rating = 0,
            life_regen = 0, no_life_regen = 1,
            never_move = 1,
            never_anger = true,
            resolvers.talents{
                [Talents.T_TAUNT]=5, -- Add the talent so the player can see it even though we cast it manually
            },
            faction = self.faction,
            summoner = self,
            summon_time = 2,
            heal = function() return 0 end, -- Cant ever heal
            takeHit = function(self, value, src, death_note)
                if not src then return false, 0 end
                if src ~= self then
                    if not death_note or death_note.source_talent_mode ~= "active" then return false, 0 end
                    self:die()
                    return false, value
                end
                self:die()
                return false, value
                -- return mod.class.NPC.takeHit(self, 1, src, death_note)
            end,
            no_breath = 1,
            remove_from_party_on_death = true,
            free_replace = true,
        }
        image:resolve()
        game.zone:addEntity(game.level, image, "actor", tx, ty)
        if game.party:hasMember(self) then
            game.party:addMember(image, {
            	control=false,
            	type="summon",
            	title=_t"Summon",
            	temporary_level = true,
            	orders = {},
            })
        end
        image:forceUseTalent(image.T_TAUNT, {ignore_cd=true, no_talent_fail = true, force_level = 5})
    end,
    action = function(self, t)
        game:onTickEnd(function() self:setEffect(self.EFF_FASTER_THAN_LIGHT, 1, {}) end)
        return true
    end,
    info = function(self, t)
        return ([[Whenever you have more than 800%% movement speed, with every two moves you leave behind a mirror image that lasts for 2 turns.
        You may activate this skill to gain 1000%% movement speed and become immune for negative status effect for 1 turn, but any action other than movement will cancel this effect.
        Your mirrors are very fragile, any direct damage will immediately destroy it.
        ]]):tformat()
    end,
}
return _M