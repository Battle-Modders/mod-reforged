::Reforged.HooksMod.hook("scripts/events/event", function(q) {
	// Returns a TooltipID used to bind the tooltip of the character/banner being displayed
	// on the screen. Similar to the usage of the vanilla `getUICharacterImage` function.
	q.RF_getUICharacterTooltipID <- { function RF_getUICharacterTooltipID( _index = 0 )
	{
		local image = this.getUICharacterImage(_index);
		if (image == null)
			return null;

		local imagePath = image.Image;

		if ("Characters" in this.m.ActiveScreen && this.m.ActiveScreen.Characters.len() > _index)
		{
			// Vanilla stores references to actors in the `m` table of the event. So we have to iterate
			// over that and use the imagePath to detect if this is the actor we are looking for.
			foreach (k, v in this.m)
			{
				// We cannot compare getImagePath to the imagePath stored here because
				// somehow that can have a different value (see actor.getImagePath where it adds
				// m.ContentID to it which can be different). So, we instead check if the
				// actor's ID is present in the imagePath between two commas.
				if (::MSU.isKindOf(v, "actor") && imagePath.find("," + v.getID() + ",") != null)
				{
					return "EventActor+" + v.getID();
				}
			}
		}

		if ("Banner" in this.m.ActiveScreen && imagePath == this.m.ActiveScreen.Banner)
		{
			foreach (f in ::World.FactionManager.getFactions())
			{
				if (f != null && (imagePath == f.getUIBanner() || imagePath == f.getUIBannerSmall()))
				{
					return "Faction+" + f.getID();
				}
			}
		}
	}}.RF_getUICharacterTooltipID;

	q.buildText = @(__original) { function buildText( _buildText )
	{
		return ::Reforged.Mod.Tooltips.parseString(__original(_buildText));
	}}.buildText;

	q.setScreen = @(__original) { function setScreen( _screen )
	{
		local original_ActiveScreen = this.m.ActiveScreen;

		__original(_screen);

		if (this.m.ActiveScreen != null && this.m.ActiveScreen != original_ActiveScreen)
		{
			::Reforged.NestedTooltips.addHyperlinksToScreen(this.m.ActiveScreen, this);
		}
	}}.setScreen;
});

::Reforged.HooksMod.hookTree("scripts/events/event", function(q) {
	q.onPrepareVariables = @(__original) { function onPrepareVariables( _vars )
	{
		__original(_vars);
		::Reforged.NestedTooltips.addHyperlinksToPrepareVariables(_vars, this);
	}}.onPrepareVariables;
});
