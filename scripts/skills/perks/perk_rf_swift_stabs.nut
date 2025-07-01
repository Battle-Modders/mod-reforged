this.perk_rf_swift_stabs <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Dagger,
		RequiredDamageType = ::Const.Damage.DamageType.Piercing,
		ActionPointCostModifier = -2,
		ActionPointCostMin = 2,
		IsInEffect = false
	},
	function create()
	{
		this.m.ID = "perk.rf_swift_stabs";
		this.m.Name = ::Const.Strings.PerkName.RF_SwiftStabs;
		this.m.Description = "This character has successfully found an opening in the target\'s armor and can quickly deliver several deadly stabs.";
		this.m.Icon = "ui/perks/perk_rf_swift_stabs.png";
		this.m.IconMini = "perk_rf_swift_stabs_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
	}

	function isHidden()
	{
		return !this.m.IsInEffect;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local weaponTypeString = this.m.RequiredWeaponType == null ? "" : " " + ::Const.Items.getWeaponTypeName(this.m.RequiredWeaponType).tolower();
		local damageTypeString = this.m.RequiredDamageType == null ? "" : " " + ::Const.Damage.getDamageTypeName(this.m.RequiredDamageType).tolower();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString(format("[Action Point|Concept.ActionPoints] costs of%s%s attacks are %s by %s to a minimum of %i", damageTypeString, weaponTypeString, ::MSU.Text.colorizeValue(this.m.ActionPointCostModifier, {InvertColor = true, AddSign = true}), this.m.ActionPointCostMin))
		});

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire upon killing the target, switching targets, missing an attack, using any non-attack skill, swapping your weapon, or [waiting|Concept.Wait] or ending your [turn|Concept.Turn]")
		});

		return ret;
	}

	function onAfterUpdate(_properties)
	{
		if (this.m.IsInEffect)
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				if (this.isSkillValid(skill) && skill.m.ActionPointCost > this.m.ActionPointCostMin)
				{
					skill.m.ActionPointCost = ::Math.max(this.m.ActionPointCostMin, skill.m.ActionPointCost + this.m.ActionPointCostModifier);
				}
			}
		}
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.IsInEffect = false;
	}

	function onTurnEnd()
	{
		this.m.IsInEffect = false;
	}

	function onWaitTurn()
	{
		this.m.IsInEffect = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity.isAlive() && !_targetEntity.isDying() && this.isSkillValid(_skill))
		{
			this.m.IsInEffect = true;
		}
		else
		{
			this.m.IsInEffect = false;
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.m.IsInEffect = false;
	}

	function onAnySkillExecutedFully( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!this.isSkillValid(_skill) && !_forFree)
		{
			this.m.IsInEffect = false;
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsInEffect = false;
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || _skill.isRanged() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(this.m.RequiredDamageType)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
