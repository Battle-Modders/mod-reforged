::mods_hookExactClass("skills/perks/perk_shield_expert", function (o) {
	local onAdded = ::mods_getMember(o, "onAdded");
	::mods_override(o, "onAdded", function() {
		onAdded();
		local shield = this.getContainer().getActor().getOffhandItem();
		if (shield != null) this.onEquip(shield);
	});

	o.onEquip <- function( _item )
	{
		if (_item.isItemType(::Const.Items.ItemType.Shield) && _item.getID().find("buckler") == null)
		{
			_item.addSkill(::new("scripts/skills/actives/rf_cover_ally_skill"));
		}
	}

	function onMissed( _attacker, _skill )
	{
		local actor = this.getContainer().getActor();
		if (actor.isArmedWithShield())
		{
			actor.setFatigue(::Math.max(0, actor.getFatigue() - ::Const.Combat.FatigueLossOnBeingMissed));
		}
	}
});
