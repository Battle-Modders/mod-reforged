::Reforged.HooksMod.hook("scripts/skills/backgrounds/lumberjack_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_strong": 2,
			"pg.special.rf_leadership": 2,
			"pg.rf_vigorous": 2
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeBackground);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_laborer"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_axe"
				],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": [
					"pg.rf_power"
				]
			}
		});
	}

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_category.getID())
		{
			case "pgc.rf_weapon":
				return _category.getMin() + 1;
		}
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorGreen("+10%") + " chance to hit with [Woodcutter\'s Axe|Item+woodcutters_axe] and [Hatchet|Item+hatchet]")
		});
		return ret;
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		local weapon = _skill.getItem();
		if (weapon != null && (weapon.getID() == "weapon.woodcutters_axe" || weapon.getID() == "weapon.hatchet"))
		{
			_properties.MeleeSkill += 10;
		}
	}
});
