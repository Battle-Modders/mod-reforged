this.rf_zombie_racial <- ::inherit("scripts/skills/skill", {
	m = {
		FatigueEffectMult = 0.0,
		FatigueDealtPerHitMultModifier = 1.0
	},
	function create()
	{
		this.m.ID = "racial.rf_zombie";
		this.m.Name = "Wiederganger";
		this.m.Description = "This character is a wiederganger.";
		this.m.Icon = "ui/orientation/zombie_01_orientation.png";
		this.m.Type = ::Const.SkillType.Racial | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.m.FatigueEffectMult == 0.0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString("Builds no [Fatigue|Concept.Fatigue]")
			});
		}
		else if (this.m.FatigueEffectMult != 1.0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString("Build up " + ::MSU.Text.colorizeMult(this.m.FatigueEffectMult, {InvertColor = true}) + " less [Fatigue|Concept.Fatigue]")
			});
		}

		local bonusFatiguePerHit = ::Const.Combat.FatigueReceivedPerHit * this.m.FatigueDealtPerHitMultModifier;
		if (bonusFatiguePerHit != 0.0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString("Inflicts " + ::MSU.Text.color(::Const.UI.Color.DamageValue, bonusFatiguePerHit) + " extra [Fatigue|Concept.Fatigue] on a hit")
			});
		}

		ret.push({
			id = 12,
			type = "text",
			icon = "ui/orientation/zombie_01_orientation.png",
			text = "Humans killed by you will rise as Wiedergangers after some time",	// This is implemented in onActorKilled of zombie.nut
		});

		ret.extend([
			{
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Not affected by nighttime penalties"
			},
			{
				id = 21,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Cannot receive [temporary injuries|Concept.InjuryTemporary]")
				// In Reforged undead have the rf_undead_injury_receiver_effect which makes them affected by injuries and allows them to receive injuries
			},
			{
				id = 22,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to [Bleeding|Skill+bleeding_effect]")
			},
			{
				id = 23,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to Poison")
			},
			{
				id = 24,
				type = "text",
				icon = "ui/icons/morale.png",
				text = ::Reforged.Mod.Tooltips.parseString("Not affected by [Morale|Concept.Morale]")
			}
		]);

		return ret;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.m.MoraleState = ::Const.MoraleState.Ignore;

		local baseProperties = actor.getBaseProperties();
		baseProperties.IsAffectedByNight = false;
		baseProperties.IsAffectedByInjuries = false;
		baseProperties.IsImmuneToBleeding = true;
		baseProperties.IsImmuneToPoison = true;
		baseProperties.FatigueEffectMult = this.m.FatigueEffectMult;
		baseProperties.FatigueDealtPerHitMult += this.m.FatigueDealtPerHitMultModifier;	// In vanilla normal zombies don't have this bonus
	}
});
