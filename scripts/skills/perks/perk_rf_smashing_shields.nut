this.perk_rf_smashing_shields <- ::inherit("scripts/skills/skill", {
	m = {
		APRestore = 4,
		Shield = null
	},
	function create()
	{
		this.m.ID = "perk.rf_smashing_shields";
		this.m.Name = ::Const.Strings.PerkName.RF_SmashingShields;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SmashingShields;
		this.m.Icon = "ui/perks/rf_smashing_shields.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!_skill.isRanged() && _targetEntity != null)
		{
			this.m.Shield = _targetEntity.getOffhandItem();
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!::MSU.isNull(this.m.Shield) && this.m.Shield.isItemType(::Const.Items.ItemType.Shield) && this.m.Shield.getCondition() == 0)
		{
			local user = this.getContainer().getActor();
			user.setActionPoints(::Math.min(user.getActionPointsMax(), user.getActionPoints() + this.m.APRestore));
			this.spawnIcon("perk_rf_smashing_shields", user.getTile());
		}

		this.m.Shield = null;
	}
});

