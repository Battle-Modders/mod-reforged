::Reforged.HooksMod.hook("scripts/items/tools/acid_flask_item", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 275; // approximately 30% reduced from vanilla value of 400
	}

	q.onPutIntoBag = @() function()
	{
		local skill = ::new("scripts/skills/actives/rf_sling_acid_flask_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}
});
