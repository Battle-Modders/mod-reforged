this.perk_rf_nudist <- ::inherit("scripts/skills/skill", {
	m = {
        HitpointMultiplier = 0.8,       // Incoming Hitpoint damage is multiplied by this value
        FatigueRecovery = 3,            // This much Fatigue is recoveried while meeting the 'FatigueRecoveryWeightThreshold' threshold
        FatigueRecoveryWeightThreshold = 5,     // Your combined armor and helmet weight must be this or lower to gain the 'FatigueRecovery' bonus
        WeightMultiplier = 2.0,         // Your armor and helmet weight is multiplied by this value
        BurdenMultiplier = 2.0          // Your armor and helmet burden is multiplied by this value
    },
	function create()
	{
		this.m.ID = "perk.rf_nudist";
		this.m.Name = ::Const.Strings.PerkName.RF_Nudist;
		this.m.Description = "This characters body is hardened from being naked all day. They function best with no armor constricting them."; // todo
		this.m.Icon = "ui/perks/rf_poise.png";  // todo
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

    function isHidden()
    {
        if (this.getFatigueRecoveryBonus() == 0) return true;
        return this.skill.isHidden();
    }

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
        tooltip.push({
            id = 6,
            type = "text",
            icon = "ui/icons/health.png",
            text = "Damage to Hitpoints is reduced by " + ::MSU.Text.colorGren((100.0 - (this.m.HitpointMultiplier * 100.0)) + "%")
        });

		if (this.getFatigueRecoveryBonus() > 0)
		{
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::MSU.Text.colorGreen("+" + this.getFatigueRecoveryBonus()) + " Fatigue Recovery per turn"
			}
		}

		if (this.m.WeightMultiplier != 1.0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString("The [Weight|Concept.Weight] from helmet and armor is increased by " + ::MSU.Text.colorRed(((this.m.WeightMultiplier - 1.0) * 100) + "%"))
			});
		}

		if (this.m.BurdenMultiplier != 1.0)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/tooltips/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString("The [Burden|Concept.Burden] from helmet and armor is increased by " + ::MSU.Text.colorRed(((this.m.BurdenMultiplier - 1.0) * 100) + "%"))
			});
		}
		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.DamageReceivedRegularMult *= this.m.HitpointMultiplier;
        _properties.FatigueRecoveryRate += this.getFatigueRecoveryBonus();
	}

    // New Helper Functions
    function getFatigueRecoveryBonus()
    {
		local rawWeight = this.getContainer().getActor().getCurrentProperties().getRawWeight([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
        if (rawWeight > this.m.FatigueRecoveryWeightThreshold) return 0;
        return this.m.FatigueRecovery;
    }

});
