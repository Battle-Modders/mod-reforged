::MSU.Table.merge(::Reforged, {
	// Is flipped during `tavern_building.getRumor` during the call to the
	// __original function. Is used to return Undead as the faction type
	// of Draugr faction during rumor generation.
	__IsDuringGetRumor = false,
	__IsDevMode = false,

	function __toggleDevMode()
	{
		this.__IsDevMode = !this.__IsDevMode;
		foreach (s in ::Reforged.Mod.ModSettings.getPage("Debug").getAllElementsAsArray(::MSU.Class.BooleanSetting).filter(@(_, _e) _e.getID().len() > 4 && _e.getID().slice(0, 4) == "Dev_"))
		{
			s.set(this.__IsDevMode);
		}
		::Tooltip.reload();
	}
});
