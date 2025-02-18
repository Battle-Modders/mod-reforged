::Reforged.HooksMod.hook("scripts/items/shields/named/named_shield", function(q) {
	q.getBaseItemFields = @(__original) function()
	{
		local ret = __original();
		ret.push("ReachIgnore");
		return ret;
	}

	// Vanilla logic but remove rolling Condition
	q.randomizeValues = @() function()
	{
		local available = [];
		available.push(function ( _i )
		{
			_i.m.MeleeDefense = this.Math.round(_i.m.MeleeDefense * this.Math.rand(120, 140) * 0.01);
		});
		available.push(function ( _i )
		{
			_i.m.RangedDefense = this.Math.round(_i.m.RangedDefense * this.Math.rand(120, 140) * 0.01);
		});
		available.push(function ( _i )
		{
			_i.m.FatigueOnSkillUse = _i.m.FatigueOnSkillUse - this.Math.rand(1, 3);
		});
		// available.push(function ( _i )
		// {
		// 	_i.m.Condition = this.Math.round(_i.m.Condition * this.Math.rand(120, 160) * 0.01) * 1.0;
		// 	_i.m.ConditionMax = _i.m.Condition;
		// });
		available.push(function ( _i )
		{
			_i.m.StaminaModifier = this.Math.round(_i.m.StaminaModifier * this.Math.rand(70, 90) * 0.01);
		});

		for( local n = 2; n != 0 && available.len() != 0; n = --n )
		{
			local r = this.Math.rand(0, available.len() - 1);
			available[r](this);
			available.remove(r);
		}
	}
});
