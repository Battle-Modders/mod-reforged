this.perk_rf_sanguinary <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		RequiresWeapon = true,
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
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled || !this.m.RequiresWeapon)
			return true;

		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Cleaver);
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		if (!this.m.IsSpent || _fatalityType == ::Const.FatalityType.None || _killer == null || _killer.getID() != this.getContainer().getActor().getID() || !_killer.isPlacedOnMap() || !::Tactical.TurnSequenceBar.isActiveEntity(_killer))
			return;

		if (_skill == null || !_skill.isAttack() || (!this.m.RequiresWeapon && !_skill.m.IsWeaponSkill) || !this.isEnabled())
			return;

		_killer.setActionPoints(::Math.min(_killer.getActionPointsMax(), _killer.getActionPoints() + this.m.RestoredActionPoints));
		_killer.setDirty(true);
		this.spawnIcon("perk_rf_sanguinary", _killer.getTile());
		this.m.IsSpent = true;
	}

	// Ensures that it cannot trigger more than once per attack (e.g. even if you kill multiple opponents in an AOE attack)
	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.IsSpent = false;
	}
});
