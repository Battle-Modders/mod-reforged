::mods_hookExactClass("skills/backgrounds/character_background", function(o) {

	o.isHired <- function()
	{
		return !::MSU.isNull(this.getContainer()) && !::MSU.isNull(this.getContainer().getActor()) && this.getContainer().getActor().isHired();
	}

	o.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		this.addProjectedAttributesToTooltip(ret);
		return ret;
	}

	o.addProjectedAttributesToTooltip <- function(_tooltip)
	{
		if (!this.isHired() || this.getContainer().getActor().getLevel() >= ::Const.XP.MaxLevelWithPerkpoints)
			return;
		foreach (segment in _tooltip)
		{
			// We'll probably want this in a more unified way later
			if ("type" in segment && segment.type == "description")
			{
				_tooltip[1].rawHTML <- this.getProjectedAttributesDescription();
				return;
			}
		}
	}

	local getGenericTooltip = o.getGenericTooltip;
	o.getGenericTooltip = function()
	{
		local ret = getGenericTooltip();
		local descriptionContainer = ret[1];
		if (this.getContainer().getActor().isTryoutDone())
		{
			descriptionContainer.text += this.getContainer().getActor().getBackground().getPerkTree().getTooltip();
			descriptionContainer.text = ::MSU.String.replace(descriptionContainer.text, "%name%", this.getContainer().getActor().getNameOnly());
		}
		else
		{
			descriptionContainer.text += "\n" +  ::MSU.Text.colorRed("Try out") + " this character to reveal " + ::MSU.Text.colorGreen("more") + " information!";
		}
		return ret;
	}

	o.getProjectedAttributesDescription <- function()
	{
		local projection = this.getContainer().getActor().getProjectedAttributes();
		local function formatString( _img, _attribute )
		{
			local min = projection[_attribute][0];
			local max = projection[_attribute][1];
			return format("<span><img src='coui://%s'/> <span>%i [%i - %i]</span></span>", _img, (min + max) / 2, min, max)
		}

		local ret = "<div>Projection of this character\'s base attribute ranges if that attribute is improved on every level up from current level to " + ::Const.XP.MaxLevelWithPerkpoints + ".</div>";
		ret += "<div class='attributePredictionContainer'>"
		ret += formatString("gfx/ui/icons/health.png", ::Const.Attributes.Hitpoints)
		ret += formatString("gfx/ui/icons/melee_skill.png", ::Const.Attributes.MeleeSkill)
		ret += formatString("gfx/ui/icons/fatigue.png", ::Const.Attributes.Fatigue)
		ret += formatString("gfx/ui/icons/ranged_skill.png", ::Const.Attributes.RangedSkill)
		ret += formatString("gfx/ui/icons/bravery.png", ::Const.Attributes.Bravery)
		ret += formatString("gfx/ui/icons/melee_defense.png", ::Const.Attributes.MeleeDefense)
		ret += formatString("gfx/ui/icons/initiative.png", ::Const.Attributes.Initiative)
		ret += formatString("gfx/ui/icons/ranged_defense.png", ::Const.Attributes.RangedDefense)
		ret += "</div>"

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
			this.addProjectedAttributesToTooltip(ret);
			return ret;
		}
	}
})
