this.rf_follower_skill_container <- this.inherit("scripts/skills/skill_container", {
	// Mock of the skill_container where we might want to add more triggers
	function update()
	{
		if (this.m.IsUpdating)
		{
			return;
		}

		this.collectGarbage(false);
	}
})
