::Reforged.HooksMod.hook("scripts/skills/special/double_grip", function(q) {
	// Is set during onUpdate so that hybrid weapons are properly dealt with in functions other than onUpdate
	// because we go through weapon types alphabetically and choose the first applicable type
	q.m.CurrWeaponType <- null;

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "With the second hand free, this character can adopt a more versatile fighting style or get a firm double grip on his weapon to inflict additional damage."
		// Set the order to be as early as possible so that it runs before all perks and items
		// (primarily because of the fact that it applies Dazed in onTargetHit and other skills may check for the presence of dazed effect)
		this.m.Order = ::Const.SkillOrder.First;
	}

	// Overwrite vanilla function to allow double-gripping with southern swords with offhand item with the perk_rf_en_garde perk
	q.canDoubleGrip = @() function()
	{
		local actor = this.getContainer().getActor();
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

			case ::Const.Items.WeaponType.Flail:
				_properties.HitChanceMult[::Const.BodyPart.Head] += 0.1;
				_properties.DamageDirectAdd += 0.2;
				break;

			case ::Const.Items.WeaponType.Hammer:
				_properties.Reach -= 1;
				_properties.MeleeDamageMult *= 1.4;
				break;

			case ::Const.Items.WeaponType.Mace:
				_properties.Reach -= 1;
				_properties.MeleeDamageMult *= 1.25;
				break;

			case ::Const.Items.WeaponType.Spear:
				_properties.Reach += 1;
				_properties.MeleeDamageMult *= 1.1;
				_properties.DamageDirectAdd += 0.1;
				break;

			case ::Const.Items.WeaponType.Sword:
				_properties.Reach -= 1;
				_properties.MeleeDamageMult *= 1.1;
				_properties.DamageDirectAdd += 0.2;
				break;

			case "SouthernSword":
				_properties.MeleeDamageMult *= 1.25;
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
					text = ::MSU.Text.colorGreen("15%") + " increased damage"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = ::MSU.Text.colorGreen("+15%") + " damage ignores armor"
				});
				break;

			case ::Const.Items.WeaponType.Cleaver:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorGreen("30%") + " increased damage"
				});
				break;

			case ::Const.Items.WeaponType.Dagger:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorGreen("20%") + " increased damage"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = ::Reforged.Mod.Tooltips.parseString("Gain " + ::MSU.Text.colorGreen("+10%") + " of your [Initiative|Concept.Initiative] as additional [Melee Defense|Concept.MeleeDefense] and [Ranged Defense|Concept.RangeDefense] against opponents who act after you in a [round|Concept.Round]")
				});
				break;

			case ::Const.Items.WeaponType.Flail:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/chance_to_hit_head.png",
					text = ::MSU.Text.colorGreen("+10%") + " chance to hit the head"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = ::MSU.Text.colorGreen("+20%") + " damage ignores armor"
				});
				break;

			case ::Const.Items.WeaponType.Hammer:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/reach.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorRed("-1") + " [Reach|Concept.Reach]")
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorGreen("40%") + " increased damage"
				});
				break;

			case ::Const.Items.WeaponType.Mace:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/reach.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorRed("-1") + " [Reach|Concept.Reach]")
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorGreen("25%") + " increased damage"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/special.png",
					text = ::Reforged.Mod.Tooltips.parseString("Hits apply the [Dazed|Skill+dazed_effect] effect")
				});
				break;

			case ::Const.Items.WeaponType.Spear:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/reach.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorGreen("+1") + " [Reach|Concept.Reach]")
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorGreen("10%") + " increased damage"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = ::MSU.Text.colorGreen("+10%") + " damage ignores armor"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/special.png",
					text = ::Reforged.Mod.Tooltips.parseString("[Thrust|Skill+thrust] can be used up to " + ::MSU.Text.colorGreen("2") + " tiles away but has " + ::MSU.Text.colorRed("-40%") + " chance to hit if there is something between you and your target")
				});
				break;

			case ::Const.Items.WeaponType.Sword:
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/reach.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorRed("-1") + " [Reach|Concept.Reach]")
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorGreen("10%") + " increased damage"
				});
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = ::MSU.Text.colorGreen("+25%") + " damage ignores armor"
				});
				break;

			case "SouthernSword":
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorGreen("25%") + " increased damage"
				});
				break;
		}

		return ret;
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
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Cleaver)) this.m.CurrWeaponType = ::Const.Items.WeaponType.Cleaver;
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Dagger))	this.m.CurrWeaponType = ::Const.Items.WeaponType.Dagger;
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Flail))	this.m.CurrWeaponType = ::Const.Items.WeaponType.Flail;
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Hammer))	this.m.CurrWeaponType = ::Const.Items.WeaponType.Hammer;
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Mace))	this.m.CurrWeaponType = ::Const.Items.WeaponType.Mace;
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Spear))	this.m.CurrWeaponType = ::Const.Items.WeaponType.Spear;
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))	this.m.CurrWeaponType = weapon.isItemType(::Const.Items.ItemType.RF_Southern) ? "SouthernSword" : ::Const.Items.WeaponType.Sword;

		this.applyBonusOnUpdate(_properties);
	}

	q.onAfterUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		if (this.m.CurrWeaponType == ::Const.Items.WeaponType.Spear)
		{
			local thrust = this.getContainer().getSkillByID("actives.thrust");
			if (thrust != null)
				thrust.m.MaxRange += 1;
		}
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		if (_targetEntity != null && this.m.CurrWeaponType == ::Const.Items.WeaponType.Spear && _skill.getID() == "actives.thrust")
		{
			local myTile = this.getContainer().getActor().getTile();
			local targetTile = _targetEntity.getTile();

			if (myTile.getDistanceTo(targetTile) != 2)
				return;

			// Drop MeleeSkill if there is a non-empty tile between me and the target
			foreach (tile in ::MSU.Tile.getNeighbors(myTile).filter(@(_, t) !t.IsEmpty))
			{
				for (local i = 0; i < 6; i++)
				{
					if (tile.hasNextTile(i) && targetTile.isSameTileAs(tile.getNextTile(i)))
					{
						_properties.MeleeSkill -= 40;
						return;
					}
				}
			}
		}

		if (_skill.getID() != "actives.puncture" && this.m.CurrWeaponType == ::Const.Items.WeaponType.Dagger)
		{
			_properties.MeleeDamageMult *= 1.2;
		}
	}

	q.onBeingAttacked = @(__original) function( _attacker, _skill, _properties )
	{
		__original(_attacker, _skill, _properties);

		if (this.m.CurrWeaponType == ::Const.Items.WeaponType.Dagger && !_attacker.isTurnDone() && !_attacker.isTurnStarted())
		{
			local bonus = ::Math.floor(_properties.Initiative * 0.1);
			_properties.MeleeDefense += bonus;
			_properties.RangedDefense += bonus;
		}
	}

	q.onTargetHit = @(__original) function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		__original(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);

		if (_targetEntity.isAlive() && this.m.CurrWeaponType == ::Const.Items.WeaponType.Mace && !_targetEntity.getCurrentProperties().IsImmuneToDaze)
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/dazed_effect"));
			local actor = this.getContainer().getActor();
			if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " struck a blow that leaves " + ::Const.UI.getColorizedEntityName(_targetEntity) + " dazed");
			}
		}
	}
});
