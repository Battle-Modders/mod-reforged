this.rf_cover_ally_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_cover_ally";
		this.m.Name = "Cover Ally";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Cover an adjacent ally, allowing them to move one tile ignoring [Zone of Control|Concept.ZoneOfControl] on their turn. Your Melee Skill, Melee Defense, Ranged Skill, and Ranged Defense will be reduced while providing cover, and if you get stunned or rooted or are no longer adjacent to the target, the cover will be lost.");
		this.m.Icon = "skills/rf_cover_ally_skill.png";
		this.m.IconDisabled = "skills/rf_cover_ally_skill_sw.png";
		this.m.Overlay = "rf_cover_ally_skill";
		this.m.SoundOnHit = [
			"sounds/combat/shieldwall_01.wav",
			"sounds/combat/shieldwall_02.wav",
			"sounds/combat/shieldwall_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_CoverAlly;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("The target gains the [Move Under Cover|Skill+rf_move_under_cover_skill] skill which allows moving " + ::MSU.Text.colorPositive(1) + " tile ignoring [Zone of Control|Concept.ZoneOfControl]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("If the target stays adjacent to you until the start of the next [round|Concept.Round], their [turn|Concept.Turn] order is calculated with " + ::MSU.Text.colorPositive("+5000") + " [Initiative|Concept.Initiative]")
			}
		]);

		if (this.getContainer().getActor().getCurrentProperties().IsRooted || this.getContainer().getActor().getCurrentProperties().IsStunned)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Cannot be used while Rooted or [Stunned|Skill+stunned_effect]"))
			});
		}

		if (this.getContainer().hasSkill("effects.rf_covering_ally"))
		{
			ret.push({
				id = 21,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Cannot be used when already [providing cover|Skill+rf_covering_ally_effect] to an ally"))
			});
		}

		return ret;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();

		return this.skill.isUsable() && actor.isPlacedOnMap() && !actor.getCurrentProperties().IsRooted && !actor.getCurrentProperties().IsStunned && !this.getContainer().hasSkill("effects.rf_covering_ally") && ::Tactical.Entities.getAlliedActors(actor.getFaction(), actor.getTile(), 1, true).len() != 0;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		return this.getContainer().getActor().isAlliedWith(target) && !target.getCurrentProperties().IsStunned && !target.getCurrentProperties().IsRooted && !target.getSkills().hasSkill("effects.rf_covered_by_ally") && !target.getSkills().hasSkill("effects.rf_covering_ally");
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " provides cover to " + ::Const.UI.getColorizedEntityName(target));

			if (this.m.SoundOnHit.len() != 0)
			{
				::Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill * 1.2, _user.getPos());
			}
		}

		local coveredByAllyEffect = ::new("scripts/skills/effects/rf_covered_by_ally_effect");
		coveredByAllyEffect.setCoverProvider(_user);
		target.getSkills().add(coveredByAllyEffect);

		local coveringAllyEffect = ::new("scripts/skills/effects/rf_covering_ally_effect");
		coveringAllyEffect.setAlly(target);
		_user.getSkills().add(coveringAllyEffect);

		return true;
	}
});
