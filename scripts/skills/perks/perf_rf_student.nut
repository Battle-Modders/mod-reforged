this.perk_rf_student <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_student";
		this.m.Name = this.Const.Strings.PerkName.Student;
		this.m.Description = this.Const.Strings.PerkDescription.Student;
		this.m.Icon = "ui/perks/perk_21.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local player = this.getContainer().getActor();
		if (player.getLevel() < player.getParagonLevel())
		{
			_properties.XPGainMult *= 1.2;
		}
	}

	function onUpdateLevel()
	{
		local player = this.getContainer().getActor();
		if (player.getLevel() == player.getParagonLevel())
		{
			player.m.PerkPoints++;
		}
	}

});

