this.rf_veteran_levels <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.rf_veteran_levels";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsSerialized = false;
		this.m.IsHidden = true;
	}

	function onUpdateLevel()
	{
		if (::Reforged.Config.VeteranPerksLevelStep == 0)
			return;

		local diff = this.getContainer().getActor().getLevel() - ::Const.XP.MaxLevelWithPerkpoints;
		if (diff > 0 && diff % ::Reforged.Config.VeteranPerksLevelStep == 0)
		{
			this.getContainer().getActor().m.PerkPoints++;
		}
	}
});
