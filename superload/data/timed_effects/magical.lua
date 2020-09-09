local Stats = require "engine.interface.ActorStats"
local Particles = require "engine.Particles"
local Shader = require "engine.Shader"
local Entity = require "engine.Entity"
local Chat = require "engine.Chat"
local Map = require "engine.Map"
local Level = require "engine.Level"
local EF = require "engine.interface.ActorTemporaryEffects"

local _M = loadPrevious(...)
local suneff = EF.tempeffect_def['EFF_IRRESISTIBLE_SUN']
if suneff then
    suneff.on_timeout =
        function(self, eff)
            local tgts = {}
            self:project({type="ball", range=0, friendlyfire=false, radius=5}, self.x, self.y, function(px, py)
            	local target = game.level.map(px, py, Map.ACTOR)
            	if not target then return end
            	if not tgts[target] then
            		tgts[target] = true
            		if not target:attr("ignore_irresistible_sun") then
            			local ox, oy = target.x, target.y
            			target:pull(self.x, self.y, 1)
            			if target.x ~= ox or target.y ~= oy then
            				game.logSeen(target, "%s is pulled in!", target:getName():capitalize())
            			end

            			if self:reactionToward(target) < 0 then
            				local dam = eff.dam * (1 + (5 - core.fov.distance(self.x, self.y, target.x, target.y)) / 8)
            				local power = math.max(self:combatSpellpower(), self:combatMindpower(), self:combatPhysicalpower()) --try apply spellshocked before damage
            				target:crossTierEffect(target.EFF_SPELLSHOCKED, power)
                            target:setEffect(target.EFF_WEIGHT_OF_THE_SUN, 2, { reduce = 30})  -- Quickly wears off when outside of AoE
            				DamageType:get(DamageType.FIRE).projector(self, target.x, target.y, DamageType.FIRE, dam/3)
            				DamageType:get(DamageType.LIGHT).projector(self, target.x, target.y, DamageType.LIGHT, dam/3)
            				DamageType:get(DamageType.PHYSICAL).projector(self, target.x, target.y, DamageType.PHYSICAL, dam/3)
            			end
            		end
            	end
            end)
        end
end
return _M