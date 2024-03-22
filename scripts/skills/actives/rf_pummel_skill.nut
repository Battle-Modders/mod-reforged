this.rf_pummel_skill <- ::inherit("scripts/skills/actives/line_breaker", {
	m = {},
	function create()
	{
		this.line_breaker.create();
		this.m.ID = "actives.rf_pummel";
		this.m.Name = "Pummel";
		this.m.Description = "Use a heavy attack to knock back your target and take their place, all in one action."
		this.m.Icon = "skills/rf_pummel_skill.png";
		this.m.IconDisabled = "skills/rf_pummel_skill_sw.png";
		this.m.Overlay = "rf_pummel_skill";
		this.m.SoundOnUse = [
			"sounds/combat/indomitable_01.wav",
			"sounds/combat/indomitable_02.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/knockback_hit_01.wav",
			"sounds/combat/knockback_hit_02.wav",
			"sounds/combat/knockback_hit_03.wav"
		];
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.LineBreaker;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		local actor = this.getContainer().getActor();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + ::Const.UI.Color.PositiveValue + "]100%[/color] chance to stagger the target"
		});

		local attack = this.getContainer().getAttackOfOpportunity();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString(format("Perform a free [%s|Skill+%s] on the target", attack.getName(), split(::IO.scriptFilenameByHash(attack.ClassNameHash), "/").top()))
		});

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "If the attack is successful, the target is pushed back a tile and you move into their position"
		});

		if (actor.getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Cannot be used while Rooted")
			});
		}

		return ret;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		return this.line_breaker.isUsable() && !actor.getCurrentProperties().IsRooted;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		target.getSkills().add(::new("scripts/skills/effects/staggered_effect"));
		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has pummeled and staggered " + ::Const.UI.getColorizedEntityName(target));
		}

		local aoo = this.getContainer().getAttackOfOpportunity();
		local overlay = aoo.m.Overlay;
		aoo.m.Overlay = "";
		local success = aoo.useForFree(_targetTile);
		aoo.m.Overlay = overlay;

		if (success && target.isAlive())
		{
			local tag = {
				User = _user,
				TargetTile = _targetTile
			}
			// Doing this.line_breaker.onUse here directly doesn't work properly.
			// The target gets knocked back by Linebreaker, but the attacker does not move to the target tile.
			// Using scheduleEvent even with a delay of 1 is enough to make it work properly. No idea why.
			::Time.scheduleEvent(::TimeUnit.Virtual, 1, this.onPushThrough.bindenv(this), tag);
		}

		return success;
	}

	function onPushThrough( _tag )
	{
		this.line_breaker.onUse(_tag.User, _tag.TargetTile);
	}
});

