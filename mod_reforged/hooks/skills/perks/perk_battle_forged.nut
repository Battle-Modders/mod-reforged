::Reforged.HooksMod.hook("scripts/skills/perks/perk_battle_forged", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		local reachIgnore = this.getReachIgnore();
		if (reachIgnore > 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/rf_reach.png",
				text = ::Reforged.Mod.Tooltips.parseString("Ignore " + ::MSU.Text.colorPositive(reachIgnore) + " [Reach Disadvantage|Concept.ReachAdvantage] when attacking")
			});
		}
		return ret;
	}}.getTooltip;

	q.onAnySkillUsed = @() { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && _skill.isAttack() && !_skill.isRanged())
		{
			local armor = this.getContainer().getActor().getArmor(::Const.BodyPart.Head) + this.getContainer().getActor().getArmor(::Const.BodyPart.Body);
			_properties.OffensiveReachIgnore += this.getReachIgnore();
		}
	}}.onAnySkillUsed;

	q.getReachIgnore <- { function getReachIgnore()
	{
		local armor = this.getContainer().getActor().getArmor(::Const.BodyPart.Head) + this.getContainer().getActor().getArmor(::Const.BodyPart.Body);
		return ::Math.max(0, ::Math.min(2, armor / 300));
	}}.getReachIgnore;
});
