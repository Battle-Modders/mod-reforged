this.perk_rf_bloodbath <- ::inherit("scripts/skills/skill", {
	m = {
		RestoredActionPoints = 3
	},
	function create()
	{
		this.m.ID = "perk.rf_bloodbath";
		this.m.Name = ::Const.Strings.PerkName.RF_Bloodbath;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Bloodbath;
		this.m.Icon = "ui/perks/rf_bloodbath.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		if (_fatalityType != ::Const.FatalityType.None && _killer != null && _killer.getID() == this.getContainer().getActor().getID() && _skill != null && !_skill.isRanged() && _skill.isAttack() && ::Tactical.TurnSequenceBar.isActiveEntity(_killer))
		{
			_killer.setActionPoints(::Math.min(_killer.getActionPointsMax(), _killer.getActionPoints() + this.m.RestoredActionPoints));
			_killer.setDirty(true);
			this.spawnIcon("perk_rf_bloodbath", _killer.getTile());
		}
	}
});

