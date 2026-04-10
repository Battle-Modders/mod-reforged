::Reforged.HooksMod.hook("scripts/entity/world/settlements/situations/situation", function(q) {
	// The contracts related to this situation that became known to
	// the player upon his last visit to this situation's settlement.
	q.m.RF_LastVisitContracts <- [];
	// WeakTableRef to the settlement this situation is attached to.
	q.m.RF_Settlement <- null;

	// Add parantheses to show stacked situations.
	q.getName = @(__original) { function getName()
	{
		if (::MSU.isNull(this.m.RF_Settlement))
			return __original();

		local myID = this.getID();
		local situations = ::MSU.isEqual(::World.State.getCurrentTown(), this.m.RF_Settlement) ? this.m.RF_Settlement.getSituations() : this.m.RF_Settlement.m.RF_LastVisitSituations;
		local num = situations.filter(@(_, _s) _s.getID() == myID).len();

		return num == 1 ? __original() : format("%s (x%i)", __original(), num);
	}}.getName;

	// Display related contracts and duration in the situation tooltip.
	// Stacked situations are supported.
	q.getTooltip = @(__original) { function getTooltip()
	{
		if (::MSU.isNull(this.m.RF_Settlement))
			return __original();

		local ret = __original();

		local isPlayerAtSettlement = ::MSU.isEqual(::World.State.getCurrentTown(), this.m.RF_Settlement);
		local situations = isPlayerAtSettlement ? this.m.RF_Settlement.getSituations() : this.m.RF_Settlement.m.RF_LastVisitSituations;

		local myID = this.getID();
		local stackedSituations = situations.filter(@(_, _s) _s.getID() == myID);

		local contracts;
		if (isPlayerAtSettlement)
		{
			local stackedSituationIDs = stackedSituations.map(@(_s) _s.getInstanceID());
			// We have to look at ALL contracts instead of only the ones at this situation's settlement, because
			// some situations have contracts offered at other locations e.g. Marauding Greenskins.
			contracts = ::World.Contracts.getOpenContracts().filter(@(_, _c) stackedSituationIDs.find(_c.getSituationID()) != null);
			if (!::World.Retinue.hasFollower("follower.agent"))
			{
				contracts.filter(@(_, _c) _c.isStarted());
			}
		}
		else
		{
			contracts = this.m.RF_LastVisitContracts;
		}

		// Add contracts related to this situation to the tooltip
		foreach (c in contracts)
		{
			ret.push({
				id = 20,	type = "hint", icon = c.RF_getTooltipIcon(),
				text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedObjectName(c, "func:RF_getTooltip,contentType:settlement-status-effect"))
			});
		}

		// Sort stacked situations by the longest lasting to the shortest lasting.
		stackedSituations.sort(@(_s1, _s2) -1 * (_s1.getValidUntil() <=> _s2.getValidUntil()));
		foreach (i, s in stackedSituations)
		{
			// If last visit contracts is len 0 that means we are currently visiting the settlement
			// or that there is no last known contract attached to this. In both cases we show the
			// duration entry if this situation has a duration.
			if (s.m.RF_LastVisitContracts.len() == 0 && s.getValidUntil() != 0)
			{
				local d = s.RF_getDaysRemaining();
				local str;
				if (d <= 0)
				{
					str = format("Is likely %s by now", stackedSituations.len() == 1 || (contracts.len() == 0 && i == 0) ? "finished" : "partially resolved");
				}
				else
				{
					str = format("Is expected to %s " + ::Reforged.Text.getDaysRemainingText(d), stackedSituations.len() == 1 || (contracts.len() == 0 && i == 0) ? "last" : "be partially resolved in");
				}
				ret.push({
					id = 21,	type = "hint", icon = "ui/icons/action_points.png"
					text = str
				});

				// Because we iterate from longest to shortest lasting, as soon as we arrive
				// at an entry that says it is likely fully resolved, we stop adding further entries.
				if (d <= 0)
					break;
			}
		}

		return ret;
	}}.getTooltip;

	// Returns a float with fractional days.
	q.RF_getDaysRemaining <- { function RF_getDaysRemaining()
	{
		return (this.getValidUntil() - ::Time.getVirtualTimeF()) / ::World.getTime().SecondsPerDay;
	}}.RF_getDaysRemaining;
});
