this.rf_swordmaster_stance_meisterhau_skill <- ::inherit("scripts/skills/actives/rf_swordmaster_stance_abstract_skill", {
	m = {
		RemovedSkills = []
	},
	function create()
	{
		this.rf_swordmaster_stance_abstract_skill.create();
		this.m.ID = "actives.rf_swordmaster_stance_meisterhau";
		this.m.Name = "Stance: Meisterhau";
		this.m.Description = "Readying yourself for the master strikes known as the Meisterhäu allows you to strike and defend at the same time.";
		this.m.Icon = "skills/rf_swordmaster__stance_meisterhau_skill.png";
		this.m.IconDisabled = "skills/rf_swordmaster__stance_meisterhau_skill_bw.png";
		this.m.Overlay = "rf_swordmaster__stance_meisterhau_skill";
		this.m.SoundOnUse = [
			"sounds/combat/riposte_01.wav",
			"sounds/combat/riposte_02.wav",
			"sounds/combat/riposte_03.wav"
		];
	}

	function onAdded()
	{
		this.toggleOn();
	}

	function getTooltip()
	{
		local tooltip = this.rf_swordmaster_stance_abstract_skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png"
			text = "Moving from your position no longer disables the En Garde perk"
		});

		this.addEnabledTooltip(tooltip);

		return tooltip;
	}

	function onCombatStarted()
	{
		this.rf_swordmaster_stance_abstract_skill.onCombatStarted();
		this.toggleOn();
	}

	function onCombatFinished()
	{
		this.rf_swordmaster_stance_abstract_skill.onCombatFinished();
		this.toggleOn();
	}
});
