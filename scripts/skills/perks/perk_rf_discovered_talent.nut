this.perk_rf_discovered_talent <- ::inherit("scripts/skills/skill", {
	m = {
		AttributesRolled = [],
		// Will not roll for attributes already at this many stars and will not set any attribute to be more than this many stars
		MaxStars = 3
	},
	function create()
	{
		this.m.ID = "perk.rf_discovered_talent";
		this.m.Name = ::Const.Strings.PerkName.RF_DiscoveredTalent;
		this.m.Description = ::Const.Strings.PerkDescription.RF_DiscoveredTalent;
		this.m.Icon = "ui/perks/perk_rf_discovered_talent.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsRefundable = false;
	}

	// Is called from player.setAttributeLevelUpValues
	function addStars()
	{
		local actor = this.getContainer().getActor();
		local potential = [];
		foreach (attribute in ::Const.Attributes)
		{
			if (attribute != ::Const.Attributes.COUNT && actor.getTalents()[attribute] < this.m.MaxStars && this.m.AttributesRolled.find(attribute) == null)
				potential.push(attribute);
		}

		if (potential.len() == 0)
			return;

		::Reforged.Math.seedRandom(actor.getUID(), this.getID(), this.m.AttributesRolled.len());

		local choice = ::MSU.Array.rand(potential);
		actor.getTalents()[choice] = ::Math.min(this.m.MaxStars, actor.getTalents()[choice] + this.rollStars(choice));

		::Math.seedRandom(::Time.getRealTime());

		actor.m.Attributes.clear();
		actor.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - actor.getLevel() + actor.m.LevelUps);

		this.m.AttributesRolled.push(choice);
	}

	// We pass _attribute in case someone wants to do complex logic with it
	// _attribute is a value from ::Const.Attributes
	function rollStars( _attribute )
	{
		return ::MSU.Class.WeightedContainer([ // [chance, numStars]
			[60, 1],
			[25, 2],
			[15, 3]
		]).roll();
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeU8(this.m.AttributesRolled.len());
		foreach (attribute in this.m.AttributesRolled)
		{
			_out.writeU8(attribute);
		}
	}

	function onDeserialize(_in)
	{
		this.skill.onDeserialize(_in);
		local len = _in.readU8();
		this.m.AttributesRolled = array(len);
		for (local i = 0; i < len; i++)
		{
			this.m.AttributesRolled[i] = _in.readU8();
		}
	}
});
