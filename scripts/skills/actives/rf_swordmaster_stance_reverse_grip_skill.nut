this.rf_swordmaster_stance_reverse_grip_skill <- ::inherit("scripts/skills/actives/rf_swordmaster_stance_abstract_skill", {
	m = {
		IsMaceWeaponTypeAdded = false
	},
	function create()
	{
		this.rf_swordmaster_stance_abstract_skill.create();
		this.m.ID = "actives.rf_swordmaster_stance_reverse_grip";
		this.m.Name = "Stance: Reverse Grip";
		this.m.Description = "Grab your sword in a reverse grip to use it like a mace.";
		this.m.Icon = "skills/rf_swordmaster_stance_reverse_grip_skill.png";
		this.m.IconDisabled = "skills/rf_swordmaster_stance_reverse_grip_skill_sw.png";
		this.m.Overlay = "rf_swordmaster_stance_reverse_grip_skill";
		this.m.SoundOnUse = [
			"sounds/combat/riposte_01.wav",
			"sounds/combat/riposte_02.wav",
			"sounds/combat/riposte_03.wav"
		];
	}

	function getTooltip()
	{
		local ret = this.rf_swordmaster_stance_abstract_skill.getTooltip();

		if (::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()))
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Removes") + " all skills from the currently equipped sword and " + ::MSU.Text.colorPositive("adds") + " the [Bash|Skill+bash] and [Knock Out|Skill+knock_out] or the [Cudgel|Skill+cudgel_skill] and [Strike Down|Skill+strike_down_skill] skills for one-handed and two-handed swords respectively")
			});
		}
		else
		{
			local skillsString = this.getContainer().getActor().getMainhandItem().isItemType(::Const.Items.ItemType.TwoHanded) ? "[Cudgel|Skill+cudgel_skill] and [Strike Down|Skill+strike_down_skill]" : "[Bash|Skill+bash] and [Knock Out|Skill+knock_out]";
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = ::MSU.Text.colorNegative("Removes") + " all skills from the currently equipped sword and adds the " + ::Reforged.Mod.Tooltips.parseString(skillsString) + " skills"
			});
		}

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/rf_reach.png",
			text = ::Reforged.Mod.Tooltips.parseString("Gain the [Concussive Strikes|Perk+perk_rf_concussive_strikes] perk")
		});

		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/rf_reach.png",
			text = ::Reforged.Mod.Tooltips.parseString("Lose " + ::MSU.Text.colorNegative("one-third") + " of your weapon\'s [Reach|Concept.Reach]")
		});

		if (!this.getContainer().getActor().isArmedWithTwoHandedWeapon() && !this.getContainer().getActor().getItems().hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Requires a two-handed sword or a one-handed sword with the offhand free")
			});
		}

		this.addEnabledTooltip(ret);

		return ret;
	}

	function onUpdate( _properties )
	{
		if (!this.m.IsOn) return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null) _properties.Reach -= ::Math.floor(weapon.getReach() * 0.3);
	}

	function isUsable()
	{
		return this.rf_swordmaster_stance_abstract_skill.isUsable() && (this.getContainer().getActor().isArmedWithTwoHandedWeapon() || this.getContainer().getActor().getItems().hasEmptySlot(::Const.ItemSlot.Offhand));
	}

	function toggleOn()
	{
		if (this.m.IsOn)
			return;

		this.rf_swordmaster_stance_abstract_skill.toggleOn();
		local weapon = this.getContainer().getActor().getMainhandItem();

		if (!weapon.isWeaponType(::Const.Items.WeaponType.Mace))
		{
			weapon.m.WeaponType = weapon.m.WeaponType | ::Const.Items.WeaponType.Mace;
			this.m.IsMaceWeaponTypeAdded = true;
		}

		this.getContainer().add(::Reforged.new("scripts/skills/perks/perk_rf_concussive_strikes", function(o) {
			o.m.IsRefundable = false;
			o.m.IsSerialized = false;
		}));

		local skills = weapon.getSkills();
		foreach (skill in skills)
		{
			if (skill.isAttack())
				weapon.removeSkill(skill);
		}

		if (weapon.isItemType(::Const.Items.ItemType.TwoHanded))
		{
			weapon.addSkill(::Reforged.new("scripts/skills/actives/cudgel_skill", function(o) {
				o.m.DirectDamageMult = weapon.m.DirectDamageMult;
			}));
			weapon.addSkill(::Reforged.new("scripts/skills/actives/strike_down_skill", function(o) {
				o.m.DirectDamageMult = weapon.m.DirectDamageMult;
			}));
		}
		else
		{
			weapon.addSkill(::Reforged.new("scripts/skills/actives/bash", function(o) {
				o.m.DirectDamageMult = weapon.m.DirectDamageMult;
			}));
			weapon.addSkill(::Reforged.new("scripts/skills/actives/knock_out", function(o) {
				o.m.DirectDamageMult = weapon.m.DirectDamageMult;
			}));
		}
	}

	function onUnequip( _item )
	{
		if (this.m.IsOn && _item.getSlotType() == ::Const.ItemSlot.Mainhand)
			this.toggleOff();
	}

	function toggleOff()
	{
		if (!this.m.IsOn)
			return;

		this.rf_swordmaster_stance_abstract_skill.toggleOff();
		this.getContainer().removeByStackByID("perk.rf_concussive_strikes");
		if (this.m.IsMaceWeaponTypeAdded)
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			if (weapon != null)
			{
				weapon.m.WeaponType -= ::Const.Items.WeaponType.Mace;
				this.m.IsMaceWeaponTypeAdded = false;
			}
		}
	}

	function onCombatFinished()
	{
		this.rf_swordmaster_stance_abstract_skill.onCombatFinished();
		this.toggleOff();
	}
});
