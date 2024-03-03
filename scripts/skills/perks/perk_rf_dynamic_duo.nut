this.perk_rf_dynamic_duo <- this.inherit("scripts/skills/skill", {
	m = {
		Partner = null,
		IsDuo = false,#

		// Config
		InitiativeBonus = 20,
		ResolveBonus = 10,

		// Const
		IsolationDistance = 1,
		MaxAllowedAllies = 1,	// other than this character
	},
	function create()
	{
		this.m.ID = "perk.rf_dynamic_duo";
		this.m.Name = ::Const.Strings.PerkName.RF_DynamicDuo;
		this.m.Description = ::Const.Strings.PerkDescription.RF_DynamicDuo;
		this.m.Icon = "ui/perks/rf_dynamic_duo.png";
		this.m.IconMini = "rf_dynamic_duo_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.BeforeLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		local ret = "Instead of fighting in a large formation, this character has trained to fight as a duo and gains bonuses while there is only one nearby ally."
		if (this.m.IsAllyDynamicDuo)
		{
			ret += " As, " + this.Tactical.getEntityByID(this.m.AllyID).getName() + " also has this perk, the bonuses are increased.";
		}

		return ret;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.m.IsDuo)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::MSU.Text.colorizeText(this.getResolveBonus()) + " Initiative"
			});

			tooltip.push({
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::MSU.Text.colorizeText(this.getInitiativeBonus()) + " Initiative"
			});
		}

		return tooltip;
	}

	function onAdded()
	{
		this.addChild(::new("scripts/skills/actives/rf_shuffle_skill"));
	}

	function onUpdate( _properties )
	{
		if (this.isDuo(true))
		{
			_properties.Bravery += this.getResolveBonus();
			_properties.Initiative += this.getInitiativeBonus();
		}
	}

// New Functions
	function getResolveBonus()
	{
		return this.m.ResolveBonus;
	}

	function getInitiativeBonus()
	{
		return this.m.InitiativeBonus;
	}

	function hasPartner( _checkFirst = false )
	{
		if (_checkFirst)
		{
			this.checkForPartner();
		}

		return (this.getPartner() != null && this.getPartner().isPlacedOnMap())
	}

	function isDuo( _checkFirst = false )
	{
		if (_checkFirst)
		{
			this.checkForPartner()
		}

		return this.m.IsDuo;
	}

	function getPartner( _checkFirst = false )
	{
		if (_checkFirst)
		{
			this.checkForPartner();
		}

		return this.m.Partner;
	}

	function checkForPartner()
	{
		this.m.Partner = null;
		this.m.IsDuo = false;

		local actor = this.getContainer().getActor();
		if (actor.isPlacedOnMap())
		{
			local adjacentFactionAllies = ::Tactical.Entities.getFactionActors(actor.getFaction(), actor.getTile(), this.m.IsolationDistance, true);
			if (adjacentFactionAllies.len() == this.m.MaxAllowedAllies)
			{
				this.m.Partner = adjacentFactionAllies[0];
				this.m.IsDuo = this.m.Partner.getSkills().hasSkill(this.getID());
			}
		}
	}
});
