this.perk_rf_flail_spinner <- ::inherit("scripts/skills/skill", {
	m = {
		Chance = 50,
		DamageMult = 0.5,

		__SpinningWithSkill = null
	},
	function create()
	{
		this.m.ID = "perk.rf_flail_spinner";
		this.m.Name = ::Const.Strings.PerkName.RF_FlailSpinner;
		this.m.Description = ::Const.Strings.PerkDescription.RF_FlailSpinner;
		this.m.Icon = "ui/perks/perk_rf_flail_spinner.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (::MSU.isEqual(_skill, this.m.__SpinningWithSkill))
		{
			_properties.DamageTotalMult *= this.m.DamageMult;
		}
	}

	function onAnySkillExecutedFully( _skill, _targetTile, _targetEntity, _forFree )
	{
		// We nullify it in onAnySkillExecutedFully so that skills that do
		// multiple attacks in a single use get the damage reduction applied to all those attacks.
		if (::MSU.isEqual(_skill, this.m.__SpinningWithSkill))
		{
			this.m.__SpinningWithSkill = null;
			return;
		}

		// Don't try to spin unless an ACTUAL new skill was executed (i.e. the use is not _forFree)
		// Otherwise it leads to an infinite chain.
		if (_forFree || !this.isSkillValid(_skill))
			return;

		local user = this.getContainer().getActor();
		if (::MSU.isNull(user) || !user.isAlive() || !::Tactical.TurnSequenceBar.isActiveEntity(user))
			return;

		if (_targetEntity == null || !_targetEntity.isAlive() || ::Math.rand(1, 100) > this.m.Chance)
			return;

		this.getContainer().setBusy(true);
		local tag = {
			Skill = _skill,
			User = user,
			TargetEntity = _targetEntity,
			TargetTile = _targetTile,
			Callback = this.trySpinFlail.bindenv(this)
		};
		// Schedule with delay of 1 when in fog of war to speed up combat
		::Time.scheduleEvent(::TimeUnit.Virtual, !user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer ? 300 : 1, tag.Callback, tag);
	}

	function trySpinFlail( _tag )
	{
		if (!_tag.User.isAlive() || !_tag.TargetEntity.isAlive())
			return;

		// If the skill is already executing, we wait for it to complete that first.
		if (_tag.Skill.RF_isExecuting())
		{
			::Time.scheduleEvent(::TimeUnit.Virtual, 1, _tag.Callback, _tag);
			return;
		}

		this.doSpinAttack(_tag.Skill, _tag.User, _tag.TargetEntity, _tag.TargetTile);
		this.getContainer().setBusy(false);
	}

	function doSpinAttack( _skill, _user, _targetEntity, _targetTile )
	{
		::logDebug(format("[%s] is using skill [%s] on target [%s (%i)] due to %s", _user.getName(), _skill.getName(), _targetEntity.getName(), _targetEntity.getID(), this.m.Name));
		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " is Spinning the Flail");
		}

		this.m.__SpinningWithSkill = _skill;
		// Consider it as a new skill use because we want this attack to trigger effects/perks
		// and other effects that depend on SkillCounter e.g. condition loss for the three-headed flail
		::Const.SkillCounter++;
		_skill.useForFree(_targetTile);
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack())
			return false;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && ::MSU.isKindOf(weapon, "weapon") && weapon.isWeaponType(::Const.Items.WeaponType.Flail);
	}
});
