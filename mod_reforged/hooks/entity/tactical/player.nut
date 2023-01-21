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
});
