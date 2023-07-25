this.shrapnell_bullets <- this.inherit("scripts/items/ammo/ammo", {
	m = {
        DamageMultiplier = 0.9,
        ArmorPiercingMult = 0.9,
        HitChanceModifier = 35
    },
	function create()
	{
		this.ammo.create();
		this.m.ID = "ammo.shrapnell_bullets";
		this.m.Name = "Shrapnell Bullet Bag";
		this.m.Description = "A bag of shrapnell bullets, used for arming exotic firearms. The projectiles split under high speed making it easier to hit your targets but reducing the overall strength of the impact. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/rf_shrapnell_bullets.png";
		this.m.IconEmpty = "ammo/powder_bag_empty.png";
		this.m.AmmoType = ::Const.Items.AmmoType.Powder;
        this.m.AmmoTypeName = "bullet";
		this.m.ShowOnCharacter = false;
		this.m.ShowQuiver = false;
		this.m.Value = 400;
		this.m.Ammo = 5;
		this.m.AmmoMax = 5;
        this.m.AmmoCost = 2;
        this.m.AmmoWeight = 0.4;
		this.m.IsDroppedAsLoot = true;
	}

	function getTooltip()
	{
		local result = this.ammo.getTooltip();

        result.extend([
		{
            id = 10,
            type = "text",
            icon = "ui/icons/damage_dealt.png",
            text = ::MSU.Text.colorizeValue((this.m.DamageMultiplier * 100) - 100) + "% damage"
        },
		{
			id = 11,
			type = "text",
			icon = "ui/icons/direct_damage.png",
			text = "The damage ignoring armor is reduced by " + ::MSU.Text.coloRed((1.0 - this.m.ArmorPiercingMult) * 100) + "%"
		},
        {
            id = 10,
            type = "text",
            icon = "ui/icons/ranged_skill.png",
            text = ::MSU.Text.colorizeValue(this.m.HitChanceModifier) + " chance to hit"
        }
	]);

		return result;
	}

	function addAmmoEffects( _loadedWeapon )
	{
		local skill = this.new("scripts/skills/effects/rf_shrapnell_bullets_ammo_effect");
		skill.m.DamageMultiplier = this.m.DamageMultiplier;
		skill.m.ArmorPiercingMult = this.m.ArmorPiercingMult;
		skill.m.HitChanceModifier = this.m.HitChanceModifier;
		this.addAmmoSkill(skill, _loadedWeapon);
	}

});
