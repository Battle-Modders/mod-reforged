::mods_hookExactClass("skills/effects/swallowed_whole_effect", function (o) {
    o.m.TargetName <- "";

	local create = o.create;
	o.create = function()
	{
		create();
        this.m.Name = "Full Belly";     // New more descriptive Name
        this.m.Description = "This character has just devoured another character. The only way to free them is killing this character and slicing its belly open.";
	}

    // The vanilla function overwrites the original 'this.m.Name' which we don't want. Instead we save that name in a separate variable
    o.setName = function( _name )
    {
        this.m.TargetName = _name;
    }

    // Overwrite to change vanilla formatting slightly
    o.getName = function()
    {
        return this.m.Name + " (" + this.m.TargetName + ")";
    }
});
