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
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Partner: " + partner.getName()
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorRed("Cannot be used while rooted")
			});
		}

		if (this.m.IsSpent)
		{
			ret.push({
				id = 21,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorRed("Cannot be used more than once per [turn|Concept.Turn]"))
			});
		}

		if (::MSU.isNull(this.m.DynamicDuoPerk.getPartner()) || !this.m.DynamicDuoPerk.getPartner().isPlacedOnMap())
		{
			ret.push({
				id = 22,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorRed("Can only be used when next to your partner")
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
		if (this.m.IsSpent || this.getContainer().getActor().getCurrentProperties().IsRooted || !this.skill.isUsable())
			return false;

		local partner = this.m.DynamicDuoPerk.getPartner();
		if (::MSU.isNull(partner) || !partner.isPlacedOnMap())
			return false;

		local actor = this.getContainer().getActor();
		return actor.isPlacedOnMap() && actor.getTile().getDistanceTo(partner.getTile()) == 1;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
			return false;

		local target = _targetTile.getEntity();
		if (this.m.DynamicDuoPerk.getPartner().getID() != target.getID() || !target.isAlliedWith(this.getContainer().getActor()))
			return false;

		local tp = target.getCurrentProperties();
		if (tp.IsStunned || tp.IsRooted || !tp.IsMovable || tp.IsImmuneToRotation)
			return false;

		return this.skill.onVerifyTarget(_originTile, _targetTile);
	}

	function onUse( _user, _targetTile )
	{
		::Tactical.getNavigator().switchEntities(_user, _targetTile.getEntity(), null, null, 1.0);
		this.m.IsSpent = true;
		return true;
	}
});
