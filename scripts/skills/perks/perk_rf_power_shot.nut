this.perk_rf_power_shot <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
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

	function isEnabled()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || (!weapon.isWeaponType(::Const.Items.WeaponType.Crossbow) && !weapon.isWeaponType(::Const.Items.WeaponType.Firearm)))
		{
			return false;
		}

		return true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_skill.isAttack() || !_skill.isRanged() || !_targetEntity.isAlive() || _targetEntity.isDying() || !this.isEnabled())
		{
			return;
		}

		if (::Math.rand(1, 100) <= this.m.Chance)
		{
			local effect = ::new("scripts/skills/effects/staggered_effect");
			_targetEntity.getSkills().add(effect);
			effect.m.TurnsLeft = 1;

			if (!this.getContainer().getActor().isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " has staggered " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for " + effect.m.TurnsLeft + " turn(s)");
			}
		}
	}
});
