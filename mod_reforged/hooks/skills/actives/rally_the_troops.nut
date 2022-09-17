::mods_hookExactClass("skills/actives/rally_the_troops", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.AIBehavior = {
			ID = ::Const.AI.Behavior.ID.Rally,
			Script = "scripts/ai/tactical/behaviors/ai_rally"
		};
	}
});
