::Reforged.HooksMod.hook("scripts/ui/screens/world/modules/world_campfire_screen/campfire_hire_dialog_module", function(q) {
	q.m.PopupDialogVisible <- false;

	q.create = @(__original) function()
	{
		__original();
		this.m.PopupDialogVisible = false;
	}

	q.onPopupDialogIsVisible <- function( _data )
	{
		this.m.PopupDialogVisible = _data[0];
	}

	q.isAnimating = @() function()
	{
		return this.m.Animating != null && this.m.Animating == true || this.m.PopupDialogVisible != null && this.m.PopupDialogVisible == true;
	}

	q.onUnlockPerk <- function(_data)
	{
		# TODO

		local entity = ::World.Retinue.getFollower(_data[0]);

		if (entity == null)
		{
			return {
				error = "Failed to find retinue.",
				code = _errorCode
			};
		}

		if (!entity.unlockPerk(_data[1]))
		{
			return {
				error = "Failed to unlock perk.",
				code = _errorCode
			};
		}
		::World.Retinue.onUnlockPerk(_data[1]);

		return this.queryHireInformation();
	}
});
