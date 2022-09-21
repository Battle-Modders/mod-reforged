this.rf_push_forward_skill <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = false	
	},
	function create()
	{
		this.m.ID = "actives.rf_push_forward";
		this.m.Name = "Push Forward";
		this.m.Description = "Order your men to push forward through the enemy lines!"
		this.m.Icon = "skills/rf_push_forward_skill.png";
		this.m.IconDisabled = "skills/rf_push_forward_skill_bw.png";
		this.m.Overlay = "rf_push_forward_skill";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
		this.m.AIBehavior = {
			ID = ::Const.AI.Behavior.ID.RF_PushForward,
			Script = "scripts/ai/tactical/behaviors/ai_rf_push_forward"
		};
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Affects all allies within [color=" + ::Const.UI.Color.PositiveValue + "]4[/color] tiles who have at least [color=" + ::Const.UI.Color.NegativeValue + "]10[/color] Fatigue remaining and are not Stunned or Fleeing"
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Affected allies build [color=" + ::Const.UI.Color.NegativeValue + "]10[/color] Fatigue"
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Affected allies and you gain the \'Pushing Forward\' effect which grants " + ::MSU.Text.colorizeValue(10) + " Melee Skill, " + ::MSU.Text.colorizeValue(20) + " Initiative and one use of the \'Linebreaker\' skill with reduced Action Point and Fatigue Cost"
		});

		if (this.m.IsSpent)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Cannot be used more than once per combat (company-wide)")
			});
		}

		return tooltip;
	}

	function isUsable()
	{
		return !this.m.IsSpent && this.skill.isUsable();
	}

	function onUse( _user, _targetTile )
	{
		this.m.IsSpent = true;

		if (_user.isPlayerControlled())
		{
			local rosterBros = ::World.getPlayerRoster().getAll();
			foreach (bro in rosterBros)
			{
				local skill = bro.getSkills().getSkillByID("actives.rf_push_forward");
				if (skill != null) skill.m.IsSpent = true;
			}
		}

		local myTile = _user.getTile();

		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(_user.getFaction()))
		{
			if (ally.getMoraleState() == ::Const.MoraleState.Fleeing || ally.getCurrentProperties().IsStunned)
			{
				continue;
			}

			if (ally.getID() == _user.getID())
			{
				this.getContainer().add(::new("scripts/skills/effects/rf_push_forward_effect"));
			}
			else
			{
				if (ally.getTile().getDistanceTo(myTile) <= 4 && ally.getFatigueMax() - ally.getFatigue() >= 10)
				{
					ally.setFatigue(ally.getFatigue() + 10);
					bro.getSkills().add(::new("scripts/skills/effects/rf_push_forward_effect"));
				}
			}
		}

		return true;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = false;
	}
});
