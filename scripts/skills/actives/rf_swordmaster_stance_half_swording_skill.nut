this.rf_swordmaster_stance_half_swording_skill <- ::inherit("scripts/skills/actives/rf_swordmaster_stance_abstract_skill", {
	m = {},
	function create()
	{
		this.rf_swordmaster_stance_abstract_skill.create();
		this.m.ID = "actives.rf_swordmaster_stance_half_swording";
		this.m.Name = "Stance: Half Swording";
		this.m.Description = "Switch to a half-sword grip to allow for precise piercing attacks through your target\'s armor.";
		this.m.Icon = "skills/rf_swordmaster_stance_half_swording_skill.png";
		this.m.IconDisabled = "skills/rf_swordmaster_stance_half_swording_skill_sw.png";
		this.m.Overlay = "rf_swordmaster_stance_half_swording_skill";
		this.m.SoundOnUse = [
			"sounds/combat/riposte_01.wav",
			"sounds/combat/riposte_02.wav",
			"sounds/combat/riposte_03.wav"
		];
	}

	function getTooltip()
	{
		local ret = this.rf_swordmaster_stance_abstract_skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Removes") + " all attack skills from the currently equipped sword and adds the [Stab|Skill+stab] and [Puncture|Skill+puncture] skills. The Stab skill deals " + ::MSU.Text.colorNegative("50%") + " reduced damage")
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/rf_reach.png",
			text = ::Reforged.Mod.Tooltips.parseString("Lose " + ::MSU.Text.colorNegative("half") + " of your weapon\'s [Reach|Concept.Reach]")
		});

		if (!this.getContainer().getActor().isArmedWithTwoHandedWeapon() && !this.getContainer().getActor().isDoubleGrippingWeapon())
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Requires a two-handed sword or a double-gripped one-handed sword")
			});
		}

		this.addEnabledTooltip(ret);

		return ret;
	}

	function onUpdate( _properties )
	{
		if (!this.m.IsOn) return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null)	_properties.Reach -= ::Math.floor(weapon.getReach() * 0.5);
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

	function onUnequip( _item )
	{
		if (this.m.IsOn && _item.getSlotType() == ::Const.ItemSlot.Mainhand)
			this.toggleOff();
	}

	function toggleOn()
	{
		if (this.m.IsOn)
			return;

		this.rf_swordmaster_stance_abstract_skill.toggleOn();
		local weapon = this.getContainer().getActor().getMainhandItem();
		foreach (skill in weapon.getSkills())
		{
			weapon.removeSkill(skill);
		}

		weapon.addSkill(::Reforged.new("scripts/skills/actives/stab", function(o) {
			o.m.DirectDamageMult = weapon.m.DirectDamageMult;
		}));
		weapon.addSkill(::new("scripts/skills/actives/puncture"));
	}

	function onCombatFinished()
	{
		this.rf_swordmaster_stance_abstract_skill.onCombatFinished();
		this.toggleOff();
	}
});
