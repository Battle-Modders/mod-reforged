this.perk_rf_small_target <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_small_target";
		this.m.Name = ::Const.Strings.PerkName.RF_SmallTarget;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SmallTarget;
		this.m.Icon = "ui/perks/rf_small_target.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.HitChance[::Const.BodyPart.Head] += 10;
	}
});

