::mods_hookExactClass("entity/tactical/human", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.Human;
		this.getSkills().removeByID("effects.captain", true);	// silent removal without triggering a logInfo entry
	}
});
