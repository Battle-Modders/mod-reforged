::Reforged.HooksMod.hook("scripts/skills/actives/wither_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Curse the target, causing its body to wither away.";
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Wither;
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target becomes [$ $|Skill+withered_effect]")
		});
		return ret;
	}}.getTooltip;

	// Ifrits are now immune to wither
	// fix vanilla using getFlags().get instead of proper getFlags().has
	q.isViableTarget = @(__original) {function isViableTarget( _user, _target )
	{
		if (_target.getSkills().hasSkill("racial.golem") || target.getFlags().has("undead") && _target.getCurrentProperties().FatigueEffectMult == 0.0)
		{
			return false;
		}
		else
		{
			return __original(_user, _target);
		}
	}}.isViableTarget;
});
