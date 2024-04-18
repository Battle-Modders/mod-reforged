this.perk_rf_family_pride <- ::inherit("scripts/skills/skill", {
	m = {
		BraveryMult = 1.5
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
			icon = "ui/icons/bravery.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(this.m.BraveryMult) + " increased [Resolve|Concept.Bravery] against negative [morale checks|Concept.Morale]")
		});

		return tooltip;
	}

	function onAdded()
	{
		this.getContainer().removeByID("trait.insecure");
		this.getContainer().removeByID("trait.dastard");
	}

	function onUpdate( _properties )
	{
		_properties.NegativeMoraleCheckBraveryMult *= this.m.BraveryMult;
	}

	function onCombatStarted()
	{
		this.getContainer().getActor().setMoraleState(::Const.MoraleState.Confident);
	}
});
