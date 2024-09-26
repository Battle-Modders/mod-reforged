this.rf_move_under_cover_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_move_under_cover";
		this.m.Name = "Move Under Cover";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Use the cover provided by a shield-bearing ally to move 1 tile ignoring [Zone of Control|Concept.ZoneOfControl] and without triggering free attacks.");
		this.m.Icon = "skills/rf_move_under_cover_skill.png";
		this.m.IconDisabled = "skills/rf_move_under_cover_skill_sw.png";
		this.m.Overlay = "rf_move_under_cover_skill";
		this.m.SoundOnUse = [
			"sounds/combat/footwork_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDisengagement = true;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
	}

	function getTooltip()
	{
		return this.getDefaultUtilityTooltip();
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled())
		{
			return;
		}

		local weapon = actor.getMainhandItem();
		if (weapon == null) return;

		if (weapon.isItemType(::Const.Items.ItemType.RangedWeapon) || weapon.m.RangeMax == 2)
		{
			if (actor.getAIAgent().findBehavior(::Const.AI.Behavior.ID.Disengage) == null)
			{
				actor.getAIAgent().addBehavior(::new("scripts/ai/tactical/behaviors/ai_disengage"));
				actor.getAIAgent().finalizeBehaviors();
			}
		}
		else
		{
			if (actor.getAIAgent().findBehavior(::Const.AI.Behavior.ID.RF_KataStep) == null)
			{
				actor.getAIAgent().addBehavior(::new("scripts/ai/tactical/behaviors/ai_rf_kata_step"));
				actor.getAIAgent().finalizeBehaviors();
			}
		}
	}

	function isUsable()
	{
		if (this.skill.isUsable())
		{
			local myTile = this.getContainer().getActor().getTile();

			for( local i = 0; i < 6; i++ )
			{
				if (myTile.hasNextTile(i))
				{
					local nextTile = myTile.getNextTile(i);

					if (!nextTile.IsOccupiedByActor)
					{
						return true;
					}
				}
			}
		}

		return false;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.IsEmpty;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCost = 0;
		this.m.ActionPointCost = 0;

		local actor = this.getContainer().getActor();
		if (actor.isPlacedOnMap())
		{
			local myTile = actor.getTile();
			if (myTile != null)
			{
				this.m.FatigueCost = ::Math.max(0, actor.getFatigueCosts()[myTile.Type]);
				this.m.ActionPointCost = ::Math.max(0, actor.getActionPointCosts()[myTile.Type]);
			}
		}
	}

	function onUse( _user, _targetTile )
	{
		::Tactical.getNavigator().teleport(_user, _targetTile, null, null, false);
		this.removeSelf();
		return true;
	}
});
