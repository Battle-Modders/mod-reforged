this.perk_rf_inspiring_presence <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false
	},
	function create()
	{
		this.m.ID = "perk.rf_inspiring_presence";
		this.m.Name = ::Const.Strings.PerkName.RF_InspiringPresence;
		this.m.Description = ::Const.Strings.PerkDescription.RF_InspiringPresence;
		this.m.Icon = "ui/perks/rf_inspiring_presence.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	o.isEnabled <- function()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.getID().find("banner") = null)
		{
			return false;
		}

		return true;
	}
});
