this.rf_swordmaster_push_through_skill <- ::inherit("scripts/skills/actives/line_breaker", {
	m = {},
	function create()
	{
		this.line_breaker.create();
		this.m.ID = "actives.rf_swordmaster_push_through";
		this.m.Name = "Push Through";
		this.m.Description = "Use your muscle and grappling skills to knock back a target and take their place, all in one action."
		this.m.Icon = "skills/rf_swordmaster_push_through_skill.png";
		this.m.IconDisabled = "skills/rf_swordmaster_push_through_skill_bw.png";
		this.m.Overlay = "rf_swordmaster_push_through_skill";
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
		this.m.FatigueCost = 15;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.LineBreaker;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();
		local actor = this.getContainer().getActor();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + ::Const.UI.Color.PositiveValue + "]100%[/color] chance to stagger the target"
		});

		local attack = this.getContainer().getAttackOfOpportunity();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString(format("Perform a free [%s|Skill+%s] on the target", attack.getName(), split(::IO.scriptFilenameByHash(attack.ClassNameHash), "/").top()))
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "If the attack is successful, the target is pushed back a tile and you move into their position"
		});

		if (actor.getCurrentProperties().IsRooted || actor.getCurrentProperties().IsStunned)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Cannot be used while Rooted or Stunned[/color]"
			});
		}

		local perk = this.getContainer().getSkillByID("perk.rf_swordmaster_grappler");
		if (perk != null) perk.addEnabledTooltip(tooltip);

		return tooltip;
	}

	function isUsable()
	{
		local perk = this.getContainer().getSkillByID("perk.rf_swordmaster_grappler");
		if (perk == null || !perk.isEnabled()) return false;

		local actor = this.getContainer().getActor();
		return this.line_breaker.isUsable() && !actor.getCurrentProperties().IsRooted && !actor.getCurrentProperties().IsStunned;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		target.getSkills().add(::new("scripts/skills/effects/staggered_effect"));
		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has pushed through and staggered " + ::Const.UI.getColorizedEntityName(target));
		}

		local aoo = this.getContainer().getAttackOfOpportunity();
		local overlay = aoq.m.Overlay;
		aoq.m.Overlay = "";
		local success = aoo.useForFree(_targetTile);
		aoq.m.Overlay = overlay;

		if (success && target.isAlive())
		{
			this.line_breaker.onUse(_user, _targetTile);
		}

		return success;
	}
});

