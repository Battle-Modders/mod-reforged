::Reforged.HooksMod.hook("scripts/items/armor_upgrades/bone_platings_upgrade", function(q) {
	q.onCombatStarted = @() { function onCombatStarted()
	{
		this.getArmor().getContainer().getActor().getSkills().add(::new("scripts/skills/effects/rf_bone_platings_effect"));
	}}.onCombatStarted;

	q.onBeforeDamageReceived = @() { function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )		// Disable the built-in damage reduction from the item (Vanilla effect)
	{
	}}.onBeforeDamageReceived;
});
