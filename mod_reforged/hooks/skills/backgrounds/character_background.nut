::mods_hookExactClass("skills/backgrounds/character_background", function(o) {
	o.isHired <- function()
	{
		return !::MSU.isNull(this.getContainer()) && !::MSU.isNull(this.getContainer().getActor()) && this.getContainer().getActor().isHired();
	}

	o.getProjectedAttributesTooltip <- function()
	{
		return [{
			id = 3,
			type = "description",
			text = "", // Needs text key or it'll be skipped
			rawHTML = this.getProjectedAttributesHTML()
		}];
	}

	local getTooltip = "getTooltip" in o ? o.getTooltip : null;
	o.getTooltip <- function()
	{
		local ret = getTooltip == null ? this.skill.getTooltip() : getTooltip();
		ret.extend(this.getProjectedAttributesTooltip());
		return ret;
	}

	local adjustHiringCostBasedOnEquipment = o.adjustHiringCostBasedOnEquipment;
	o.adjustHiringCostBasedOnEquipment = function()
	{
		adjustHiringCostBasedOnEquipment();
		local actor = this.getContainer().getActor();
		local hiringCost = actor.m.HiringCost;
		local minimum = hiringCost * (1.0 - ::Reforged.Config.HiringCostVariance);
		local maximum = hiringCost * (1.0 + ::Reforged.Config.HiringCostVariance);
		hiringCost = ::Reforged.Math.luckyRoll(minimum, maximum, hiringCost, ::Reforged.Config.HiringCostLuck);		// Randomizes this value an additional time for every 100 luck and picks the one closest to the original
		hiringCost = ::Reforged.Math.ceil(hiringCost, -1);		// Makes sure this unsigned integer ends with a 0 one again
		actor.m.HiringCost = hiringCost;
	}

	o.getPerkTreeTooltip <- function()
	{
		return {
			id = 3,
			type = "description",
			text = this.getContainer().getActor().getPerkTree().getTooltip()
		};
	}

	local getGenericTooltip = o.getGenericTooltip;
	o.getGenericTooltip = function()
	{
		local ret = getGenericTooltip();
		if (this.getContainer().getActor().isTryoutDone())
		{
			local perkTreeTooltip = this.getPerkTreeTooltip();
			perkTreeTooltip.text = ::MSU.String.replace(perkTreeTooltip.text, "%name%", this.getContainer().getActor().getNameOnly());
			ret.push(perkTreeTooltip);
			ret.push(this.getProjectedAttributesTooltip());
		}
		else
		{
			ret.push({
				id = 3,
				type = "description",
				text =  ::MSU.Text.colorRed("Try out") + " this character to reveal " + ::MSU.Text.colorGreen("more") + " information!"
			});
		}
		return ret;
	}

	o.getProjectedAttributesHTML <- function()
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

::mods_hookDescendants("skills/backgrounds/character_background", function(o) {
	if ("getTooltip" in o)
	{
		local getTooltip = o.getTooltip;
		o.getTooltip <- function()
		{
			local ret = getTooltip();
			ret.extend(this.getProjectedAttributesTooltip());
			return ret;
		}
	}
})
