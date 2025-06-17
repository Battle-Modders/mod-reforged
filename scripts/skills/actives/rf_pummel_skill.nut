this.rf_pummel_skill <- ::inherit("scripts/skills/actives/line_breaker", {
	m = {
		// Is set to true during the delayed line_breaker.onVerifyTarget call
		// so that during that call it properly requires a non-null tile to knock back to
		RequireTileToKnockBackTo = false
	},
	function create()
	{
		this.line_breaker.create();
		this.m.ID = "actives.rf_pummel";
		this.m.Name = "Pummel";
		this.m.Description = "Use a heavy attack to knock back your target and take their place, all in one action.";
		this.m.KilledString = "Crushed";
		this.m.Icon = "skills/rf_pummel_skill.png";
		this.m.IconDisabled = "skills/rf_pummel_skill_sw.png";
		this.m.Overlay = "rf_pummel_skill";
		this.m.SoundOnUse = [
			"sounds/combat/indomitable_01.wav",
			"sounds/combat/indomitable_02.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/smash_hit_01.wav",
			"sounds/combat/smash_hit_02.wav",
			"sounds/combat/smash_hit_03.wav"
		];
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsWeaponSkill = true;
		this.m.IsUsingHitchance = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.DirectDamageMult = 0.5;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.LineBreaker;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("[Staggers|Skill+staggered_effect] the target on a hit")
		});

		local line_breaker = ::new("scripts/skills/actives/line_breaker");
		line_breaker.m.Container = this.getContainer();

		// slice 3 to remove name, description and cost string
		ret.extend(line_breaker.getTooltip().slice(3));

		line_breaker.m.Container = null;

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Cannot be used while Rooted")
			});
		}

		return ret;
	}

	// This function is checked during line_breaker.onVerifyTarget. We want this skill
	// to be usable on even on targets who have no valid tile to knock back to because
	// it does an attack and may kill the target, opening up the target tile.
	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		local tile = this.line_breaker.findTileToKnockBackTo(_userTile, _targetTile);
		if (tile != null)
		{
			return tile;
		}

		return this.m.RequireTileToKnockBackTo ? null : _targetTile;
	}

	function isUsable()
	{
		return this.line_breaker.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted;
	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInHammers)
		{
			this.m.FatigueCostMult *= ::Const.Combat.WeaponSpecFatigueMult;
		}
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (success)
		{
			if (target.isAlive() && !target.isNonCombatant())
			{
				local stagger = this.new("scripts/skills/effects/staggered_effect");
				target.getSkills().add(stagger);

				if (_user.isAlive() && !_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(stagger.getLogEntryOnAdded(::Const.UI.getColorizedEntityName(_user), ::Const.UI.getColorizedEntityName(target)));
				}
			}

			local tag = {
				User = _user,
				TargetTile = _targetTile
			};
			// Doing this.line_breaker.onUse here directly doesn't work properly:
			// The targetEntity gets knocked back by Linebreaker, but the attacker does not move to the target tile.
			// Using scheduleEvent even with a delay of 1 is enough to make it work properly. No idea why. -- Midas
			::Time.scheduleEvent(::TimeUnit.Virtual, 1, this.onPummel.bindenv(this), tag);
		}

		return success;
	}

	function onPummel( _tag )
	{
		this.m.RequireTileToKnockBackTo = true;

		if (this.line_breaker.onVerifyTarget(_tag.User.getTile(), _tag.TargetTile))
			this.line_breaker.onUse(_tag.User, _tag.TargetTile);
		else
			::Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, null, null, false);

		this.m.RequireTileToKnockBackTo = false;
	}
});
