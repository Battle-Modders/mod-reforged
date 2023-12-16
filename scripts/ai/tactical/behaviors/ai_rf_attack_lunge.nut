this.ai_rf_attack_lunge <- ::inherit("scripts/ai/tactical/behaviors/ai_attack_default", {
	m = {},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_AttackLunge;
		this.m.Order = ::Const.AI.Behavior.Order.RF_AttackLunge;
		this.m.PossibleSkills = [
			"actives.lunge"
		];
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		local ret = this.ai_attack_default.onEvaluate(_entity);
		if (this.m.Skill != null)
		{
			if (this.queryTargetsInMeleeRange(1, this.m.Skill.getMaxRange()).len() != 0)
			{
				this.getProperties().EngageRangeMin = _entity.getIdealRange();
				this.getProperties().EngageRangeMax = _entity.getIdealRange();
				this.getProperties().EngageRangeIdeal = _entity.getIdealRange();
			}
			else if (_entity.getInitiative() > 90)
			{
				// Encourage stopping at max range of Lunge and using that
				// to engage instead of walking into the enemy's face with EngageMelee behavior
				this.getProperties().EngageRangeMin = this.m.Skill.getMinRange();
				this.getProperties().EngageRangeMax = this.m.Skill.getMaxRange();
				this.getProperties().EngageRangeIdeal = this.m.Skill.getMaxRange();
				this.getProperties().BehaviorMult[this.m.ID] *= 10;
				this.getProperties().BehaviorMult[::Const.AI.Behavior.ID.EngageMelee] *= 0.1;
			}
		}
		return ret;
	}

	function queryTargetValue( _entity, _target, _skill = null )
	{
		local ret = this.ai_attack_default.queryTargetValue(_entity, _target, _skill);
		if (_skill == null || _skill.getID() != "actives.lunge")
			return ret;

		local targetTile = _target.getTile();
		local destTile = _skill.getDestinationTile(targetTile);
		if (destTile == null)
			return ret;

		local myTile = _entity.getTile();
		local currZOC = myTile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());
		local newZOC = destTile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());

		local mult = 0.0;

		mult += (currZOC - newZOC) * ::Const.AI.Behavior.EngageMultipleOpponentsPenalty * this.getProperties().EngageTargetMultipleOpponentsMult;
		mult += ::Const.AI.Behavior.EngageSpearwallTargetPenalty * this.querySpearwallValueForTile(_entity, targetTile);

		if (myTile.IsBadTerrain)
		{
			mult += ::Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
		}
		if (destTile.IsBadTerrain)
		{
			mult -= ::Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
		}

		if (this.hasNegativeTileEffect(myTile, _entity) || myTile.Properties.IsMarkedForImpact)
		{
			mult += ::Const.AI.Behavior.EngageBadTerrainEffectPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
		}

		if (this.hasNegativeTileEffect(destTile, _entity) || destTile.Properties.IsMarkedForImpact)
		{
			mult -= ::Const.AI.Behavior.EngageBadTerrainEffectPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
		}

		mult += (destTile.Level - targetTile.Level) * ::Const.AI.Behavior.EngageTerrainLevelBonus * this.getProperties().EngageOnGoodTerrainBonusMult;
		mult += myTile.TVTotal - destTile.TVTotal * ::Const.AI.Behavior.EngageTVValueMult * this.getProperties().EngageOnGoodTerrainBonusMult;

		if (mult == 0)
		{
			return ret;
		}
		else if (mult > 0)
		{
			return ret * mult;
		}
		else if (mult < 0)
		{
			return mult < -1 ? ret * -0.5 / mult : ret * -1 * mult;
		}
	}
});

