this.perk_rf_phalanx <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredDamageType = ::Const.Damage.DamageType.Piercing
	},
	function create()
	{
		this.m.ID = "perk.rf_phalanx";
		this.m.Name = ::Const.Strings.PerkName.RF_Phalanx;
		this.m.Description = "This character is highly skilled in fighting in formation.";
		this.m.Icon = "ui/perks/perk_rf_phalanx.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return this.getReachModifier() == 0 && this.getStartSurroundCountAtModifier() == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local reachModifier = this.getReachModifier();
		if (reachModifier != 0)
		{
			local damageTypeString = this.m.RequiredDamageType == null ? "" : " with a " + ::Const.Damage.getDamageTypeName(this.m.RequiredDamageType).tolower() + " attack";
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/rf_reach.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(reachModifier, {AddSign = true}) + " [Reach|Concept.Reach] when defending or when attacking" + damageTypeString)
			});
		}

		local surroundModifier = this.getStartSurroundCountAtModifier();
		if (surroundModifier != 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString("Ignore the defense malus from being [surrounded|Concept.Surrounding] by up to " + ::MSU.Text.colorizeValue(surroundModifier) + " opponents")
			});
		}

		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && !_skill.isRanged() && (this.m.RequiredDamageType == null || _skill.getDamageType().contains(this.m.RequiredDamageType)))
		{
			_properties.Reach += this.getReachModifier();
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (_skill.isAttack() && !_skill.isRanged())
		{
			_properties.Reach += this.getReachModifier();
		}
	}

	function onUpdate( _properties )
	{
		if (this.isEnabled())
		{
			_properties.StartSurroundCountAt += this.getStartSurroundCountAtModifier();
		}
	}

	function getReachModifier()
	{
		return this.getAllyCount();
	}

	function getStartSurroundCountAtModifier()
	{
		return this.getAllyCount();
	}

	function getAllyCount()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
		{
			return 0;
		}

		local ret = 0;

		foreach (ally in ::Tactical.Entities.getAlliedActors(actor.getFaction(), actor.getTile(), 1, true))
		{
			if (this.isActorValid(ally))
			{
				ret += 1;
			}
		}

		return ret;
	}

	function isActorValid( _actor )
	{
		local actor = this.getContainer().getActor();

		local weapon = actor.getMainhandItem();
		if (weapon == null || weapon.isItemType(::Const.Items.ItemType.OneHanded) && (!actor.isArmedWithShield() || actor.getOffhandItem().getID().find("buckler") != null))
		{
			return false;
		}

		foreach (skill in weapon.getSkills())
		{
			if (skill.isAttack() && !skill.isRanged() && (this.m.RequiredDamageType == null || skill.getDamageType().contains(this.m.RequiredDamageType)))
			{
				return true;
			}
		}

		return false;
	}

	function isEnabled()
	{
		return this.isActorValid(_actor);
	}
});
