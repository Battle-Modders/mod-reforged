::Reforged.HooksMod.hook("scripts/skills/actives/uproot_zoc_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/break_free_roots_00.wav",
			"sounds/combat/break_free_roots_01.wav",
			"sounds/combat/break_free_roots_02.wav",
			"sounds/combat/break_free_roots_03.wav"
		];
	}

	q.onTargetHit <- function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive())
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/rooted_effect"));

			local breakFree = ::new("scripts/skills/actives/break_free_skill");
			breakFree.setDecal("roots_destroyed");
			breakFree.m.Icon = "skills/active_75.png";
			breakFree.m.IconDisabled = "skills/active_75_sw.png";
			breakFree.m.Overlay = "active_75";
			breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;

			_targetEntity.getSkills().add(breakFree);

			_targetEntity.raiseRootsFromGround("bust_roots", "bust_roots_back");
		}
	}
});
