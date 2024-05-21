this.perk_rf_deep_impact <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Hammer,
		RequiredDamageType = ::Const.Damage.DamageType.Blunt
	},
	function create()
	{
		this.m.ID = "perk.rf_deep_impact";
		this.m.Name = ::Const.Strings.PerkName.RF_DeepImpact;
		this.m.Description = ::Const.Strings.PerkDescription.RF_DeepImpact;
		this.m.Icon = "ui/perks/rf_deep_impact.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onEquip( _item )
	{
		if (this.m.RequiredWeaponType == null || !_item.isItemType(::Const.Items.ItemType.Weapon) || !_item.isWeaponType(this.m.RequiredWeaponType))
			return;

		local self = this;
		_item.addSkill(::MSU.new("scripts/skills/actives/rf_deep_impact_skill", function(o) {
			o.m.RequiredWeaponType = self.m.RequiredWeaponType;
			o.m.RequiredDamageType = self.m.RequiredDamageType;
		}));
	}

	function onAdded()
	{
		if (this.m.RequiredWeaponType == null)
		{
			local self = this;
			this.getContainer().add(::MSU.new("scripts/skills/actives/rf_deep_impact_skill", function(o) {
				o.m.RequiredWeaponType = self.m.RequiredWeaponType;
				o.m.RequiredDamageType = self.m.RequiredDamageType;
			}));
		}
		else
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			if (weapon != null)
				this.onEquip(weapon);
		}
	}

	function onRemoved()
	{
		if (this.m.RequiredWeaponType == null)
			this.getContainer().removeByID("actives.rf_deep_impact");
	}
});
