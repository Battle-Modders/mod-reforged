this.perk_rf_spear_advantage <- ::inherit("scripts/skills/skill", {
	m = {
		BonusPerStack = 5,
		MaxStacks = 4,
		Opponents = {}
	},
	function create()
	{
		this.m.ID = "perk.rf_spear_advantage";
		this.m.Name = ::Const.Strings.PerkName.RF_SpearAdvantage;
		this.m.Description = "This character is using his spear to great effect, manifesting his advantage in combat.";
		this.m.Icon = "ui/perks/rf_spear_advantage.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.Opponents.len() == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/plus.png",
			text = "Increased Melee Skill and Melee Defense"
		});

		foreach (id, stacks in this.m.Opponents)
		{
			local opponent = ::Tactical.getEntityByID(id);
			if (opponent != null && opponent.isAlive() && opponent.isPlacedOnMap())
			{
				tooltip.push({
					id = 10,
					type = "text",
					icon = "ui/orientation/" + opponent.getOverlayImage() + ".png",
					text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.getBonus(id) + "[/color] against " + opponent.getName()
				});
			}
		}

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "[color=" + ::Const.UI.Color.NegativeValue + "]The bonus against an opponent expires upon receiving damage from that opponent[/color]"
		});

		return tooltip;
	}

	function getBonus( _entityID )
	{
		return ::Math.floor(this.m.Opponents[_entityID] * this.m.BonusPerStack);
	}

	function isEnabled()
	{
		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Spear);
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker != null && (_attacker.getID() in this.m.Opponents))
		{
			delete this.m.Opponents[_attacker.getID()];
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!this.isEnabled() || !_skill.isAttack()) return;

		if  (_targetEntity.isAlive())
		{
			if (!(_targetEntity.getID() in this.m.Opponents)) this.m.Opponents[_targetEntity.getID()] <- 1;
			else this.m.Opponents[_targetEntity.getID()] = ::Math.min(this.m.MaxStacks, this.m.Opponents[_targetEntity.getID()] + 1);
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (_attacker.getID() in this.m.Opponents)
		{
			_properties.MeleeDefense += this.getBonus(_attacker.getID());
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!this.isEnabled() || !_skill.isAttack() || _targetEntity == null) return;

		if (_targetEntity.getID() in this.m.Opponents)
		{
			_properties.MeleeSkill += this.getBonus(_targetEntity.getID());
		}
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (_skill.isRanged() || !_targetTile.IsOccupiedByActor) return;

		if (_targetTile.getEntity().getID() in this.m.Opponents)
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = ::MSU.Text.colorGreen(this.getBonus(_targetTile.getEntity().getID()) + "% ") + this.getName()
			});
		}
	}

	function onGetHitFactorsAsTarget( _skill, _targetTile, _tooltip )
	{
		if (_skill.isRanged()) return;

		if (_skill.getContainer().getActor() in this.m.Opponents)
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = ::MSU.Text.colorRed(this.getBonus(_skill.getContainer().getActor().getID()) + "% ") + this.getName()
			});
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Opponents.clear();
	}
});
