::MSU.Table.merge(::Reforged, {
	// Is flipped during `tavern_building.getRumor` during the call to the
	// __original function. Is used to return Undead as the faction type
	// of Draugr faction during rumor generation.
	__IsDuringGetRumor = false
});
