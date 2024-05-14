::Reforged.HooksMod.hook("scripts/skills/backgrounds/butcher_southern_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_vicious": 3,
			"pg.rf_axe": 1.25,
			"pg.rf_spear": 0.8,
			"pg.rf_sword": 1.25
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeBackground);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_laborer"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_cleaver"
				],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_armor":
				return _collection.getMin() - 1;
		}
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorGreen("+10%") + " chance to hit with [Butcher\'s Cleaver|Item+butchers_cleaver]")
		});
		return ret;
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		local weapon = _skill.getItem();
		if (weapon != null && weapon.getID() == "weapon.butchers_cleaver")
		{
			_properties.MeleeSkill += 10;
		}
	}
});
