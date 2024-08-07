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
		this.m.Icon = "ui/perks/perk_rf_entrenched.png";
		this.m.IconMini = "perk_rf_entrenched_mini";
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
		local ret = this.skill.getTooltip();

		local bonus = this.getBonus();

		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+" + bonus) + " [Ranged Skill|Concept.RangeSkill]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+" + bonus) + " [Ranged Defense|Concept.RangeDefense]")
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+" + bonus) + " [Resolve|Concept.Bravery]")
			}
		]);

		return ret;
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
