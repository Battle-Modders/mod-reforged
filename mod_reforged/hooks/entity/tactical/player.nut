::mods_hookExactClass("entity/tactical/player", function(o) {

    // Player and Non-Player are now using the exact same tooltip-structure again because the only difference of the exact values for progressbar has been streamlined
    // This will make modding easier because now the elements for both types of tooltips have the same IDs
    o.getTooltip = function ( _targetedWithSkill = null )
    {
        return this.actor.getTooltip(_targetedWithSkill);
    }

	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.getSkills().add(::new("scripts/skills/actives/rf_adjust_dented_armor_ally_skill"));
	}

	o.getProjectedAttributes <- function()
	{
		local baseProperties = this.getBaseProperties();

		local ret = {};
		foreach (attributeName, attribute in ::Const.Attributes)
		{
			if (attribute == ::Const.Attributes.COUNT) continue;

			local attributeMin = ::Const.AttributesLevelUp[attribute].Min + ::Math.min(this.m.Talents[attribute], 2);
			local attributeMax = ::Const.AttributesLevelUp[attribute].Max;
			if (this.m.Talents[attribute] == 3) attributeMax += 1;

			local levelUpsRemaining = ::Math.max(::Const.XP.MaxLevelWithPerkpoints - this.getLevel() + this.getLevelUps(), 0);
			local attributeValue = attributeName == "Fatigue" ? baseProperties["Stamina"] : baseProperties[attributeName]; // Thank you Overhype

			ret[attribute] <- [
				attributeValue + attributeMin * levelUpsRemaining,
				attributeValue + attributeMax * levelUpsRemaining
			];
		}

		return ret;
	}

	o.isHired <- function()
	{
		return this.getPlaceInFormation() != 255;
	}

});
