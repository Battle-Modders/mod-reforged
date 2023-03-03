// Intermediate class, currently just for the four arrow-like quality ammunition variants
this.quality_ammunition <- this.inherit("scripts/items/ammo/ammo", {
	m = {
		ArmorPiercingMult = 1.2,
		ArmorDamageMult = 1.2,
	},

	function create()
	{
		this.ammo.create();
		this.m.ShowOnCharacter = true;
		this.m.ShowQuiver = true;
		this.m.Sprite = "rf_bust_quality_quiver";	// Vanilla also uses the same sprite for bolts and arrows alike
		this.m.IsDroppedAsLoot = true;
	}

	function getTooltip()
	{
		local ret = this.ammo.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "The damage ignoring armor is increased by " + ::MSU.Text.colorGreen((this.m.ArmorPiercingMult - 1.0) * 100) + "%"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "The damage dealt to armor is increased by " + ::MSU.Text.colorGreen((this.m.ArmorDamageMult - 1.0) * 100) + "%"
			}
		]);

		return ret;
	}

	function addAmmoEffects( _loadedWeapon )
	{
		local skill = this.new("scripts/skills/effects/rf_quality_ammunition_effect");
		skill.m.ArmorPiercingMult = this.m.ArmorPiercingMult;
		skill.m.ArmorDamageMult = this.m.ArmorDamageMult;
		this.addAmmoSkill(skill, _loadedWeapon);
	}

});
