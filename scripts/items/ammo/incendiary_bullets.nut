this.incendiary_bullets <- this.inherit("scripts/items/ammo/ammo", {
	m = {
        DamageMultiplier = 0.8
    },
	function create()
	{
		this.ammo.create();
		this.m.ID = "ammo.incendiary_bullets";
		this.m.Name = "Incendiary Bullet Bag";
		this.m.Description = "A bag of incendiary bullets, used for arming exotic firearms. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/rf_incendiary_bullets.png";
		this.m.IconEmpty = "ammo/powder_bag_empty.png";
		this.m.AmmoType = ::Const.Items.AmmoType.Powder;
        this.m.AmmoTypeName = "bullet";
		this.m.ShowOnCharacter = false;
		this.m.ShowQuiver = false;
		this.m.Value = 500;
		this.m.Ammo = 5;
		this.m.AmmoMax = 5;
        this.m.AmmoCost = 4;
        this.m.AmmoWeight = 0.4;
		this.m.IsDroppedAsLoot = true;
	}

	function getTooltip()
	{
		local result = this.ammo.getTooltip();

        result.push({
            id = 10,
            type = "text",
            icon = "ui/icons/ranged_skill.png",
            text = ::MSU.Text.colorizeValue((this.m.DamageMultiplier * 100) - 100) + "% damage"
        });

        result.push({
            id = 11,
            type = "text",
            icon = "ui/icons/campfire.png",
            text = "Damage Type is changed to Burning"
        });

        result.push({
            id = 12,
            type = "text",
            icon = "ui/icons/campfire.png",
            text = "A hit will set the ground below the target on fire"
        });

		return result;
	}

	function addAmmoEffects( _loadedWeapon )
	{
		local skill = this.new("scripts/skills/effects/rf_incendiary_bullets_ammo_effect");
		skill.m.DamageMultiplier = this.m.DamageMultiplier;
		this.addAmmoSkill(skill, _loadedWeapon);
	}

});

