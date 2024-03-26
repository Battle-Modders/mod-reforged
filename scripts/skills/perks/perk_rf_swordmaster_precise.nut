this.perk_rf_swordmaster_precise <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {},
	function create()
	{
		this.perk_rf_swordmaster_abstract.create();
		this.m.ID = "perk.rf_swordmaster_precise";
		this.m.Name = this.Const.Strings.PerkName.RF_SwordmasterPrecise;
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("This character is exceptionally precise with the sword, able to consistently strike at the most vulnerable parts. This effect becomes stronger with each [level|Concept.Level].");
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
		local bonus = this.getSkillBonus();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(bonus) + " [Melee Skill|Concept.MeleeSkill]")
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(bonus) + " [Melee Defense|Concept.MeleeDefense]")
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(1.0 + this.getDirectDamageBonus(), {AddSign = true}) + " additional damage ignoring armor")
			}
		]);
		return ret;
	}

	function onUpdate( _properties )
	{
		if (!this.isEnabled())
			return;

		local skillBonus = this.getSkillBonus();
		_properties.MeleeSkill += skillBonus;
		_properties.MeleeDefense += skillBonus;
		_properties.DamageDirectAdd += this.getDirectDamageBonus();
	}

	function getDirectDamageBonus()
	{
		local ret = this.getContainer().getActor().getLevel() * 0.01;
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isItemType(::Const.Items.ItemType.RF_Fencing))
		{
			ret += 0.25;
		}
		return ret;
	}

	function getSkillBonus()
	{
		return this.getContainer().getActor().getLevel();
	}
});
