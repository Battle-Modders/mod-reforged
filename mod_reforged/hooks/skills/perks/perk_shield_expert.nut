::Reforged.HooksMod.hook("scripts/skills/perks/perk_shield_expert", function(q) {
	q.m.FatigueBeforeMiss <- 0;

	q.onAdded = @(__original) function()
	{
		__original();
		local shield = this.getContainer().getActor().getOffhandItem();
		if (shield != null) this.onEquip(shield);
	}

	q.onEquip <- function( _item )
	{
		if (_item.isItemType(::Const.Items.ItemType.Shield) && _item.getID().find("buckler") == null)
		{
			_item.addSkill(::new("scripts/skills/actives/rf_cover_ally_skill"));
		}
	}

	// This is called via skill_container.buildPropertiesForDefense
	// If the attack misses, we will recover the character's fatigue back to this value
	q.onBeingAttacked <- function( _attacker, _skill, _properties )
	{
		this.m.FatigueBeforeMiss = this.getContainer().getActor().getFatigue();
	}

	// We "recover" the fatigue that was built during actor.onMissed.
	// Ideally this perk shouldn't even build that fatigue, but that requires overwriting
	// actor.onMissed. So instead of that, this recover system is cleaner for now.
	// If MSU adds another character property `FatigueLossOnBeingMissed` and hooks actor.onMissed
	// to incorporate that then we can use that for a more accurate solution.
	q.onMissed <- function( _attacker, _skill )
	{
		local actor = this.getContainer().getActor();
		if (actor.getFatigue() > this.m.FatigueBeforeMiss)
			actor.setFatigue(::Math.max(0, ::Math.min(actor.getFatigueMax(), this.m.FatigueBeforeMiss)));
	}
});
