local class = require"engine.class"
local DamageType = require "engine.DamageType"
class:bindHook("ToME:load", function(self, data)
  DamageType:loadDefinition("/data-modify_prodigies/damage_types.lua")
end)