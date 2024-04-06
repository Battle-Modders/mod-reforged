// ::Reforged.HooksMod.hook("scripts/entity/tactical/humans/caravan_hand", function(q) {
// 	q.onInit = @() function()
// 	{
// 		this.human.onInit();
// 		local b = this.m.BaseProperties;
// 		b.setValues(this.Const.Tactical.Actor.CaravanHand);
// 		this.m.ActionPoints = b.ActionPoints;
// 		this.m.Hitpoints = b.Hitpoints;
// 		this.m.CurrentProperties = clone b;
// 		this.setAppearance();
// 		this.getSprite("socket").setBrush("bust_base_caravan");
// 		this.getSprite("dirt").Visible = true;
// 		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default
// 	}

// 	q.assignRandomEquipment = @(__original) function()
// 	{
// 	    __original();
// 	}
// });
