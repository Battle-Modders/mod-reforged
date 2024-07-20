this.rf_trip_artist_effect <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		IsSpent = true
	},
	function create()
	{
		this.m.ID = "effects.rf_trip_artist";
		this.m.Name = "Trip Artist";
		this.m.Description = "This character is a master of fighting while using nets in the offhand.";
		this.m.Icon = "ui/perks/rf_trip_artist.png";
		// this.m.IconMini = "rf_trip_artist_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
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
		return tooltip;
	}

	function getNestedTooltip()
	{
		if (this.getContainer().getActor().getID() != ::MSU.getDummyPlayer().getID())
			return this.getTooltip();

		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The first successful melee attack every [turn|Concept.Turn] against an adjacent target will apply the [staggered|Skill+staggered_effect] effect")
		});
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("When wielding a weapon with a [Reach|Concept.Reach] of less than 4, gain the difference in [Reach|Concept.Reach] up to 4")
		});
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::MSU.Text.colorNegative("Requires an equipped net")
		});
		return tooltip;
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
