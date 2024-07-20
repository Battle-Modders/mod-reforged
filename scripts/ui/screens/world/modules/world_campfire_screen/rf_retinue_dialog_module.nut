this.rf_retinue_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		CurrentSlot = 0
	},
	function setCurrentSlot( _s )
	{
		this.m.CurrentSlot = _s;
	}

	function create()
	{
		this.m.ID = "RF_RetinueDialogModule";
		this.ui_module.create();
	}

	function destroy()
	{
		this.ui_module.destroy();
	}

	function clear()
	{
	}

	function onLeaveButtonPressed()
	{
		this.m.Parent.onModuleClosed();
	}

	function queryRetinueInformation()
	{
		local data = ::World.Retinue.getFollowerFromSlot(this.m.CurrentSlot).getUIData();
		return {
			Data = data,
		};
	}
});

