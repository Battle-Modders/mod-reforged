::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_crossbow", function(q) {
	q.onAfterUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		local reload = this.getContainer().getSkillByID("actives.reload_bolt");
		if (reload != null && reload.m.ActionPointCost > 4 && reload.getBaseValue("ActionPointCost") > 4)
			reload.m.ActionPointCost -= 1;
	}

	q.onAnySkillExecuted = @(__original) function( _skill, _targetTile, _targetEntity, _forFree )
	{
		__original(_skill, _targetTile, _targetEntity, _forFree);
		if (_skill.getID() == "actives.reload_bolt" || _skill.getID() == "actives.reload_handgonne")
		{
			local actor = this.getContainer().getActor();
			local items = actor.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag);

			local bestDefense = 0;
			local bestShield = null;

			foreach( item in items )
			{
				if (!item.isItemType(::Const.Items.ItemType.Shield)) continue;

				local defense = item.getMeleeDefense() + item.getRangedDefense();
				if (defense > bestDefense)
				{
					bestDefense = defense;
					bestShield = item;
				}
			}

			if (bestShield != null)
			{
				local paviseEffect = ::new("scripts/skills/effects/rf_pavise_cover_effect");
				paviseEffect.init(bestShield.getMeleeDefense(), bestShield.getRangedDefense());
				actor.getSkills().add(paviseEffect);
			}
		}
	}

	// Crossbow Mastery now automatically loads your weapon at the start of the combat
	q.onCombatStarted = @(__original) function()
	{
		__original();

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null) return;

		if ("IsLoaded" in weapon.m)		// This is currently our simple identifying factor for loaded weapons
		{
			if (weapon.isLoaded()) return;

			local ammoItem = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Ammo);
			if (ammoItem == null) return;
			if (ammoItem.getAmmo() == 0 && this.getContainer().getActor().isPlayerControlled()) return;	// NPCs are not required to have ammo in their quivers for this effect
			if (weapon.getRequiredAmmoType() != ammoItem.getAmmoType()) return;

			weapon.setLoaded(true);
			ammoItem.consumeAmmo();
		}
	}
});
