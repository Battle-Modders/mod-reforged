this.perk_rf_kingfisher <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		NetEffect = null,
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "perk.rf_kingfisher";
		this.m.Name = ::Const.Strings.PerkName.RF_Kingfisher;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Kingfisher;
		this.m.Icon = "ui/perks/perk_rf_kingfisher.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		// Ensure that the actor has an offhand item with the throw_net skill
		local offhandItem = this.getContainer().getActor().getOffhandItem();
		if (offhandItem == null)
			return false;

		foreach (skill in offhandItem.getSkills())
		{
			if (skill.getID() == "actives.throw_net" && !skill.isHidden())
				return true;
		}

		return false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.IsSpent || _skill.isRanged() || ::Math.rand(1, 100) > ::Const.Tactical.MV_CurrentAttackInfo.ChanceToHit || !this.isEnabled())
			return;

		// ScheduleEvent is used because container.m.IsUpdating is true right now, so directly using skills is not good here
		// and leads to improper removal/addition of skills
		::Time.scheduleEvent(::TimeUnit.Virtual, 1, this.onApplyNet.bindenv(this), {
			Target = _targetEntity,
			User = this.getContainer().getActor()
		});
	}

	function onUpdate( _properties )
	{
		if (!this.m.IsSpent && this.isEnabled())
			_properties.Reach += 2;
	}

	function onMovementFinished()
	{
		// Lose the net if you end up at any tile more than 1 distance away from the target you have trapped
		if (this.m.IsSpent && !::MSU.isNull(this.m.NetEffect) && this.m.NetEffect.getContainer().getActor().getTile().getDistanceTo(this.getContainer().getActor().getTile()) > 1)
		{
			this.m.NetEffect.m.KingfisherPerk = null;
			this.setSpent(false, false);
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.setSpent(false);
	}

	// The _reEquip parameter is used to properly unequip the net during onMovementFinished, because during that function container.m.IsUpdating
	// is true so unequipping, equipping, and then trying to unequip again leads to errors in the skills of the item being unequipped.
	function setSpent( _isSpent, _reEquip = true )
	{
		this.m.IsSpent = _isSpent;

		if (!_isSpent)
			this.m.NetEffect = null;

		local actor = this.getContainer().getActor();
		local net = actor.getOffhandItem();
		if (net != null)
		{
			net.m.IsChangeableInBattle = !_isSpent;
			if (!_isSpent)
			{
				actor.getItems().unequip(net);
				if (_reEquip)
					actor.getItems().equip(net); // Unequip and re-equip the net to get all the skills back which were hidden during onTargetHit above
			}
		}
	}

	function onApplyNet( _tag )
	{
		if (this.m.IsSpent)
			return;

		if (!_tag.Target.isAlive() || !_tag.Target.isPlacedOnMap() || !_tag.User.isAlive() || !_tag.User.isPlacedOnMap() || _tag.Target.getSkills().hasSkill("effects.net"))
			return;

		local targetTile = _tag.Target.getTile();
		local myTile = _tag.User.getTile();
		if (targetTile.getDistanceTo(myTile) != 1)
			return;

		local throwNetSkill = this.getContainer().getSkillByID("actives.throw_net");
		if (throwNetSkill == null || !throwNetSkill.onVerifyTarget(myTile, targetTile))
			return;

		local netItemScript = ::IO.scriptFilenameByHash(_tag.User.getOffhandItem().ClassNameHash);

		throwNetSkill.useForFree(_tag.Target.getTile());

		local netEffect = _tag.Target.getSkills().getSkillByID("effects.net");
		if (netEffect == null) // Make sure target is actually netted. In vanilla net can be thrown on targets which are immune to it causing it to miss.
			return;

		// Hook the net_effect on the target to reset our perk when the net expires or the target dies
		netEffect.m.KingfisherPerk <- ::MSU.asWeakTableRef(this);
		netEffect.resetKingfisher <- { function resetKingfisher()
		{
			if (!::MSU.isNull(this.m.KingfisherPerk))
				this.m.KingfisherPerk.setSpent(false);
		}}.resetKingfisher;
		local onRemoved = netEffect.onRemoved;
		netEffect.onRemoved <- { function onRemoved()
		{
			onRemoved();
			this.resetKingfisher();
		}}.onRemoved;
		local onDeath = netEffect.onDeath;
		netEffect.onDeath <- { function onDeath( _fatalityType )
		{
			onDeath(_fatalityType);
			this.resetKingfisher();
		}}.onDeath;

		this.m.NetEffect = ::MSU.asWeakTableRef(netEffect);

		local replacementNet = ::new(netItemScript)

		_tag.User.getItems().equip(replacementNet); // the original net is unequipped during use of throw net skill, so we equip a "new" net of the same type
		foreach (skill in replacementNet.m.SkillPtrs)
		{
			// We set all the skills of the newly equipped net to Hidden so they cannot be used
			skill.m.IsHidden = true;
		}

		_tag.Target.getSkills().getSkillByID("actives.break_free").setChanceBonus(999);

		this.setSpent(true);
	}
});
