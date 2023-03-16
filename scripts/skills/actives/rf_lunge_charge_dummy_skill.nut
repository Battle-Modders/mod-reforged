// The purpose of this skill is to allow the `ai_charge.nut` and `ai_engage_melee.nut` vanilla behaviors to be used for Lunge AI.
// It adds a dummy skill that works like the charge skill i.e. it is used on empty tiles adjacent to an enemy
// If it is usable then it allows the `ai_engage_melee.nut` behavior to tell the entity to carefully position themselves to engage with a Lunge
// instead of walking straight into the face of an enemy.

this.rf_lunge_charge_dummy_skill <- ::inherit("scripts/skills/actives/charge", {
	m = {},
	function create()
	{
		this.charge.create();
		this.m.ID = "actives.rf_lunge_charge_dummy";
		this.m.Name = "Lunge Charge";
		this.m.Description = "You should not be able to see this skill. If you are seeing it, then please report it as a bug."
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Charge;
	}

	function isHidden()
	{
		return !this.getContainer().hasSkill("actives.lunge");
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsEmpty) return false;

		local lunge = this.getContainer().getSkillByID("actives.lunge");
		if (lunge == null) return false;

		for (local i = 0; i < 6; i++)
		{
			if (!_targetTile.hasNextTile(i)) continue;

			local lungeTargetTile = _targetTile.getNextTile(i);
			if (lungeTargetTile.IsOccupiedByActor && lunge.verifyTargetAndRange(lungeTargetTile, _originTile) && lunge.getDestinationTile(lungeTargetTile).ID == _targetTile.ID)
				return true;
		}

		return false;
	}

	function onAfterUpdate( _properties )
	{
		local lunge = this.getContainer().getSkillByID("actives.lunge");

		if (lunge != null)
		{
			this.m.FatigueCost = lunge.m.FatigueCost;
			this.m.FatigueCostMult = lunge.m.FatigueCostMult;
			this.m.ActionPointCost = lunge.m.ActionPointCost;
			this.m.MinRange = lunge.m.MinRange - 1;
			this.m.MaxRange = lunge.m.MaxRange - 1;
		}
	}
});

