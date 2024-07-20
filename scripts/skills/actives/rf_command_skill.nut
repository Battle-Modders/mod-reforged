this.rf_command_skill <- ::inherit("scripts/skills/skill", {
	m = {
		ActionPointsRecovered = 1
	},

	function create()
	{
		this.m.ID = "actives.rf_command";
		this.m.Name = "Command";
		this.m.Description = "Command an ally to act now!\nCannot be used on fleeing or stunned allies.";
		this.m.Icon = "skills/rf_command_skill.png";
		this.m.IconDisabled = "skills/rf_command_skill_sw.png";
		this.m.Overlay = "rf_command_skill";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_Command;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.extend([
			{
				id = 8,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "Move the target to the next position in the turn sequence"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Recover " + ::MSU.Text.colorPositive(this.m.ActionPointsRecovered) + " Action Point(s) on the target"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of " + ::MSU.Text.colorPositive(this.getMaxRange()) + " tiles"
			}
		]);

		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) return false;

		local target = _targetTile.getEntity();

		if (this.m.Container.getActor().getFaction() != target.getFaction()) return false;

		if (target.isTurnDone()) return false;
		if (target.getCurrentProperties().IsStunned) return false;
		if (target.getMoraleState() == ::Const.MoraleState.Fleeing) return false;
		if (target.getSkills().hasSkill("effects.rf_commanded")) return false;

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		::Tactical.TurnSequenceBar.moveEntityToFront(target.getID());

		if (!_user.isHiddenToPlayer())
		{
			local logText = ::Const.UI.getColorizedEntityName(_user) + " uses Command";
			if (!target.isHiddenToPlayer())
			{
				logText += " on " + ::Const.UI.getColorizedEntityName(target);
			}
			::Tactical.EventLog.log(logText);
		}

		local recoveredActionPoints = ::Math.min(target.getActionPointsMax() - target.getActionPoints(), this.m.ActionPointsRecovered);
		if (recoveredActionPoints != 0)
		{
			target.setActionPoints(target.getActionPoints() + recoveredActionPoints);
			if (!target.isHiddenToPlayer())
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " recovers " + ::MSU.Text.colorPositive(recoveredActionPoints) + " Action Point(s)");
			}
		}
		target.getSkills().add(::new("scripts/skills/effects/rf_commanded_effect"));

		this.spawnIcon("rf_command_effect", _targetTile);
		return true;
	}
});
