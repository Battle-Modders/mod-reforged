this.rf_deep_impact_skill <- ::inherit("scripts/skills/actives/smite_skill", {
	m = {
		TwoHandedAPCostAdd = 2
	},
	function create()
	{
		this.smite_skill.create();
		this.m.ID = "actives.rf_deep_impact";
		this.m.Name = "Deep Impact";
		this.m.Description = "Hit them where it hurts the most.";
		this.m.Icon = "skills/rf_deep_impact_skill.png";
		this.m.IconDisabled = "skills/rf_deep_impact_skill_sw.png";
		this.m.Overlay = "rf_deep_impact_skill";
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.KnockOut;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();

		local effect = ::new("scripts/skills/effects/rf_deep_impact_effect");
		effect.m.Container = ::MSU.getDummyPlayer().getSkills();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("If the attack is successful and does damage to [Hitpoints|Concept.Hitpoints] the target receives the [Deep Impact|Skill+rf_deep_impact_effect] effect"),
			children = effect.getTooltip().slice(2) // slice 2 to remove name and description
		});

		effect.m.Container = null;

		if (this.m.TwoHandedAPCostAdd != 0 && ::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()))
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString("Costs " + ::MSU.Text.colorizeValue(this.m.TwoHandedAPCostAdd, {AddSign = true, InvertColor = true}) + " [Action Points|Concept.ActionPoints] with two-handed hammers")
			});
		}

		return ret;
	}

	function onAdded()
	{
		this.setBaseValue("ActionPointCost", this.getBaseValue("ActionPointCost") + this.m.TwoHandedAPCostAdd);
	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInHammers)
		{
			this.m.FatigueCostMult *= ::Const.Combat.WeaponSpecFatigueMult;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill != this || !_targetEntity.isAlive() || _damageInflictedHitpoints == 0)
			return;

		local effect = _targetEntity.getSkills().getSkillByID("effects.rf_deep_impact");
		if (effect == null)
			effect = ::new("scripts/skills/effects/rf_deep_impact_effect");

		local mult = _damageInflictedHitpoints.tofloat() / _targetEntity.getHitpoints();
		effect.setDamageTotalMult(effect.m.DamageTotalMult - mult);
		effect.setSkillMult(effect.m.SkillMult - mult);
		_targetEntity.getSkills().add(effect);
	}
});
