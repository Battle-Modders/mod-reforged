local getThresholdForInjury = function( _script )
{
	foreach (entry in ::Const.Injury.All)
	{
		if (entry.Script == _script)
			return entry.Threshold * 100;
	}
}

::Reforged.NestedTooltips <- {
	Tooltips = {
		Concept = {}
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
		"character-stats.Talent",
		"character-stats.SightDistance"

		"character-screen.left-panel-header-module.Experience",
		"character-screen.left-panel-header-module.Level",

		"assets.BusinessReputation",
		"assets.MoralReputation"
	],

	function getNestedPerkName( _obj, _extraData = null )
	{
		local perkDef = ::Const.Perks.findById(_obj.getID());
		return format("[%s|Perk+%s%s]", perkDef != null ? perkDef.Name : _obj.m.Name, _obj.ClassName, _extraData == null ? "" : "," + _extraData);
	}

	function getNestedPerkImage( _obj, _extraData = null )
	{
		local perkDef = ::Const.Perks.findById(_obj.getID());
		return format("[Img/gfx/%s|Perk+%s%s,cssClass:rf-nested-skill-image]", perkDef != null ? perkDef.Icon : _obj.getIcon(), _obj.ClassName, _extraData == null ? "" : "," + _extraData);
	}

	function getNestedSkillName( _obj, _extraData = null, _getName = false )
	{
		// We use `.m.Name` instead of `getName()` because some skills (e.g. status effects)
		// modify the name during getName() e.g. to add info about the number of stacks
		return format("[%s|Skill+%s%s]", _getName ? _obj.getName() : _obj.m.Name, _obj.ClassName, _extraData == null ? "" : "," + _extraData);
	}

	function getNestedSkillImage( _obj, _extraData = null, _checkUsability = false )
	{
		local icon = !_checkUsability || _obj.isUsable() && _obj.isAffordable() ? _obj.getIconColored() : _obj.getIconDisabled();
		return format("[Img/gfx/%s|Skill+%s%s,cssClass:rf-nested-skill-image]", icon, _obj.ClassName, _extraData == null ? "" : "," + _extraData);
	}

	function getNestedItemName( _obj, _extraData = null )
	{
		return format("[%s|Item+%s%s]", _obj.getName(), _obj.ClassName, _extraData == null ? "" : "," + _extraData);
	}

	function getNestedItemImage( _obj, _extraData = null )
	{
		return format("[Img/gfx/ui/items/%s|Item+%s%s]", _obj.getIcon(), _obj.ClassName, _extraData == null ? "" : "," + _extraData);
	}

	function getNestedEntityImage( _obj, _extraData = null )
	{
		return format("[Img/gfx/ui/orientation/%s.png|Entity+%i%s,cssClass:rf-nested-skill-image]", _obj.getOverlayImage(), _obj.getID(), _extraData == null ? "" : "," + _extraData);
	}

	function getNestedEntityName( _obj, _extraData = null )
	{
		return format("[%s|Entity+%i%s]", _obj.getName(), _obj.getID(), _extraData == null ? "" : "," + _extraData);
	}

	function getNestedObjectName( _obj, _extraData = null )
	{
		return format("[%s|Obj+%s%s]", _obj.getName(), ::Reforged.Mod.Tooltips.parseObject(_obj), _extraData == null ? "" : "," + _extraData);
	}

	function __addItemLinkInEntry( _entry, _item, _textKey = "text" )
	{
		if (_textKey in _entry && _entry[_textKey].find(_item.getName()) != null)
		{
			_entry[_textKey] = ::Reforged.Mod.Tooltips.parseString(::String.replace(_entry[_textKey], _item.getName(), ::Reforged.NestedTooltips.getNestedObjectName(_item, "contentType:ui-item")));
			if ("icon" in _entry && _entry.icon == "ui/items/" + v.getIcon())
			{
				_entry.icon = ::Reforged.Mod.Tooltips.parseString(format("[Img/gfx/ui/items/%s|Obj+%s,contentType:ui-item]", _item.getIcon(),::Reforged.Mod.Tooltips.parseObject(_item)));
			}
		}
	}

	// Called from setScreen of event or contract.
	// We retroactively walk through the screen text and its Options/List text
	// and convert the text to hyperlinks.
	function addHyperlinksToScreen( _screen, _event )
	{
		local text = _screen.Text;
		foreach (k, v in _event.m)
		{
			if (!::MSU.isKindOf(v, "item") || text.find(v.getName()) == null)
				continue;

			_screen.Text = ::Reforged.Mod.Tooltips.parseString(::String.replace(text, v.getName(), format("[%s|Obj+%s]", v.getName(), "contentType:ui-item")));
			foreach (option in _screen.Options)
			{
				this.__addItemLinkInEntry(option, v, "Text");
			}
			foreach (entry in _screen.List)
			{
				this.__addItemLinkInEntry(entry, v);
			}
		}

		// Instead of looking through all the bros in player roster and temporary roster
		// we only look through characters stored in the `m` table of the event/contract
		// as they are usually the ones referred to in List.
		local players = [];
		foreach (v in _event.m)
		{
			if (::MSU.isKindOf(v, "player"))
			{
				players.push(v);
			}
		}

		// Iterate on each entry in List and convert any mention of player name or item name from stash
		// to a link to that player or item.
		// Warning: If two bros have identical names and are present in the same event (its m table)
		// we may end up linking the wrong one.
		// Warning: If two items have the same name and icon we may end up linking the wrong one.
		if (_screen.List.len() != 0)
		{
			local items = ::World.Assets.getStash().getItems().filter(@(_, _item) _item != null);
			local icons = items.map(@(_item) "ui/items/" + _item.getIcon());

			foreach (entry in _screen.List)
			{
				if ("text" in entry)
				{
					local bro = null;
					foreach (p in players)
					{
						local name = p.getName();
						local idx = entry.text.find(name);
						if (idx == null)
						{
							name = p.getNameOnly();
							idx = entry.text.find(name);
						}
						if (idx != null)
						{
							entry.text = ::Reforged.Mod.Tooltips.parseString(::String.replace(entry.text, name, format("[%s|EventActor+%i]", name, p.getID())));
							bro = p;
							break;
						}
					}
					// Could be a skill icon
					if (bro != null && "icon" in entry)
					{
						local isDone = false;
						local icon = entry.icon;
						foreach (s in bro.getSkills().m.Skills)
						{
							if (s.getIcon() == icon)
							{
								entry.icon = ::Reforged.Mod.Tooltips.parseString(format("[Img/gfx/%s|Skill+%s,entityId:%i]", icon, s.ClassName, bro.getID()));
								entry.text = ::Reforged.Mod.Tooltips.parseString(::String.replace(entry.text, s.getName(), ::Reforged.NestedTooltips.getNestedSkillName(s, "entityId:" + bro.getID())));
								isDone = true;
								break;
							}
						}

						if (isDone)
						{
							continue;
						}
					}
				}

				if ("icon" in entry)
				{
					local idx = icons.find(entry.icon);
					if (idx != null && "text" in entry && entry.text.find(items[idx].getName()) != null)
					{
						local item = items[idx];
						entry.icon = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedItemImage(item));
						entry.text = ::Reforged.Mod.Tooltips.parseString(::String.replace(entry.text, item.getName(), ::Reforged.NestedTooltips.getNestedItemName(item)));
						continue;
					}
				}
			}
		}
	}

	// Is called after prepareVariables in event or contract.
	// We retroactively look through all vars and convert applicable ones to hyperlinks.
	function addHyperlinksToPrepareVariables( _vars, _event )
	{
		local factions = ::World.FactionManager.getFactionsOfType(::Const.FactionType.NobleHouse);
		factions.extend(::World.FactionManager.getFactionsOfType(::Const.FactionType.Settlement));
		factions.extend(::World.FactionManager.getFactionsOfType(::Const.FactionType.OrientalCityState));

		local factionNames = factions.map(@(_f) _f.getName());
		local factionNamesOnly = factions.map(@(_f) _f.m.Name);

		local bros = ::World.getPlayerRoster().getAll();
		bros.extend(::World.getTemporaryRoster().getAll());

		local broNames = bros.map(@(_b) _b.getName());
		local broNamesOnly = bros.map(@(_b) _b.getNameOnly());

		local isContract = ::MSU.isKindOf(_event, "contract");

		foreach (pair in _vars)
		{
			switch (pair[0])
			{
				case "SPEECH_ON": case "SPEECH_START": case "SPEECH_OFF":
				case "OOC": case "OOC_OFF":
				case "companyname":
				case "randomnoble":
				case "randomname":
					continue;
			}

			if (isContract)
			{
				switch (pair[0])
				{
					case "employer":
						if (_event.m.EmployerID != 0)
						{
							pair[1] = ::Reforged.Mod.Tooltips.parseString(format("[%s|EventActor+%i]", pair[1], _event.m.EmployerID));
							continue;
						}
						break;

					case "faction":
						pair[1] = ::Reforged.Mod.Tooltips.parseString(format("[%s|Faction+%i]", pair[1], ::World.FactionManager.getFaction(_event.getFaction()).getID()));
						continue;

					case "origin":
						pair[1] = ::Reforged.Mod.Tooltips.parseString(format("[%s|WorldEntity+%i]", pair[1], _event.getOrigin().getID()));
						continue;

					case "townname":
						pair[1] = ::Reforged.Mod.Tooltips.parseString(format("[%s|WorldEntity+%i]", pair[1], _event.getHome().getID()));
						continue;
				}
			}

			local text = pair[1];

			// Warning: If two bros have identical names, we may end up linking the wrong one.
			local idx = broNamesOnly.find(text);
			if (idx == null)
			{
				idx = broNames.find(text);
			}
			if (idx != null)
			{
				pair[1] = ::Reforged.Mod.Tooltips.parseString(format("[%s|EventActor+%i]", text, bros[idx].getID()));
				continue;
			}

			idx = factionNames.find(text);
			if (idx == null)
			{
				idx = factionNamesOnly.find(text);
			}
			if (idx != null)
			{
				pair[1] = ::Reforged.Mod.Tooltips.parseString(format("[%s|Faction+%i]", text, factions[idx].getID()));
				continue;
			}
		}
	}
}

::Reforged.QueueBucket.FirstWorldInit.push(function() {
	foreach (concept in ::Reforged.NestedTooltips.AutoConcepts)
	{
		local c = concept;
		::Reforged.NestedTooltips.Tooltips.Concept[split(concept, ".").top()] <- ::MSU.Class.CustomTooltip(@(_) ::TooltipScreen.m.TooltipEvents.general_queryUIElementTooltipData(::MSU.getDummyPlayer().getID(), c, null));
	}

	::MSU.Table.merge(::Reforged.NestedTooltips.Tooltips.Concept, {
		Disabled = ::MSU.Class.BasicTooltip("Disabled", ::Reforged.Mod.Tooltips.parseString("A disabled character is unable to act and will skip their [turn|Concept.Turn].\n\nExamples of [effects|Concept.StatusEffect] which can cause a character to become disabled include [$ $|Skill+stunned_effect] and [$ $|Skill+sleeping_effect].")),
		Rooted = ::MSU.Class.BasicTooltip("Rooted", ::Reforged.Mod.Tooltips.parseString("A rooted character is stuck in place - unable to move or be moved from their position.\n\nExamples of [effects|Concept.StatusEffect] which can cause a character to become rooted include [$ $|Skill+net_effect] and [$ $|Skill+web_effect].")),
		Wait = ::MSU.Class.BasicTooltip("Wait", ::Reforged.Mod.Tooltips.parseString(format("If you are not the last character in the [turn order|Concept.Turn] in a [round|Concept.Round], you may use the Wait action. This moves you to the end of the current [turn order|Concept.Turn], allowing you to act again before the end of the [round|Concept.Round].\n\nYou can only use Wait once per [turn|Concept.Turn].%s", ::Const.CharacterProperties.InitiativeAfterWaitMult == 1.0 ? "" : "\n\nUsing Wait causes your [turn order|Concept.Turn] in the next [round|Concept.Round] to be calculated with " + ::MSU.Text.colorizeMult(::Const.CharacterProperties.InitiativeAfterWaitMult) + " " + (::Const.CharacterProperties.InitiativeAfterWaitMult > 1.0 ? "more" : "less") + " [Initiative|Concept.Initiative]."))),
		Perk = ::MSU.Class.BasicTooltip("Perk", ::Reforged.Mod.Tooltips.parseString("As characters gain levels, they unlock perk points which can be spent to unlock powerful perks. Perks grant a character permanent bonuses or unlock new skills for use. The character\'s current [perk tier|Concept.PerkTier] increases by 1 each time a perk point is spent.")),
		StatusEffect = ::MSU.Class.BasicTooltip("Status Effect", ::Reforged.Mod.Tooltips.parseString("Status effects are positive or negative effects on a character, which are mostly temporary. A status effect can have various effects ranging from increasing/decreasing [attributes|Concept.CharacterAttribute] to unlocking new abilities.")),
		Injury = ::MSU.Class.BasicTooltip("Injury", ::Reforged.Mod.Tooltips.parseString("If sufficient damage is dealt to [Hitpoints|Concept.Hitpoints] during combat, characters can sustain an injury. Injuries are [status effects|Concept.StatusEffect] that confer various maluses.\n\nInjuries sustained during combat are [temporary|Concept.InjuryTemporary], and will heal over time. Such injuries can be treated at a Temple for faster healing.\n\nIf a character is killed during combat, they have a chance to be struck down instead of being killed and survive the battle with a [permanent injury|Concept.InjuryPermanent]"))
		InjuryTemporary = ::MSU.Class.BasicTooltip("Temporary Injury", ::Reforged.Mod.Tooltips.parseString("Temporary injuries are received during combat when the damage to [Hitpoints|Concept.Hitpoints] received by a character exceeds the injury threshold. These injuries heal over time, but can be treated at a Temple for faster healing."))
		InjuryPermanent = ::MSU.Class.BasicTooltip("Permanent Injury", ::Reforged.Mod.Tooltips.parseString("Permanent injuries are received when a character is \'struck down\' during combat instead of being killed. These injuries, and the maluses they incur, are forever.")),
		InjuryThreshold = ::MSU.Class.BasicTooltip("Injury Threshold", ::Reforged.Mod.Tooltips.parseString("If the damage received to [Hitpoints|Concept.Hitpoints] is at least " + ::MSU.Text.colorNegative(::Const.Combat.InjuryMinDamage) + " and is greater than a certain percentage of the maximum [Hitpoints|Concept.Hitpoints], the character receives an [injury|Concept.InjuryTemporary]. This percentage can be modified by certain [perks|Concept.Perk] or traits of both the attacker and the target.\n\nCertain [injuries|Concept.InjuryTemporary] require this percentage to be at least a certain value before they can be inflicted, with heavier [injuries|Concept.InjuryTemporary] requiring a higher percentage.\n\nFor example the threshold for [$ $|Skill+cut_arm_injury] is " + ::MSU.Text.colorNegative(getThresholdForInjury("injury/cut_arm_injury") + "%") + " and that of [$ $|Skill+split_hand_injury] is " + ::MSU.Text.colorNegative(getThresholdForInjury("injury/split_hand_injury") + "%") + ".")),
		Reach = ::MSU.Class.CustomTooltip(function(_data){
			local ret = [
			{
				id = 1,
				type = "title",
				text = "Reach"
			},
			{
				id = 2,
				type = "description",
				text = ::Reforged.Mod.Tooltips.parseString("Reach is a depiction of how far a character\'s attacks can reach, making melee combat easier against targets with shorter reach.\n\n[Melee skill|Concept.MeleeSkill] is increased when attacking opponents with shorter reach, and reduced against opponents with longer reach. Reach has diminishing returns, starting at " + ::Reforged.Reach.BonusPerReach + " and dropping by 1 to a minimum of 1. It only applies when attacking a target adjacent to you or up to 2 tiles away with nothing between you and the target.\n\nAfter a successful hit, the target\'s [Reach Advantage|Concept.ReachAdvantage] is lost until the attacker waits or ends their turn.\n\nShields can negate some or all of the target\'s [Reach Advantage|Concept.ReachAdvantage]. Characters who are rooted have their Reach halved. Those without a melee attack have no Reach.")
			}]
			if ("entityId" in _data && "TooltipEvents" in this.getroottable())
			{
				ret.extend(::TooltipEvents.getBaseAttributesTooltip( _data.entityId, _data.elementId, null));
			}
			return ret;
		}),
		ReachIgnoreOffensive = ::MSU.Class.BasicTooltip("Offensive Reach Ignore", ::Reforged.Mod.Tooltips.parseString(@"This represents the amount of [Reach Disadvantage|Concept.ReachDisadvantage] that a character can ignore when attacking a target with higher [Reach|Concept.Reach].")),
		ReachIgnoreDefensive = ::MSU.Class.BasicTooltip("Defensive Reach Ignore", ::Reforged.Mod.Tooltips.parseString(@"This represents the amount of [Reach Disadvantage|Concept.ReachDisadvantage] that a character can ignore when defending against an attacker who has higher [Reach|Concept.Reach].")),
		ReachAdvantage = ::MSU.Class.BasicTooltip("Reach Advantage", ::Reforged.Mod.Tooltips.parseString("A character is considered to have Reach Advantage when their [Reach|Concept.Reach] is greater than that of the other character during an attack. The Reach Advantage in this case refers to the difference in the two characters' [Reach|Concept.Reach] values.\n\nIf a character has a shield equipped, the shield can help negate the Reach Advantage of an attacker, and with the [$ $|Perk+perk_duelist] perk, can also help negate that of a target.")),
		ReachDisadvantage = ::MSU.Class.BasicTooltip("Reach Disadvantage", ::Reforged.Mod.Tooltips.parseString("A character is considered to have Reach Disadvantage when their [Reach|Concept.Reach] is lower than that of the other character during an attack. The Reach Disadvantage in this case refers to the difference in the two characters' [Reach|Concept.Reach] values.")),
		PerkTier = ::MSU.Class.BasicTooltip("Perk Tier", ::Reforged.Mod.Tooltips.parseString("[Perks|Concept.Perk] are distributed in a character\'s perk tree across 7 rows which are known as tiers. A character must have spent at least as many perk points as the tier-1 to be able to access the perks on that tier.")),
		StackMultiplicatively = ::MSU.Class.BasicTooltip("Stacking Multiplicatively", ::Reforged.Mod.Tooltips.parseString("Values can stack multiplicatively or [additively|Concept.StackAdditively]. Multiplicative stacking means that the values are multiplied.\n\nFor example, imagine a value of 100. Two skills that both increase this by 40% and stack multiplicatively increase the value by a total of 1.4 x 1.4 = 1.96 times, so it becomes 100 x 1.96 = 196. Two skills that reduce it by 40% and stack multiplicatively reduce it by (1.0 - 0.4) x (1.0 - 0.4) = 0.36 times, so it becomes 100 x 0.36 = 36.\n\nGenerally, [additive stacking|Concept.StackAdditively] is stronger when reducing a value or when the value is small and multiplicative stacking is stronger when increasing a value or when the value is large.")),
		StackAdditively = ::MSU.Class.BasicTooltip("Stacking Additively", ::Reforged.Mod.Tooltips.parseString("Values can stack [multiplicatively|Concept.StackMultiplicatively] or additively. Additive stacking means that the values are added.\n\nFor example, imagine a value of 100. Two skills that both increase this by 40% and stack additively increase the value by a total of 1.0 + 0.4 + 0.4 = 1.8 times, so it becomes 100 x 1.8 = 180. Two skills that reduce it by 40% and stack additively reduce it by 1.0 - 0.4 - 0.4 = 0.2 times, so it becomes 100 x 0.2 = 20.\n\nGenerally, additive stacking is stronger when reducing a value or when the value is small and [multiplicative stacking|Concept.StackMultiplicatively] is stronger when increasing a value or when the value is large.")),
		CharacterAttribute = ::MSU.Class.BasicTooltip("Character Attribute", ::Reforged.Mod.Tooltips.parseString("Characters in Battle Brothers have various attributes that describe the character\'s skill and/or aptitude in certain areas. Attributes include: [Hitpoints|Concept.Hitpoints], [Fatigue|Concept.Fatigue], [Resolve|Concept.Bravery], [Initiative|Concept.Initiative] [Melee Skill|Concept.MeleeSkill], [Melee Defense|Concept.MeleeDefense], [Ranged Skill|Concept.RangeSkill] and [Ranged Defense|Concept.RangeDefense].\n\nAs characters gain [experience|Concept.Experience] and [level up|Concept.Level] they can increase their attributes and unlock [perks|Concept.Perk].")),
		BaseAttribute = ::MSU.Class.BasicTooltip("Base Attribute", ::Reforged.Mod.Tooltips.parseString("A character\'s [attributes|Concept.CharacterAttribute] can be modified by various means e.g. perks, traits, status effects, equipment etc. The Base value of the attribute is the one that is before any such modifications. See also: [Current Attribute|Concept.CurrentAttribute].")),
		CurrentAttribute = ::MSU.Class.BasicTooltip("Current Attribute", ::Reforged.Mod.Tooltips.parseString("A character\'s [attributes|Concept.CharacterAttribute] can be modified by various means e.g. perks, traits, status effects, equipment etc. The Current value of the attribute is the one that is after any such modifications. See also: [Base Attribute|Concept.BaseAttribute].")),
		Surrounding = ::MSU.Class.BasicTooltip("Surrounding", ::Reforged.Mod.Tooltips.parseString("When a character is in the zone of control of multiple hostile characters, he is considered surrounded. Characters attacking a surrounded target in melee gain additional chance to hit. Several perks such as [$ $|Perk+perk_underdog], [$ $|Perk+perk_backstabber] and [$ $|Perk+perk_rf_long_reach] interact with the surrounding mechanic, reducing or increasing its effectiveness.")),
		FatigueRecovery = ::MSU.Class.BasicTooltip("Fatigue Recovery", ::Reforged.Mod.Tooltips.parseString("At the start of every turn the [Fatigue|Concept.Fatigue] of a character is reduced by a certain amount. This is known as Fatigue Recovery.\n\nBy default the Fatigue Recovery of player characters is 15, whereas enemies, depending on the enemy type, may have a much higher Fatigue Recovery.\n\nFatigue Recovery may be affected by [perks|Concept.Perk], [traits|Concept.Trait], [status effects|Concept.StatusEffect] and [injuries|Concept.Injury].")),
		AOE = ::MSU.Class.BasicTooltip("Area of Effect", ::Reforged.Mod.Tooltips.parseString("Area of Effect (AOE) skills target multiple tiles with their effects instead of only a single tile.")),
		Fatality = ::MSU.Class.BasicTooltip("Fatality", ::Reforged.Mod.Tooltips.parseString("Fatalities are special forms of death which depict a certain gruesomeness beyond the ordinary. Fatalities include:\n- Decapitation - removing the target\'s head.\n- Disembowelment - opening up the target\'s belly to spill the guts.\n- Smashing - smashing the target\'s head into bits.")),
		Turn = ::MSU.Class.BasicTooltip("Turn", ::Reforged.Mod.Tooltips.parseString("Combat in battle brothers is turn-based. Each combat consists of a series of [rounds|Concept.Round]. During a round, characters act in turns. A character\'s position in the turn order is determined by the character\'s [Initiative|Concept.Initiative] relative to other characters.\n\n[Effects|Concept.StatusEffect] that last a certain number of turns last until the character has started or ended their turn that many times, depending on whether the [effect|Concept.StatusEffect] expires at the start or end of the turn respectively.")),
		Round = ::MSU.Class.BasicTooltip("Round", ::Reforged.Mod.Tooltips.parseString("Combat in battle brothers is turn-based. Each combat consists of a series of rounds. During a round, characters act in [turns|Concept.Turn]. A round ends when all characters have ended their [turns|Concept.Turn].")),
		ZoneOfControl = ::MSU.Class.BasicTooltip("Zone of Control", ::Reforged.Mod.Tooltips.parseString("Most melee characters exert Zone of Control on their surrounding tiles. Trying to move out of enemy Zone of Control will trigger one free attack from each controlling enemy until the first attack hit or every attack missed. A hit will cancel the movement.")),
		BagSlots = ::MSU.Class.BasicTooltip("Bag Slots", ::Reforged.Mod.Tooltips.parseString("Bag slots can be used to store additional weapons or utility items for use during combat. Every character has " + ::new("scripts/items/item_container").getUnlockedBagSlots() + " bag slots by default and can have a maximum of " + ::Const.ItemSlotSpaces[::Const.ItemSlot.Bag] + ".")),
		HybridWeapon = ::MSU.Class.BasicTooltip("Hybrid Weapon", ::Reforged.Mod.Tooltips.parseString("Hybrid Weapons are weapons with two weapon types. Non-Hybrid Weapons have only one weapon type.")),
		Trait = ::MSU.Class.BasicTooltip("Trait", ::Reforged.Mod.Tooltips.parseString("Characters can have several traits that are semi-permanent and represent aspects of their personality. Traits are different from [perks|Concept.Perk] and cannot be learned through [experience|Concept.Experience] or [level-ups|Concept.Level]. Traits can give various bonuses or maluses for example: [$ $|Skill+huge_trait] and [$ $|Skill+tiny_trait]."))
	});

	::Reforged.Mod.Tooltips.setTooltips(::Reforged.NestedTooltips.Tooltips);
});
