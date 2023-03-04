::mods_hookExactClass("items/ammo/ammo", function(o)
{
    o.m.AmmoTypeName <- "ammo_type_name";
    o.m.AmmoWeight <- 0.0;

    local create = o.create;
    o.create = function()
    {
        create();
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
    }

    local onEquip = o.onEquip;
    o.onEquip = function()
    {
		onEquip();
		this.addGenericItemSkill();		// In vanilly they usually control this with a boolean but currently there are no cases where we DONT want this to be added
    }

    // New functions which only exist in item.nut:

    // New function that new ammunition items can use to reduce the amount of copying the same lines
    o.getTooltip <- function()
    {
        local ret = this.item.getTooltip();   // Name + Description + Category + Value + image

		if (this.getStaminaModifier() < 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue " + ::MSU.Text.colorRed(this.getStaminaModifier())
			});
		}

		if (this.m.Ammo != 0)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Contains " + ::MSU.Text.colorRed(this.m.Ammo) + " " + this.m.AmmoTypeName + "s"
			});
		}
		else
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorRed("Is empty and useless")
			});
		}
        ret.push({
            id = 7,
            type = "text",
            icon = "ui/icons/asset_ammo.png",
            text = "Refill cost per ammunition: [b]" + ::MSU.Text.colorRed(this.m.AmmoCost) + "[/b]"
        });
        return ret;
    }

    o.getStaminaModifier <- function()
    {
        return -1 * ::Math.ceil(this.getAmmo() * this.m.AmmoWeight);
    }

    o.onUpdateProperties <- function( _properties )
	{
		_properties.Stamina += this.getStaminaModifier();
    }
});
