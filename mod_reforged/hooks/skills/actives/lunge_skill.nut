::mods_hookExactClass("skills/actives/lunge_skill", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HitChanceBonus = -20;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_AttackLunge;
	}

	o.isDuelistValid <- function()
	{
		return this.getBaseValue("ActionPointCost") <= 4;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local tooltip = getTooltip();
		tooltip.insert(tooltip.len() - 1, {
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has " + ::MSU.Text.colorizePercentage(this.m.HitChanceBonus) + " chance to hit"
		});
		return tooltip;
	}

	o.onAdded <- function()
	{
		if (!this.getContainer().getActor().isPlayerControlled())
			this.getContainer().add(this.new("scripts/skills/actives/rf_lunge_charge_dummy_skill"));
	}

	o.onRemoved <- function()
	{
		this.getContainer().removeByID("actives.rf_lunge_charge_dummy");
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		onAnySkillUsed(_skill, _targetEntity, _properties);
		if (_skill == this)
		{
			if (!this.getContainer().getActor().isPlayerControlled()) this.m.HitChanceBonus = 0;

			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}

	o.getDestinationTile <- function( _targetTile )
	{
		local myTile = this.getContainer().getActor().getTile();
		local targetDistance = _targetTile.getDistanceTo(myTile);

		for (local i = 0; i < 6; i++)
		{
			if (!_targetTile.hasNextTile(i)) continue;

			local destTile = _targetTile.getNextTile(i);
			if (!destTile.IsEmpty || destTile.getDistanceTo(myTile) > this.m.MaxRange - 1 || ::Math.abs(_targetTile.Level - destTile.Level) > 1)
				continue;

			if (this.m.MaxRange == 2)
			{
				if (::Math.abs(myTile.Level - destTile.Level) <= 1) return destTile;
			}
			else
			{
				for (local j = 0; j < 6; j++)
				{
					if (!destTile.hasNextTile(j)) continue;

					local adjacentTile = destTile.getNextTile(j);
					if (adjacentTile.IsEmpty && myTile.getDistanceTo(adjacentTile) <= 1 && ::Math.abs(myTile.Level - adjacentTile.Level) + ::Math.abs(adjacentTile.Level - destTile.Level) <= 1)
						return destTile;
				}
			}
		}
	}

	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && this.getDestinationTile(_targetTile) != null;
	}

	o.onUse = function( _user, _targetTile )
	{
		local destTile = this.getDestinationTile(_targetTile);

		if (destTile == null) return false;

		this.getContainer().setBusy(true);
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile,
			OnRepelled = this.onRepelled
		};
		_user.spawnTerrainDropdownEffect(_user.getTile());
		::Tactical.getNavigator().teleport(_user, destTile, this.onTeleportDone.bindenv(this), tag, false, 3.0);
		return true;
	}
});
