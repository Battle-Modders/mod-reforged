::Reforged.HooksMod.hook("scripts/items/weapons/legendary/obsidian_dagger", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 1;
	}}.create;

	q.getTooltip = @() { function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Applies [$ $|Skill+withered_effect] when inflicting at least " + ::MSU.Text.color(::Const.UI.Color.DamageValue, ::Const.Combat.PoisonEffectMinDamage) + " damage to [Hitpoints|Concept.Hitpoints]")
		});
		return result;
	}}.getTooltip;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		// ideally we should make unique skills with custom graphics to match other legendary weapons
		// and implement wither there too
		this.addSkill(::Reforged.new("scripts/skills/actives/stab"));

		this.addSkill(::Reforged.new("scripts/skills/actives/gash_skill", function(o) {
			// 15 fatigue cost gash
			o.m.FatigueCost -= 5;
			o.setApplyDaggerMastery(true);
		}));
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
