::Reforged.HooksMod.hook("scripts/items/helmets/oriental/assassin_face_mask", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Vision = -2; // vanilla -1
	}}.create;
});
