this.perk_rf_whirling_death <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Flail,
		Stacks = 0,
		DamageTotalMult = 0.5, // Multiplier for the damage dealt during the extra attack
		ChanceToHitHeadPerReachDiff = 10, // Is used for two-handed flails

		__WhirlingWithSkill = null
	},
	function create()
	{
		this.m.ID = "perk.rf_whirling_death";
		this.m.Name = ::Const.Strings.PerkName.RF_WhirlingDeath;
		this.m.Description = "This character\'s attacks are like a whirlwind, making it very dangerous to be near them.";
		this.m.Icon = "ui/perks/perk_rf_whirling_death.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/rf_reach.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.Stacks, {AddSign = true}) + " [Reach|Concept.Reach]")
		});
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Will expire upon swapping your weapon!"
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.Reach += this.m.Stacks;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (::MSU.isEqual(_skill, this.m.__WhirlingWithSkill))
		{
			_properties.DamageTotalMult *= this.m.DamageTotalMult;
		}

		if (_targetEntity != null && this.isSkillValid(_skill))
		{
			local weapon = _skill.getItem();
			if (weapon != null && weapon.isItemType(::Const.Items.ItemType.TwoHanded))
			{
				local reachDiff = this.getContainer().getActor().getCurrentProperties().getReach() - _targetEntity.getCurrentProperties().getReach();
				if (reachDiff > 0)
					_properties.HitChance[::Const.BodyPart.Head] += reachDiff * this.m.ChanceToHitHeadPerReachDiff;
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		local user = this.getContainer().getActor();
		if (!user.isAlive() || _targetEntity == null || !_targetEntity.isAlive())
			return;

		if (!this.isSkillValid(_skill) || this.m.__WhirlingWithSkill != null)
			return;

		this.m.Stacks++;

		if (!::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
			return;

		local weapon = _skill.getItem();
		if (!::MSU.isNull(weapon) && !weapon.isItemType(::Const.Items.ItemType.OneHanded))
			return;

		local target = this.chooseTarget(_skill, _targetTile);
		if (target == null)
			return;

		this.getContainer().setBusy(true);
		local tag = {
			Skill = _skill,
			User = user,
			TargetEntity = target,
			TargetTile = target.getTile(),
			Callback = this.tryWhirl.bindenv(this)
		};
		// Schedule with delay of 1 when in fog of war, to speed up combat
		::Time.scheduleEvent(::TimeUnit.Virtual, !user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer ? 100 : 1, tag.Callback, tag);
	}

	function onAnySkillExecutedFully( _skill, _targetTile, _targetEntity, _forFree )
	{
		// We nullify it in onAnySkillExecutedFully so that skills that do
		// multiple attacks in a single use get the damage reduction applied to all those attacks.
		if (::MSU.isEqual(_skill, this.m.__WhirlingWithSkill))
		{
			this.m.__WhirlingWithSkill = null;
		}
	}

	function onTurnStart()
	{
		this.m.Stacks = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
	}

	function onPayForItemAction( _skill, _items )
	{
		foreach (item in _items)
		{
			if (item != null && item.getSlotType() == ::Const.ItemSlot.Mainhand)
			{
				this.m.Stacks = 0;
				return;
			}
		}
	}

	function chooseTarget( _skill, _originalTargetTile )
	{
		local user = this.getContainer().getActor();
		local myReach = user.getCurrentProperties().getReach();
		local myTile = user.getTile();

		local targets = [];
		foreach (tile in ::MSU.Tile.getNeighbors(myTile))
		{
			if (!tile.IsOccupiedByActor || tile.isSameTileAs(_originalTargetTile))
				continue;

			local entity = tile.getEntity();
			if (!entity.isAlliedWith(user) && entity.getCurrentProperties().getReach() < myReach && _skill.onVerifyTarget(myTile, tile))
			{
				targets.push(entity);
			}
		}

		return ::MSU.Array.rand(targets);
	}

	function tryWhirl( _tag )
	{
		if (!_tag.User.isAlive() || !_tag.TargetEntity.isAlive())
			return;

		// If the skill is already executing, we wait for it to complete that first.
		if (_tag.Skill.RF_isExecuting())
		{
			::Time.scheduleEvent(::TimeUnit.Virtual, 1, _tag.Callback, _tag);
			return;
		}

		this.doWhirlAttack(_tag.Skill, _tag.User, _tag.TargetEntity, _tag.TargetTile);
		this.getContainer().setBusy(false);
	}

	function doWhirlAttack( _skill, _user, _targetEntity, _targetTile )
	{
		::logDebug(format("[%s] is using skill [%s] on target [%s (%i)] due to %s", _user.getName(), _skill.getName(), _targetEntity.getName(), _targetEntity.getID(), this.m.Name));
		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has " + this.m.Name);
		}

		this.m.__WhirlingWithSkill = _skill;
		// Consider it as a new skill use because we want this attack to trigger effects/perks
		// and other effects that depend on SkillCounter e.g. condition loss for the three-headed flail
		::Const.SkillCounter++;
		_skill.useForFree(_targetTile);
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || _skill.isRanged())
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
