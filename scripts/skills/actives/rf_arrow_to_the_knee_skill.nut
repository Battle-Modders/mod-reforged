this.rf_arrow_to_the_knee_skill <- ::inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = -2
	},
	function create()
	{
		this.m.ID = "actives.rf_arrow_to_the_knee";
		this.m.Name = "Arrow to the Knee";
		this.m.Description = "A debilitating shot aimed at the knees of your target, dealing reduced damage but reducing your target\'s Melee and Ranged defense and causing them to spend additional Action Points per tile moved.";
		this.m.KilledString = "Shot";
		this.m.Icon = "skills/rf_arrow_to_the_knee_skill.png";
		this.m.IconDisabled = "skills/rf_arrow_to_the_knee_skill_bw.png";
		this.m.Overlay = "rf_arrow_to_the_knee_skill";
		this.m.SoundOnUse = [
			"sounds/combat/aimed_shot_01.wav",
			"sounds/combat/aimed_shot_02.wav",
			"sounds/combat/aimed_shot_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/arrow_hit_01.wav",
			"sounds/combat/arrow_hit_02.wav",
			"sounds/combat/arrow_hit_03.wav"
		];
		this.m.SoundOnHitShield = [
			"sounds/combat/shield_hit_arrow_01.wav",
			"sounds/combat/shield_hit_arrow_02.wav",
			"sounds/combat/shield_hit_arrow_03.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/arrow_miss_01.wav",
			"sounds/combat/arrow_miss_02.wav",
			"sounds/combat/arrow_miss_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 1000;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsWeaponSkill = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = ::Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = ::Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 7;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = ::Const.ProjectileType.Arrow;
	}

	function getTooltip()
	{
		local tooltip = this.getRangedTooltip(this.getDefaultTooltip());

		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deals [color=" + ::Const.UI.Color.NegativeValue + "]50%[/color] reduced damage"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + ::Const.UI.Color.NegativeValue + "]0%[/color] chance to hit the head"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Target will have [color=" + ::Const.UI.Color.NegativeValue + "]-5[/color] Melee and Ranged defense for for 2 turns"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Target will require [color=" + ::Const.UI.Color.NegativeValue + "]2[/color] additional Action Points per tile moved for 2 turns"
			}
		]);

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + ::Const.UI.Color.PositiveValue + "]" + ammo + "[/color] arrows left"
			});
		}
		else
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Needs a non-empty quiver of arrows equipped[/color]"
			});
		}

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Cannot be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.getAmmo() > 0 && !this.getContainer().getActor().isEngagedInMelee();
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Ammo);

		if (item == null)
		{
			return 0;
		}

		if (item.getAmmoType() == ::Const.Items.AmmoType.Arrows)
		{
			return item.getAmmo();
		}
	}

	function consumeAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Ammo);

		if (item != null)
		{
			item.consumeAmmo();
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.MaxRange = this.m.Item.getRangeMax() + (_properties.IsSpecializedInBows ? 1 : 0);
		this.m.FatigueCostMult = _properties.IsSpecializedInBows ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.consumeAmmo();

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.getContainer().setBusy(true);
			local tag = {
				Skill = this,
				User = _user,
				TargetTile = _targetTile
				TargetEntity = _targetTile.getEntity()
			};
			::Time.scheduleEvent(::TimeUnit.Virtual, this.m.Delay, this.onPerformAttack, tag);

			if (!_user.isPlayerControlled() && _targetTile.getEntity().isPlayerControlled())
			{
				_user.getTile().addVisibilityForFaction(::Const.Faction.Player);
			}

			return true;
		}
		else
		{
			return this.attackEntity(_user, _targetTile.getEntity());
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive())
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/rf_arrow_to_the_knee_debuff_effect"));
		}
	}

	function onPerformAttack( _tag )
	{
		_tag.Skill.getContainer().setBusy(false);
		local ret = _tag.Skill.attackEntity(_tag.User, _tag.TargetTile.getEntity());
		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
			_properties.RangedDamageMult *= 0.5;
			_properties.HitChanceMult[::Const.BodyPart.Head] *= 0.0;
		}
	}
});

