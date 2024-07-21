this.perk_rf_target_practice <- ::inherit("scripts/skills/skill", {
	m = {
		RangedSkillBonus = 10
	},
	function create()
	{
		this.m.ID = "perk.rf_target_practice";
		this.m.Name = ::Const.Strings.PerkName.RF_TargetPractice;
		this.m.Description = ::Const.Strings.PerkDescription.RF_TargetPractice;
		this.m.Icon = "ui/perks/perk_rf_target_practice.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.ItemActionOrder = ::Const.ItemActionOrder.First;
	}

	function isEnabled()
	{
		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Bow);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_skill.isRanged() || !_skill.m.IsWeaponSkill || !this.isEnabled())
			return;

		if (_targetEntity.isArmedWithRangedWeapon() || ::Const.Tactical.Common.getBlockedTiles(this.getContainer().getActor().getTile(), _targetEntity.getTile(), this.getContainer().getActor().getFaction()).len() == 0);
		{
			_properties.RangedSkill += this.m.RangedSkillBonus;
		}
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (!_skill.isRanged() || !_skill.m.IsWeaponSkill || !this.isEnabled())
			return;

		local targetEntity = _targetTile.getEntity();
		if (targetEntity != null && (targetEntity.isArmedWithRangedWeapon() || ::Const.Tactical.Common.getBlockedTiles(this.getContainer().getActor().getTile(), targetEntity.getTile(), this.getContainer().getActor().getFaction()).len() == 0))
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]" + this.m.RangedSkillBonus + "%[/color] " + this.getName()
			});
		}
	}
});
