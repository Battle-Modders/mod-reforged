::Reforged.NestedTooltips <- {
	Tooltips = {
		Concept = {
			Perk = ::MSU.Class.BasicTooltip("Perk", ::Reforged.Mod.Tooltips.parseString("As characters gain levels, they unlock perk points which can be spent to unlock powerful perks. Perks grant a character permanent bonuses or unlock new skills for use. Perks are a central theme in Battle Brothers and are the key to a character\'s specialization.")),
			StatusEffect = ::MSU.Class.BasicTooltip("Status Effect", ::Reforged.Mod.Tooltips.parseString("Status effects are positive or negative effects on a character, which are mostly temporary. A status effect can have various effects ranging from increasing/decreasing [attributes|Concept.CharacterAttribute] to unlocking new abilities.")),
			Injury = ::MSU.Class.BasicTooltip("Injury", ::Reforged.Mod.Tooltips.parseString("If sufficient damage is dealt to [Hitpoints|Concept.Hitpoints] during combat, characters can sustain an injury. Injuries are [status effects|Concept.StatusEffect] that confer various maluses.\n\nInjuries sustained during combat are [temporary|Concept.InjuryTemporary], and will heal over time. Such injuries can be treated at a Temple for faster healing.\n\nIf a character is killed during combat, they have a chance to be struck down instead of being killed and survive the battle with a [permanent injury|Concept.InjuryPermanent]"))
			InjuryTemporary = ::MSU.Class.BasicTooltip("Temporary Injury", ::Reforged.Mod.Tooltips.parseString("Temporary injuries are received during combat when the damage to [Hitpoints|Concept.Hitpoints] received by a character exceeds the injury threshold. These injuries heal over time, but can be treated at a Temple for faster healing."))
			InjuryPermanent = ::MSU.Class.BasicTooltip("Permanent Injury", ::Reforged.Mod.Tooltips.parseString("Permanent injuries are received when a character is \'struck down\' during combat instead of being killed. These injuries, and the maluses they incur, are forever."))
			Reach = ::MSU.Class.BasicTooltip("Reach", ::Reforged.Mod.Tooltips.parseString("Reach is a depiction of how far a character\'s attacks can reach, making melee combat easier against targets with shorter reach.\n\n[Melee skill|Concept.MeleeSkill] is increased when attacking opponents with shorter reach, and reduced against opponents with longer reach, by " + ::MSU.Text.colorGreen(::Reforged.Reach.BonusPerReach) + " per difference in reach. It only applies when attacking a target adjacent to you or up to 2 tiles away with nothing between you and the target.\n\nAfter a successful hit, the target\'s reach advantage is lost until the attacker waits or ends their turn.\n\nReach grants no [Melee Skill|Concept.MeleeSkill] when attacking an opponent who has a shield. Characters who are rooted have their Reach halved. Those who are [stunned|Skill+stunned_effect], fleeing, or without a melee attack have no Reach.")),
			PerkTier = ::MSU.Class.BasicTooltip("Perk Tier", ::Reforged.Mod.Tooltips.parseString("[Perks|Concept.Perk] are distributed in a character\'s perk tree across 7 rows which are known as tiers. A character must have spent at least as many perk points as the tier-1 to be able to access the perks on that tier.")),
			StackMultiplicatively = ::MSU.Class.BasicTooltip("Stacking Multiplicatively", ::Reforged.Mod.Tooltips.parseString("Values can stack multiplicatively or [additively|Concept.StackAdditively]. Multiplicative stacking means that the values are multiplied.\n\nFor example, imagine a value of 100. Two skills that both increase this by 40% and stack multiplicatively increase the value by a total of 1.4 x 1.4 = 1.96 times, so it becomes 100 x 1.96 = 186. Two skills that reduce it by 40% and stack multiplicatively reduce it by (1.0 - 0.4) x (1.0 - 0.4) = 0.36 times, so it becomes 100 x 0.36 = 36.\n\nGenerally, [additive stacking|Concept.StackAdditively] is stronger when reducing a value or when the value is small and multiplicative stacking is stronger when increasing a value or when the value is large.")),
			StackAdditively = ::MSU.Class.BasicTooltip("Stacking Additively", ::Reforged.Mod.Tooltips.parseString("Values can stack [multiplicatively|Concept.StackMultiplicatively] or additively. Additive stacking means that the values are added.\n\nFor example, imagine a value of 100. Two skills that both increase this by 40% and stack additively increase the value by a total of 1.0 + 0.4 + 0.4 = 1.8 times, so it becomes 100 x 1.8 = 180. Two skills that reduce it by 40% and stack additively reduce it by 1.0 - 0.4 - 0.4 = 0.2 times, so it becomes 100 x 0.2 = 20.\n\nGenerally, additive stacking is stronger when reducing a value or when the value is small and [multiplicative stacking|Concept.StackMultiplicatively] is stronger when increasing a value or when the value is large.")),
			CharacterAttribute = ::MSU.Class.BasicTooltip("Character Attribute", ::Reforged.Mod.Tooltips.parseString("Characters in Battle Brothers have various attributes that describe the character\'s skill and/or aptitude in certain areas. Attributes include: [Hitpoints|Concept.Hitpoints], [Fatigue|Concept.Fatigue], [Resolve|Concept.Bravery], [Initiative|Concept.Initiative] [Melee Skill|Concept.MeleeSkill], [Melee Defense|Concept.MeleeDefense], [Ranged Skill|Concept.RangeSkill] and [Ranged Defense|Concept.RangeDefense].\n\nAs characters gain [experience|Concept.Experience] and [level up|Concept.Level] they can increase their attributes and unlock [perks|Concept.Perk].")),
			BaseAttribute = ::MSU.Class.BasicTooltip("Base Attribute", ::Reforged.Mod.Tooltips.parseString("A character\'s [attributes|Concept.CharacterAttribute] can be modified by various means e.g. perks, traits, status effects, equipment etc. The Base value of the attribute is the one that is before any such modifications.")),
			Surrounding = ::MSU.Class.BasicTooltip("Surrounding", ::Reforged.Mod.Tooltips.parseString("When a character is in the zone of control of multiple hostile characters, he is considered surrounded. Characters attacking a surrounded target in melee gain additional chance to hit. Several perks such as [Underdog|Perk.perk_underdog], [Backstabber|Perk.perk_backstabber] and [Long Reach|Perk.perk_rf_long_reach] interact with the surrounding mechanic, reducing or increasing its effectiveness.")),
			FatigueRecovery = ::MSU.Class.BasicTooltip("Fatigue Recovery", ::Reforged.Mod.Tooltips.parseString("At the start of every turn the [Fatigue|Concept.Fatigue] of a character is reduced by a certain amount. This is known as Fatigue Recovery.\n\nBy default the Fatigue Recovery of player characters is 15, whereas enemies, depending on the enemy type, may have a much higher Fatigue Recovery.\n\nFatigue Recovery may be affected by [perks|Concept.Perk], [traits|Concept.Trait], [status effects|Concept.StatusEffect] and [injuries|Concept.Injury].")),
			AOE = ::MSU.Class.BasicTooltip("Area of Effect", ::Reforged.Mod.Tooltips.parseString("Area of Effect (AOE) skills target multiple tiles with their effects instead of only a single tile.")),
			Fatality = ::MSU.Class.BasicTooltip("Fatality", ::Reforged.Mod.Tooltips.parseString("Fatalities are special forms of death which depict a certain gruesomeness beyond the ordinary. Fatalities include:\n- Decapitation - removing the target\'s head.\n- Disembowelment - opening up the target\'s belly to spill the guts.\n- Smashing - smashing the target\'s head into bits.")),
			Turn = ::MSU.Class.BasicTooltip("Turn", ::Reforged.Mod.Tooltips.parseString("Combat in battle brothers is turn-based. Each combat consists of a series of [rounds|Concept.Round]. During a round, characters act in turns. A character\'s position in the turn order is determined by the character\'s [Initiative|Concept.Initiative] relative to other characters.\n\n[Effects|Concept.StatusEffect] that last a certain number of turns last until the character has started or ended their turn that many times, depending on whether the [effect|Concept.StatusEffect] expires at the start or end of the turn respectively.")),
			Round = ::MSU.Class.BasicTooltip("Round", ::Reforged.Mod.Tooltips.parseString("Combat in battle brothers is turn-based. Each combat consists of a series of rounds. During a round, characters act in [turns|Concept.Turn]. A round ends when all characters have ended their [turns|Concept.Turn].")),
			ZoneOfControl = ::MSU.Class.BasicTooltip("Zone of Control", ::Reforged.Mod.Tooltips.parseString("Most melee characters exert Zone of Control on their surrounding tiles. Trying to move out of enemy Zone of Control will trigger one free attack from each controlling enemy until the first attack hit or every attack missed. A hit will cancel the movement.")),
		}
	},
	AutoConcepts = [
		"character-stats.ActionPoints",
		"character-stats.Hitpoints",
		"character-stats.Morale",
		"character-stats.Fatigue",
		"character-stats.MaximumFatigue",
		"character-stats.ArmorHead",
		"character-stats.ArmorBody",
		"character-stats.MeleeSkill",
		"character-stats.RangeSkill",
		"character-stats.MeleeDefense",
		"character-stats.RangeDefense",
		"character-stats.SightDistance",
		"character-stats.RegularDamage",
		"character-stats.CrushingDamage",
		"character-stats.ChanceToHitHead",
		"character-stats.Initiative",
		"character-stats.Bravery",

		"character-screen.left-panel-header-module.Experience",
		"character-screen.left-panel-header-module.Level",
	]
}

::MSU.AfterQueue.add(::Reforged.ID, function() {
	foreach (concept in ::Reforged.NestedTooltips.AutoConcepts)
	{
		local desc = ::TooltipScreen.m.TooltipEvents.general_queryUIElementTooltipData(::Reforged.getDummyPlayer().getID(), concept, null);
		::Reforged.NestedTooltips.Tooltips.Concept[split(concept, ".").top()] <- ::MSU.Class.CustomTooltip(@(data) desc);
	}

	// Manual adding of 'Talent' because that concepts description never got past 'TODO' in vanilla
	::Reforged.NestedTooltips.Tooltips.Concept["Talent"] <- ::MSU.Class.CustomTooltip(@(data) [
		{
			id = 1,
			type = "title",
			text = "Talent"
		},
		{
			id = 2,
			type = "description",
			text = "Talents are the stars next to some of the attributes of a brother. Talents improve the minimum and maximum possible rolls for those attribute during a level-up depending on the number of stars."
		}
	]);

	::Reforged.Mod.Tooltips.setTooltips(::Reforged.NestedTooltips.Tooltips);
});
