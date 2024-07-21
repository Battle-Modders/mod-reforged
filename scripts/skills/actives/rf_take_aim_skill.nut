this.rf_take_aim_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_take_aim";
		this.m.Name = "Take Aim";
		this.m.Description = "Put additional effort into getting a better aim to hit targets behind cover with a Crossbow or to reach farther targets with a Handgonne."
		this.m.Icon = "skills/rf_take_aim_skill.png";
		this.m.IconDisabled = "skills/rf_take_aim_skill_sw.png";
		this.m.Overlay = "rf_take_aim_skill";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsStacking = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 20;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "For the next ranged attack:"
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Crossbows ignore any hitchance penalty from obstacles, and the shot cannot go astray"
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Handgonnes have their Maximum Range increased by 1 and if used at shorter range, have their area of effect increased by 1 instead"
		});

		return tooltip;
	}

	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || (!weapon.isWeaponType(::Const.Items.WeaponType.Crossbow) && !this.getContainer().hasSkill("actives.fire_handgonne")))
		{
			return false;
		}

		return true;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.rf_take_aim") && !actor.isEngagedInMelee() && this.isEnabled();
	}

	function isHidden()
	{
		return !this.getContainer().getActor().isArmedWithRangedWeapon();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Container.add(::new("scripts/skills/effects/rf_take_aim_effect"));
		return true;
	}

	function onRemoved()
	{
		this.m.Container.removeByID("effects.rf_take_aim");
	}
});
