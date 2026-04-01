this.rf_barrow_chant_effect <- ::inherit("scripts/skills/skill", {
	m = {
		RestlessnessChance = 50
	},
	function create()
	{
		this.m.ID = "effects.rf_barrow_chant";
		this.m.Name = "Barrow Chant";
		this.m.Description = "A low dreadful chant that appeases the dead but drags at the spirit of the living, choking off any surge of confidence.";
		// TODO: Placeholder icons
		this.m.Icon = "ui/perks/perk_32.png";
		// this.m.IconMini = "TODO";
		// this.m.Overlay = "TODO";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Enemies on the battlefield cannot be [Confident|Concept.Morale]")
		});

		local debuff = ::new("scripts/skills/effects/rf_barrow_chant_debuff_effect");
		if (debuff.m.DamageMultPerMoraleStateAdd != 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Affected enemies deal " + ::MSU.Text.colorizeMultWithText(1.0 + debuff.m.DamageMultPerMoraleStateAdd) + " damage for each morale state below [Confident|Concept.Morale]")
			});
		}

		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Upon your death each allied Barrowkin has an individual " + ::MSU.Text.colorizeValue(this.m.RestlessnessChance, {AddPercent = true}) + " chance to become [$ $|Skill+rf_draugr_restless_effect]")
		});

		return ret;
	}

	function onDeath( _fatalityType )
	{
		local actor = this.getContainer().getActor();
		foreach (a in ::Tactical.Entities.getAllInstancesAsArray())
		{
			a.getSkills().removeByID("effects.rf_barrow_chant_debuff");

			if (a.isAlliedWith(actor) && ::MSU.isKindOf(a, "rf_draugr") && ::Math.rand(1, 100) <= this.m.RestlessnessChance)
			{
				a.getSkills().add(::new("scripts/skills/effects/rf_draugr_restless_effect"));
			}
		}
	}

	function onActorSpawned( _actor )
	{
		_actor.getSkills().add(::new("scripts/skills/effects/rf_barrow_chant_debuff_effect"));
	}
});
