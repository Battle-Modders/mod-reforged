
::mods_hookExactClass("skills/special/no_ammo_warning", function(o) {
    // Temporarily changes the getID function from the ammo item into getAmmoType
    local isHidden = o.isHidden;
    o.isHidden = function()
    {
        local ammoItem = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Ammo);
        if (ammoItem == null) return isHidden();

        local oldGetID = ammoItem.item.getID;
        ammoItem.item.getID = ammoItem.getAmmoType;

        local ret = isHidden();

        ammoItem.item.getID = oldGetID;
        return ret;
    }
});
