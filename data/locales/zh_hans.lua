locale "zh_hans"

------------------------------------------------
section "game/addons/tome-modify-prodigies/data/damage_types.lua"

t("mind", "精神", "_t")
t("mentally tortured", "受到精神折磨", "_t")
t("mindraped", "被精神强X", "_t")
t("psyched", "过度兴奋", "_t")


------------------------------------------------
section "game/addons/tome-modify-prodigies/data/timed_effects/other.lua"

t("Faster Than Light", "超越光速", "_t")
t("Moving at extreme speed (1000%% faster) and gains immunity for negative status effect. Any action other than movement will cancel it. ", "以极限速度（1000%%）进行移动，同时免疫负面状态。任何除移动外的行为将取消该效果。", "tformat")
t("speed", "速度", "effect subtype")
t("#Target# is moving at extreme speed!", "#Target#走得飞快！", "_t")
t("+Faster Than Light", "+超越光速", "_t")
t("#Target# slows down.", "#Target#速度减慢了。", "_t")
t("-Faster Than Light", "-超越光速", "_t")
t("Antimagic Aura", "反魔光环", "_t")
t("You've entered the antimagic aura, decreasing spellpower and spell cast speed by %d%%, increasing mind speed by %d%%.", "你已经进入了反魔光环，法术强度和施法速度减少%d%%，精神速度增加%d%%。", "tformat")
t("antimagic", "反魔法", "effect subtype")
t("+Antimagic Aura", "+反魔光环", "_t")
t("-Antimagic Aura", "-反魔光环", "_t")


------------------------------------------------
section "game/addons/tome-modify-prodigies/init.lua"



------------------------------------------------
section "game/addons/tome-modify-prodigies/superload/data/talents/uber/cun.lua"

t("Antimagic Aura", "反魔光环", "talent name")
t("Antimagic", "反魔法", "_t")
t([[A powerful antimagic aura surrounds you in radius %d, decreasing spellpower and spell cast speed by 20%%, increasing mind speed by 20%%.
        You may activate this skill to make this aura explode in radius 10, doubling the effect for 5 turns and restore 10 equilibrium with each applied target.
        Besides, your Antimagic Shield costs no time to use.
        ]], [[范围%d的反魔光环围绕在你身边，降低20%%法术强度和施法速度，并增加20%%精神速度。
        你可以主动启动这个技能，引爆反魔光环内的能量，令10格内所有生物在5回合内受到双倍效果，并且每影响一个生物，你回复10点失衡值。
        此外，学习该技能后，使用反魔盾不需要时间。]], "tformat")
t([[You have friends in low places and have learned some underhanded tricks.
        While holding dagger in offhand, whenever you inflict damage to a target in your sight, you deal an additional %.2f physical damage.
        The target will gain resistance to this effect if it triggers more than one times in a single turn, decresing 5%% per trigger.
        The damage scales with your level and cunning.
        Also learning this talent will grant you immunity to others' Tricks of the Trade effect.
        ]], [[你结交了狐朋狗友，学到了一些下三滥的技巧。
        每次对视野内的目标造成伤害时，如果副手持有匕首，则造成额外%0.2f物理伤害。
        目标在同一回合内多次受到该伤害时，会获得一定抗性，每次受到的伤害减少5%%。
        伤害受角色等级和灵巧加成。
        此外，学习该技能后，你将免疫“欺诈圣手”带来的伤害。]], "tformat")


------------------------------------------------
section "game/addons/tome-modify-prodigies/superload/data/talents/uber/dex.lua"

t("Faster Than Light", "超越光速", "talent name")
t("Mirror Image (%s)", "镜像 (%s)", "tformat")
t("A blurred image.", "一个模糊的镜像。", "_t")
t("Summon", "召唤", "_t")
t([[Whenever you have more than 800%% movement speed, with every two moves you leave behind a mirror image that lasts for 2 turns.
        You may activate this skill to gain 1000%% movement speed and become immune for negative status effect for 1 turn, but any action other than movement will cancel this effect.
        Your mirrors are very fragile, any direct damage will immediately destroy it.
        ]], [[当你的移动速度超过800%%时，每移动两步，将留下一个持续2回合的镜像。
        你可以主动启动这个技能，获得持续1回合的1000%%移动速度与负面状态免疫，但期间任何非移动的行为都会提前终止该效果。
        你的镜像非常脆弱，任何直接伤害都会立刻摧毁它。]], "tformat")


------------------------------------------------
section "game/addons/tome-modify-prodigies/superload/data/talents/uber/mag.lua"

t([[You have learned to harness your latent arcane powers, channeling them through your weapon.
       This has the following effects:
       All your weapon damage modifier will be converted to Magic.
       Your APR is increased by 100%% of your Magic.
       Your weapon always deals arcane damage;
       Your arcane damage and arcane resistance penetration is increated by %d%%.
       ]], [[你学会如何利用自己潜在的奥术力量，将它们注入你的武器。
       这一技能具有以下效果：
       所有武器的属性加成被替换为魔法。
       护甲穿透增加100%%魔法属性。
       所有武器均造成奥术伤害。
       获得%d%%奥术伤害加成和抗性穿透。]], "tformat")


------------------------------------------------
section "game/addons/tome-modify-prodigies/superload/data/talents/uber/str.lua"

t([[When you rush, the creature you rush to is marked. If you kill it in the next 2 turns then your rush cooldown is reset.
        Each time you rush, you gain a stacking +20%% damage buff for 2 turns, up to 100%%.
        Rush now takes 25%% time to use, and only costs 2 stamina.]], [[当你使用冲锋时，冲锋目标会被标记。在接下来两轮之内杀掉冲锋对象，则冲锋技能会冷却完毕。
        每当此技能触发时，你获得 1 个增加 20%%伤害的增益效果，最大叠加至 100%%。
        冲锋现在只消耗 2 点体力, 且消耗时间减少为 25%%。]], "tformat")
t("Have dug at least 30 walls/trees/etc. and have dealt over 50000 damage with two-handed weapons", "曾挖掉至少 30 块石头/树木/等等，并且使用双手武器造成超过 50000 点伤害", "_t")
t("Be of size category 'big' or larger. This is also required to use it.", "体型至少为较大（使用也要满足此条件）", "_t")
t([[You deal a massive blow to your foe, smashing it for 350%% weapon damage, knocking it back 5 tiles, and knocking aside all foes in its path.
        All targets affected are stunned for 3 turns and applied the Counterstrike effect.
        If the knockback makes it hit a wall, it will smash down the wall, gain an additional +150%% weapon damage and daze the target for 5 turns, this ignores daze immunities.
        For each size category over 'big' you gain an additional +80%% weapon damage.]], [[        对敌人进行一次猛击，造成 350%% 的武器伤害并击退目标 5 码，同时击退所有经过的目标。
        所有受影响的目标都会被震慑3回合，并被附加反击特效。
        如果敌人在击退时撞上墙壁，墙壁会被撞毁且对敌人造成的武器伤害系数进一步增加 150%% 。
        体型超过“巨大”时，每增加一级，额外增加 80%% 武器伤害。]], "tformat")
t("Mainhand weapon damage above 150", "主手武器伤害超过150", "_t")
t([[Hit the ground, making a powerful shockwave in radius %d that deals %.2f physical damage.
        The damage and radius scales with your main hand weapon damage.
        ]], [[用武器攻击地面，在%d格范围内制造强大的冲击波，造成%0.2f物理伤害。
        伤害和范围受主手武器伤害加成。]], "tformat")


------------------------------------------------
section "game/addons/tome-modify-prodigies/superload/data/talents/uber/wil.lua"

t([[Transcend the physical and rule over all with an iron will!
        Your mind attack cannot be resisted by mental save any more.
        Any foe who fails to resist your mind attack will suffer 20%% more damage, and may get brainlocked for 2 turns if it is a critical strike.
        ]], [[用钢铁般的意志驱使整个身体。
        当此技能激活时，你的精神伤害无法被豁免减半。
        此外，当对方的精神豁免未能抵抗你的精神攻击时，你的精神伤害增加20%%，且如果是暴击伤害将有可能触发锁脑效果。]], "tformat")
t([[Your will is a shield against assaults from crazed arcane users.
        You take 15%% less damage from spell.
        Each time that you take damage from a spell, you punish the spellcaster with %0.2f mind damage.
        Also, they will suffer a 35%% spell failure chance (with duration equal to the cooldown of the spell they used on you).
        Note: the punishment has a cooldown.]], [[你的意志是对抗邪恶魔法师的盾牌。 你受到的法术伤害减少15%%。
        每当你受到魔法伤害，你会惩罚施法者，使其受到 %0.2f 的精神伤害。
        同时，它们在对你使用的技能进入冷却的回合中，会受到 35%% 法术失败率惩罚。
        注意：该技能有冷却时间。]], "tformat")
t("Determination", "坚定意志", "talent name")
t([[You have lived through many battles, which fills you with determination.
        This increases the duration of new beneficial effects and reduces the duration of new negative effects applied to you by 25%% + 1 rounded up.
        ]], [[你经历了许多战斗，意志变得更加坚定。
        你获得的增益效果延长25%%+1回合，负面效果减少25%%+1回合。]], "tformat")
t("Mind Over Matter", "心胜于物", "talent name")
t([[Mind damage dealt to/by you is increased by %d%%.
        Others are decreased by %d%%.
        ]], [[你受到/造成的精神伤害增加 %d%%，其他类型伤害减少 %d%%。
        ]], "tformat")


------------------------------------------------
section "game/addons/tome-modify-prodigies/superload/data/timed_effects/magical.lua"

t("%s is pulled in!", "%s 被拉了进去！", "logSeen")


