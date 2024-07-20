this.perk_rf_offhand_training <- ::inherit("scripts/skills/skill", {
	m = {
		StaminaModifierThreshold = -10,
		IsFreeUse = false,
		IsConsumingFreeUse = false // Used in onBeforeAnySkillExecuted to flip IsFreeUse in onAnySkillExecuted
	},
	function create()
	{
		this.m.ID = "perk.rf_offhand_training";
		this.m.Name = ::Const.Strings.PerkName.RF_OffhandTraining;
		this.m.Description = "This character is skilled in the use of offhand items such as tools and bucklers.";
		this.m.Icon = "ui/perks/perk_rf_offhand_training.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.ItemActionOrder = ::Const.ItemActionOrder.BeforeLast;
	}

	function isHidden()
	{
		return !this.m.IsFreeUse;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The first use of any offhand item weighing less than " + ::MSU.Text.colorNegative(-this.m.StaminaModifierThreshold) + " this [turn|Concept.Turn] costs no [Action Points|Concept.ActionPoints]")
		});
		return ret;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/effects/rf_trip_artist_effect"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("effects.rf_trip_artist");
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!this.m.IsFreeUse || _forFree || !::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
			return;

		if (_skill.getItem() != null && ::MSU.isEqual(_skill.getItem(), this.getContainer().getActor().getOffhandItem()))
		{
			// Using a net unequips the net and therefore the item of the used skill becomes null
			// Therefore we must check the item BEFORE use and then flip the member variable for free use AFTER use
			this.m.IsConsumingFreeUse = true;
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.IsConsumingFreeUse)
			this.m.IsFreeUse = false;
	}

	function onAfterUpdate( _properties )
	{
		if (!this.m.IsFreeUse)
			return;

		local offhand = this.getContainer().getActor().getOffhandItem();
		if (offhand != null && offhand.getStaminaModifier() > this.m.StaminaModifierThreshold)
		{
			foreach (skill in off.getSkills())
			{
				skill.m.ActionPointCost = 0;
			}
		}
	}

	function onTurnStart()
	{
		this.m.IsConsumingFreeUse = false;
		this.m.IsFreeUse = true;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsConsumingFreeUse = false;
		this.m.IsFreeUse = false;
	}
});
