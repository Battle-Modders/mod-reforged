this.perk_rf_fencer <- ::inherit("scripts/skills/skill", {
	m = {
		FatigueMult = 0.80,
		Bonus = 10
	},
	function create()
	{
		this.m.ID = "perk.rf_fencer";
		this.m.Name = ::Const.Strings.PerkName.RF_Fencer;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Fencer;
		this.m.Icon = "ui/perks/perk_rf_fencer.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onEquip( _item )
	{
		if (_item.isItemType(::Const.Items.ItemType.Weapon) && _item.isItemType(::Const.Items.ItemType.RF_Fencing))
		{
			if (_item.isItemType(::Const.Items.ItemType.OneHanded))
			{
				_item.addSkill(::Reforged.new("scripts/skills/actives/perforate_skill"));
				_item.addSkill(::Reforged.new("scripts/skills/actives/rf_perforate_sword_thrust_skill"));
			}
			else
			{
				_item.addSkill(::Reforged.new("scripts/skills/actives/lunge_skill"));
			}
		}
	}

	function onAdded()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null) this.onEquip(weapon);
	}

	function isEnabled()
	{
		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isItemType(::Const.Items.ItemType.RF_Fencing))
		{
			return false;
		}

		return true;
	}

	function onUpdate( _properties )
	{
		local passingStep = this.getContainer().getSkillByID("actives.rf_passing_step");
		if (passingStep != null)
		{
			passingStep.m.RequiredDamageType = null;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!this.getContainer().getActor().isPlayerControlled() || !this.isEnabled())
		{
			return;
		}

		if (_skill.getID() == "actives.lunge" || _skill.getID() == "actives.skewer")
		{
			_properties.MeleeSkill += this.m.Bonus;
			_skill.m.HitChanceBonus += this.m.Bonus;
		}
	}
});
