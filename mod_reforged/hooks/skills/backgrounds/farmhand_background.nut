::Reforged.HooksMod.hook("scripts/skills/backgrounds/farmhand_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_tough": 2,
			"pg.rf_vigorous": 2
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeBackground);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_laborer"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_fighting_style":
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
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+10%") + " chance to hit with [Pitchfork|Item+pitchfork] and " + ::MSU.Text.colorPositive("+5%") + " chance to hit with [Hooked Blade|Item+hooked_blade]")
		});
		return ret;
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		local weapon = _skill.getItem();
		if (weapon != null)
		{
			if (weapon.getID() == "weapon.pitchfork")
			{
				_properties.MeleeSkill += 10;
			}
			else if (weapon.getID() == "weapon.hooked_blade")
			{
				_properties.MeleeSkill += 5;
			}
		}
	}
});
