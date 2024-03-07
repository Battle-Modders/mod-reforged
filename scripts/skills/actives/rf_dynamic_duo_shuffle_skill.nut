this.rf_dynamic_duo_shuffle_skill <- ::inherit("scripts/skills/skill", {
	m = {
		DynamicDuoPerk = null,
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "actives.rf_dynamic_duo_shuffle";
		this.m.Name = "Shuffle";
		this.m.Description = "Once per turn, switch places with your partner for free, provided neither you nor your partner is stunned or rooted.";
		this.m.Icon = "skills/rf_dynamic_duo_shuffle_skill.png";
		this.m.IconDisabled = "skills/rf_dynamic_duo_shuffle_skill_sw.png";
		this.m.Overlay = "rf_dynamic_duo_shuffle_skill";
		this.m.SoundOnUse = [
			"sounds/combat/rotation_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		local partner = this.m.DynamicDuoPerk.getPartner();
		if (partner != null)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Partner: " + partner.getName()
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Cannot be used while rooted[/color]"
			});
		}

		if (this.m.IsSpent)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Cannot be used more than once per turn[/color]"
			});
		}

		return ret;
	}

	function getCursorForTile( _tile )
	{
		return ::Const.UI.Cursor.Rotation;
	}

	function isUsable()
	{
		return !this.m.IsSpent && this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (!target.isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}

		return this.skill.onVerifyTarget(_originTile, _targetTile) && this.m.DynamicDuoPerk.getPartner().getID() == target.getID() && !target.getCurrentProperties().IsStunned && !target.getCurrentProperties().IsRooted && target.getCurrentProperties().IsMovable && !target.getCurrentProperties().IsImmuneToRotation;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.Tactical.getNavigator().switchEntities(_user, target, null, null, 1.0);
		this.m.IsSpent = true;
		return true;
	}
});
