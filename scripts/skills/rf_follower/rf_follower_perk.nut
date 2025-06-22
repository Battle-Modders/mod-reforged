this.rf_follower_perk <- this.inherit("scripts/skills/skill", {
	m = {
	},
	function create()
	{
		this.m.ID = "perk.test";
		this.m.Name = "Test";
		this.m.Description = "Test Description";
		this.m.Icon = "ui/perks/perk_06.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function setContainer( _c )
	{
		this.m.Container = this.WeakTableRef(_c);
	}
});

