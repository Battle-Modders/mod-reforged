this.perk_rf_family_pride <- ::inherit("scripts/skills/skill", {
	m = {
		RoundsThreshold = 5	
	},
	function create()
	{
		this.m.ID = "perk.rf_family_pride";
		this.m.Name = ::Const.Strings.PerkName.RF_FamilyPride;
		this.m.Description = "This character hails from a family who have no prejudice against pride.";
		this.m.Icon = "ui/perks/rf_family_pride.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return !this.getContainer().getActor().isPlacedOnMap();
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
			
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Morale checks cannot drop this character\'s morale below [color=" + ::Const.UI.Color.PositiveValue + "]" + ::Const.MoraleStateName[this.getMinMoraleState()] + "[/color]"
		});

		return tooltip;
	}

	function onAdded()
	{
		this.getContainer().removeByID("trait.insecure");
		this.getContainer().removeByID("trait.dastard");
	}

	function onCombatStarted()
	{
		this.getContainer().getActor().setMoraleState(::Const.MoraleState.Confident);
	}

	function getMinMoraleState()
	{
		if (this.getContainer().hasSkill("trait.determined"))
		{
			return ::Const.MoraleState.Confident;
		}

		return ::Time.getRound() > this.m.RoundsThreshold ? ::Const.MoraleState.Steady : ::Const.MoraleState.Confident;
	}
});
