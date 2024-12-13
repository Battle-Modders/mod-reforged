::Reforged.HooksMod.hook("scripts/skills/backgrounds/character_background", function(q) {
	// Private
	q.m.BaseAttributes <- {		// In Vanilla these are currently only defined within the buildAttributes() function of this class
		Hitpoints = 	[50, 60],
		Bravery = 		[30, 40],
		Stamina = 		[90, 100],
		MeleeSkill = 	[47, 57],
		RangedSkill = 	[32, 42],
		MeleeDefense = 	[0, 5],
		RangedDefense = [0, 5],
		Initiative = 	[100, 110],
	}

	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({});
	}

	q.isHired <- function()
	{
		return !::MSU.isNull(this.getContainer()) && !::MSU.isNull(this.getContainer().getActor()) && this.getContainer().getActor().isHired();
	}

	q.getProjectedAttributesTooltip <- function()
	{
		return [{
			id = 3,
			type = "description",
			rawHTMLInText = true,
			text = this.getProjectedAttributesHTML()
		}];
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

	q.getBaseAttributesTooltip <- function( _hideRolledValues )
	{
		local function formatString( _img, _base, _min, _max )
		{
			if (_hideRolledValues) _base = "";
			_base += "";	// To force _base to become a string, because that's why format expects
			return format("<span class='attributePredictionItem'><img src='coui://%s'/> <span class='attributePredictionSingle'>%s</span> <span class='attributePredictionRange'>[%i - %i]</span></span>", _img, _base, _min, _max);
		}

		local baseProperties = this.getContainer().getActor().getBaseProperties();
		local baseAttr = this.m.BaseAttributes;
		local change = this.onChangeAttributes();

		local html = "<div class='attributePredictionHeader'>Base Attribute Ranges for this Background:</div>";
		html += "<div class='attributePredictionContainer'>";
		html += formatString("gfx/ui/icons/health.png", baseProperties.Hitpoints, baseAttr.Hitpoints[0] + change.Hitpoints[0], baseAttr.Hitpoints[1] + change.Hitpoints[1]);
		html += formatString("gfx/ui/icons/melee_skill.png", baseProperties.MeleeSkill, baseAttr.MeleeSkill[0] + change.MeleeSkill[0], baseAttr.MeleeSkill[1] + change.MeleeSkill[1]);
		html += formatString("gfx/ui/icons/fatigue.png", baseProperties.Stamina, baseAttr.Stamina[0] + change.Stamina[0], baseAttr.Stamina[1] + change.Stamina[1]);
		html += formatString("gfx/ui/icons/ranged_skill.png", baseProperties.RangedSkill, baseAttr.RangedSkill[0] + change.RangedSkill[0], baseAttr.RangedSkill[1] + change.RangedSkill[1]);
		html += formatString("gfx/ui/icons/bravery.png", baseProperties.Bravery, baseAttr.Bravery[0] + change.Bravery[0], baseAttr.Bravery[1] + change.Bravery[1]);
		html += formatString("gfx/ui/icons/melee_defense.png", baseProperties.MeleeDefense, baseAttr.MeleeDefense[0] + change.MeleeDefense[0], baseAttr.MeleeDefense[1] + change.MeleeDefense[1]);
		html += formatString("gfx/ui/icons/initiative.png", baseProperties.Initiative, baseAttr.Initiative[0] + change.Initiative[0], baseAttr.Initiative[1] + change.Initiative[1]);
		html += formatString("gfx/ui/icons/ranged_defense.png", baseProperties.RangedDefense, baseAttr.RangedDefense[0] + change.RangedDefense[0], baseAttr.RangedDefense[1] + change.RangedDefense[1]);

		return [{
			id = 4,
			type = "description",
			rawHTMLInText = true,
			text = html,
		}];
	}
});

::Reforged.HooksMod.hookTree("scripts/skills/backgrounds/character_background", function(q) {
	q.getGenericTooltip = @(__original) function()
	{
		local ret = __original();

		if (::Reforged.Mod.ModSettings.getSetting("CharacterScreen_ShowBaseAttributeRangesHiring").getValue())
		{
			ret.extend(this.getBaseAttributesTooltip(true));
		}

		return ret;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		local showBaseAttributeRangeRegular = ::Reforged.Mod.ModSettings.getSetting("CharacterScreen_ShowBaseAttributeRangesRegular").getValue();
		if (showBaseAttributeRangeRegular == "Always")
		{
			ret.extend(this.getBaseAttributesTooltip(false));
		}
		else if (showBaseAttributeRangeRegular == "Only New Recruits")
		{
			local player = this.getContainer().getActor();
			if (player.getLevel() == player.getLevelUps() + 1)	// This condition is an approximation of "not yet having spent any level-up"
			{
				ret.extend(this.getBaseAttributesTooltip(false));
			}
		}

		if (::Reforged.Mod.ModSettings.getSetting("CharacterScreen_ShowAttributeProjection").getValue())
		{
			local player = this.getContainer().getActor();
			if (::Const.XP.MaxLevelWithPerkpoints - player.getLevel() + player.getLevelUps() > 0)
			{
				ret.extend(this.getProjectedAttributesTooltip());
			}
		}

		return ret;
	}
})
