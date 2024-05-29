this.perk_rf_power_shot <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Crossbow | ::Const.Items.WeaponType.Firearm,
		Chance = 50
	},
	function create()
	{
		this.m.ID = "perk.rf_power_shot";
		this.m.Name = ::Const.Strings.PerkName.RF_PowerShot;
		this.m.Description = ::Const.Strings.PerkDescription.RF_PowerShot;
		this.m.Icon = "ui/perks/rf_power_shot.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || !this.isSkillValid(_skill) || ::Math.rand(1, 100) > this.m.Chance)
			return;

		local effect = ::new("scripts/skills/effects/staggered_effect");
		_targetEntity.getSkills().add(effect);
		effect.m.TurnsLeft = 1;

		if (!this.getContainer().getActor().isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " has staggered " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for " + effect.m.TurnsLeft + " turn(s)");
		}
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack())
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
