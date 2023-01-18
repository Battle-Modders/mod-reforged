this.perk_rf_leverage <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false
	},
	function create()
	{
		this.m.ID = "perk.rf_leverage";
		this.m.Name = ::Const.Strings.PerkName.RF_Leverage;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Leverage;
		this.m.Icon = "ui/perks/rf_leverage.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isItemType(::Const.Items.ItemType.TwoHanded) || weapon.getRangeMax() != 2)
		{
			return false;
		}

		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && !_skill.isRanged() && _targetEntity != null && _targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile()) == 2 && this.isEnabled())
		{
			_properties.HitChance[::Const.BodyPart.Head] += 20;
		}
	}
});
