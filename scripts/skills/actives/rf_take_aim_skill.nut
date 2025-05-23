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
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 25;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		local takeAimEffect = ::new("scripts/skills/effects/rf_take_aim_effect");
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Gain the [Taking Aim|Skill+rf_take_aim_effect] effect"),
			children = takeAimEffect.getTooltip().slice(2) // slice 2 to remove name and description
		});

		if (::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()) || !this.getContainer().getActor().getMainhandItem().isLoaded())
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Requires a loaded weapon")
			});
		}

		return ret;
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
		if (!this.isEnabled())
			return false;

		return this.skill.isUsable() && actor.getMainhandItem().isLoaded() && !this.getContainer().hasSkill("effects.rf_take_aim") && !actor.isEngagedInMelee();
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
