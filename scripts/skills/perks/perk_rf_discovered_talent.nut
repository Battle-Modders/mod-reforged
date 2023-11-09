this.perk_rf_discovered_talent <- ::inherit("scripts/skills/skill", {
	m = {
		IsApplied = false
	},
	function create()
	{
		this.m.ID = "perk.rf_discovered_talent";
		this.m.Name = ::Const.Strings.PerkName.RF_DiscoveredTalent;
		this.m.Description = ::Const.Strings.PerkDescription.RF_DiscoveredTalent;
		this.m.Icon = "ui/perks/rf_discovered_talent.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsRefundable = false;
	}

	function onAdded()
	{
		if (this.m.IsApplied || !this.getContainer().getActor().isPlayerControlled() || !::MSU.isKindOf(this.getContainer().getActor(), "player"))
		{
			return;
		}

		local actor = this.getContainer().getActor();

		local talents = actor.getTalents();
		for (local i = 0; i < talents.len(); i++)
		{
			if (talents[i] < 3)
			{
				talents[i] += 1;
			}
		}

		// Because of its perk requirement we guaranteed that there are no pending past level-ups which would otherwise be overwritten
		actor.m.Attributes.clear();
		actor.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - actor.getLevel() + 1);
		actor.m.LevelUps += 1;

		this.m.IsApplied = true;
	}

	function onDeserialize(_in)
	{
		this.skill.onDeserialize(_in);
		this.m.IsApplied = true;
	}
});
