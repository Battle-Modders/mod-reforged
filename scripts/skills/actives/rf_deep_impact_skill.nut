// This skill is never meant to be added directly to a character. Instead you add another skill to the character
// and call this skill's convertToDeepImpactSkill function to convert that skill to a deep impact skill.
// This is because this skill is meant to be a proxy for the AOO of a weapon, but there is no clean way to achieve that.
this.rf_deep_impact_skill <- ::inherit("scripts/skills/skill", {
	m = {
		TwoHandedAPCostAdd = 2
	},
	function create()
	{
		this.m.ID = "actives.rf_deep_impact";
		this.m.Name = "Deep Impact";
		this.m.Description = "Hit them where it hurts the most.";
		this.m.Icon = "skills/rf_deep_impact_skill.png";
		this.m.IconDisabled = "skills/rf_deep_impact_skill_sw.png";
		this.m.Overlay = "rf_deep_impact_skill";
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.KnockOut;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();
		ret.extend(this.getDeepImpactTooltip());

		if (this.m.TwoHandedAPCostAdd != 0 && ::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()))
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString("Costs " + ::MSU.Text.colorizeValue(this.m.TwoHandedAPCostAdd, {AddSign = true, InvertColor = true}) + " [Action Points|Concept.ActionPoints] with two-handed hammers")
			});
		}

		return ret;
	}

	function getDeepImpactTooltip()
	{
		local effect = ::new("scripts/skills/effects/rf_deep_impact_effect");
		effect.m.Container = ::MSU.getDummyPlayer().getSkills();

		local ret = [{
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("If the attack is successful and does damage to [Hitpoints|Concept.Hitpoints] the target receives the [Deep Impact|Skill+rf_deep_impact_effect] effect"),
			children = effect.getTooltip().slice(2) // slice 2 to remove name and description
		}];

		effect.m.Container = null;

		return ret;
	}

	function onItemSet()
	{
		if (this.getItem().isItemType(::Const.Items.ItemType.TwoHanded))
		{
			this.m.ActionPointCost += this.m.TwoHandedAPCostAdd;
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

	// Converts the given skill to a "deep impact" version of it by modifying some `m` fields and some functions.
	// ALso changes the ID of that skill to deep impact's id.
	function convertSkill( _skill )
	{
		_skill.m.Name = _skill.m.Name + " (" + this.m.Name + ")";

		foreach (field in ["ID", "Description", "Icon", "IconDisabled", "Overlay", "IsIgnoredAsAOO", "FatigueCost", "AIBehaviorID"])
		{
			_skill.m[field] = this.m[field];
		}

		_skill.m.__RF_DeepImpactSkill <- this;

		local getTooltip = _skill.getTooltip;
		_skill.getTooltip = function()
		{
			local ret = getTooltip();
			ret.extend(this.m.__RF_DeepImpactSkill.getDeepImpactTooltip.call(this));
			return ret;
		}

		local onTargetHit = _skill.onTargetHit;
		_skill.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
		{
			onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor );
			this.m.__RF_DeepImpactSkill.onTargetHit.call(this, _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
		}
	}
});
