this.rf_encumbrance_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_encumbrance";
		this.m.Name = "Encumbrance";
		this.m.Description = "This character\'s armor\'s weight is too much. Encumbrance has 4 levels and it increases when the total remaining Fatigue after gear is less than 50, 40, 30, 20. Only applies when the total penalty to Fatigue from head and body armor is at least -20.";
		this.m.Icon = "skills/rf_encumbrance_effect.png";
		//this.m.IconMini = "rf_armor_fatigue_recovery_effect_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
	}

	function isHidden()
	{
		return this.getEncumbranceLevel() == 0 || !this.getContainer().getActor().isPlayerControlled();
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local level = this.getEncumbranceLevel();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Current Encumbrance Level: [color=" + ::Const.UI.Color.NegativeValue + "]" + level + "[/color]"
		});

		local fatigueBuildUp = this.getFatigueOnTurnStart(level);
		if (fatigueBuildUp != 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::MSU.Text.colorRed("+" + fatigueBuildUp) + " Fatigue at the start of every turn"
			});
		}

		local travelCost = this.getMovementFatigueCostModifier(level);
		if (travelCost != 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::MSU.Text.colorRed("+" + travelCost) + " Fatigue built per tile traveled"
			});
		}

		return tooltip;
	}

	function getEncumbranceLevel()
	{
		if (this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]) > -20)
		{
			return 0;
		}

		local fat = this.getContainer().getActor().getFatigueMax();
		if (fat < 20)
		{
			return 4;
		}
		else if (fat < 30)
		{
			return 3;
		}
		else if (fat < 40)
		{
			return 2;
		}
		else if (fat < 50)
		{
			return 1;
		}

		return 0;
	}

	function getMovementFatigueCostModifier( _encumbranceLevel )
	{
		switch (_encumbranceLevel)
		{
			case 0:	// Not a valid level
			case 1:	// Level 1
				return 0;

			case 2:	// Level 2
				return 1;

			case 3:	// Level 3
				return 3;

			default:	// Level 4+
				return 3;
		}
	}

	function getFatigueOnTurnStart( _encumbranceLevel )
	{
		switch (_encumbranceLevel)
		{
			case 0:	// Not a valid level for this effect
				return 0;

			case 1:	// Level 1
				return 1;

			case 2:	// Level 2
			case 3:	// Level 3
				return 2;

			default:	// Level 4+
				return 3;
		}
	}

	function onUpdate( _properties )
	{
		_properties.MovementFatigueCostAdditional += this.getMovementFatigueCostModifier(this.getEncumbranceLevel());
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		actor.setFatigue(::Math.min(actor.getFatigueMax(), actor.getFatigue() + this.getFatigueOnTurnStart(this.getEncumbranceLevel())));
	}
});
