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
		this.m.Icon = "skills/rf_swordmaster_stance_meisterhau_skill.png";
		this.m.IconDisabled = "skills/rf_swordmaster_stance_meisterhau_skill_bw.png";
		this.m.Overlay = "rf_swordmaster_stance_meisterhau_skill";
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
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Triggering [En Garde|Skill+perk_rf_en_garde] no longer builds [Fatigue|Concept.Fatigue] after having moved from your position")
		});

		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Gain the [Kick|Skill+rf_swordmaster_kick_skill], [Tackle|Skill+rf+swordmaster_tackle_skill] and [Push Through|Skill+rf+swordmaster_push_through_skill] skills")
		});

		this.addEnabledTooltip(tooltip);

		return tooltip;
	}

	function toggleOn()
	{
		if (this.m.IsOn)
			return;

		this.rf_swordmaster_stance_abstract_skill.toggleOn();
		this.getContainer().add(::new("scripts/skills/actives/rf_swordmaster_tackle_skill"));
		this.getContainer().add(::new("scripts/skills/actives/rf_swordmaster_kick_skill"));
		this.getContainer().add(::new("scripts/skills/actives/rf_swordmaster_push_through_skill"));
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null)
		{
			this.getContainer().getActor().getItems().unequip(weapon);
			this.getContainer().getActor().getItems().equip(weapon);
		}
	}

	function onEquip( _item )
	{
		if (_item.getSlotType() == ::Const.ItemSlot.Mainhand)
			this.toggleOn();
	}

	function toggleOff()
	{
		if (!this.m.IsOn)
			return;

		this.rf_swordmaster_stance_abstract_skill.toggleOff();
		this.getContainer().removeByID("actives.rf_swordmaster_tackle");
		this.getContainer().removeByID("actives.rf_swordmaster_kick");
		this.getContainer().removeByID("actives.rf_swordmaster_push_through");
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
