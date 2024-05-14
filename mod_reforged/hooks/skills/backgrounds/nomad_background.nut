::Reforged.HooksMod.hook("scripts/skills/backgrounds/nomad_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_tactician": 3,
			"pg.rf_trained": 1.4,
			"pg.rf_unstoppable": 1.5,
			"pg.rf_vicious": 1.5,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_ranged": 0.5
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeSpecialist);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_raider"
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
				return _collection.getMin() + 1;
		}
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Can use the [Throw Dirt|Skill+throw_dirt_skill] skill once per [turn|Concept.Turn]")
		});
		return ret;
	}

	q.onAdded = @(__original) function()
	{
		__original();
		this.getContainer().add(::new("scripts/skills/actives/throw_dirt_skill"));
	}

	q.onRemoved = @(__original) function()
	{
		__original();
		this.getContainer().removeByID("actives.throw_dirt");
	}

	q.onAnySkillExecuted = @(__original) function( _skill, _targetTile, _targetEntity, _forFree )
	{
		__original(_skill, _targetTile, _targetEntity, _forFree);
		if (_skill.getID() == "actives.throw_dirt")
		{
			_skill.m.IsUsable = false;
		}
	}

	q.onTurnStart = @(__original) function()
	{
		__original();
		local throwDirt = this.getContainer().getSkillByID("actives.throw_dirt");
		if (throwDirt != null)
		{
			throwDirt.m.IsUsable = true;
		}
	}

	q.onQueryTooltip = @(__original) function( _skill, _tooltip )
	{
		__original(_skill, _tooltip);
		if (_skill.getID() == "actives.throw_dirt" && !_skill.m.IsUsable)
		{
			_tooltip.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorRed("Can only be used once per [turn|Concept.Turn]"))
			});
		}
	}
});
