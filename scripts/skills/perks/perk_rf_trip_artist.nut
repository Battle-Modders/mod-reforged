this.perk_rf_trip_artist <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		IsSpent = true
	},
	function create()
	{
		this.m.ID = "perk.rf_trip_artist";
		this.m.Name = ::Const.Strings.PerkName.RF_TripArtist;
		this.m.Description = ::Const.Strings.PerkDescription.RF_TripArtist;
		this.m.Icon = "ui/perks/rf_trip_artist.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		return this.getContainer().hasSkill("actives.throw_net");
	}

	function isHidden()
	{
		return this.m.IsSpent || !this.isEnabled();
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The next melee attack against an adjacent target will apply the Staggered effect"
		});
	}

	function onUpdate( _properties )
	{
		if (!this.isEnabled()) return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.getReach() < 4)
		{
			_properties.Reach += 4 - weapon.getReach();
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.IsSpent || !_skill.isAttack() || _skill.isRanged() || !_targetEntity.isAlive() || !this.isEnabled() || _targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile()) > 1)
			return;

		this.m.IsSpent = true;

		_targetEntity.getSkills().add(::new("scripts/skills/effects/staggered_effect"));

		::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " has staggered " + ::Const.UI.getColorizedEntityName(_targetEntity));
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = true;
	}
});
