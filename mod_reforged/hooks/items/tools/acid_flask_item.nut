::Reforged.HooksMod.hook("scripts/items/tools/acid_flask_item", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Value = 275; // approximately 30% reduced from vanilla value of 400
	}}.create;

	q.onPutIntoBag = @() { function onPutIntoBag()
	{
		local skill = ::new("scripts/skills/actives/rf_sling_acid_flask_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}}.onPutIntoBag;
});
