::mods_hookExactClass("skills/backgrounds/character_background", function(o) {
	local getBackgroundDescription = o.getBackgroundDescription;
	o.getBackgroundDescription = function()
	{
		local ret = getBackgroundDescription() + "\n\n";

		if (!this.getContainer().getActor().isTryoutDone())
		{
			ret += ::MSU.Text.colorRed("Try out") + " this character to reveal " + ::MSU.Text.colorGreen("more") + " information!";
		}
		else
		{
			ret += this.getContainer().getActor().getBackground().getPerkTree().getTooltip();
			ret = ::MSU.String.replace(ret, "%name%", this.getContainer().getActor().getNameOnly());
		}

		return ret;
	}

	local getDescription = "getDescription" in o ? o.getDescription : null;
	o.getDescription <- function()
	{
		local ret = getDescription != null ? getDescription() : this.skill.getDescription();

		if (::MSU.isNull(this.getContainer()) || this.getContainer().getActor().getLevel() >= ::Const.XP.MaxLevelWithPerkpoints || this.getContainer().getActor().getPlaceInFormation() != 255) // Formation check to confirm this character is hired and default is 255
			return ret;

		return ret + "\n\n----\n" + this.getProjectedAttributesDescription();
	}

	o.getProjectedAttributesDescription <- function()
	{
		local projection = this.getContainer().getActor().getProjectedAttributes();

		local function getStringSpacing( _attribute )
		{
			local str = "&nbsp;&nbsp;&nbsp;";
			foreach (attributeName, attribute in ::Const.Attributes)
			{
				if (attribute > ::Const.Attributes.Initiative) continue;
				if (attribute != _attribute)
				{
					if (projection[attribute][0] >= 100) str += "&nbsp;&nbsp;&nbsp;";
					if (projection[attribute][1] >= 100) str += "&nbsp;&nbsp;";
				}
			}
			return str;
		}

		local function formatString( _img, _attribute )
		{
			local min = projection[_attribute][0];
			local max = projection[_attribute][1];
			return format("[img]%s[/img] %i [size=10][%i - %i][/size]", _img, (min + max) / 2, min, max);
		}

		local ret = "Projection of this character\'s base attribute ranges if that attribute is improved on every level up from current level to " + ::Const.XP.MaxLevelWithPerkpoints + ".\n";
		ret += "\n" + formatString("gfx/ui/icons/health_15px.png", ::Const.Attributes.Hitpoints) + getStringSpacing(::Const.Attributes.Hitpoints) + formatString("gfx/ui/icons/melee_skill_15px.png", ::Const.Attributes.MeleeSkill);
		ret += "\n" + formatString("gfx/ui/icons/fatigue_15px.png", ::Const.Attributes.Fatigue) + getStringSpacing(::Const.Attributes.Fatigue) + formatString("gfx/ui/icons/ranged_skill_15px.png", ::Const.Attributes.RangedSkill);
		ret += "\n" + formatString("gfx/ui/icons/bravery_15px.png", ::Const.Attributes.Bravery) + getStringSpacing(::Const.Attributes.Bravery) + formatString("gfx/ui/icons/melee_defense_15px.png", ::Const.Attributes.MeleeDefense);
		ret += "\n" + formatString("gfx/ui/icons/initiative_15px.png", ::Const.Attributes.Initiative) + getStringSpacing(::Const.Attributes.Initiative) + formatString("gfx/ui/icons/ranged_defense_15px.png", ::Const.Attributes.RangedDefense);

		return ret;
	}
});
