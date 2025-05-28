::Reforged.HooksMod.hook("scripts/items/tools/smoke_bomb_item", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Value = 275; // approximately 30% reduced from vanilla value of 400
	}}.create;

	q.onPutIntoBag = @() { function onPutIntoBag()
	{
		local skill = ::new("scripts/skills/actives/rf_sling_smoke_bomb_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}}.onPutIntoBag;
});
