::Reforged.HooksMod.hook("scripts/items/weapons/legendary/obsidian_dagger", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 1;
	}}.create;

	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Applies [$ $|Skill+withered_effect] when inflicting at least " + ::MSU.Text.color(::Const.UI.Color.DamageValue, ::Const.Combat.PoisonEffectMinDamage) + " damage to [Hitpoints|Concept.Hitpoints]")
		});
		return ret;
	}}.getTooltip;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/rf_obsidian_stab_skill"));
		
		this.addSkill(::Reforged.new("scripts/skills/actives/rf_obsidian_gash_skill"));
	}}.onEquip;

	// overwrite vanilla resurrection and add in wither
	// wither logic here is similar to bleed quiver
	q.onDamageDealt = @() { function onDamageDealt( _target, _skill, _hitInfo )
	{
		this.weapon.onDamageDealt(_target, _skill, _hitInfo);

		if (!_target.isAlive() || _target.isDying())
			return;

		// reimplement wither condition check here; ideally we can borrow the check in wither_skill?
		if ((_target.getFlags().has("undead") && _target.getCurrentProperties().FatigueEffectMult == 0.0) || _target.getSkills().hasSkill("racial.golem"))  
			return;
		
		if (_hitInfo.DamageInflictedHitpoints >= ::Const.Combat.PoisonEffectMinDamage)
		{
			_target.getSkills().add(::new("scripts/skills/effects/withered_effect"));
		}
	}}.onDamageDealt;
});
