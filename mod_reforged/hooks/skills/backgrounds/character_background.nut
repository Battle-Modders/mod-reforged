::Reforged.HooksMod.hook("scripts/skills/backgrounds/character_background", function(q) {
	q.isHired <- function()
	{
		return !::MSU.isNull(this.getContainer()) && !::MSU.isNull(this.getContainer().getActor()) && this.getContainer().getActor().isHired();
	}

	q.getProjectedAttributesTooltip <- function()
	{
		return [{
			id = 3,
			type = "description",
			text = "", // Needs text key or it'll be skipped
			rawHTML = this.getProjectedAttributesHTML()
		}];
	}

	// TODO: Currently this randomization is not persistent across game load. We need to serialize the hiring cost.
	q.adjustHiringCostBasedOnEquipment = @(__original) function()
	{
		__original();
		local actor = this.getContainer().getActor();
		local hiringCost = actor.m.HiringCost;
		local minimum = hiringCost * (1.0 - ::Reforged.Config.HiringCostVariance);
		local maximum = hiringCost * (1.0 + ::Reforged.Config.HiringCostVariance);
		hiringCost = ::Reforged.Math.luckyRoll(minimum, maximum, hiringCost, ::Reforged.Config.HiringCostLuck);		// Randomizes this value an additional time for every 100 luck and picks the one closest to the original
		hiringCost = ::Reforged.Math.ceil(hiringCost, -1);		// Makes sure this unsigned integer ends with a 0 one again
		actor.m.HiringCost = hiringCost;
	}

	q.getPerkTreeTooltip <- function()
	{
		return {
			id = 3,
			type = "description",
			text = this.getContainer().getActor().getPerkTree().getTooltip()
		};
	}

	q.getProjectedAttributesHTML <- function()
	{
		local projection = this.getContainer().getActor().getProjectedAttributes();
		local function formatString( _img, _attribute )
		{
			local min = projection[_attribute][0];
			local max = projection[_attribute][1];
			return format("<span class='attributePredictionItem'><img src='coui://%s'/> <span class='attributePredictionSingle'>%i</span> <span class='attributePredictionRange'>[%i - %i]</span></span>", _img, (min + max) / 2, min, max);
		}

		local ret = "<div class='attributePredictionHeader'>Projection of this character\'s base attribute ranges at level " + ::Const.XP.MaxLevelWithPerkpoints + ".</div>";
		ret += "<div class='attributePredictionContainer'>";
		ret += formatString("gfx/ui/icons/health.png", ::Const.Attributes.Hitpoints);
		ret += formatString("gfx/ui/icons/melee_skill.png", ::Const.Attributes.MeleeSkill);
		ret += formatString("gfx/ui/icons/fatigue.png", ::Const.Attributes.Fatigue);
		ret += formatString("gfx/ui/icons/ranged_skill.png", ::Const.Attributes.RangedSkill);
		ret += formatString("gfx/ui/icons/bravery.png", ::Const.Attributes.Bravery);
		ret += formatString("gfx/ui/icons/melee_defense.png", ::Const.Attributes.MeleeDefense);
		ret += formatString("gfx/ui/icons/initiative.png", ::Const.Attributes.Initiative);
		ret += formatString("gfx/ui/icons/ranged_defense.png", ::Const.Attributes.RangedDefense);
		ret += "</div>";

		return ret;
	}
});

::Reforged.HooksMod.hookTree("scripts/skills/backgrounds/character_background", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		local player = this.getContainer().getActor();
		if (::Const.XP.MaxLevelWithPerkpoints - player.getLevel() + player.getLevelUps() > 0)
		{
			ret.extend(this.getProjectedAttributesTooltip());
		}
		return ret;
	}
})
