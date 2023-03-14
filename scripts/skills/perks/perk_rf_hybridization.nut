this.perk_rf_hybridization <- ::inherit("scripts/skills/skill", {
	m = {
		Bonus = 10
	},
	function create()
	{
		this.m.ID = "perk.rf_hybridization";
		this.m.Name = ::Const.Strings.PerkName.RF_Hybridization;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Hybridization;
		this.m.Icon = "ui/perks/rf_hybridization.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local bonus = ::Math.floor(this.getContainer().getActor().getBaseProperties().getRangedSkill() * this.m.Bonus * 0.01);

		_properties.MeleeSkill += bonus;
		_properties.MeleeDefense += bonus;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.getID() == "actives.throw_spear")
		{
			this.getContainer().getActor().getMainhandItem().m.ShieldDamage *= 1.5;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || !_skill.isRanged() || !_skill.m.IsWeaponSkill)
		{
			return;
		}

		local actor = this.getContainer().getActor();

		local weapon = actor.getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
			return;

		if (_skill.getDamageType().contains(::Const.Damage.DamageType.Blunt))
		{
			local staggeredEffect = _targetEntity.getSkills().getSkillByID("effects.staggered");
			if (staggeredEffect != null)
			{
				if (_targetEntity.getCurrentProperties().IsImmuneToStun) return;

				local effect = ::new("scripts/skills/effects/stunned_effect");
				_targetEntity.getSkills().add(effect);
				effect.m.TurnsLeft = 1;
				if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has stunned " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for " + effect.m.TurnsLeft + " turn");
				}
			}
			else if (::Math.rand(1, 100) <= 50)
			{
				local effect = ::new("scripts/skills/effects/staggered_effect");
				_targetEntity.getSkills().add(effect);
				effect.m.TurnsLeft = 1;
				if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has staggered " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for " + effect.m.TurnsLeft + " turn");
				}
			}
		}
		else if (_skill.getDamageType().contains(::Const.Damage.DamageType.Piercing))
		{
			if (::Math.rand(1, 100) <= 50)
			{
				local effect = ::new("scripts/skills/effects/rf_arrow_to_the_knee_debuff_effect");
				_targetEntity.getSkills().add(effect);
				if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has impaled " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for " + effect.m.TurnsLeft + " turns");
				}
			}
		}
		else if (_skill.getDamageType().contains(::Const.Damage.DamageType.Cutting))
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/overwhelmed_effect"));
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.getID() == "actives.throw_spear")
		{
			_tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Does " + ::MSU.Text.colorGreen("50%") + " increased damage to shields due to " + this.getName()
			});
		}
	}
});

