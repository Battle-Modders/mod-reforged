this.perk_rf_decisive <- ::inherit("scripts/skills/skill", {
	m = {
		// Config
		BraveryMult = 1.15,	// Gained with 1+ stacks
		InitiativeMult = 1.15, // Gained with 1+ stacks
		FatigueCostMult = 0.85,		// Gained with 2+ stacks
		DamageMult = 1.15,		// Gained with 3+ stacks
		AttractionMult = 1.1,	// Gained with 3+ stacks
		MaxStacks = 3,

		// Private
		Stacks = 0,
		OriginalIconMini = "perk_rf_decisive_mini"
	},
	function create()
	{
		this.m.ID = "perk.rf_decisive";
		this.m.Name = ::Const.Strings.PerkName.RF_Decisive;
		this.m.Description = "This character is capable of making quick and confident decisions without any hesitation.";
		this.m.Icon = "ui/perks/perk_rf_decisive.png";
		this.m.IconMini = "";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function getName()
	{
		return this.m.Stacks == 0 ? this.m.Name : this.m.Name + " (x" + this.m.Stacks + ")";
	}

	// During combat we always display this effect on player characters even with 0 stacks as a helpful reminder
	function isHidden()
	{
		return !::Tactical.isActive() || this.m.Stacks == 0 && !this.getContainer().getActor().isPlayerControlled();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local braveryMult = this.getBraveryMult();
		if (braveryMult != 1.0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(braveryMult) + " [Resolve|Concept.Bravery]")
			});
		}

		local initiativeMult = this.getInitiativeMult();
		if (initiativeMult != 1.0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(initiativeMult) + " [Initiative|Concept.Initiative]")
			});
		}

		local fatigueMult = this.getFatigueMult();
		if (fatigueMult != 1.0)
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString("Skills build up " + ::MSU.Text.colorizeMult(fatigueMult, {InvertColor = true}) + " less [Fatigue|Concept.Fatigue]")
			});
		}

		local damageMult = this.getDamageMult();
		if (damageMult != 1.0)
		{
			ret.push({
				id = 13,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal " + ::MSU.Text.colorizeMult(damageMult) + " more damage"
			});
		}

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("All stacks are lost when using [Wait|Concept.Wait]")
		});

		return ret;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.setStacks(0);
	}

	function onTurnEnd()
	{
		if (this.getContainer().getActor().isWaitActionSpent() == false)
		{
			this.setStacks(::Math.min(this.m.Stacks + 1, this.m.MaxStacks))
		}
	}

	function onWaitTurn()
	{
		this.setStacks(0);
	}

	function onUpdate( _properties )
	{
		_properties.BraveryMult *= this.getBraveryMult();
		_properties.InitiativeMult *= this.getInitiativeMult();
		_properties.DamageTotalMult *= this.getDamageMult();
		_properties.TargetAttractionMult *= this.getAttractionMult();	// This is on par with other vanilla effects which increase the damage output. All of them make the character more likely to be targeted
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
	function setStacks( _stacks )
	{
		this.m.Stacks = _stacks;
		if (this.m.Stacks == 0)
		{
			this.m.IconMini = "";
		}
		else
		{
			this.m.IconMini = this.m.OriginalIconMini;
		}
	}

	function getBraveryMult()
	{
		return this.m.Stacks >= 1 ? this.m.BraveryMult : 1.0;
	}

	function getInitiativeMult()
	{
		return this.m.Stacks >= 1 ? this.m.InitiativeMult : 1.0;
	}

	function getFatigueMult()
	{
		return this.m.Stacks >= 2 ? this.m.FatigueCostMult : 1.0;
	}

	function getDamageMult()
	{
		return this.m.Stacks >= 3 ? this.m.DamageMult : 1.0;
	}

	function getAttractionMult()
	{
		return this.m.Stacks >= 3 ? this.m.AttractionMult : 1.0;
	}
});
