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
		this.m.Icon = "ui/perks/perk_rf_trip_artist.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		// Ensure that the actor has an offhand item with the throw_net skill
		local offhandItem = this.getContainer().getActor().getOffhandItem();
		if (offhandItem == null)
			return false;

		foreach (skill in offhandItem.getSkills())
		{
			if (skill.getID() == "actives.throw_net" && !skill.isHidden())
				return true;
		}

		return false;
	}

	function isHidden()
	{
		return this.m.IsSpent || !this.isEnabled();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The next melee attack against an adjacent target will [stagger|Skill+staggered_effect] them")
		});
		return ret;
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
