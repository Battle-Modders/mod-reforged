::Reforged.HooksMod.hook("scripts/skills/actives/skewer_skill", function(q) {
	q.m.MeleeSkillAdd <- -20;

	q.create = @(__original) { function create()
	{
		__original();
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 5;
	}}.create;

	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push(
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Ignores additional armor, the higher the user\'s current Initiative")
			});

		if (this.m.MeleeSkillAdd != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has " + ::MSU.Text.colorizeValue(this.m.MeleeSkillAdd, {AddSign = true, AddPercent = true}) + " chance to hit"
			});
		}

		return ret;
	}}.getTooltip;

	q.onAfterUpdate = @() { function onAfterUpdate( _properties )
	{
        // Use sword mastery instead of dagger
		if (_properties.IsSpecializedInSwords)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
		}
	}}.onAnySkillUsed;

	q.onAnySkillUsed = @() { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{		
		if (_skill == this)
		{
			local a = this.getContainer().getActor();
            // adjust numbers for rf; skill is worse than default attack when lower than 87.5 init similar to lunge
			local s = this.Math.minf(2.0, 2.0 * (this.Math.max(0, a.getInitiative() + (_targetEntity != null ? this.getFatigueCost() * a.getCurrentProperties().FatigueToInitiativeRate : 0)) / 175.0));
			_properties.DamageDirectAdd += (s-1);

			if (!this.getContainer().getActor().isPlayerControlled())
			{
				_properties.MeleeSkill += this.m.MeleeSkillAdd;
				// this.m.HitChanceBonus is set by Modular Vanilla based on changes to _properties.MeleeSkill
			}
		}
	}}.onAnySkillUsed;
});
