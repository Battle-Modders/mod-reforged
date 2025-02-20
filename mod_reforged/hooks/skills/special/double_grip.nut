::Reforged.HooksMod.hook("scripts/skills/special/double_grip", function(q) {
	// Is set during onUpdate so that hybrid weapons are properly dealt with in functions other than onUpdate
	// because we go through weapon types alphabetically and choose the first applicable type
	q.m.CurrWeaponType <- null;
	q.m.MeleeDamageMult_Dagger <- 1.2;
	q.m.IsFreeSwapSpent <- true;

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "With the second hand free, this character can adopt a more versatile fighting style or get a firm double grip on his weapon to inflict additional damage."
		// Set the order to be as early as possible so that it runs before all perks and items
		// (primarily because of the fact that it applies Dazed in onTargetHit and other skills may check for the presence of dazed effect)
		this.m.Order = ::Const.SkillOrder.First;
	}

	// Make swapping to bagged non-hybrid dagger a free action.
	// This has nothing to do with double grip bonus but is implemented in double_grip just for convenience
	// because double_grip is present on all relevant characters.
	q.getItemActionCost = @() function( _items )
	{
		if (this.m.IsFreeSwapSpent)
			return;

		foreach (item in _items)
		{
			if (item != null && item.isItemType(::Const.Items.ItemType.Weapon) && item.isWeaponType(::Const.Items.WeaponType.Dagger, true, true))
			{
				return 0;
			}
		}
	}

	q.onPayForItemAction = @(__original) function( _skill, _items )
	{
		__original(_skill, _items);
		this.m.IsFreeSwapSpent = true;
	}

	q.onTurnStart = @(__original) function()
	{
		__original();
		this.m.IsFreeSwapSpent = false;
	}

	// Overwrite vanilla function to allow double-gripping with southern swords with offhand item with the perk_rf_en_garde perk
	q.canDoubleGrip = @() function()
	{
		local actor = this.getContainer().getActor();
		if (actor.isDisarmed())
			return false;

		local weapon = actor.getMainhandItem();
		if (weapon == null || !weapon.isDoubleGrippable())
			return false;

		local offhand = actor.getOffhandItem();
		if (offhand == null)
			return true;

		return offhand.getStaminaModifier() > -10 && weapon.isItemType(::Const.Items.ItemType.RF_Southern) && weapon.isWeaponType(::Const.Items.WeaponType.Sword) && this.getContainer().hasSkill("perk.rf_en_garde");
	}

	q.applyBonusOnUpdate <- function( _properties )
	{
		switch (this.m.CurrWeaponType)
		{
			case ::Const.Items.WeaponType.Axe:
				_properties.MeleeDamageMult *= 1.15;
				_properties.DamageDirectAdd += 0.15;
				break;

			case ::Const.Items.WeaponType.Cleaver:
				_properties.MeleeDamageMult *= 1.3;
				break;

			case ::Const.Items.WeaponType.Dagger:
				_properties.MeleeDamageMult *= this.m.MeleeDamageMult_Dagger;
				break;

			case ::Const.Items.WeaponType.Flail:
				_properties.HitChance[::Const.BodyPart.Head] += 10;
				_properties.DamageDirectAdd += 0.2;
				break;

			case ::Const.Items.WeaponType.Hammer:
				_properties.MeleeDamageMult *= 1.25;
				break;

			case ::Const.Items.WeaponType.Mace:
				_properties.MeleeDamageMult *= 1.15;
				break;

			case ::Const.Items.WeaponType.Spear:
				_properties.Reach += 1;
				_properties.MeleeDamageMult *= 1.1;
				_properties.DamageDirectAdd += 0.1;
				break;

			case ::Const.Items.WeaponType.Sword:
				_properties.MeleeDamageMult *= 1.1;
				_properties.DamageDirectAdd += 0.2;
				break;

			case "SouthernSword":
				_properties.MeleeDamageMult *= 1.25;
				break;

			case "FencingSword":
				_properties.DamageDirectAdd += 0.25;
				break;
		}
	}

	q.getBonusTooltip <- function()
	{
		local ret = [];
		switch (this.m.CurrWeaponType)
		{
			case ::Const.Items.WeaponType.Axe:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorPositive("15%") + " more damage"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = ::MSU.Text.colorPositive("+15%") + " damage ignores armor"
				});
				break;

			case ::Const.Items.WeaponType.Cleaver:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorPositive("30%") + " more damage"
				});
				break;

			case ::Const.Items.WeaponType.Dagger:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorizeMult(this.m.MeleeDamageMult_Dagger) + " more damage"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = ::Reforged.Mod.Tooltips.parseString("Gain " + ::MSU.Text.colorPositive("+10%") + " of your [Initiative|Concept.Initiative] as additional [Melee Defense|Concept.MeleeDefense] and [Ranged Defense|Concept.RangeDefense] against opponents who act after you in a [round|Concept.Round]")
				});
				break;

			case ::Const.Items.WeaponType.Flail:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/chance_to_hit_head.png",
					text = ::MSU.Text.colorPositive("+10%") + " chance to hit the head"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = ::MSU.Text.colorPositive("+20%") + " damage ignores armor"
				});
				break;

			case ::Const.Items.WeaponType.Hammer:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorPositive("25%") + " more damage"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = ::Reforged.Mod.Tooltips.parseString("Skills build up " + ::MSU.Text.colorPositive("25%") + " less [Fatigue|Concept.Fatigue]")
				});
				break;

			case ::Const.Items.WeaponType.Mace:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorPositive("15%") + " more damage"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/special.png",
					text = ::Reforged.Mod.Tooltips.parseString("Hits that deal at least " + ::MSU.Text.colorDamage(::Const.Combat.MinDamageToApplyBleeding) + " to [Hitpoints|Concept.Hitpoints] apply the [Dazed|Skill+dazed_effect] effect")
				});
				break;

			case ::Const.Items.WeaponType.Spear:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/rf_reach.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+1") + " [Reach|Concept.Reach]")
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorPositive("10%") + " more damage"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = ::MSU.Text.colorPositive("+10%") + " damage ignores armor"
				});
				break;

			case ::Const.Items.WeaponType.Sword:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorPositive("10%") + " more damage"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = ::MSU.Text.colorPositive("+20%") + " damage ignores armor"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = ::Reforged.Mod.Tooltips.parseString("Skills build up " + ::MSU.Text.colorPositive("33%") + " less [Fatigue|Concept.Fatigue]")
				});
				break;

			case "SouthernSword":
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorPositive("25%") + " more damage"
				});
				break;

			case "FencingSword":
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = ::MSU.Text.colorPositive("+25%") + " damage ignores armor"
				});
				break;
		}

		return ret;
	}

	q.getName = @() function()
	{
		switch (this.m.CurrWeaponType)
		{
			case null:
				return this.m.Name;

			case "SouthernSword":
				return format("%s (%s)", this.m.Name, "Southern Sword");

			case "FencingSword":
				return format("%s (%s)", this.m.Name, "Fencing Sword");

			default:
				return format("%s (%s)", this.m.Name, ::Const.Items.getWeaponTypeName(this.m.CurrWeaponType));
		}
	}

	q.getTooltip = @() function()
	{
		local ret = this.skill.getTooltip();
		ret.extend(this.getBonusTooltip());
		return ret;
	}

	q.onUpdate = @() function( _properties )
	{
		this.m.CurrWeaponType = null;

		if (!this.canDoubleGrip())
			return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon.isWeaponType(::Const.Items.WeaponType.Axe)) 			this.m.CurrWeaponType = ::Const.Items.WeaponType.Axe;
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Dagger))	this.m.CurrWeaponType = ::Const.Items.WeaponType.Dagger;
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Flail))	this.m.CurrWeaponType = ::Const.Items.WeaponType.Flail;
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Hammer))	this.m.CurrWeaponType = ::Const.Items.WeaponType.Hammer;
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Mace))	this.m.CurrWeaponType = ::Const.Items.WeaponType.Mace;
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Spear))	this.m.CurrWeaponType = ::Const.Items.WeaponType.Spear;
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))
		{
			if (weapon.isItemType(::Const.Items.ItemType.RF_Southern))
			{
				this.m.CurrWeaponType = "SouthernSword";
			}
			else if (weapon.isItemType(::Const.Items.ItemType.RF_Fencing))
			{
				this.m.CurrWeaponType = "FencingSword";
			}
			else
			{
				this.m.CurrWeaponType = ::Const.Items.WeaponType.Sword;
			}
		}
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Cleaver)) this.m.CurrWeaponType = ::Const.Items.WeaponType.Cleaver; // Check cleaver after Sword so fencing and southern are assigned properly

		this.applyBonusOnUpdate(_properties);
	}

	q.onAfterUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		if (this.m.CurrWeaponType == ::Const.Items.WeaponType.Hammer)
		{
			foreach (skill in this.getContainer().getActor().getMainhandItem().getSkills())
			{
				skill.m.FatigueCostMult *= 0.75;
			}
		}
		else if (this.m.CurrWeaponType == ::Const.Items.WeaponType.Sword)
		{
			foreach (skill in this.getContainer().getActor().getMainhandItem().getSkills())
			{
				skill.m.FatigueCostMult *= 0.66;
			}
		}
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		if (_skill.getID() == "actives.puncture" && this.m.CurrWeaponType == ::Const.Items.WeaponType.Dagger)
		{
			_properties.MeleeDamageMult /= this.m.MeleeDamageMult_Dagger;
		}
	}

	q.onBeingAttacked = @(__original) function( _attacker, _skill, _properties )
	{
		__original(_attacker, _skill, _properties);

		if (this.m.CurrWeaponType == ::Const.Items.WeaponType.Dagger)
		{
			local actor = this.getContainer().getActor();
			// If I have already ended or started my turn this means the attacker is acting AFTER me in this round
			if (actor.m.IsTurnDone || actor.isTurnStarted())
			{
				local bonus = ::Math.floor(actor.getCurrentProperties().getInitiative() * 0.1);
				_properties.MeleeDefense += bonus;
				_properties.RangedDefense += bonus;
			}
		}
	}

	q.onTargetHit = @(__original) function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		__original(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);

		if (_targetEntity.isAlive() && this.m.CurrWeaponType == ::Const.Items.WeaponType.Mace && !_targetEntity.getCurrentProperties().IsImmuneToDaze && _damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding)
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/dazed_effect"));
			local actor = this.getContainer().getActor();
			if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " struck a blow that leaves " + ::Const.UI.getColorizedEntityName(_targetEntity) + " dazed");
			}
		}
	}

	q.onGetHitFactorsAsTarget = @(__original) function( _skill, _targetTile, _tooltip )
	{
		__original(_skill, _targetTile, _tooltip);

		if (this.m.CurrWeaponType == ::Const.Items.WeaponType.Dagger)
		{
			local actor = this.getContainer().getActor();
			// If I have already ended or started my turn this means the attacker is acting AFTER me in this round
			if (actor.m.IsTurnDone || actor.isTurnStarted())
			{
				local bonus = ::Math.floor(actor.getCurrentProperties().getInitiative() * 0.1);
				if (bonus != 0)
				{
					_tooltip.push({
						icon = "ui/tooltips/positive.png",
						text = ::MSU.Text.colorNegative(bonus + "%") + " " + this.getName() + " with dagger"
					});
				}
			}
		}
	}
});
