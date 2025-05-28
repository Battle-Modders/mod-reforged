::Reforged.HooksMod.hook("scripts/skills/traits/player_character_trait", function(q) {
	q.create = @(__original) { function create()
	{
		__original();

		// In vanilla this array is empty for this trait. We add some sensible ones.
		this.m.Excluded.extend([
			"trait.survivor",
			"trait.greedy",
			"trait.loyal",
			"trait.disloyal"
		]);
		this.m.Excluded = ::MSU.Array.uniques(this.m.Excluded);
	}}.create;

	// Often this trait is added AFTER `player.setStartValuesEx` which adds traits to a bro.
	// So we cause it, upon addition, to look at existing traits and remove the ones which
	// are incompatible with it. Then add new traits equal to the number of removed traits.
	q.onAdded = @(__original) { function onAdded()
	{
		if (this.m.IsNew)
		{
			local count = 0;
			foreach (id in this.m.Excluded)
			{
				local trait = this.getContainer().getSkillByID(id);
				if (trait != null)
				{
					this.getContainer().remove(trait);
					count++;
				}
			}

			if (count != 0)
			{
				foreach (t in this.getContainer().getActor().MV_addTraits(count))
				{
					t.addTitle();
				}
			}
		}

		__original();
	}}.onAdded;
});
