this.perk_rf_eyes_up <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		TargetTile = null,
		ActorsAppliedTo = []
	},
	function create()
	{
		this.m.ID = "perk.rf_eyes_up";
		this.m.Name = ::Const.Strings.PerkName.RF_EyesUp;
		this.m.Description = ::Const.Strings.PerkDescription.RF_EyesUp;
		this.m.Icon = "ui/perks/rf_eyes_up.png";
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
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Bow))
		{
			return false;
		}

		return true;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.TargetTile = _targetTile;
		this.m.ActorsAppliedTo.clear();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.isEnabled() && (_skill.isRanged() || this.m.IsForceEnabled)) this.applyEffect(_targetEntity);
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (this.isEnabled() && (_skill.isRanged() || this.m.IsForceEnabled)) this.applyEffect(_targetEntity);
	}

	function applyEffect( _targetEntity )
	{
		if (_targetEntity.isAlive() && !_targetEntity.isDying() && this.m.ActorsAppliedTo.find(_targetEntity.getID()) == null)
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/rf_eyes_up_effect"));
			this.m.ActorsAppliedTo.push(_targetEntity.getID());
		}

		if (this.m.TargetTile == null)
			return;

		foreach (tile in ::MSU.Tile.getNeighbors(this.m.TargetTile))
		{
			if (tile.IsOccupiedByActor)
			{
				local entity = tile.getEntity();
				if (entity.isAlliedWith(this.getContainer().getActor()) || this.m.ActorsAppliedTo.find(entity.getID() != null)) continue;

				local effect = ::new("scripts/skills/effects/rf_eyes_up_effect");
				local previouslyAppliedEffect = entity.getSkills().getSkillByID("effects.rf_eyes_up");
				if (previouslyAppliedEffect != null)
				{
					previouslyAppliedEffect.addStacks(-0.5);
				}
				else
				{
					effect.addStacks(-0.5);
				}
				entity.getSkills().add(effect);
				this.m.ActorsAppliedTo.push(entity.getID());
			}
		}
	}

	function onCombatFinished()
	{
		this.m.TargetTile = null;
		this.m.ActorsAppliedTo.clear();
	}
});
