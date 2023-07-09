::mods_hookExactClass("items/ammo/ammo", function(o)
{
	// public Variables
    o.m.AmmoTypeName <- "ammo_type_name";	// Must be overwritten with an actual informative name
    o.m.AmmoWeight <- 0.0;			// Every Ammo in this bag applies this value as a negative StaminaModifier
	o.m.StaminaModifier <- 0;		// Flat StaminaModifier. In Vanilla this already exists on most other equipables

	// private Variables
	o.m.AmmoSkillPtrs = [];			// Array of weakrefs to skills: For keeping track of all skills added by this ammunition

    local create = o.create;
    o.create = function()
    {
        create();
		this.m.ItemType = ::Const.Items.ItemType.Ammo;		// This is a line that Vanilla just forgot to include in this shared parent class
    }

    local onEquip = o.onEquip;
    o.onEquip = function()
    {
		onEquip();
		this.addGenericItemSkill();		// Now that ammunition by design can inflict a Staminamodifier and potentially more effects we force an addGenericItemSkill call
    }

// Function overwrites of 'item.nut' functions

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
		local staminaModifier = this.m.StaminaModifier;		// flat modifier
		staminaModifier -= ::Math.ceil(this.getAmmo() * this.m.AmmoWeight)		// scaling modifier
        return staminaModifier;
    }

    o.onUpdateProperties <- function( _properties )
	{
		_properties.Stamina += this.getStaminaModifier();
    }

// New Functions:

	o.addAmmoSkill <- function( _skill, _loadedWeapon )
	{
		_skill.setItem(_loadedWeapon);
		this.m.AmmoSkillPtrs.push(::MSU.asWeakTableRef(_skill));
		this.getContainer().getActor().getSkills().add(_skill, this.m.AmmoSkillPtrs.len());
	}

	o.clearAmmoSkills <- function()
	{
		if (this.getContainer() == null || this.getContainer().getActor() == null || this.getContainer().getActor().isNull())
		{
			return;
		}

		foreach (skill in this.m.AmmoSkillPtrs)
		{
			this.getContainer().getActor().getSkills().remove(skill);
		}

		this.m.AmmoSkillPtrs = [];
	}

	// This is called by the ranged weapon when it is loaded equipped (with this ammunition)
	o.addAmmoEffects <- function( _equippedWeaponReference ) {}

	// This is called by the ranged weapon when it is unloaded or unequipped (while it was loaded with this ammunition)
	o.removeAmmoEffects <- function( _equippedWeaponReference )
	{
		this.clearAmmoSkills():
	}

});
