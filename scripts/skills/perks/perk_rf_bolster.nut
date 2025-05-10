this.perk_rf_bolster <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = null,
		RequiredWeaponReach = 6
	},
	function create()
	{
		this.m.ID = "perk.rf_bolster";
		this.m.Name = ::Const.Strings.PerkName.RF_Bolster;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Bolster;
		this.m.Icon = "ui/perks/perk_rf_bolster.png";
		this.m.Overlay = "perk_rf_bolster";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || actor.isEngagedInMelee() || !this.isSkillValid(_skill))
			return;

		foreach (ally in ::Tactical.Entities.getFactionActors(actor.getFaction(), actor.getTile(), 1, true))
		{
			local moraleState = ally.getMoraleState();
			if (moraleState < ::Const.MoraleState.Confident)
			{
				ally.checkMorale(1, ::Const.Morale.RallyBaseDifficulty, ::Const.MoraleCheckType.Default, this.m.Overlay);
			}
		}
	}

	function isSkillValid( _skill )
	{
		if (_skill.isRanged() || !_skill.isAttack())
			return false;

		local weapon = _skill.getItem();
		if (::MSU.isNull(weapon))
			return this.m.RequiredWeaponType == null && this.m.RequiredWeaponReach == null;

		return weapon.isItemType(::Const.Items.ItemType.Weapon) && (this.m.RequiredWeaponReach == null || weapon.getReach() >= this.m.RequiredWeaponReach) && (this.m.RequiredWeaponType == null || weapon.isWeaponType(this.m.RequiredWeaponType));
	}
});
