this.rf_trip_artist_effect <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = true
	},
	function create()
	{
		this.m.ID = "effects.rf_trip_artist";
		this.m.Name = "Trip Artist";
		this.m.Description = "This character is a master of fighting while using nets in the offhand.";
		this.m.Icon = "ui/perks/perk_rf_trip_artist.png";
		// this.m.IconMini = "rf_trip_artist_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
	}

	function isEnabled()
	{
		return this.getContainer().hasSkill("actives.throw_net");
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		if (::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()))
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("The first melee attack every [turn|Concept.Turn] against an adjacent target will apply the [staggered|Skill+staggered_effect] effect on a hit")
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("When wielding a weapon with a [Reach|Concept.Reach] of less than 4, " + ::MSU.Text.colorPositive("gain") + " the difference in [Reach|Concept.Reach] up to 4")
			});
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Requires an equipped net"
			});
		}
		else
		{
			if (!this.isEnabled())
			{
				ret.push({
					id = 20,
					type = "text",
					icon = "ui/icons/warning.png",
					text = ::MSU.Text.colorNegative("Requires an equipped net")
				});
			}
			else
			{
				if (!this.m.IsSpent || !::Tactical.isActive())
				{
					ret.push({
						id = 10,
						type = "text",
						icon = "ui/icons/special.png",
						text = ::Reforged.Mod.Tooltips.parseString("The next melee attack against an adjacent target will apply the [Staggered|Skill+staggered_effect] effect on a hit")
					});
				}

				local weapon = this.getContainer().getActor().getMainhandItem();
				if (weapon != null && weapon.getReach() < 4)
				{
					ret.push({
						id = 11,
						type = "text",
						icon = "ui/icons/special.png",
						text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(4 - weapon.getReach(), {AddSign = true}) + " [Reach|Concept.Reach]")
					});
				}
			}
		}

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
