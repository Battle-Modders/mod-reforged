::Reforged.PerkGroups.Vicious <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_vicious";
		this.Name = "Vicious";
		this.Icon = "ui/perk_groups/rf_vicious.png";
		this.FlavorText = [
			"is vicious",
			"seems fiendishly vicious",
			"is ferociously vicious",
			"is brutal and vicious",
			"appears diabolically vicious",
			"is beastially vicious",
			"enjoys vicious butchery"
		];
		this.Tree = [
			["perk.crippling_strikes"],
			["perk.coup_de_grace"],
			["perk.taunt"],
			[],
			["perk.berserk"],
			["perk.rf_battle_fervor"],
			["perk.fearsome"]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_shield": 0.8
		};
	}
};
