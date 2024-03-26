::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_cleaver", function(q) {
	q.onAdded = @(__original) function()
	{
		__original();
		this.getContainer().add(::MSU.new("scripts/skills/perks/perk_rf_bloodlust", function(o) {
			o.m.IsRefundable = false;
			o.m.IsSerialized = false;
		}));
	}

	q.onRemoved = @(__original) function()
	{
		__original();
		this.getContainer().removeByID("perk.rf_bloodlust");
	}

	q.isEnabled <- function()
	{
		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Cleaver);
	}

	q.onTargetHit = @(__original) function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		__original(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
		if (_targetEntity.isAlive() && _damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding && !_targetEntity.getCurrentProperties().isImmuneToBleeding && _skill.isAttack() && _skill.m.IsWeaponSkill && this.isEnabled())
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/bleeding_effect"));
		}
	}
});
