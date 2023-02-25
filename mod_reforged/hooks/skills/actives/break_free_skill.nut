::mods_hookExactClass("skills/actives/break_free_skill", function(o) {
	o.onAdded <- function()
    {
        this.removeSelf();
    }
});
