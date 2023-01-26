this.rf_inspiring_presence_buff_effect <- ::inherit("scripts/skills/skill", {
	m = {
		BonusActionPoints = 3,
		IsInEffect = false,
		IsStartingTurn = false
	},
	function create()
	{
		this.m.ID = "effects.rf_inspiring_presence_buff";
		this.m.Name = "Feeling Inspired";
		this.m.Description = "This character started the turn in the presence of a highly inspiring character!";
		this.m.Icon = "skills/rf_inspiring_presence_buff_effect.png";
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.StatusEffect;
		this.m.SoundOnUse = [
			"sounds/combat/rf_inspiring_presence_01.wav",
			"sounds/combat/rf_inspiring_presence_02.wav",
			"sounds/combat/rf_inspiring_presence_03.wav"
		];
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return !this.m.IsInEffect;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.BonusActionPoints + "[/color] Action Points"
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		if (this.m.IsInEffect)
		{
			_properties.ActionPoints += this.m.BonusActionPoints;
			
			if (this.m.IsStartingTurn)
			{
				this.getContainer().getActor().setActionPoints(this.getContainer().getActor().getActionPointsMax() + this.m.BonusActionPoints);
				this.m.IsStartingTurn = false;
			}
		}
	}

	function onTurnStart()
	{
		local actorHasAdjacentEnemy = function( _actor )
		{
			local adjacentEnemies = ::Tactical.Entities.getHostileActors(_actor.getFaction(), _actor.getTile(), 1, true);
			return adjacentEnemies.len() > 0;
		}

		local actor = this.getContainer().getActor();
		local allies = ::Tactical.Entities.getFactionActors(actor.getFaction(), actor.getTile(), 1, true);
		local hasAdjacentEnemy = actorHasAdjacentEnemy(actor);
		local hasInspirer = false;

		foreach (ally in allies)
		{
			if (!hasInspirer)
			{
				local inspiringPresence = ally.getSkills().getSkillByID("perk.inspiring_presence");
				if (inspiringPresence != null && inspiringPresence.isEnabled())
				{
					hasInspirer = true;
				}
			}

			if (!hasAdjacentEnemy && actorHasAdjacentEnemy(ally))
			{
				hasAdjacentEnemy = true;
			}
		}

		if (hasInspirer && hasAdjacentEnemy)
		{
			this.m.IsInEffect = true;
			this.m.IsStartingTurn = true;
			this.spawnIcon("rf_inspiring_presence_buff_effect", actor.getTile());
			::Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, actor.getPos());
		}
	}

	function onTurnEnd()
	{
		this.m.IsInEffect = false;
		this.m.IsStartingTurn = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished;
		this.m.IsInEffect = false;
		this.m.IsStartingTurn = false;
	}
});
