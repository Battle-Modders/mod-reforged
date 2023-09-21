::mods_hookNewObject("ai/tactical/agent", function (o) {
	local addBehavior = o.addBehavior;
	o.addBehavior = function( _behavior )
	{
		local obj = this;
		while ("SuperName" in obj)
		{
			if ((obj.ClassName in ::Reforged.AI.ExcludedBehaviors) && ::Reforged.AI.ExcludedBehaviors[obj.ClassName].find(_behavior.getID()) != null)
			{
				return;
			}
			obj = obj[obj.SuperName];
		}

		return addBehavior(_behavior);
	}
});
