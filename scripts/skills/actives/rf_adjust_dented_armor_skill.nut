this.rf_adjust_dented_armor_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_adjust_dented_armor";
		this.m.Name = "Adjust Dented Armor";
		this.m.Description = "Adjust your dented armor. While this is an exhausting and time consuming task, it may be worthwhile to regain your mobility.";
		this.m.Icon = "skills/rf_adjust_dented_armor_skill.png";
		this.m.IconDisabled = "skills/rf_adjust_dented_armor_skill_sw.png";
		this.m.Overlay = "rf_adjust_dented_armor_skill";
		this.m.SoundOnUse = [
			"sounds/ambience/settlement/fortification_armor_weapons_00.wav",
			"sounds/ambience/settlement/fortification_armor_weapons_01.wav",
			"sounds/ambience/settlement/fortification_armor_weapons_02.wav",
			"sounds/ambience/settlement/fortification_armor_weapons_03.wav",
			"sounds/ambience/settlement/fortification_armor_weapons_04.wav",
			"sounds/ambience/settlement/fortification_armor_weapons_05.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Removes the [Dented Armor|Skill+rf_dented_armor_effect] effect")
		});

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Cannot be used because this character is [engaged|Concept.ZoneOfControl] in melee"))
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().getActor().isEngagedInMelee();
	}

	function onUse( _user, _targetTile )
	{
		this.spawnIcon("rf_adjust_dented_armor_ally_skill", _user.getTile());
		this.getContainer().removeByID("effects.rf_dented_armor");
		_user.setDirty(true);
		return true;
	}
});
