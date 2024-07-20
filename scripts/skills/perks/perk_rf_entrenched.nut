this.perk_rf_entrenched <- ::inherit("scripts/skills/skill", {
	m = {
		FirstStackBonus = 7,
		BonusPerStack = 2,
		MaxStacks = 5,
		Stacks = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_entrenched";
		this.m.Name = ::Const.Strings.PerkName.RF_Entrenched;
		this.m.Description = "This character\'s confidence in combat is increased due to support from adjacent allies.";
		this.m.Icon = "ui/perks/rf_entrenched.png";
		this.m.IconMini = "rf_entrenched_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getName()
	{
		return this.m.Stacks > 1 ? this.m.Name + " (x" + this.m.Stacks + ")" : this.m.Name;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		local bonus = this.getBonus();

		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Resolve"
			}
		]);

		return tooltip;
	}

	function isEnabled()
	{
		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isItemType(::Const.Items.ItemType.RangedWeapon))
		{
			return false;
		}

		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
		{
			return false;
		}

		local adjacentAllies = ::Tactical.Entities.getFactionActors(actor.getFaction(), actor.getTile(), 1);
		foreach (ally in adjacentAllies)
		{
			if (!ally.isEngagedInMelee() && ally.hasZoneOfControl() && ally.getID() != actor.getID())
			{
				return true;
			}
		}

		return false;
	}

	function getBonus()
	{
		return this.m.Stacks == 0 ? 0 : this.m.FirstStackBonus + (this.m.Stacks - 1) * this.m.BonusPerStack;
	}

	function onUpdate( _properties )
	{
		if (this.m.Stacks > 0 && this.isEnabled())
		{
			local bonus = this.getBonus();
			_properties.RangedSkill += bonus;
			_properties.RangedDefense += bonus;
			_properties.Bravery += bonus;
		}		
	}

	function onTurnStart()
	{
		if (this.isEnabled())
		{
			this.m.Stacks = ::Math.min(this.m.MaxStacks, this.m.Stacks + 1);
		}
		else
		{
			this.m.Stacks = 0;
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
	}
});
