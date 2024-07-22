this.rf_adjust_dented_armor_ally_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_adjust_dented_armor_ally";
		this.m.Name = "Adjust Ally\'s Dented Armor";
		this.m.Description = "Adjust an ally\'s dented armor.";
		this.m.Icon = "skills/rf_adjust_dented_armor_ally_skill.png";
		this.m.IconDisabled = "skills/rf_adjust_dented_armor_ally_skill_sw.png";
		this.m.Overlay = "rf_adjust_dented_armor_ally_skill";
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
		this.m.IsTargeted = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Removes the Dented Armor status effect"
		});

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Cannot be used because this character is engaged in melee")
			});
		}

		return tooltip;
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();

		if (actor.isPlacedOnMap())
		{
			local myTile = actor.getTile();

			for (local i = 0; i < 6; i++)
			{
				if (myTile.hasNextTile(i))
				{
					local tile = myTile.getNextTile(i);

					if (::Math.abs(tile.Level - myTile.Level) <= 1 && tile.IsOccupiedByActor && !tile.getEntity().isEngagedInMelee() && actor.isAlliedWith(tile.getEntity()) && tile.getEntity().getSkills().hasSkill("effects.rf_dented_armor"))
					{
						return false;
					}
				}
			}
		}

		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (!this.m.Container.getActor().isAlliedWith(target))
		{
			return false;
		}

		if (target.getSkills().hasSkill("effects.rf_dented_armor"))
		{
			return true;
		}

		return false;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnIcon("rf_adjust_dented_armor_ally_skill", _targetTile);
		target.getSkills().removeByID("effects.rf_dented_armor");
		target.setDirty(true);
		return true;
	}
});

