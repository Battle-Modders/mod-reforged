this.perk_rf_trick_shooter <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_trick_shooter";
		this.m.Name = ::Const.Strings.PerkName.RF_TrickShooter;
		this.m.Description = ::Const.Strings.PerkDescription.RF_TrickShooter;
		this.m.Icon = "ui/perks/rf_trick_shooter.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		this.getContainer().add(::MSU.new("scripts/skills/perks/perk_rf_hip_shooter", function(o) {
			o.m.IsRefundable = false;
			o.m.IsSerialized = false;
		}));
		this.getContainer().add(::MSU.new("scripts/skills/perks/perk_rf_flaming_arrows", function(o) {
			o.m.IsRefundable = false;
			o.m.IsSerialized = false;
		}));
	}

	function onRemoved()
	{
		this.getContainer().removeByStackByID("perk.rf_hip_shooter", false);
		this.getContainer().removeByStackByID("perk.rf_flaming_arrows", false);
	}
});
