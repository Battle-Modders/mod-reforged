::Reforged.HooksMod.hook("scripts/skills/actives/summon_mirror_image_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Create mirror images of the Lorekeeper up to a maximum of " + ::MSU.Text.colorPositive(4) + ". They can cast [Lightning Strike|Skill+lightning_storm_skill], [Wither|Skill+wither_skill], and [Raise Undead|Skill+raise_undead].");
	}

	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		if (::Tactical.Entities.getFlags().getAsInt("RaiseAllUndeadUsed") == 0)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString("Can only be used after [Raise all Undead|Skill+raise_all_undead_skill] has been used")
			});
		}

		// Const
		local maxImagesTotal = 4;

		local currentPhylacteries = 0;
		local currentImages = 0;
		foreach (e in ::Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction()))
		{
			if (e.getType() == ::Const.EntityType.SkeletonPhylactery)
			{
				currentPhylacteries++;
			}
			if (e.getType() == ::Const.EntityType.SkeletonLichMirrorImage)
			{
				currentImages++;
			}
		}
		local phylacteryReference = ::Math.max(0, currentPhylacteries - ::Time.getRound() / 9);
		local bonusImages = ::Math.max(0, 6 - phylacteryReference);
		local imagesToSpawn = ::Math.min(2 + bonusImages, maxImagesTotal - currentImages);

		if (imagesToSpawn != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will summon " + ::MSU.Text.colorPositive(imagesToSpawn) + " Lorekeeper Apparitions up to a maximum of " + ::MSU.Text.colorPositive(maxImagesTotal)
			});
		}
		else
		{
			ret.push({
				id = 21,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Cannot be used while there are " + ::MSU.Text.colorPositive(maxImagesTotal) + " or more Lorekeeper Apparitions on the battlefield"
			});
		}

		return ret;
	}
});
