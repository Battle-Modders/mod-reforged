this.perk_rf_rising_star <- ::inherit("scripts/skills/skill", {
	m = {
		StartLevel = null,
		LevelsRequiredForPerk = 5	
	},
	function create()
	{
		this.m.ID = "perk.rf_rising_star";
		this.m.Name = ::Const.Strings.PerkName.RF_RisingStar;
		this.m.Description = ::Const.Strings.PerkDescription.RF_RisingStar;
		this.m.Icon = "ui/perks/rf_rising_star.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsRefundable = false;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().getLevel() < this.m.StartLevel + this.m.LevelsRequiredForPerk)
		{
			_properties.XPGainMult *= 1.2;
		}
		else
		{
			_properties.XPGainMult *= 1.05;
		}
	}

	function onUpdateLevel()
	{
		if (this.getContainer().getActor().getLevel() == this.m.StartLevel + this.m.LevelsRequiredForPerk)
		{
			this.getContainer().getActor().m.PerkPoints += 2;
		}
	}

	function onAdded()
	{
		if (this.m.StartLevel == null) this.m.StartLevel = this.getContainer().getActor().getLevel();
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeU8(this.m.StartLevel);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.StartLevel = _in.readU8();
	}
});
