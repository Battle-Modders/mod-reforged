this.perk_rf_bloodlust <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Cleaver,
		Stacks = 0,
		MaxStacks = 2,
		StacksPerTrigger = 2,
		MultPerStack = 0.25
	},
	function create()
	{
		this.m.ID = "perk.rf_bloodlust";
		this.m.Name = ::Const.Strings.PerkName.RF_Bloodlust;
		this.m.Description = "This character gains increased vigor when inflicting fatalities.";
		this.m.Icon = "ui/perks/rf_bloodlust.png";
		this.m.IconMini = "rf_bloodlust_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.BeforeLast; // So that it runs onAfterUpdate after active skills to properly reduce their fatigue cost
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local mult = 1.0 + (this.m.Stacks * this.m.MultPerStack);
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(mult) + " increased [Resolve|Concept.Bravery]")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(mult) + " increased [Initiative|Concept.Initiative]")
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(mult) + " more [Fatigue recovered|Concept.FatigueRecovery] next [turn|Concept.Turn]")
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("These effects are reduced by " + ::MSU.Text.colorNegative("-" + (this.m.MultPerStack * 100) + "%") + " every [turn|Concept.Turn] until another fatality")
		});
		return ret;
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		if (_fatalityType != ::Const.FatalityType.None && _killer != null && _killer.getID() == this.getContainer().getActor().getID() && _skill != null && this.isSkillValid(_skill))
		{
			this.m.Stacks = ::Math.min(this.m.MaxStacks, this.m.Stacks + this.m.StacksPerTrigger);
		}
	}

	function onUpdate( _properties )
	{
		if (this.m.Stacks == 0)
			return;

		local mult = 1.0 + this.m.MultPerStack * this.m.Stacks;
		_properties.BraveryMult *= mult;
		_properties.InitiativeMult *= mult;
		_properties.FatigueRecoveryRateMult *= mult;
	}

	function onAfterUpdate( _properties )
	{
		if (this.m.Stacks == 0)
			return;

		foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
		{
			skill.m.FatigueCostMult *= 1.0 - (this.m.MultPerStack * this.m.Stacks);
		}
	}

	function onTurnStart()
	{
		this.m.Stacks = ::Math.max(0, this.m.Stacks - 1);
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
	}

	function isSkillValid( _skill )
	{
		if (_skill.isRanged() || !_skill.isAttack())
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
