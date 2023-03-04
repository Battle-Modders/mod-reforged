
::Reforged.HooksMod.hook("scripts/skills/special/no_ammo_warning", function(q) {
    // Temporarily changes the getID function from the ammo item into getAmmoType
    q.isHidden = @(__original) function()
    {
        local ammoItem = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Ammo);
        if (ammoItem == null) return __original();

        local oldGetID = ammoItem.item.getID;
        ammoItem.item.getID = ammoItem.getAmmoType;

        local ret = __original();

        ammoItem.item.getID = oldGetID;
        return ret;
    }
});
