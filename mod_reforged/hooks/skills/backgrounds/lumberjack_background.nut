::Reforged.HooksMod.hook("scripts/skills/backgrounds/lumberjack_background", function(q) {
	q.createPerkTreeBlueprint = @() { function createPerkTreeBlueprint()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
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
	}}.createPerkTreeBlueprint;

	q.getPerkGroupCollectionMin = @() { function getPerkGroupCollectionMin( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_weapon":
				return _collection.getMin() + 1;
		}
	}}.getPerkGroupCollectionMin;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
			case "pg.rf_tough":
			case "pg.rf_vigorous":
				return 2;
		}
	}}.getPerkGroupMultiplier;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+10%") + " chance to hit with [Woodcutter\'s Axe|Item+woodcutters_axe] and [Hatchet|Item+hatchet]")
		});
		return ret;
	}}.getTooltip;

	q.onAnySkillUsed = @(__original) { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		local weapon = _skill.getItem();
		if (weapon != null && (weapon.getID() == "weapon.woodcutters_axe" || weapon.getID() == "weapon.hatchet"))
		{
			_properties.MeleeSkill += 10;
		}
	}}.onAnySkillUsed;
});
