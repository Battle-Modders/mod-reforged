this.perk_rf_long_reach <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = null,
		RequiredWeaponReach = 7
	},
	function create()
	{
		this.m.ID = "perk.rf_long_reach";
		this.m.Name = ::Const.Strings.PerkName.RF_LongReach;
		this.m.Description = ::Const.Strings.PerkDescription.RF_LongReach;
		this.m.Icon = "ui/perks/perk_rf_long_reach.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	// This gets called by 'getSurroundedCount' from 'actor.nut' for every character at a distance of 2 tiles from _targetEntity, who has perk_rf_long_reach
	// @return true if we are surrounding _targetEntity, or false otherwise
	function countsAsSurrounding( _targetEntity )
	{
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local targetTile = _targetEntity.getTile();

		if (!actor.hasZoneOfControl() || !myTile.hasLineOfSightTo(targetTile, actor.getCurrentProperties().getVision()))
			return false;

		foreach (skill in actor.getSkills().getAllSkillsOfType(::Const.SkillType.Active))
		{
			if (this.isSkillValid(skill) && skill.verifyTargetAndRange(myTile, targetTile))
			{
				return true;
			}
		}

		return false;
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || _skill.getMaxRange() < 2)
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType) && weapon.getReach() >= this.m.RequiredWeaponReach;
	}
});
