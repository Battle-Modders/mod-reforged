::Reforged.HooksMod.hook("scripts/items/ammo/ammo", function(q)
{
    q.m.AmmoWeight <- 0.0;			// Every Ammo in this bag applies this value as a negative StaminaModifier
	q.m.StaminaModifier <- 0;		// Flat StaminaModifier. In Vanilla this already exists on most other equipables

    q.create = @(__original) function()
    {
        __original();
		this.m.SlotType = ::Const.ItemSlot.Ammo,		// This is a line that Vanilla just forgot to include in this shared parent class
		this.m.ItemType = ::Const.Items.ItemType.Ammo;	// This is a line that Vanilla just forgot to include in this shared parent class
    }

    q.onEquip = @(__original) function()
    {
		__original();
		this.addGenericItemSkill();		// Now that ammunition can inflict a Staminamodifier by design and potentially more effects we force an addGenericItemSkill call
    }

// Function overwrites of 'item.nut' functions
    // New function that new ammunition items can use to reduce the amount of copying the same lines
    q.getTooltip <- function()
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
				text = "Contains " + ::MSU.Text.colorRed(this.m.Ammo) + " " + ::Reforged.Const.AmmoType[this.getAmmoType()].Name
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

    q.getStaminaModifier <- function()
    {
		local staminaModifier = this.m.StaminaModifier;		// flat modifier
		staminaModifier -= ::Math.ceil(this.getAmmo() * this.m.AmmoWeight)		// scaling modifier
        return staminaModifier;
    }

    q.onUpdateProperties <- function( _properties )
	{
		_properties.Stamina += this.getStaminaModifier();
    }

// New Functions
	q.getAmmoWeight <- function()
	{
		return this.m.AmmoWeight;
	}
});
