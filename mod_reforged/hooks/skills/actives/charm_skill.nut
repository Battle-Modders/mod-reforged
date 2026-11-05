::Reforged.HooksMod.hook("scripts/skills/actives/charm_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Try to charm a character, forcing him to turn on his allies and obey you instead. The higher a character\'s [Resolve|Concept.Bravery], the higher the chance to resist being charmed.");
		// Charm is now melee, use beckon at range instead
		this.m.MaxRange = 1;
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will trigger " + ::MSU.Text.colorNegative("2") + " [morale checks|Concept.Morale] on the target and if both are successful, the target gains the [$ $|Skill+charmed_effect] effect")
		});
		// ret.push({
		// 	id = 11,
		// 	type = "text",
		// 	icon = "ui/icons/vision.png",
		// 	text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
		// });
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Used in melee range only"
		});
		return ret;
	}}.getTooltip;

	q.isViableTarget = @(__original){ function isViableTarget( _user, _target ){
		if (_target.getSkills().hasSkill("effects.rf_beckoned"))
		{
			return false;
		}
		return __original(_user, _target);
	}}.isViableTarget;

	// Overwrite to count slaves together with beckon, requires the actor to have SlavesCharm and SlavesBeckon field in m like hexe
	q.removeSlave = @() { function removeSlave( _entityID )
	{
		local i = this.m.Slaves.find(_entityID);

		if (i != null)
		{
			this.m.Slaves.remove(i);
		}
		
		this.getContainer().getActor().m.SlavesCharm = this.m.Slaves.len();
		if (this.isAlive() && this.getContainer().getActor().m.SlavesBeckon == 0 && this.getContainer().getActor().m.SlavesCharm == 0)
		{
			this.getContainer().getActor().setCharming(false);
		}
	}}.removeSlave;

	// Sprite change is purely handled through onAdded of charm and beckon effects and removeSlave of skills
	q.onUpdate = @() { function onUpdate( _properties )
	{
	}}.onUpdate;
});
