this.rf_swordmaster_active_abstract <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
	}

	function isEnabled()
	{
		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Sword))
		{
			return false;
		}

		return true;
	}

	function addEnabledTooltip( _tooltip )
	{
		if (!this.isEnabled())
		{
			_tooltip.push({
				id = 50,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Requires a sword")
			});
		}
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.isEnabled();
	}

});
