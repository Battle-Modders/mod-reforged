::Reforged.HooksMod.hook("scripts/entity/world/entity_manager", function(q) {
	q.RF_getUniqueLocationDescription <- { function RF_getUniqueLocationDescription( _descriptions )
	{
		local vars = [
			[ "randomname", ::MSU.Array.rand(::Const.Strings.CharacterNames) ],
			[ "randomnoble", ::MSU.Array.rand(::Const.Strings.KnightNames) ]
		];

		local desc, isValid;
		for (local i = 0; i < 1000; i++)
		{
			isValid = true;
			desc = ::buildTextFromTemplate(::MSU.Array.rand(_descriptions), vars);

			foreach (v in this.m.Locations)
			{
				if (desc == v.getDescription())
				{
					isValid = false;
					break;
				}
			}

			if (isValid)
			{
				return desc;
			}
		}

		::logError("unable to find unique description: " + desc);
		return desc;
	}}.RF_getUniqueLocationDescription;
});
