local class = require"engine.class"
local ActorTemporaryEffects = require "engine.interface.ActorTemporaryEffects"
local DamageType = require "engine.DamageType"
class:bindHook("ToME:load", function(self, data)
  DamageType:loadDefinition("/data-modify_prodigies/damage_types.lua")
  ActorTemporaryEffects:loadDefinition('/data-modify_prodigies/timed_effects/other.lua')
end)