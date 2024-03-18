this.rf_dislocated_jaw_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {
		FatigueRecoveryModifier = -3,
		BraveryMult = 0.7,
	},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.rf_dislocated_jaw";
		this.m.Name = "Dislocated Jaw";
		this.m.Description = "A forceful impact to the jaw caused it to become dislocated, making it painful to breathe or communicate.";
		this.m.Type = this.m.Type | ::Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "rf_dislocated_jaw_injury";
		this.m.Icon = "ui/injury/rf_dislocated_jaw_injury.png";
		this.m.IconMini = "rf_dislocated_jaw_injury_mini";
		this.m.HealingTimeMin = 1;
		this.m.HealingTimeMax = 2;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.m.FatigueRecoveryModifier != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::MSU.Text.colorizeValue(this.m.FatigueRecoveryModifier) + " Fatigue Recovery per turn"
			});
		}

		if (this.m.BraveryMult != 1.0)
		{
			local actor = this.getContainer().getActor();
			if (actor.isPlacedOnMap() && ::Tactical.TurnSequenceBar.isActiveEntity(actor))
			{
				ret.push({
					id = 10,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(this.m.BraveryMult) + " less [Resolve|Concept.Bravery]")
				});
			}
			else
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(this.m.BraveryMult) + " less [Resolve|Concept.Bravery] during this character\'s turn")
				});
			}
		}

		this.addTooltipHint(ret);	// Injury specific additional tooltips

		return ret;
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);

		if (!_properties.IsAffectedByInjuries || this.m.IsFresh && !_properties.IsAffectedByFreshInjuries)
		{
			return;
		}

		_properties.FatigueRecoveryRate += this.m.FatigueRecoveryModifier;

		local actor = this.getContainer().getActor();
		if (actor.isPlacedOnMap() && ::Tactical.TurnSequenceBar.isActiveEntity(actor))
		{
			_properties.BraveryMult *= this.m.BraveryMult;
		}
	}
});
