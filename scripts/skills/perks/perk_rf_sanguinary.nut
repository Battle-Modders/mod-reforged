this.perk_rf_sanguinary <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Cleaver,
		RequiredDamageType = ::Const.Damage.DamageType.Cutting,
		IsSpent = true,
		RestoredActionPoints = 3
	},
	function create()
	{
		this.m.ID = "perk.rf_sanguinary";
		this.m.Name = ::Const.Strings.PerkName.RF_Sanguinary;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Sanguinary;
		this.m.Icon = "ui/perks/rf_sanguinary.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		if (this.m.IsSpent || _fatalityType == ::Const.FatalityType.None || _killer == null || _killer.getID() != this.getContainer().getActor().getID() || !_killer.isPlacedOnMap() || !::Tactical.TurnSequenceBar.isActiveEntity(_killer))
			return;

		if (_skill == null || !this.isSkillValid(_skill))
			return;

		_killer.setActionPoints(::Math.min(_killer.getActionPointsMax(), _killer.getActionPoints() + this.m.RestoredActionPoints));
		_killer.setDirty(true);
		this.spawnIcon("perk_rf_sanguinary", _killer.getTile());
		this.m.IsSpent = true; // Ensures that it cannot trigger more than once per attack (e.g. even if you kill multiple opponents in an AOE attack)
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.IsSpent = false;
	}

	function isSkillValid( _skill )
	{
		if (_skill.isRanged() || !_skill.isAttack() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(::Const.Damage.DamageType.Cutting)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
