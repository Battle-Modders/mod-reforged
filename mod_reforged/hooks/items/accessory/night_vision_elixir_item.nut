::Reforged.HooksMod.hook("scripts/items/accessory/night_vision_elixir_item", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 250;
	}
});
