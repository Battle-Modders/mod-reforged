::Reforged.HooksMod.hook("scripts/skills/effects/swallowed_whole_effect", function(q) {
	q.m.TargetName <- "";

	q.create = @(__original) { function create()
	{
		__original();
		this.m.Name = "Full Belly";	 // New more descriptive Name
		this.m.Description = "This character has just devoured another character. The only way to free them is killing this character and slicing its belly open.";
	}}.create;

	// The vanilla function overwrites the original 'this.m.Name' which we don't want. Instead we save that name in a separate variable
	q.setName = @() { function setName( _name )
	{
		this.m.TargetName = _name;
	}}.setName;

	// Overwrite to change vanilla formatting slightly
	q.getName = @() { function getName()
	{
		return this.m.Name + " (" + this.m.TargetName + ")";
	}}.getName;
});
