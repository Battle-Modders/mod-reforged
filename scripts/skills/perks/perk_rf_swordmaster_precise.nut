this.perk_rf_swordmaster_precise <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {},
	function create()
	{
		this.perk_rf_swordmaster_abstract.create();
		this.m.ID = "perk.rf_swordmaster_precise";
		this.m.Name = ::Const.Strings.PerkName.RF_SwordmasterPrecise;
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("This character is exceptionally precise with the sword, able to consistently strike at the most vulnerable parts. This effect becomes stronger with each [level.|Concept.Level]");
		this.m.Icon = "ui/perks/rf_swordmaster_precise.png";
		this.m.Type = this.m.Type | ::Const.SkillType.StatusEffect;
	}

	function isHidden()
	{
		return !this.isEnabled();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local skillModifier = this.getMeleeSkillModifier();
		if (skillModifier != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(skillModifier) + " [Melee Skill|Concept.MeleeSkill]")
			});
		}

		local defenseModifier = this.getMeleeDefenseModifier();
		if (defenseModifier != 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(defenseModifier) + " [Melee Defense|Concept.MeleeDefense]")
			});
		}

		local directDamageModifier = this.getDirectDamageModifier();
		if (directDamageModifier != 0)
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(1.0 + this.getDirectDamageModifier(), {AddSign = true}) + " damage ignoring armor")
			});
		}

		return ret;
	}

	function onUpdate( _properties )
	{
		if (!this.isEnabled())
			return;

		_properties.MeleeSkill += this.getMeleeSkillModifier();
		_properties.MeleeDefense += this.getMeleeDefenseModifier();
		_properties.DamageDirectAdd += this.getDirectDamageModifier();
	}

	function getDirectDamageModifier()
	{
		local ret = this.getContainer().getActor().getLevel() * 0.01;
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isItemType(::Const.Items.ItemType.RF_Fencing))
		{
			ret += 0.25;
		}
		return ret;
	}

	function getMeleeSkillModifier()
	{
		return this.getContainer().getActor().getLevel();
	}

	function getMeleeDefenseModifier()
	{
		return this.getContainer().getActor().getLevel();
	}
});
