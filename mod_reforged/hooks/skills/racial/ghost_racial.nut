::Reforged.HooksMod.hook("scripts/skills/racial/ghost_racial", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Name = "Ghost";
		this.m.Icon = "ui/orientation/ghost_01_orientation.png";
		this.m.IsHidden = false;
		if (this.isType(::Const.SkillType.Perk))
			this.removeType(::Const.SkillType.Perk);	// This effect having the type 'Perk' serves no purpose and only causes issues in modding
	}}.create;

	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString("When being attacked, gain " + ::MSU.Text.colorPositive("+10") + " [Melee Defense|Concept.MeleeDefense] and [Ranged Defense|Concept.RangeDefense] for each tile between you and the attacker")
			},
			{
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Not affected by [Nighttime|Skill+night_effect]")
			},
			{
				id = 21,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Not affected by, and cannot receive, [temporary injuries|Concept.InjuryTemporary]")
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
				text = "Immune to Poison"
			},
			{
				id = 24,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being knocked back or grabbed"
			},
			{
				id = 25,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to fire"
			},
			{
				id = 26,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to being [disarmed|Skill+disarmed_effect]")
			},

			{
				id = 27,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to being [rooted|Concept.Rooted]")
			},
			{
				id = 28,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to being [stunned|Skill+stunned_effect]")
			},
			{
				id = 29,
				type = "text",
				icon = "ui/icons/morale.png",
				text = ::Reforged.Mod.Tooltips.parseString("Not affected by [Morale|Concept.Morale]")
			}
		]);
		return ret;
	}}.getTooltip;

	q.onAdded = @() { function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.m.MoraleState = ::Const.MoraleState.Ignore;

		local baseProperties = actor.getBaseProperties();
		baseProperties.IsAffectedByInjuries = false;
		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToBleeding = true;
		baseProperties.IsImmuneToDisarm = true;
		baseProperties.IsImmuneToFire = true;
		baseProperties.IsImmuneToKnockBackAndGrab = true;
		baseProperties.IsImmuneToPoison = true;
		baseProperties.IsImmuneToRoot = true;
		baseProperties.IsImmuneToStun = true;

		// This is purely a setting for AI decisions:
		baseProperties.IsIgnoringArmorOnAttack = true;
	}}.onAdded;
});
