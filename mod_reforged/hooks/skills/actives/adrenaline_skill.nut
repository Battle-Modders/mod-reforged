::mods_hookExactClass("skills/actives/adrenaline_skill", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Adrenaline;
	}
});
