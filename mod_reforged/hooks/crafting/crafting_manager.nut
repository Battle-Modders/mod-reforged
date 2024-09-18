::Reforged.HooksMod.hook("scripts/crafting/crafting_manager", function(q) {
	q.getQualifiedBlueprints = @(__original) function()
	{
		local settingValue = ::Reforged.Mod.ModSettings.getSetting("CraftingBlueprintVisibility").getValue();
		switch (settingValue)
		{
			case "Vanilla":
			{
				return __original();
			}
			case "Always":
			{
				local ret = [];
				foreach (b in this.m.Blueprints)
				{
					local oldTimesCrafted = b.m.TimesCrafted;
					b.m.TimesCrafted = 1;	// We want to show all recipes and by setting TimesCrafted to 1, we trick Vanilla to do just that
					if (b.isQualified())
					{
						ret.push(b);
					}
					b.m.TimesCrafted = oldTimesCrafted;
				}
				return ret;
			}
			case "One Ingredient Available":
			{
				local ret = [];
				foreach (b in this.m.Blueprints)
				{
					if (b.isPartlyCraftable())
					{
						local oldTimesCrafted = b.m.TimesCrafted;
						b.m.TimesCrafted = 1;	// We want to force-show this recipe, unless there is another custom visibilty rule
						if (b.isQualified())
						{
							ret.push(b);
						}
						b.m.TimesCrafted = oldTimesCrafted;
					}
				}
				return ret;
			}
			case "All Ingredients Available":
			{
				local ret = [];
				foreach (b in this.m.Blueprints)
				{
					local oldTimesCrafted = b.m.TimesCrafted;
					b.m.TimesCrafted = 0;	// We do not want to show recipes, just because we crafted them once before, so we trick Vanilla to not show those
					if (b.isQualified())
					{
						ret.push(b);
					}
					b.m.TimesCrafted = oldTimesCrafted;
				}
				return ret;
			}
			default:
			{
				throw "Unknown setting value: " + settingValue;
			}
		}
	}

	// Rewrite Vanilla function to re-use the logic of getQualifiedBlueprints, instead of re-implementing it
	q.getQualifiedBlueprintsForUI = @() function()
	{
		local ret = [];

		foreach (blueprint in this.getQualifiedBlueprints())
		{
			ret.push(blueprint.getUIData());
		}
		ret.sort(this.onSortBlueprints);

		return ret;
	}
});
