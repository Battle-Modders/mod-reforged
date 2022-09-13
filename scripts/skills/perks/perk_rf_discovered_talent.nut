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

		local requiredLevelUpsSpent = this.getContainer().hasSkill("perk.gifted") ? 5 : 4;

		if (actor.m.LevelUpsSpent < requiredLevelUpsSpent)
		{
			local startIndex = requiredLevelUpsSpent - actor.m.LevelUpsSpent;
			local attributes = array(actor.m.Attributes.len());

			foreach (i, attributeLevelUps in actor.m.Attributes)
			{
				attributes[i] = array(startIndex);
				for (local j = 0; j < startIndex; j++)
				{
					attributes[i][j] = attributeLevelUps[j];
				}
			}

			actor.m.Attributes.clear();
			actor.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - actor.getLevel() + actor.m.LevelUps);

			foreach (i, attributeLevelUps in attributes)
			{
				foreach (j, levelup in attributeLevelUps)
				{
					actor.m.Attributes[i][j] = levelup;
				}
			}
		}
		else
		{
			actor.m.Attributes.clear();
			actor.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - actor.getLevel() + actor.m.LevelUps);
		}

		actor.m.LevelUps += 1;
		actor.fillAttributeLevelUpValues(1);

		this.m.IsApplied = true;
	}

	function onDeserialize(_in)
	{
		this.skill.onDeserialize(_in);
		this.m.IsApplied = true;
	}
});
