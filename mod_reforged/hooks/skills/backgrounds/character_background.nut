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

	q.createPerkTreeBlueprint = @() function()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({});
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

	// If _hideRolledValues is true, then the actual base roll is hidden. This is important to not spoil the base roll information to the player during hiring
	q.getBaseAttributesTooltip <- function( _hideRolledValues )
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();
		local baseAttr = this.m.BaseAttributes;
		local change = this.onChangeAttributes();

		local function formatString( _img, _attrName )
		{
			local baseValue = _hideRolledValues ? "" : baseProperties[_attrName].tostring();
			local minValue = baseAttr[_attrName][0] + change[_attrName][0];
			local maxValue = baseAttr[_attrName][1] + change[_attrName][1];
			return format("<span class='attributePredictionItem'><img src='coui://%s'/> <span class='attributePredictionSingle'>%s</span> <span class='attributePredictionRange'>[%i - %i]</span></span>", _img, baseValue, minValue, maxValue);
		}

		local html = "<div class='attributePredictionHeader'>Base Attribute Ranges for this Background:</div>";
		html += "<div class='attributePredictionContainer'>";
		html += formatString("gfx/ui/icons/health.png", "Hitpoints");
		html += formatString("gfx/ui/icons/melee_skill.png", "MeleeSkill");
		html += formatString("gfx/ui/icons/fatigue.png", "Stamina");
		html += formatString("gfx/ui/icons/ranged_skill.png", "RangedSkill");
		html += formatString("gfx/ui/icons/bravery.png", "Bravery");
		html += formatString("gfx/ui/icons/melee_defense.png", "MeleeDefense");
		html += formatString("gfx/ui/icons/initiative.png", "Initiative");
		html += formatString("gfx/ui/icons/ranged_defense.png", "RangedDefense");

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
			ret.extend(this.getBaseAttributesTooltip(true));	// During hiring we only want to show the minimum and maximum range. Not the rolled value
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
			if (!this.getContainer().getActor().getFlags().has("RF_HasSpentLevelUp"))
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
