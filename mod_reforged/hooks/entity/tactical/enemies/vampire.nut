::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/vampire", function(q) {
	q.m.HeadSprites <- null; // len 3 array of sprites, 0 = healthy, 1 = damaged, 2 = severely damaged
	q.m.BodySprites <- null; // len 3 array of sprites, 0 = healthy, 1 = damaged, 2 = severely damaged
	q.m.VampireBloodHeadSprites <- null; // Reference to an array in character_heads.nut

	q.create = @(__original) function()
	{
		__original();
		this.m.BodySprites = [
			"bust_skeleton_body_05",
			"bust_skeleton_body_04",
			"bust_skeleton_body_03"
		];
		this.m.HeadSprites = [
			::Math.rand(0, 1) == 1 ? "bust_skeleton_head_05" : "bust_rf_vampire_head_01",
			"bust_skeleton_head_04",
			"bust_skeleton_head_03"
		];
		this.m.VampireBloodHeadSprites = ::Const.RF_VampireBloodHead;
	}

	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Vampire);
		// b.IsAffectedByNight = false;			// Now handled by racial effect
		// b.IsAffectedByInjuries = false;		// Now handled by racial effect
		// b.IsImmuneToPoison = true;			// Now handled by racial effect
		// b.IsSpecializedInSwords = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		local hairColor = ::Const.HairColors.Zombie[::Math.rand(0, ::Const.HairColors.Zombie.len() - 1)];
		this.addSprite("socket").setBrush("bust_base_undead");
		local body = this.addSprite("body");
		body.setBrush(this.m.BodySprites[0]);
		body.setHorizontalFlipping(true);
		this.addSprite("old_body");
		this.addSprite("body_injury").setBrush("bust_skeleton_body_05_injured");
		this.addSprite("armor");
		local body_detail = this.addSprite("body_detail");

		if (::Math.rand(1, 100) <= 75)
		{
			body_detail.setBrush("bust_skeleton_detail_0" + ::Math.rand(2, 3));
		}

		local head = this.addSprite("head");
		head.setBrush(this.m.HeadSprites[0]);
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		this.addSprite("old_head");
		local injury = this.addSprite("injury");
		injury.setBrush("bust_skeleton_head_05_injured");
		local head_detail = this.addSprite("head_detail");

		if (::Math.rand(1, 100) <= 50)
		{
			head_detail.setBrush("bust_skeleton_head_detail_01");
		}

		local beard = this.addSprite("beard");
		beard.setBrightness(0.7);
		beard.varyColor(0.02, 0.02, 0.02);

		local vampireBlood = this.addSprite("rf_vampire_blood_head");
		vampireBlood.setBrush(::MSU.Array.rand(this.m.VampireBloodHeadSprites[0]));
		vampireBlood.Visible = false;
		this.addSprite("old_rf_vampire_blood_head");

		local hair = this.addSprite("hair");
		hair.Color = beard.Color;

		if (::Math.rand(1, 100) <= 75)
		{
			hair.setBrush("hair_" + hairColor + "_" + ::Const.Hair.Vampire[::Math.rand(0, ::Const.Hair.Vampire.len() - 1)]);
		}

		this.setSpriteOffset("hair", this.createVec(0, -3));
		this.addSprite("helmet");
		this.addSprite("helmet_damage");
		local beard_top = this.addSprite("beard_top");

		if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top"))
		{
			beard_top.setBrush(beard.getBrush().Name + "_top");
			beard_top.Color = beard.Color;
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.setHorizontalFlipping(true);
		body_blood.Visible = false;
		local body_dirt = this.addSprite("dirt");
		body_dirt.setBrush("bust_body_dirt_02");
		body_dirt.setHorizontalFlipping(true);
		body_dirt.Visible = ::Math.rand(1, 100) <= 33;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.m.Skills.add(::new("scripts/skills/special/double_grip"));
		this.m.Skills.add(::new("scripts/skills/racial/vampire_racial"));
		this.m.Skills.add(::new("scripts/skills/actives/darkflight"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes")); // replaced by enemy cleaver perk group
		this.m.Skills.add(::new("scripts/skills/perks/perk_nine_lives"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.Human;
		this.m.Skills.add(::new("scripts/skills/perks/perk_head_hunter"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sanguinary"));
	}

	q.onUpdateInjuryLayer = @() function()
	{
		local p = this.getHitpointsPct();
		local bodyBrush = this.getSprite("body").getBrush().Name;
		local headBrush = this.getSprite("head").getBrush().Name;
		local vampire_blood_head_brush = this.getSprite("rf_vampire_blood_head").getBrush().Name;

		if (p <= 0.33)
		{
			this.getSprite("body").setBrush(this.m.BodySprites[2]);
			this.getSprite("body_injury").setBrush("bust_skeleton_body_03_injured");
			this.getSprite("head").setBrush(this.m.HeadSprites[2]);
			this.getSprite("injury").setBrush("bust_skeleton_head_03_injured");
			if (this.m.VampireBloodHeadSprites[2].find(vampire_blood_head_brush) == null)
				this.getSprite("rf_vampire_blood_head").setBrush(::MSU.Array.rand(this.m.VampireBloodHeadSprites[2]));
		}
		else if (p <= 0.66)
		{
			this.getSprite("body").setBrush(this.m.BodySprites[1]);
			this.getSprite("body_injury").setBrush("bust_skeleton_body_04_injured");
			this.getSprite("head").setBrush(this.m.HeadSprites[1]);
			this.getSprite("injury").setBrush("bust_skeleton_head_04_injured");
			if (this.m.VampireBloodHeadSprites[1].find(vampire_blood_head_brush) == null)
				this.getSprite("rf_vampire_blood_head").setBrush(::MSU.Array.rand(this.m.VampireBloodHeadSprites[1]));
		}
		else
		{
			this.getSprite("body").setBrush(this.m.BodySprites[0]);
			this.getSprite("body_injury").setBrush("bust_skeleton_body_05_injured");
			this.getSprite("head").setBrush(this.m.HeadSprites[0]);
			this.getSprite("injury").setBrush("bust_skeleton_head_05_injured");
			if (this.m.VampireBloodHeadSprites[0].find(vampire_blood_head_brush) == null)
				this.getSprite("rf_vampire_blood_head").setBrush(::MSU.Array.rand(this.m.VampireBloodHeadSprites[0]));
		}

		this.getSprite("body_injury").Visible = this.m.WasInjured;
		this.getSprite("injury").Visible = this.m.WasInjured;
		local racial = this.getSkills().getSkillByID("racial.vampire");
		this.getSprite("rf_vampire_blood_head").Visible = racial != null && racial.m.RF_HasFed;

		if (bodyBrush != this.getSprite("body").getBrush().Name)
		{
			local old_body = this.getSprite("old_body");
			old_body.Visible = true;
			old_body.Alpha = 255;
			old_body.setBrush(bodyBrush);
			old_body.fadeOutAndHide(3000);
			local old_head = this.getSprite("old_head");
			old_head.Visible = true;
			old_head.Alpha = 255;
			old_head.setBrush(headBrush);
			old_head.fadeOutAndHide(3000);
			local old_vampire_blood_head = this.getSprite("old_rf_vampire_blood_head");
			old_vampire_blood_head.Visible = true;
			old_vampire_blood_head.Alpha = 255;
			old_vampire_blood_head.setBrush(vampire_blood_head_brush);
			old_vampire_blood_head.fadeOutAndHide(3000);
		}

		this.setDirty(true);
	}

	q.onFactionChanged = @(__original) function()
	{
		__original();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("rf_vampire_blood_head").setHorizontalFlipping(flip);
		this.getSprite("old_rf_vampire_blood_head").setHorizontalFlipping(flip);
	}

	q.onDeath = @(__original) function( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null && ::Math.rand(1, 100) <= 20)
		{
			local loot = ::new("scripts/items/loot/signet_ring_item");
			loot.drop(_tile);
		}
		__original(_killer, _skill, _tile, _fatalityType);
	}

	q.onSpawned = @() function()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
		}
	}
});
