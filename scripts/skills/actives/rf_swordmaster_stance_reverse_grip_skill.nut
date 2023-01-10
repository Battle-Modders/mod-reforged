this.rf_swordmaster_stance_reverse_grip_skill <- ::inherit("scripts/skills/actives/rf_swordmaster_stance_abstract_skill", {
	m = {},
	function create()
	{
		this.rf_swordmaster_stance_abstract_skill.create();
		this.m.ID = "actives.rf_swordmaster_stance_reverse_grip";
		this.m.Name = "Stance: Reverse Grip";
		this.m.Description = "Grab your sword in a reverse grip to use it like a mace.";
		this.m.Icon = "skills/rf_swordmaster_stance_reverse_grip_skill.png";
		this.m.IconDisabled = "skills/rf_swordmaster_stance_reverse_grip_skill_bw.png";
		this.m.Overlay = "rf_swordmaster_stance_reverse_grip_skill";
		this.m.SoundOnUse = [
			"sounds/combat/riposte_01.wav",
			"sounds/combat/riposte_02.wav",
			"sounds/combat/riposte_03.wav"
		];
	}

	function getTooltip()
	{
		local tooltip = this.rf_swordmaster_stance_abstract_skill.getTooltip();

		local skillsString = this.getContainer().getActor().getMainhandItem().isItemType(::Const.Items.ItemType.TwoHanded) ? "[color=" + ::Const.UI.Color.PositiveValue + "]Cudgel[/color] and [color=" + ::Const.UI.Color.PositiveValue + "]Strike Down[/color]" : "[color=" + ::Const.UI.Color.PositiveValue + "]Bash[/color] and [color=" + ::Const.UI.Color.PositiveValue + "]Knock Out[/color]";
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png"
			text = "[color=" + ::Const.UI.Color.NegativeValue + "]Removes[/color] all skills from the currently equipped sword and adds the " + skillsString + " skills"
		});

		if (!this.getContainer().getActor().isArmedWithTwoHandedWeapon() && !this.getContainer().getActor().isDoubleGrippingWeapon())
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Requires a two-handed sword or a double-gripped one-handed sword[/color]"
			});
		}

		this.addEnabledTooltip(tooltip);

		return tooltip;
	}

	function isUsable()
	{
		return this.rf_swordmaster_stance_abstract_skill.isUsable() && (this.getContainer().getActor().isArmedWithTwoHandedWeapon() || this.getContainer().getActor().isDoubleGrippingWeapon());
	}

	function toggleOn()
	{
		this.rf_swordmaster_stance_abstract_skill.toggleOn();
		local weapon = this.getContainer().getActor().getMainhandItem();
		local skills = weapon.getSkills();
		foreach (skill in skills)
		{
			weapon.removeSkill(skill);
		}

		if (weapon.isItemType(::Const.Items.ItemType.TwoHanded))
		{
			weapon.addSkill(::new("scripts/skills/actives/cudgel_skill"));
			weapon.addSkill(::new("scripts/skills/actives/strike_down_skill"));
		}
		else
		{
			weapon.addSkill(::new("scripts/skills/actives/bash"));
			weapon.addSkill(::new("scripts/skills/actives/knock_out"));
		}
	}

	function toggleOff()
	{
		this.rf_swordmaster_stance_abstract_skill.toggleOff();
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && this.m.RemovedSkills.len() != 0)
		{
			this.getContainer().getActor().getItems().unequip(weapon);
			this.getContainer().getActor().getItems().equip(weapon);
		}
	}

	function onCombatFinished()
	{
		this.rf_swordmaster_stance_abstract_skill.onCombatFinished();
		this.toggleOff();
	}
});
