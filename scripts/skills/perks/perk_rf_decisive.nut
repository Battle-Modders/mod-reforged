this.perk_rf_decisive <- ::inherit("scripts/skills/skill", {
	m = {
		// Config
		FatigueMult = 0.85,
		ResolveModifier = 15,
		DamageMult = 1.15,
		AttractionMult = 1.1,

		// Const
		Stacks = 0,
		MaxStacks = 3,
	},
	function create()
	{
		this.m.ID = "perk.rf_decisive";
		this.m.Name = ::Const.Strings.PerkName.RF_Decisive;
		this.m.Description = "This character is capable of making quick and confident decisions without any hesitation.";
		this.m.Icon = "ui/perks/rf_decisive.png";	// TODO implement
		this.m.IconMini = "rf_decisive_mini";	// TODO implement
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function getName()
	{
		return (this.m.Stacks == 0) ? this.m.Name : this.m.Name + " (x" + this.m.Stacks + ")";
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		local resolveModifier = this.getResolveModifier();
		if (resolveModifier != 0)
		{
			tooltip.push({
				id = 5,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::MSU.Text.colorizeValue(resolveModifier) + " Resolve"
			});
		}

		local fatigueMult = this.getFatigueMult();
		if (fatigueMult != 1.0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Skills build up " + ::MSU.Text.colorizeMult(fatigueMult, {AddSign = true, InvertColor = true}) + " Fatigue"
			});
		}

		local damageMult = this.getDamageMult();
		if (damageMult != 1.0)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = ::MSU.Text.colorizeMult(damageMult, {AddSign = true}) + " Damage"
			});
		}

		return tooltip;
	}

	function onCombatStarted()
	{
		this.m.Stacks = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
	}

	function onTurnEnd()
	{
		if (this.getContainer().getActor().isWaitActionSpent() == false)
		{
			this.m.Stacks = ::Math.min(this.m.Stacks + 1, this.m.MaxStacks);
		}
	}

	function onWaitTurn()
	{
		this.m.Stacks = 0;
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += this.getResolveModifier();
		_properties.DamageTotalMult *= this.getDamageMult();
		_properties.TargetAttractionMult *= this.getAttractionMult();	// This is on par with other vanilla affects which increase the damage output. All of them make this character more likely to be targeted
	}

	function onAfterUpdate( _properties )
	{
		local fatigueMult = this.getFatigueMult();
		if (fatigueMult != 1.0)
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				skill.m.FatigueCostMult *= fatigueMult;
			}
		}
	}

// New Functions
	function getResolveModifier()
	{
		if (this.m.Stacks >= 1)
		{
			return this.m.ResolveModifier;
		}

		return 0;
	}

	function getFatigueMult()
	{
		if (this.m.Stacks >= 2)
		{
			return this.m.FatigueMult;
		}

		return 1.0;
	}

	function getDamageMult()
	{
		if (this.m.Stacks >= 3)
		{
			return this.m.DamageMult;
		}

		return 1.0;
	}

	function getAttractionMult()
	{
		if (this.m.Stacks >= 3)
		{
			return this.m.AttractionMult;
		}

		return 1.0;
	}
});
