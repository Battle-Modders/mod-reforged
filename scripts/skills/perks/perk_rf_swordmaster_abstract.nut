this.perk_rf_swordmaster_abstract <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false
	},
	function create()
	{
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Last;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

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
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Requires a sword")
			});
		}
	}

});
