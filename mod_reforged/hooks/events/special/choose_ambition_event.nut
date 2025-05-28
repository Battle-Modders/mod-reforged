::Reforged.HooksMod.hook("scripts/events/events/special/choose_ambition_event", function (q) {
	q.createOption = @(__original) { function createOption( _s )
	{
		local ret = __original(_s)

		ret.Icon = _s.getButtonIcon();
		if (ret.Icon == "") delete ret["Icon"];	// Javascript complains if the entry exists but is empty, so we never send it at all in these cases.

		return ret;
	}}.createOption;
});
