this.rf_adjust_dented_armor_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_adjust_dented_armor";
		this.m.Name = "Adjust Dented Armor";
		this.m.Description = "Adjust your dented armor. While this is an exhausting and time consuming task, it may be worthwhile to regain your mobility.";
		this.m.Icon = "skills/rf_adjust_dented_armor_skill.png";
		this.m.IconDisabled = "skills/rf_adjust_dented_armor_skill_bw.png";
		this.m.Overlay = "rf_adjust_dented_armor_skill";
		this.m.SoundOnHit = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
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
			tooltip.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Cannot be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
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

