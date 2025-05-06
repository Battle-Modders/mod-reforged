this.rf_line_breaker_skill <- ::inherit("scripts/skills/actives/line_breaker", {
	m = {
		IsForceEnabled = false
	},
	function create()
	{
		this.line_breaker.create();
		this.m.ID = "actives.rf_line_breaker";
		this.m.Name = "Line Breaker";
		this.m.Description = "Push through the ranks of your enemies by knocking back a target and taking its place, all in one action.";
		this.m.Icon = "skills/rf_line_breaker_skill.png";
		this.m.IconDisabled = "skills/rf_line_breaker_skill_sw.png";
		this.m.Overlay = "rf_line_breaker_skill";
		this.m.SoundOnUse = [
			"sounds/combat/indomitable_01.wav",
			"sounds/combat/indomitable_02.wav"
		];
		this.m.IsSerialized = false;
		this.m.FatigueCost = 25;
		this.m.IsUsingHitchance = true;
		this.m.HitChanceBonus = 15;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.LineBreaker;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = ::Reforged.Mod.Tooltips.parseString(format("Has %s chance to hit", ::MSU.Text.colorizeValue(this.m.HitChanceBonus, {AddSign = true, AddPercent = true})))
		});

		if (!this.getContainer().getActor().getCurrentProperties().IsRooted || this.getContainer().getActor().getCurrentProperties().IsStunned)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Cannot be used while Rooted or [Stunned|Skill+stunned_effect]"))
			});
		}

		return ret;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		return this.skill.isUsable() && (this.m.IsForceEnabled || actor.isArmedWithShield()) && !actor.getCurrentProperties().IsRooted && !actor.getCurrentProperties().IsStunned;
	}

	function onUse( _user, _targetTile )
	{
		if (this.attackEntity(_user, _targetTile.getEntity()))
		{
			local tag = {
				User = _user,
				TargetTile = _targetTile
			}
			// Doing this.line_breaker.onUse here directly doesn't work properly.
			// The target gets knocked back by Linebreaker, but the attacker does not move to the target tile.
			// Using scheduleEvent even with a delay of 1 is enough to make it work properly. No idea why.
			::Time.scheduleEvent(::TimeUnit.Virtual, 1, this.onPushThrough.bindenv(this), tag);

			return true;
		}

		return false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.line_breaker.onAnySkillUsed(_skill, _targetEntity, _properties);

		if (_skill == this)
		{
			_properties.DamageTotalMult = 0.0;
			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}

	function onPushThrough( _tag )
	{
		if (_tag.TargetTile.IsOccupiedByActor)
			this.line_breaker.onUse(_tag.User, _tag.TargetTile);
	}
});
