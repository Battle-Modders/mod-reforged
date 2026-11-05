this.rf_beckon_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Slaves = []
	},
	function removeSlave( _entityID, is_swapping_to_charm )
	{
		local i = this.m.Slaves.find(_entityID);

		if (i != null)
		{
			this.m.Slaves.remove(i);
		}
		
		this.getContainer().getActor().m.SlavesBeckon = this.m.Slaves.len();
		if (this.isAlive() && !is_swapping_to_charm && this.getContainer().getActor().m.SlavesBeckon == 0 && this.getContainer().getActor().m.SlavesCharm == 0)
		{
			this.getContainer().getActor().setCharming(false);
		}
	}

	function isAlive()
	{
		return this.getContainer() != null && !this.getContainer().isNull() && this.getContainer().getActor() != null && !this.getContainer().getActor().isNull() && this.getContainer().getActor().isAlive() && this.getContainer().getActor().getHitpoints() > 0;
	}

	function create()
	{
		this.m.ID = "actives.rf_beckon_skill";
		this.m.Name = "Beckon";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Try to beckon a character, forcing him to come to you and be charmed or expose himself. The higher a character\'s [Resolve|Concept.Bravery], the higher the chance to resist being charmed.");
		this.m.Icon = "skills/active_120.png";
		this.m.IconDisabled = "skills/active_120.png";
		this.m.Overlay = "active_120";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/hexe_charm_kiss_01.wav",
			"sounds/enemies/dlc2/hexe_charm_kiss_02.wav",
			"sounds/enemies/dlc2/hexe_charm_kiss_03.wav",
			"sounds/enemies/dlc2/hexe_charm_kiss_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/enemies/dlc2/hexe_charm_chimes_01.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_02.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_03.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_04.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 500;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = true;
        // Maybe allow the hexe to beckon 2 dudes with 4ap?
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 10;
        // Use charm in melee instead
		this.m.MinRange = 2;
		this.m.MaxRange = 8;
		this.m.MaxLevelDifference = 4;
	}

    function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will trigger " + ::MSU.Text.colorNegative("1") + " [morale checks|Concept.Morale] on the target and if successful, the target gains the [$ $|Skill+rf_beckoned_effect] effect")
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
		});

		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/vision.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will use [$ $|Skill+charm_skill] instead in melee range")
		});

		return ret;
	}

	function isViableTarget( _user, _target )
	{
		if (_target.isAlliedWith(_user))
		{
			return false;
		}

		if (_target.getMoraleState() == ::Const.MoraleState.Ignore || _target.getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			return false;
		}

		if (_target.getCurrentProperties().MoraleCheckBraveryMult[::Const.MoraleCheckType.MentalAttack] >= 1000.0)
		{
			return false;
		}

		if (_target.getSkills().hasSkill("effects.charmed"))
		{
			return false;
		}

		if (_target.getSkills().hasSkill("effects.rf_beckoned"))
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local tag = {
			User = _user,
			TargetTile = _targetTile
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onDelayedEffect.bindenv(this), tag);
		return true;
	}

	function onDelayedEffect( _tag )
	{
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;
		local target = _targetTile.getEntity();
		local time = this.Tactical.spawnProjectileEffect("effect_heart_01", _user.getTile(), _targetTile, 0.33, 2.0, false, false);
		local self = this;
		this.Time.scheduleEvent(this.TimeUnit.Virtual, time, function ( _e )
		{
			local bonus = _targetTile.getDistanceTo(_user.getTile()) == 1 ? -5 : 0;

			if (target.checkMorale(0, -35 + bonus, ::Const.MoraleCheckType.MentalAttack))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " resists being beckoned thanks to his resolve");
				}

				return false;
			}

			if (target.getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50)
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " resists being beckoned thanks to his unnatural physiology");
				}

				return false;
			}

			this.m.Slaves.push(target.getID());
			local beckoned = this.new("scripts/skills/effects/rf_beckoned_effect");
			beckoned.setMaster(self);
			target.getSkills().add(beckoned);

			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " is beckoned");
			}

			_user.setCharming(true);
		}.bindenv(this), this);
	}

	function onDeath( _fatalityType )
	{
		foreach( id in this.m.Slaves )
		{
			local e = this.Tactical.getEntityByID(id);

			if (e != null)
			{
				e.getSkills().removeByID("effects.beckoned");
			}
		}

		this.m.Slaves = [];
	}

});

