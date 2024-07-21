this.perk_rf_rising_star <- ::inherit("scripts/skills/skill", {
	m = {
		StartLevel = null,
		LevelsRequiredForPerk = 5	
	},
	function create()
	{
		this.m.ID = "perk.rf_rising_star";
		this.m.Name = ::Const.Strings.PerkName.RF_RisingStar;
		this.m.Description = "This character is a destined for greatness.";
		this.m.Icon = "ui/perks/perk_rf_rising_star.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsRefundable = false;
	}

	function isHidden()
	{
		return this.m.StartLevel + this.m.LevelsRequiredForPerk <= this.getContainer().getActor().getLevel();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will gain 2 [perk points|Concept.Perk] at [level|Concept.Level] " + (this.m.StartLevel + this.m.LevelsRequiredForPerk))
		});
		return ret;
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
