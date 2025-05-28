::Reforged.HooksMod.hook("scripts/items/ammo/legendary/quiver_of_coated_arrows", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			if (entry.id == 7)
			{
				// Change the bleeding related entry to multiple stacks of bleeding instead of 2 turns of bleeding
				// because of different bleeding mechanics in Reforged
				entry.text = ::Reforged.Mod.Tooltips.parseString("Inflicts " + ::MSU.Text.colorDamage(this.m.BleedDamage / 5) + " + stacks of [Bleeding|Skill+bleeding_effect]")
				break;
			}
		}
		return ret;
	}}.getTooltip;

	// Overwrite vanilla function to:
	// - Extract skill validity into a separate function (vanilla only checks for ids of aimed shot or quick shot)
	// - Add multiple bleed stacks based on this.m.BleedDamage / 5
	q.onDamageDealt = @() { function onDamageDealt( _target, _skill, _hitInfo )
	{
		if (!this.isSkillValid(_skill))
			return;

		if (!_target.isAlive() || _target.isDying())
		{
			if (::isKindOf(_target, "lindwurm_tail") || !_target.getCurrentProperties().IsImmuneToBleeding)
			{
				::Sound.play(::MSU.Array.rand(this.m.BleedSounds), ::Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			}
		}
		else if (!_target.getCurrentProperties().IsImmuneToBleeding && _hitInfo.DamageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding)
		{
			for (local i = 0; i < this.m.BleedDamage / 5; i++)
			{
				_target.getSkills().add(::new("scripts/skills/effects/bleeding_effect"));
			}
			::Sound.play(::MSU.Array.rand(this.m.BleedSounds), ::Const.Sound.Volume.Skill, this.getContainer().getActor().getPos())
		}
	}}.onDamageDealt;

	q.isSkillValid <- { function isSkillValid( _skill )
	{
		if (!_skill.isRanged() || !_skill.isAttack())
			return false;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Bow);
	}}.isSkillValid;
});
