::Reforged.HooksMod.hook("scripts/factions/faction", function (q) {
	// Overwrite, because we only want to hide certain settlements at 50 relation, if they didn't have a recent relationship change with the player
	q.isHidden = @() { function isHidden()
	{
		return this.m.IsHidden || (this.m.IsHiddenIfNeutral && this.m.PlayerRelation == 50 && this.m.PlayerRelationChanges.len() == 0);
	}}.isHidden;

	q.RF_getTooltip <- { function RF_getTooltip()
	{
		local settlements = this.getSettlements();

		if (settlements.len() == 1)
		{
			return settlements[0].getTooltip();
		}

		return [
			{
				id = 1,	type = "title",	text = this.getName()
			},
			{
				id = 2, type = "description", text = (this.getMotto() == "" ? "" : this.getMotto() + "\n\n") + this.getDescription()
			}
			{
				id = 3, type = "hint",
				text = "Settlements:",
				children = settlements.map(@(_s) {
							id = 3,	type = "text",	icon = _s.getImagePath(),
							text = ::Reforged.Mod.Tooltips.parseString(format("[%s|Obj+%s]", _s.getName(), ::Reforged.Mod.Tooltips.parseObject(_s)))
						})
			}
		];
	}}.RF_getTooltip;
});
