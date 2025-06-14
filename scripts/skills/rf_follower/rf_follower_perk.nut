this.rf_follower_perk <- this.inherit("scripts/skills/skill", {
	m = {
		// generic or special
		RequiredToolsForUnlock = {},
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
	function setRequiredPerksForUnlock(_perkTable)
	{
		foreach (followerID, amount in _perkTable)
		{
			if (followerID != "generic" && !(followerID in ::World.Retinue.m.ValidFollowers))
			{
				::logError("Reforged: Tried to add rf_follower_perk requirement which is not a valid follower ID: " + followerID);
				::MSU.Log.printStackTrace();
			}
			else
			{
				this.m.RequiredToolsForUnlock[followerID] <- amount;
			}
 		}
	}
});

