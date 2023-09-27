::Reforged.HooksMod.hook("scripts/skills/perks/perk_nine_lives", function(q) {
    // New Variables to tweak the behavior of this perk
    q.m.MinHP <- 11;
    q.m.MaxHP <- 15;

    q.create = @(__original) function()
	{
        __original();

        // This makes the perk now always show by default on top of characters while it is not procced yet
		this.m.IconMini = "perk_07_mini";
        this.addType(::Const.SkillType.StatusEffect);   // 'StatusEffect' is requires so that this will show up under the 'Effects' section in the tooltip
    }

    // Nine lives now shows up as an effect while available. Therefore we give it a custom more detailed description
	q.getDescription <- function()
	{
		return "Upon receiving the next killing blow, this character will survive with " + ::MSU.Text.colorGreen(this.m.MinHP + "-" + this.m.MaxHP) + " Hitpoints, all damage over time effects wil be removed, and Melee Skill, Melee Defense, Resolve and Initiative will be increased until the start of their next turn.";
	}

    q.setSpent = @(__original) function( _f )
	{
        local proc = (_f && !this.m.IsSpent);
        __original(_f);
        if (proc) this.onProc();
	}

	q.onCombatFinished = @(__original) function()
	{
		this.m.IsHidden = false;
		__original();
	}

    // New function that is called after vanilla just applied the 11-15 hitpoints reset, removal of Dots and addition of the temporary nine_lives_effect
    q.onProc <- function()
    {
        this.m.IsHidden = true;     // Visually indicate that this character no longer has cheat-death for this battle
        if (this.m.MinHP == 11 && this.m.MaxHP == 15) return; // There is no need to set the Hitpoints two times if these values were not changes by us/submods

        this.getContainer().getActor().m.Hitpoints = ::Math.rand(this.m.MinHP, this.m.MaxHP);
        this.getContainer().getActor().setDirty(true);
    }
});
