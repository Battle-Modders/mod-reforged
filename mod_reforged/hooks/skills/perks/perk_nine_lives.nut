::Reforged.HooksMod.hook("scripts/skills/perks/perk_nine_lives", function(q) {
	// New Variables to tweak the behavior of this perk
	q.m.MinHP <- 11;
	q.m.MaxHP <- 15;

	q.create = @(__original) { function create()
	{
		__original();

		// This makes the perk now always show by default on top of characters while it is not procced yet
		this.m.IconMini = "perk_07_mini";
		this.addType(::Const.SkillType.StatusEffect);	// 'StatusEffect' is requires so that this will show up under the 'Effects' section in the tooltip
	}}.create;

	// Nine lives now shows up as an effect while available. Therefore we give it a custom more detailed description
	q.getDescription = @() { function getDescription()
	{
		return ::Reforged.Mod.Tooltips.parseString("Upon receiving the next killing blow, this character will survive with " + ::MSU.Text.colorPositive(this.m.MinHP + "-" + this.m.MaxHP) + " [Hitpoints|Concept.Hitpoints], all damage over time [effects|Concept.StatusEffect] wil be removed, and [Melee Skill,|Concept.MeleeSkill] [Melee Defense,|Concept.MeleeDefense] [Resolve|Concept.Bravery] and [Initiative|Concept.Initiative] will be increased until the start of their next [turn.|Concept.Turn]");
	}}.getDescription;

	q.setSpent = @(__original) { function setSpent( _f )
	{
		local proc = (_f && !this.m.IsSpent);
		__original(_f);
		if (proc) this.onProc();
	}}.setSpent;

	q.onCombatFinished = @(__original) { function onCombatFinished()
	{
		this.m.IsHidden = false;
		__original();
	}}.onCombatFinished;

	// New function that is called after vanilla just applied the 11-15 hitpoints reset, removal of Dots and addition of the temporary nine_lives_effect
	q.onProc <- { function onProc()
	{
		this.m.IsHidden = true;	 // Visually indicate that this character no longer has cheat-death for this battle
		if (this.m.MinHP == 11 && this.m.MaxHP == 15) return; // There is no need to set the Hitpoints two times if these values were not changes by us/submods

		this.getContainer().getActor().m.Hitpoints = ::Math.rand(this.m.MinHP, this.m.MaxHP);
		this.getContainer().getActor().setDirty(true);
	}}.onProc;
});
