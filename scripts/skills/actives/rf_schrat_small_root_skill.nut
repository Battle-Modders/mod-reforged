this.rf_schrat_small_root_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_schrat_small_root";
		this.m.Name = "Root";
		this.m.Description = "";
		this.m.Icon = "skills/active_122.png";
		this.m.IconDisabled = "skills/active_122.png";
		this.m.Overlay = "active_122";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/schrat_uproot_short_01.wav",
			"sounds/enemies/dlc2/schrat_uproot_short_02.wav",
			"sounds/enemies/dlc2/schrat_uproot_short_03.wav",
			"sounds/enemies/dlc2/schrat_uproot_short_04.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/break_free_roots_00.wav",
			"sounds/combat/break_free_roots_01.wav",
			"sounds/combat/break_free_roots_02.wav",
			"sounds/combat/break_free_roots_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.ThrowNet;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && !_targetTile.getEntity().getCurrentProperties().IsRooted && !_targetTile.getEntity().getCurrentProperties().IsImmuneToRoot;
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();

		if (this.m.SoundOnHit.len() != 0)
		{
			::Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, targetEntity.getPos());
		}

		targetEntity.getSkills().add(::new("scripts/skills/effects/rooted_effect"));

		local breakFree = ::new("scripts/skills/actives/break_free_skill");
		breakFree.setDecal("roots_destroyed");
		breakFree.m.Icon = "skills/active_75.png";
		breakFree.m.IconDisabled = "skills/active_75_sw.png";
		breakFree.m.Overlay = "active_75";
		breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;
		targetEntity.getSkills().add(breakFree);
		targetEntity.raiseRootsFromGround("bust_roots", "bust_roots_back");

		::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has rooted " + ::Const.UI.getColorizedEntityName(targetEntity));

		this.getContainer().getActor().kill(this.getContainer().getActor(), this);

		return true;
	}
});

