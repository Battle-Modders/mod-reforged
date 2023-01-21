::mods_hookExactClass("entity/tactical/player", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.getSkills().add(::new("scripts/skills/actives/rf_adjust_dented_armor_ally_skill"));
	}

    local onHired = o.onHired;
    o.onHired = function()
    {
        onHired();

        // Due to the lack of a skill-specific onHired() I need to do this hook for a single unique trait
        local swindlerTrait = this.getSkills().getSkillByID("trait.swindler");
        if (swindlerTrait == null) return;
        swindlerTrait.revealSwindle();
    }
});
