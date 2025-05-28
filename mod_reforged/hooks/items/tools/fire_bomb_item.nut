::Reforged.HooksMod.hook("scripts/items/tools/fire_bomb_item", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Value = 420; // approximately 30% reduced from vanilla value of 600
	}}.create;

	q.onPutIntoBag = @() { function onPutIntoBag()
	{
		local skill = ::new("scripts/skills/actives/rf_sling_fire_bomb_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}}.onPutIntoBag;
});
