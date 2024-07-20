this.rf_sanguine_curse_skill <- ::inherit("scripts/skills/skill", {
	m = {
		Victim = null
	},
	function create()
	{
		this.m.ID = "actives.rf_sanguine_curse";
		this.m.Name = "Sanguine Curse";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Apply a curse that drains the target of their [Hitpoints|Concept.Hitpoints] and [Stamina.|Concept.Fatigue]");
		this.m.Icon = "skills/rf_sanguine_curse_skill.png";
		this.m.IconDisabled = "skills/rf_sanguine_curse_skill.png";
		this.m.Overlay = "rf_sanguine_curse_skill";
		this.m.SoundOnUse = [
			"sounds/combat/rf_sanguine_curse_skill_01.wav",
			"sounds/combat/rf_sanguine_curse_skill_02.wav",
			"sounds/combat/rf_sanguine_curse_skill_03.wav",
			"sounds/combat/rf_sanguine_curse_skill_04.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 7;
		this.m.MaxLevelDifference = 4;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_SanguineCurse;
	}

	function setVictim( _entity )
	{
		this.m.Victim = _entity == null ? null : ::MSU.asWeakTableRef(_entity);
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Applies [Sanguine Curse|NullEntitySkill+rf_sanguine_curse_effect] on the target")
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::MSU.Text.colorNegative(::Reforged.Mod.Tooltips.parseString("Only a single [Sanguine Curse|NullEntitySkill+rf_sanguine_curse_effect] can be active at any time"))
		});
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && !_targetTile.getEntity().getSkills().hasSkill("effects.rf_sanguine_curse");
	}

	function isUsable()
	{
		return this.skill.isUsable() && ::MSU.isNull(this.m.Victim);
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.setVictim(target);

		local curse = ::new("scripts/skills/effects/rf_sanguine_curse_effect");
		curse.setCaster(_user);
		target.getSkills().add(curse);

		return true;
	}

	function onRemoved()
	{
		if (!::MSU.isNull(this.m.Victim))
		{
			this.m.Victim.getSkills().removeByID("effects.rf_sanguine_curse");
			this.m.Victim = null;
		}
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}
});
