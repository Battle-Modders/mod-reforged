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

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/reach.png",
			text = "You will lose " + ::MSU.Text.colorRed("one-third") + " of your weapon\'s Reach"
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

	function getNestedTooltip()
	{
		local tooltip = this.rf_swordmaster_stance_abstract_skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png"
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorRed("Removes") + " all skills from the currently equipped sword and " + ::MSU.Text.colorGreen("adds") + " the [Bash|Skill+bash] and [Knock Out|Skill+knock_out] or the [Cudgel|Skill+cudgel_skill] and [Strike Down|Skill+strike_down_skill] skills for one-handed and two-handed swords respectively")
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/reach.png",
			text = "Lose " + ::MSU.Text.colorRed("one-third") + " of your weapon\'s Reach"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "[color=" + ::Const.UI.Color.NegativeValue + "]Requires a two-handed sword or a double-gripped one-handed sword[/color]"
		});

		this.addEnabledTooltip(tooltip);

		return tooltip;
	}

	function onUpdate( _properties )
	{
		if (!this.m.IsOn) return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null) _properties.Reach -= ::Math.floor(weapon.getReach() * 0.3);
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
		if (weapon != null)
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
