this.rf_old_swordmaster_scenario_recruit_effect <- ::inherit("scripts/skills/effects/rf_old_swordmaster_scenario_abstract_effect", {
	m = {
		FreePerkChancePerLevel = 10
		FreePerksGainedIDs = []
	},
	function create()
	{
		this.rf_old_swordmaster_scenario_abstract_effect.create();
		this.m.ID = "effects.rf_old_swordmaster_scenario_recruit";
		this.m.Name = "Swordmaster\'s Training";
		this.m.Description = "This character is being trained by a highly accomplished swordmaster, and gains increased combat effectiveness when wielding a sword. This effect becomes stronger with each level.";
		this.m.Icon = "skills/rf_old_swordmaster_scenario_recruit_effect.png";
	}

	function getTooltip()
	{
		local ret = this.rf_old_swordmaster_scenario_abstract_effect.getTooltip();

		if (!this.isEnabled())
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Requires a Sword to be equipped")
			});
		}
		else
		{
			local skillBonus = this.getBonus();

			ret.extend([
				{
					id = 10,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(skillBonus, {AddSign = true}) + " [Melee Skill|Concept.MeleeSkill]")
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(skillBonus, {AddSign = true}) + " [Melee Defense|Concept.MeleeDefense]")
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(skillBonus, {AddSign = true}) + " [Initiative|Concept.Initiative]")
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(skillBonus, {AddSign = true, AddPercent = true}) + " damage ignores armor")
				}
			]);
		}

		if (this.getFreePerkChance() != 0)
		{
			local hasPotentialPerk = false;

			foreach (row in ::DynamicPerks.PerkGroups.findById("pg.rf_sword").getTree())
			{
				foreach (perkID in row)
				{
					if (this.m.FreePerksGainedIDs.find(perkID) == null)
					{
						ret.push({
							id = 14,
							type = "text",
							icon = "ui/icons/special.png",
							text = ::Reforged.Mod.Tooltips.parseString(format("Upon gaining a [level|Concept.Level], has a %s chance to learn a random [perk|Concept.Perk] from the Sword perk group. Will refund the [perk|Concept.Perk] points spent on already picked [perks|Concept.Perk].", ::MSU.Text.colorizeValue(this.getFreePerkChance(), {AddPercent = true})))
						});

						hasPotentialPerk = true;
						break;
					}
				}

				if (hasPotentialPerk)
				{
					break;
				}
			}
		}

		if (this.m.FreePerksGainedIDs.len() != 0)
		{
			local freePerks = "";
			foreach (id in this.m.FreePerksGainedIDs)
			{
				freePerks += ::Reforged.NestedTooltips.getNestedPerkImage(this.getContainer().getSkillByID(id));
			}

			if (freePerks != "")
			{
				ret.push({
					id = 15,
					type = "text",
					icon = "ui/icons/special.png",
					text = ::Reforged.Mod.Tooltips.parseString("Free perks learned:\n" + freePerks)
				});
			}
		}

		return ret;
	}

	function getBonus()
	{
		return this.getContainer().getActor().getLevel();
	}

	function onUpdate( _properties )
	{
		this.rf_old_swordmaster_scenario_abstract_effect.onUpdate(_properties);

		local actor = this.getContainer().getActor();
		if (this.isEnabled())
		{
			local bonus = this.getBonus();

			_properties.MeleeSkill += bonus;
			_properties.MeleeDefense += bonus;
			_properties.Initiative += bonus;
			_properties.DamageDirectAdd += bonus * 0.01;
		}
	}

	function getFreePerkChance()
	{
		return this.getContainer().getActor().getPerkTree().hasPerkGroup("pg.rf_sword") ? this.m.FreePerkChancePerLevel : 0;
	}

	function onUpdateLevel()
	{
		local actor = this.getContainer().getActor();

		::Math.seedRandom(1000 * actor.getUID() + ::toHash(this.getID()) + actor.getLevel());

		if (::Math.rand(1, 100) <= this.getFreePerkChance() && actor.getPerkTree().hasPerkGroup("pg.rf_sword"))
		{
			local potentialPerks = [];
			foreach (row in ::DynamicPerks.PerkGroups.findById("pg.rf_sword").getTree())
			{
				foreach (perkID in row)
				{
					if (this.m.FreePerksGainedIDs.find(perkID) == null)
					{
						potentialPerks.push(perkID);
					}
				}
			}

			if (potentialPerks.len() != 0)
			{
				local chosenID = ::MSU.Array.rand(potentialPerks);
				local preExistingPerk = this.getContainer().getSkillByID(chosenID);

				if (preExistingPerk != null && preExistingPerk.isRefundable())
				{
					actor.m.PerkPoints++;
					actor.m.PerkPointsSpent--;
				}

				if (preExistingPerk != null && preExistingPerk.isSerialized())
				{
					preExistingPerk.m.IsRefundable = false;
				}
				else
				{
					this.getContainer().add(::Reforged.new(::Const.Perks.findById(chosenID).Script, function(o) {
						o.m.IsRefundable = false;
					}));
				}

				this.m.FreePerksGainedIDs.push(chosenID);
			}
		}

		// add actor.getUID() so that if multiple bros call this function sequentially
		// the RNG is seeded with a different seed every time leading to intermittent rand calls being truly random.
		// * 100 to increase the difference in seed.
		::Math.seedRandom(::Time.getRealTime() + actor.getUID() * 100);
	}

	function onSerialize(_out)
	{
		this.rf_old_swordmaster_scenario_abstract_effect.onSerialize(_out);
		::MSU.Serialization.serialize(this.m.FreePerksGainedIDs, _out);
	}

	function onDeserialize(_in)
	{
		this.rf_old_swordmaster_scenario_abstract_effect.onDeserialize(_in);
		this.m.FreePerksGainedIDs = ::MSU.Serialization.deserialize(_in);
	}
});
