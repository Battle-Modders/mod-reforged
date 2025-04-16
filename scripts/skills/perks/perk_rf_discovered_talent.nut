this.perk_rf_discovered_talent <- ::inherit("scripts/skills/skill", {
	m = {
		AttributesRolled = [],
		MaxStars = 3,
		StarsChance = ::MSU.Class.WeightedContainer([ // [chance, numStars]
			[70, 1],
			[20, 2],
			[10, 3]
		])
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

		::Math.seedRandom(1000 * actor.getUID() + ::toHash(this.getID()) + this.m.AttributesRolled.len() * 10000);

		local choice = ::MSU.Array.rand(potential);

		::Math.seedRandom(::Time.getRealTime());

		actor.getTalents()[choice] = ::Math.min(this.m.MaxStars, actor.getTalents()[choice] + this.StarsChance.roll());

		actor.m.Attributes.clear();
		actor.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - actor.getLevel() + actor.m.LevelUps);

		this.m.AttributesRolled.push(choice);
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
