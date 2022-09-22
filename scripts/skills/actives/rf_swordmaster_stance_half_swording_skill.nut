this.rf_swordmaster_stance_half_swording_skill <- ::inherit("scripts/skills/actives/rf_swordmaster_stance_abstract_skill", {
	m = {
		RemovedSkills = []
	},
	function create()
	{
		this.rf_swordmaster_stance_abstract_skill.create();
		this.m.ID = "actives.rf_swordmaster_stance_half_swording";
		this.m.Name = "Stance: Half Swording";
		this.m.Description = "Switch to a half-sword grip to allow for precise piercing attacks through your target\'s armor.";
		this.m.Icon = "skills/rf_swordmaster_stance_half_swording_skill.png";
		this.m.IconDisabled = "skills/rf_swordmaster_stance_half_swording_skill_bw.png";
		this.m.Overlay = "rf_swordmaster_stance_half_swording_skill";
		this.m.SoundOnUse = [
			"sounds/combat/riposte_01.wav",
			"sounds/combat/riposte_02.wav",
			"sounds/combat/riposte_03.wav"
		];
	}

	function getTooltip()
	{
		local tooltip = this.rf_swordmaster_stance_abstract_skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png"
			text = "[color=" + ::Const.UI.Color.NegativeValue + "]Removes[/color] all attack skills from the currently equipped sword and adds the [color=" + ::Const.UI.Color.PositiveValue + "]Stab[/color] and [color=" + ::Const.UI.Color.PositiveValue + "]Puncture[/color] skills"
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

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.IsOn && _skill.getID() == "actives.stab")
		{
			_properties.DamageTotalMult *= 0.5;
		}
	}

	function toggleOn()
	{
		this.rf_swordmaster_stance_abstract_skill.toggleOn();
		local weapon = this.getContainer().getActor().getMainhandItem();
		local skills = weapon.getSkills();
		foreach (skill in skills)
		{
			this.m.RemovedSkills.push(skill);
			weapon.removeSkill(skill);
		}

		weapon.addSkill(::new("scripts/skills/actives/puncture"));
	}

	function toggleOff()
	{
		this.rf_swordmaster_stance_abstract_skill.toggleOff();
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && this.m.RemovedSkills.len() != 0)
		{
			weapon.removeSkill(this.getContainer().getSkillByID("actives.puncture"));
			foreach (skill in this.m.RemovedSkills)
			{
				weapon.addSkill(skill);
			}
		}

		this.m.RemovedSkills.clear();
	}

	function onUnequip( _item )
	{
		if (_item.getSlotType() == ::Const.ItemSlot.Mainhand) this.m.RemovedSkills.clear();
	}

	function onCombatFinished()
	{
		this.rf_swordmaster_stance_abstract_skill.onCombatFinished();
		this.m.RemovedSkills.clear();
	}
});
