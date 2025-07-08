this.perk_rf_deep_impact <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_deep_impact";
		this.m.Name = ::Const.Strings.PerkName.RF_DeepImpact;
		this.m.Description = ::Const.Strings.PerkDescription.RF_DeepImpact;
		this.m.Icon = "ui/perks/perk_rf_deep_impact.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onEquip( _item )
	{
		if (_item.isItemType(::Const.Items.ItemType.Weapon) && _item.isWeaponType(::Const.Items.WeaponType.Hammer))
		{
			_item.addSkill(::Reforged.new("scripts/skills/actives/rf_deep_impact_skill", function(o) {
				o.m.DirectDamageMult = _item.m.DirectDamageMult;
			}));
		}
	}

	function onAdded()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null)
			this.onEquip(weapon);
	}

	function onRemoved()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Hammer))
		{
			foreach (s in weapon.m.SkillPtrs)
			{
				if (s.getID() == "actives.rf_deep_impact")
				{
					weapon.removeSkill(s);
					break;
				}
			}
		}
	}
});
