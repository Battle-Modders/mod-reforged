this.rf_swordmaster_stance_abstract_skill <- ::inherit("scripts/skills/actives/rf_swordmaster_active_abstract", {
	m = {
		IsOn = false
	},
	function create()
	{
		this.rf_swordmaster_active_abstract.create();
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 1;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png"
			text = "Currently Active: " + (this.m.IsOn ? ::MSU.Text.colorPositive("Yes") : ::MSU.Text.colorNegative("No"))
		});

		return ret;
	}

	function onAdded()
	{
		this.toggleOff();
	}

	function isHidden()
	{
		return !this.isEnabled();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.m.IsOn;
	}

	function toggleOn()
	{
		this.m.IsOn = true;
		foreach (skill in this.getContainer().getSkillsByFunction(@(skill) ::MSU.isKindOf(skill, "rf_swordmaster_stance_abstract_skill")))
		{
			if (skill != this) skill.toggleOff();
		}
	}

	function toggleOff()
	{
		this.m.IsOn = false;
	}

	function onRemoved()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null)
		{
			this.getContainer().getActor().getItems().unequip(weapon);
			this.getContainer().getActor().getItems().equip(weapon);
		}
	}

	function onUse( _user, _targetTile )
	{
		if (this.m.IsOn) this.toggleOff();
		else this.toggleOn();
		return true;
	}
});
