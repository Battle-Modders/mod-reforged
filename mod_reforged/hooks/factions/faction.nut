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

		local ret = [
			{
				id = 1,	type = "title",	text = this.getName()
			},
			{
				id = 2, type = "description", text = (this.getMotto() == "" ? "" : this.getMotto() + "\n\n") + this.getDescription()
			},
			{
				id = 10, type = "hint", icon = this.getUIBanner(), text = "Relations: " + this.getPlayerRelationAsText()
			}
		];

		// List only discovered settlements.
		settlements = settlements.filter(@(_, _s) _s.isDiscovered());
		if (settlements.len() != 0)
		{
			// Sort military settlements before civilian ones.
			// Sort larger settlements before smaller ones.
			settlements.sort(function( _a, _b ) {
				if (_a.isMilitary() && !_b.isMilitary())
					return -1;
				if (!_a.isMilitary() && _b.isMilitary())
					return 1;
				if (_a.getSize() > _b.getSize())
					return -1;
				if (_a.getSize() < _b.getSize())
					return 1;
				return 0;
			});

			ret.push({
				id = 3, type = "hint",	 icon = "ui/icons/special.png",
				text = "Known settlements:",
				children = settlements.map(@(_s) {
							id = 3,	type = "text",	icon = _s.getImagePath(),
							text = ::Reforged.Mod.Tooltips.parseString(format("[%s|Obj+%s]", _s.getName(), ::Reforged.Mod.Tooltips.parseObject(_s)))
						})
			});
		}

		return ret;
	}}.RF_getTooltip;
});
