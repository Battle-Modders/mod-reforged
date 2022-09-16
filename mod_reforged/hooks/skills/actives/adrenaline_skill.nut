::mods_hookExactClass("skills/actives/adrenaline_skill", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.AIBehavior = {
			ID = ::Const.AI.Behavior.ID.Adrenaline,
			Script = "scripts/ai/tactical/behaviors/ai_adrenaline"
		};
	}
});
