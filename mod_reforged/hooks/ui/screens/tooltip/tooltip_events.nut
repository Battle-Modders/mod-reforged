::Reforged.HooksMod.hook("scripts/ui/screens/tooltip/tooltip_events", function(q) {
	q.general_queryUIElementTooltipData = @(__original) function( _entityId, _elementId, _elementOwner )
	{
		switch (_elementId)
		{
			case "character-screen.left-panel-header-module.Experience":
				return [
					{
						id = 1,
						type = "title",
						text = "Experience"
					},
					{
						id = 2,
						type = "description",
						text = ::Reforged.Mod.Tooltips.parseString("Characters gain experience as they or their allies slay enemies in battles. If a character has accumulated sufficient experience, he\'ll [level up|Concept.Level].\n\nExperience gained from dying enemies is proportional to the fraction of the total damage dealt to that enemy by your company. Of this experience, " + (::Const.XP.XPForKillerPct * 100) + "% is shared proportionally between the brothers who did damage. The other " + (100 - ::Const.XP.XPForKillerPct * 100) + "% is shared equally among all members of the company.")
					}
				];

			case "character-screen.left-panel-header-module.Level":
				return [
					{
						id = 1,
						type = "title",
						text = "Level"
					},
					{
						id = 2,
						type = "description",
						text = ::Reforged.Mod.Tooltips.parseString("The character\'s level measures [experience|Concept.Experience] in battle. Characters rise in levels as they gain experience and are able to increase their [attributes|Concept.CharacterAttribute] and gain [perks|Concept.Perk] that make them better at the mercenary profession.\n\nBeyond the " + ::Const.XP.MaxLevelWithPerkpoints + "th character level, characters are veterans and gain perk points " + (::Reforged.Config.VeteranPerksLevelStep == 1 ? "" : "only") + " every " + ::Reforged.Config.VeteranPerksLevelStep + "th level. They can still improve their attributes but the attribute gain per level is small.")
					}
				];

			case "menu-screen.new-campaign.EasyDifficulty":
				local ret = [
					{
						id = 1,
						type = "title",
						text = "Beginner Difficulty"
					},
					{
						id = 2,
						type = "description",
						text = "Your men gain experience slightly faster and enemies are slightly weaker, to ease you into the game.\n\nRecommended for players new to the game."
					}
				];
				::Const.Difficulty.generateTooltipInfo(ret, ::Const.Difficulty.Easy);
				return ret;

			case "menu-screen.new-campaign.NormalDifficulty":
				local ret =  [
					{
						id = 1,
						type = "title",
						text = "Veteran Difficulty"
					},
					{
						id = 2,
						type = "description",
						text = "Provides for a balanced playing experience that can be quite challenging.\n\nRecommended for veterans of the game or the genre."
					}
				];
				::Const.Difficulty.generateTooltipInfo(ret, ::Const.Difficulty.Normal);
				return ret;

			case "menu-screen.new-campaign.HardDifficulty":
				local ret =  [
					{
						id = 1,
						type = "title",
						text = "Expert Difficulty"
					},
					{
						id = 2,
						type = "description",
						text = "Your opponents will be more challenging and numerous.\n\nRecommended for experts in the game who want an even deadlier challenge."
					}
				];
				::Const.Difficulty.generateTooltipInfo(ret, ::Const.Difficulty.Hard);
				return ret;
		}

		return __original(_entityId, _elementId, _elementOwner);
	}
});
