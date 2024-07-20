::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/goblin_wolfrider", function(q) {
	q.onInit = @() function()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.GoblinWolfrider);
		// b.AdditionalActionPointCost = 1;
		// b.DamageDirectMult = 1.25;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInSpears = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_01_head_0" + ::Math.rand(1, 3));
		this.setAlwaysApplySpriteOffset(true);
		local offset = this.createVec(8, 14);
		this.setSpriteOffset("body", offset);
		this.setSpriteOffset("armor", offset);
		this.setSpriteOffset("head", offset);
		this.setSpriteOffset("injury", offset);
		this.setSpriteOffset("helmet", offset);
		this.setSpriteOffset("helmet_damage", offset);
		this.setSpriteOffset("body_blood", offset);
		local variant = ::Math.rand(1, 2);
		local wolf = this.addSprite("wolf");
		wolf.setBrush("bust_wolf_0" + variant + "_body");
		wolf.varySaturation(0.15);
		wolf.varyColor(0.07, 0.07, 0.07);
		local wolf = this.addSprite("wolf_head");
		wolf.setBrush("bust_wolf_0" + variant + "_head");
		wolf.Saturation = wolf.Saturation;
		wolf.Color = wolf.Color;
		this.removeSprite("injury_body");
		local wolf_injury = this.addSprite("injury_body");
		wolf_injury.setBrush("bust_wolf_01_injured");
		wolf_injury.Visible = false;
		local wolf_armor = this.addSprite("wolf_armor");
		wolf_armor.setBrush("bust_wolf_02_armor_01");
		offset = this.createVec(0, -20);
		this.setSpriteOffset("wolf", offset);
		this.setSpriteOffset("wolf_head", offset);
		this.setSpriteOffset("wolf_armor", offset);
		this.setSpriteOffset("injury_body", offset);
		this.addDefaultStatusSprites();
		this.setSpriteOffset("arms_icon", this.createVec(15, 15));
		this.getSprite("arms_icon").Rotation = 13.0;
		local wolf_bite = this.new("scripts/skills/actives/wolf_bite");
		wolf_bite.setRestrained(true);
		wolf_bite.m.ActionPointCost = 0;
		this.m.Skills.add(wolf_bite);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/racial/rf_goblin_wolfrider_racial"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		__original();

		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	}
});
