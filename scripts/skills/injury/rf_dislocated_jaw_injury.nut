this.rf_dislocated_jaw_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {
		FatigueRecoveryModifier = -3,
		ResolveMult = 0.7,
	},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.rf_dislocated_jaw";
		this.m.Name = "Dislocated Jaw";
		this.m.Description = "The forceful impact to the jaw caused it to become dislocated, making it painful to breath or communicate.";
		this.m.Type = this.m.Type | ::Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_43";		// TODO
		this.m.Icon = "ui/injury/injury_icon_43.png";		// TODO
		this.m.IconMini = "injury_icon_43_mini";		// TODO
		this.m.HealingTimeMin = 1;
		this.m.HealingTimeMax = 2;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.m.FatigueRecoveryModifier != 0)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::MSU.Text.colorizeValue(this.m.FatigueRecoveryModifier) + " Fatigue Recovery per turn"
			});
		}

		if (this.m.ResolveMult != 1.0)
		{
			local actor = this.getContainer().getActor();
			if (actor.isPlacedOnMap() && ::Tactical.TurnSequenceBar.isActiveEntity(actor))
			{
				tooltip.push({
					id = 8,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = ::MSU.Text.colorizeMult(this.m.ResolveMult, {AddSign = true}) + " Resolve"
				});
			}
			else
			{
				tooltip.push({
					id = 8,
					type = "text",
					icon = "ui/icons/special.png",
					text =  "Resolve is reduced by " + ::MSU.Text.colorizeMult(this.m.ResolveMult) + " during this characters turn"
				});
			}
		}

		this.addTooltipHint(tooltip);	// Injury Specific additional tooltips

		return tooltip;
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
			_properties.BraveryMult *= this.m.ResolveMult;
		}
	}

});

