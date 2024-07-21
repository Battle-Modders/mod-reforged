this.perk_rf_command <- ::inherit("scripts/skills/skill", {
	m = {},

	function create()
	{
		this.m.ID = "perk.rf_command";
		this.m.Name = ::Const.Strings.PerkName.RF_Command;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Command;
		this.m.Icon = "ui/perks/perk_rf_command.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAdded()
	{
		this.m.Container.add(::new("scripts/skills/actives/rf_command_skill"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.rf_command");
	}
});
