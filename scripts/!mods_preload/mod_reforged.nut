::Reforged <- {
	Version = "0.1.0",
	ID = "mod_reforged",
	Name = "Reforged Mod",
};

::mods_registerMod(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);
::mods_queue(::Reforged.ID, "mod_msu", function() {
	::Reforged.Mod <- ::MSU.Class.Mod(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);	

	
});
