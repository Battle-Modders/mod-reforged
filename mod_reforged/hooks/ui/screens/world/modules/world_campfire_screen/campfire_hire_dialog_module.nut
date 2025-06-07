::Reforged.HooksMod.hook("scripts/ui/screens/world/modules/world_campfire_screen/campfire_hire_dialog_module", function(q) {
	q.onUnlockPerk <- function(_data)
	{
		# TODO

		local entity = this.Tactical.getEntityByID(_data[0]);

		if (entity == null)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindEntity);
		}

		if (!entity.unlockPerk(_data[1]))
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToUnlockPerk);
		}

		return this.queryHireInformation();
	}
});
