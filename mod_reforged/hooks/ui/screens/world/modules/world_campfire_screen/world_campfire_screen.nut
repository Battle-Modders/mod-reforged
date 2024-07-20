::Reforged.HooksMod.hook("scripts/ui/screens/world/modules/world_campfire_screen/world_campfire_screen", function(q) {
	q.m.RetinueDialogModule <- null;

	q.getRetinueDialogModule <- function()
	{
		return this.m.RetinueDialogModule;
	}

	q.create = @(__original) function()
	{
		__original();
		this.m.RetinueDialogModule = ::new("scripts/ui/screens/world/modules/world_campfire_screen/rf_retinue_dialog_module");
		this.m.RetinueDialogModule.setParent(this);
		this.m.RetinueDialogModule.connectUI(this.m.JSHandle);
	}

	q.destroy = @(__original) function()
	{
		this.m.RetinueDialogModule.destroy();
		this.m.RetinueDialogModule = null;
		__original();
	}

	q.clear = @(__original) function()
	{
		this.m.RetinueDialogModule.clear();
		__original();
	}

	q.showLastActiveDialog = @(__original) function()
	{
		if (this.m.LastActiveModule == this.m.RetinueDialogModule)
		{
			this.showRetinueDialog();
		}
		else
		{
			__original();
		}
	}

	q.onModuleClosed = @(__original) function()
	{
		if (this.m.LastActiveModule == this.m.RetinueDialogModule)
		{
			this.showMainDialog();
		}
		else
		{
			__original();
		}
	}

	q.onSlotClicked = @() function()
	{
		if (this.isAnimating())
		{
			return;
		}
		this.showRetinueDialog();
	}

	o.showRetinueDialog <- function()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = null;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showRetinueDialog", this.m.RetinueDialogModule.queryRetinueInformation());
		}
	}
});
