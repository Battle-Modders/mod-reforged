::Reforged.HooksMod.hook("scripts/skills/backgrounds/butcher_background", function(q) {
	q.createPerkTreeBlueprint = @() { function createPerkTreeBlueprint()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
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
	}}.createPerkTreeBlueprint;

	q.getPerkGroupCollectionMin = @() { function getPerkGroupCollectionMin( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_armor":
				return _collection.getMin() - 1;
		}
	}}.getPerkGroupCollectionMin;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_vicious":
				return 3;

			case "pg.rf_axe":
			case "pg.rf_sword":
				return 1.25;

			case "pg.rf_spear":
				return 0.8;
		}
	}}.getPerkGroupMultiplier;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+10%") + " chance to hit with [Butcher\'s Cleaver|Item+butchers_cleaver]")
		});
		return ret;
	}}.getTooltip;

	q.onAnySkillUsed = @(__original) { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		local weapon = _skill.getItem();
		if (weapon != null && weapon.getID() == "weapon.butchers_cleaver")
		{
			_properties.MeleeSkill += 10;
		}
	}}.onAnySkillUsed;
});
