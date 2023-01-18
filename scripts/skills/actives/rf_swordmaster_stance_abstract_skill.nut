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
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png"
			text = "Currently Active: " + (this.m.IsOn ? "[color=" + ::Const.UI.Color.PositiveValue + "]Yes[/color]" : "[color=" + ::Const.UI.Color.NegativeValue + "]No[/color]")
		});

		return tooltip;
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
		foreach (skill in this.getContainer().getSkillsByFunction(@(skill) ::MSU.isKindOf(skill, "rf_swordmaster_stance_abstract")))
		{
			if (skill != this) skill.toggleOff();
		}
	}

	function toggleOff()
	{
		this.m.IsOn = false;
	}

	function onUse( _user, _targetTile )
	{
		if (this.m.IsOn) this.toggleOff();
		else this.toggleOn();
		return true;
	}
});
