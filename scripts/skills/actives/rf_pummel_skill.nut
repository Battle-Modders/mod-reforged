this.rf_pummel_skill <- ::inherit("scripts/skills/actives/line_breaker", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Hammer
	},
	function create()
	{
		this.line_breaker.create();
		this.m.ID = "actives.rf_pummel";
		this.m.Name = "Pummel";
		this.m.Description = "Use a heavy attack to knock back your target and take their place, all in one action."
		this.m.Icon = "skills/rf_pummel_skill.png";
		this.m.IconDisabled = "skills/rf_pummel_skill_sw.png";
		this.m.Overlay = "rf_pummel_skill";
		this.m.SoundOnUse = [
			"sounds/combat/indomitable_01.wav",
			"sounds/combat/indomitable_02.wav"
		];
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.LineBreaker;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		local attack = this.getValidAttack();

		if (attack == null)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative(this.m.RequiredWeaponType == null ? ::Reforged.Mod.Tooltips.parseString("Requires an attack that exerts [Zone of Control|Concept.ZoneOfControl]") : "Requires an attack from a two-handed " + ::Const.Items.getWeaponTypeName(this.m.RequiredWeaponType).tolower())
			});
		}
		else
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Perform a free " + ::Reforged.NestedTooltips.getNestedSkillName(attack) + " on the target")
			});
		}

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("If the attack is successful, the target becomes [staggered|Skill+staggered_effect]")
		});

		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("If the attack is successful, automatically use [Line Breaker|Skill+line_breaker] for free on the target")
		});

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 13,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Cannot be used while Rooted")
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.line_breaker.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted && this.getValidAttack() != null;
	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInHammers)
		{
			this.m.FatigueCostMult *= ::Const.Combat.WeaponSpecFatigueMult;
		}
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();

		local aoo = this.getValidAttack();
		local overlay = aoo.m.Overlay;
		aoo.m.Overlay = "";
		local success = aoo.useForFree(_targetTile);
		aoo.m.Overlay = overlay;

		if (success)
		{
			if (targetEntity.isAlive())
			{
				targetEntity.getSkills().add(::new("scripts/skills/effects/staggered_effect"));
				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has pummeled and staggered " + ::Const.UI.getColorizedEntityName(targetEntity));
			}

			local tag = {
				User = _user,
				TargetTile = _targetTile
				TargetEntity = targetEntity
			}
			// Doing this.line_breaker.onUse here directly doesn't work properly:
			// The targetEntity gets knocked back by Linebreaker, but the attacker does not move to the target tile.
			// Using scheduleEvent even with a delay of 1 is enough to make it work properly. No idea why. -- Midas
			::Time.scheduleEvent(::TimeUnit.Virtual, 1, this.onPushThrough.bindenv(this), tag);
		}

		return success;
	}

	function onPushThrough( _tag )
	{
		if (_tag.TargetEntity.isAlive())
			this.line_breaker.onUse(_tag.User, _tag.TargetTile);
		else
			::Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, null, null, false);
	}

	function getValidAttack()
	{
		local aoo = this.getContainer().getAttackOfOpportunity();
		if (aoo == null)
			return null;

		if (this.m.RequiredWeaponType == null)
			return aoo;

		local weapon = aoo.getItem();
		if (!::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType))
			return aoo;
	}
});
