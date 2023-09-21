::mods_hookExactClass("skills/actives/riposte", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Riposte;
	}
});
