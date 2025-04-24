
::Reforged.HooksMod.hook("scripts/items/tools/holy_water_item", function(q) {
	q.onPutIntoBag = @() function()
	{
		local skill = ::new("scripts/skills/actives/rf_sling_holy_water_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}
});
