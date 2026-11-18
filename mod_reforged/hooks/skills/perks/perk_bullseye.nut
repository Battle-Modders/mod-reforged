::Reforged.HooksMod.hook("scripts/skills/perks/perk_bullseye", function(q) {
	q.onAnySkillUsed = @(__original) { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		if (!this.isSkillValid(_skill) || _targetEntity == null)
			return;

		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().RangedAttackBlockedChanceMult == 0 || ::Const.Tactical.Common.getBlockedTiles(actor.getTile(), _targetEntity.getTile(), actor.getFaction()).len() == 0)
		{
			_properties.DamageDirectAdd += this.getDirectDamageModifier(_skill);
		}
	}}.onAnySkillUsed;

	q.onGetHitFactors = @(__original) { function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		__original(_skill, _targetTile, _tooltip);

		if (!this.isSkillValid(_skill))
			return;

		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().RangedAttackBlockedChanceMult == 0 || ::Const.Tactical.Common.getBlockedTiles(actor.getTile(), _targetTile, actor.getFaction()).len() == 0)
		{
			_tooltip.push({
				icon = ::Const.Perks.findById(this.getID()).Icon,
				text = ::MSU.Text.colorizePct(this.getDirectDamageModifier(_skill), {AddSign = true}) + " armor penetration"
			});
		}
	}}.onGetHitFactors;

	q.getDirectDamageModifier <- { function getDirectDamageModifier( _skill )
	{
		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Bow) ? 0.1 : 0.2;
	}}.getDirectDamageModifier;

	q.isSkillValid <- { function isSkillValid( _skill )
	{
		return _skill.isRanged() && _skill.isAttack();
	}}.isSkillValid;
});
