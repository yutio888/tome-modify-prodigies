newEffect{
    name = "FASTER_THAN_LIGHT", image = "talents/fast_as_lightning.png",
    desc = _t"Faster Than Light",
    long_desc = function(self, eff) return ("Moving at extreme speed (1000%% faster) and gains immunity for negative status effect. ")
            :tformat() end,
    type = "other",
    status = "beneficial",
    subtype = { speed=true },
    parameters = {power=100, no_talents=1},
    on_gain = function(self, err) return _t"#Target# is moving at extreme speed!", _t"+FTL" end,
    on_lose = function(self, err) return _t"#Target# slows down.", _t"-FTL" end,
    get_fractional_percent = function(self, eff)
        local d = game.turn - eff.start_turn
        return util.bound(360 - d / eff.possible_end_turns * 360, 0, 360)
    end,
    activate = function(self, eff)
        eff.start_turn = game.turn
        eff.possible_end_turns = 10
        eff.moveid = self:addTemporaryValue("movement_speed", 10)

        self:effectTemporaryValue(eff, "ai_spread_add", 5)  -- Reduce accuracy of AI position guesses so we don't track straight to players that moved out of LOS

        -- should change priorities rather than forbid all talents
        if self.ai_state and eff.no_talents ~= 0 then eff.aiid = self:addTemporaryValue("ai_state", {no_talents=eff.no_talents}) end -- Makes the AI not use talents while active

        self:effectTemporaryValue(eff, "negative_status_effect_immune", 1)
    end,
    deactivate = function(self, eff)
        if eff.aiid then self:removeTemporaryValue("ai_state", eff.aiid) end
        self:removeTemporaryValue("movement_speed", eff.moveid)
    end,
}