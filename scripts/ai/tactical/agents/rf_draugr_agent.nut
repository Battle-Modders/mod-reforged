// Based on `zombie_agent` but we don't inherit from it
// because we don't want to auto-exclude behaviors from ::Reforged.ExcludedBehaviors.
this.rf_draugr_agent <- ::inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = ::Const.AI.Agent.ID.Zombie;
		this.m.Properties.TargetPriorityHitchanceMult = 0.25;
		this.m.Properties.TargetPriorityHitpointsMult = 0.25;
		this.m.Properties.TargetPriorityDamageMult = 0.25;
		this.m.Properties.TargetPriorityRandomMult = 0.25;
		this.m.Properties.TargetPriorityFleeingMult = 1.0;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.5;
		this.m.Properties.TargetPriorityCounterSkillsMult = 1.0;
		this.m.Properties.OverallDefensivenessMult = 0.0;
		this.m.Properties.OverallFormationMult = 0.5;
		this.m.Properties.OverallMagnetismMult = 0.5;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
		this.m.Properties.EngageOnGoodTerrainBonusMult = 0.0;
		this.m.Properties.EngageOnBadTerrainPenaltyMult = 0.0;
		this.m.Properties.EngageAgainstSpearwallMult = 0.0;
		this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.0;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 0.0;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;
		this.m.Properties.EngageLockDownTargetMult = 1.0;
		this.m.Properties.PreferCarefulEngage = false;
	}

	function onAddBehaviors()
	{
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_swing"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_split"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_thresh"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_bow"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_reload"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_pickup_weapon"));
	}

	function onUpdate()
	{
		this.setEngageRangeBasedOnWeapon();
		local item = this.m.Actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);

		if (item != null && item.isItemType(::Const.Items.ItemType.Weapon) && item.isAoE())
		{
			this.m.Properties.EngageTargetMultipleOpponentsMult = 0.75;
		}
		else
		{
			this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
		}
	}
});
