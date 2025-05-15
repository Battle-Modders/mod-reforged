// New ZoC skill for trickster_god (Ijirok)
this.rf_gore_zoc_skill <- ::inherit("scripts/skills/actives/gore_skill", {
	m = {},
	function create()
	{
		this.gore_skill.create();
		this.m.ID = "actives.rf_gore_zoc_skill";
		// This particular sound from the base gore_skill doesn't seem fitting for a ZoC attack
		::MSU.Array.removeByValue(this.m.SoundOnUse, "sounds/enemies/dlc4/thing_charge_03.wav");
		this.m.IsTargetingActor = true;
		this.m.IsVisibleTileNeeded = true;
		this.m.IsIgnoredAsAOO = false;
		this.m.ActionPointCost = 999;
		this.m.FatigueCost = 999;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
	}

	// Overwrite base gore_skill function
	function getTooltip()
	{
		return this.skill.getDefaultTooltip();
	}

	// Overwrite base gore_skill function
	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile);
	}

	// Overwrite base gore_skill function
	function onUpdate( _properties )
	{
	}

	// Overwrite base gore_skill function
	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectImpale);
		return this.attackEntity(_user, _targetTile.getEntity());
	}
});
