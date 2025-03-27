::Reforged.HooksMod.hook("scripts/skills/actives/release_falcon_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Order = ::Const.SkillOrder.BeforeLast + 5;	// We want release-ables to be listed after break-free skills (which are BeforeLast)
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		local effect = ::new("scripts/skills/effects/rf_falcon_released_effect");
		effect.m.Container = ::MSU.getDummyPlayer().getSkills();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString(format("Allies who are not [stunned|Skill+stunned_effect], rooted, or [fleeing|Concept.Morale] gain the %s effect", ::Reforged.NestedTooltips.getNestedSkillName(effect))),
			children = effect.getTooltip().slice(2) // slice 2 to remove name and description
		});

		effect.m.Container = null;

		return ret;
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{
		local ret = __original(_user, _targetTile);

		if (ret)
		{
			foreach (ally in ::Tactical.Entities.getAlliedActors(_user.getFaction()))
			{
				if (ally.getCurrentProperties().IsStunned || ally.getCurrentProperties().IsRooted || ally.getMoraleState() == ::Const.MoraleState.Fleeing)
				{
					continue;
				}

				ally.getSkills().add(::new("scripts/skills/effects/rf_falcon_released_effect"));
			}
		}

		return ret;
	}
});
