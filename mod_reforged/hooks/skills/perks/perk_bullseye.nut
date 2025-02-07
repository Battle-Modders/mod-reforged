::Reforged.HooksMod.hook("scripts/skills/perks/perk_bullseye", function(q) {
	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		if (!_skill.isRanged() || _targetEntity == null)
			return;

		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().RangedAttackBlockedChanceMult == 0 || ::Const.Tactical.Common.getBlockedTiles(actor.getTile(), _targetEntity.getTile(), actor.getFaction()).len() == 0)
		{
			_properties.DamageDirectAdd += this.getDirectDamageModifier(_skill);
		}
	}

	q.onGetHitFactors = @(__original) function( _skill, _targetTile, _tooltip )
	{
		__original(_skill, _targetTile, _tooltip);

		if (_skill != this)
			return;

		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().RangedAttackBlockedChanceMult == 0 || ::Const.Tactical.Common.getBlockedTiles(actor.getTile(), _targetTile, actor.getFaction()).len() == 0)
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = this.getName()
			});
		}
	}

	q.getDirectDamageModifier <- function( _skill )
	{
		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Bow) ? 0.1 : 0.2;
	}
});
