this.rf_deep_impact_skill <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = null,
		RequiredDamageType = null,
		IsAttacking = false // Used to check that this skill was used to trigger the AOO and if yes then apply debuff
	},
	function create()
	{
		this.m.ID = "actives.rf_deep_impact";
		this.m.Name = "Deep Impact";
		this.m.Description = "Hit them where it hurts the most.";
		this.m.Icon = "skills/rf_deep_impact_skill.png";
		this.m.IconDisabled = "skills/rf_deep_impact_skill_sw.png";
		this.m.Overlay = "rf_deep_impact_skill";
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.KnockOut;
	}

	function getCostString()
	{
		local aoo = this.getContainer().getAttackOfOpportunity();
		if (aoo != null && this.isSkillValid(aoo))
			return this.skill.getCostString();

		return ::Reforged.Mod.Tooltips.parseString("Costs as if your primary attack had a base [Fatigue|Concept.Fatigue] cost of " + ::MSU.Text.colorNegative(this.m.FatigueCost));
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		if (this.getContainer().getActor().getID() == ::MSU.getDummyPlayer().getID())
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Perform your primary attack on the target and if successful, apply the [Deep Impact|Skill+rf_deep_impact_effect] effect")
			});
			return ret;
		}

		local aoo = this.getContainer().getAttackOfOpportunity();
		if (aoo == null || !this.isSkillValid(aoo))
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Requires a valid attack"))
			});
		}
		else
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("Perform a %s on the target and if successful, apply the [Deep Impact|Skill+rf_deep_impact_effect] effect", ::Reforged.NestedTooltips.getNestedSkillName(aoo)))
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		local aoo = this.getContainer().getAttackOfOpportunity();
		if (aoo != null && this.isSkillValid(aoo))
		{
			this.m.ActionPointCost = aoo.m.ActionPointCost;
			this.m.FatigueCostMult = aoo.m.FatigueCostMult;
			this.m.MinRange = aoo.m.MinRange;
			this.m.MaxRange = aoo.m.MaxRange;
		}
	}

	// MSU function
	// overwrite to return AOO damage type instead of our own
	function getDamageType()
	{
		local aoo = this.getContainer().getAttackOfOpportunity();
		return aoo != null && this.isSkillValid(aoo) ? aoo.getDamageType() : this.skill.getDamageType();
	}

	function isUsable()
	{
		local aoo = this.getContainer().getAttackOfOpportunity();
		return aoo != null && aoo.isUsable() && this.isSkillValid(aoo);
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		local aoo = this.getContainer().getAttackOfOpportunity();
		return aoo != null && aoo.onVerifyTarget(_originTile, _targetTile);
	}

	// This skill really just serves as a proxy for the AOO. It's job is to trigger the AOO on the target tile
	function onUse( _user, _targetTile )
	{
		local aoo = this.getContainer().getAttackOfOpportunity();

		local overlay = aoo.m.Overlay;
		aoo.m.Overlay = "";

		this.m.IsAttacking = true;
		local ret = aoo.useForFree(_targetTile);
		this.m.IsAttacking = false;

		aoo.m.Overlay = overlay;

		return ret;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!this.m.IsAttacking || !_targetEntity.isAlive() || _damageInflictedHitpoints == 0 || !this.isSkillValid(_skill))
			return;

		local effect = _targetEntity.getSkills().getSkillByID("effects.rf_deep_impact");
		if (effect == null)
			effect = ::new("scripts/skills/effects/rf_deep_impact_effect");

		effect.setDamageTotalMult(effect.m.DamageTotalMult - _damageInflictedHitpoints.tofloat() / _targetEntity.getHitpoints());
		_targetEntity.getSkills().add(effect);
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(this.m.RequiredDamageType)))
			return;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
