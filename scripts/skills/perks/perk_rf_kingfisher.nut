this.perk_rf_kingfisher <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		Chance = 0,
		NetEffect = null,
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "perk.rf_kingfisher";
		this.m.Name = ::Const.Strings.PerkName.RF_Kingfisher;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Kingfisher;
		this.m.Icon = "ui/perks/rf_kingfisher.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		return this.getContainer().hasSkill("actives.throw_net") != null; // Ignores hidden skills so while this IsSpent, it will be false
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		this.m.Chance = 0;
		if (this.m.IsSpent || _targetEntity.getSkills().hasSkill("effects.net") || _targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile()) > 1 || !this.isEnabled())
			return;

		this.m.Chance = _skill.getHitchance(_targetEntity);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || ::Math.rand(1, 100) > this.m.Chance || !this.getContainer().getActor().isPlacedOnMap() || !_targetEntity.isPlacedOnMap())
			return;

		local throwNetSkill = this.getContainer().getSkillByID("actives.throw_net");
		if (!throwNetSkill.onVerifyTarget(this.getContainer().getActor().getTile(), _targetEntity.getTile()))
			return;

		local netItemScript = ::IO.scriptFilenameByHash(this.getContainer().getActor().getOffhandItem().ClassNameHash);

		throwNetSkill.useForFree(_targetEntity.getTile());

		local replacementNet = ::new(netItemScript)

		this.getContainer().getActor().getItems().equip(replacementNet); // the original net is unequipped during use of throw net skill, so we equip a "new" net of the same type
		foreach (skill in replacementNet.m.SkillPtrs)
		{
			// the skill isn't added to the skill_container yet, because we are within the onTargetHit function, so it goes to SkillsToAdd
			// so we can't get it via container.getSkillByID, instead we find it by iterating over the skills of the item
			if (skill.getID() == "actives.throw_net")
			{
				skill.m.IsHidden = true;
				break;
			}
		}

		local netEffect = _targetEntity.getSkills().getSkillByID("effects.net");
		netEffect.m.KingfisherPerk <- ::MSU.asWeakTableRef(this);
		local onRemoved = netEffect.onRemoved;
		netEffect.onRemoved = function()
		{
			onRemoved();
			if (!::MSU.isNull(this.m.KingfisherPerk))
			{
				this.m.KingfisherPerk.setSpent(false);
			}
		}
		local onDeath = netEffect.onDeath;
		netEffect.onDeath = function( _fatalityType )
		{
			onDeath();
			this.onRemoved();
		}

		this.m.NetEffect = ::MSU.asWeakTableRef(netEffect);

		_targetEntity.getSkills().getSkillByID("actives.break_free").setChanceBonus(999);

		this.setSpent(true);
	}

	function onUpdate( _properties )
	{
		if (!this.m.IsSpent && this.isEnabled())
			_properties.Reach += 2;
	}

	function onMovementFinished( _tile )
	{
		// Lose the net if you end up at any tile more than 1 distance away from the target you have trapped
		if (this.m.IsSpent && !::MSU.isNull(this.m.NetEffect) && this.m.NetEffect.getContainer().getActor().getTile().getDistanceTo(_tile) > 1)
		{
			this.m.NetEffect.m.KingfisherPerk = null;
			this.setSpent(false);
			this.getContainer().getActor().getItems().unequip(this.getContainer().getActor().getOffhandItem());
		}
	}

	function setSpent( _isSpent )
	{
		this.m.IsSpent = _isSpent;

		if (!_isSpent)
			this.m.NetEffect = null;

		local net = this.getContainer().getActor().getOffhandItem();
		if (net != null)
			net.m.IsChangeableInBattle = !_isSpent;

		local throwNetSkill = this.getContainer().getSkillByID("actives.throw_net");
		if (throwNetSkill != null)
			throwNetSkill.m.IsHidden = _isSpent;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.setSpent(false);
	}
});
