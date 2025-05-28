::Reforged.HooksMod.hook("scripts/contracts/contracts/return_item_contract", function(q) {
	q.createStates = @(__original) { function createStates()
	{
		__original();
		foreach (state in this.m.States)
		{
			if (state.ID != "Offer") continue;
			local end = state.end;
			state.end = function()
			{
				end();
				this.Contract.m.Target.setMovementSpeed(this.Contract.m.Target.getBaseMovementSpeed() * 0.9);  // Thieves are easier to catch
			}
			break;
		}
	}}.createStates;

	q.createScreens = @(__original) { function createScreens()
	{
		__original();
		foreach (screen in this.m.Screens)
		{
			if (screen.ID != "CounterOffer1") continue;
			foreach (option in screen.Options)
			{	// We now show the original payment so the player compare the two
				if (option.Text != "We\'re paid to return it, and that\'s what we\'ll do.") continue;
				option.Text = "We\'re paid %reward_completion% to return it, and that\'s what we\'ll do.";
				break;
			}
			break;
		}
	}}.createScreens;

	q.onPrepareVariables = @(__original) { function onPrepareVariables( _vars )
	{
		__original(_vars);
		foreach (var in _vars)
		{
			if (var[0] != "bribe") continue;
			var[1] = "[b]" + var[1] + "[/b]";	 // Bribe is bold now so its easier to spot and compare
			break;
		}
	}}.onPrepareVariables;
});
