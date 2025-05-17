this.perk_rf_angler <- ::inherit("scripts/skills/skill", {
	m = {
		BreakFreeAPCostMult = 1.5,
		MaxDistanceForAPCostMult = 2
	},
	function create()
	{
		this.m.ID = "perk.rf_angler";
		this.m.Name = ::Const.Strings.PerkName.RF_Angler;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Angler;
		this.m.Icon = "ui/perks/perk_rf_angler.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.getID() == "actives.throw_net" && _targetTile.getDistanceTo(this.getContainer().getActor().getTile()) <= this.m.MaxDistanceForAPCostMult)
		{
			local breakFreeSkill = _targetEntity.getSkills().getSkillByID("actives.break_free");
			if (breakFreeSkill != null)
			{
				breakFreeSkill.setBaseValue("ActionPointCost", ::Math.floor(breakFreeSkill.getBaseValue("ActionPointCost") * this.m.BreakFreeAPCostMult));
			}
		}
	}

	function onAfterUpdate( _properties )
	{
		local throwNet = this.getSkills().getSkillByID("actives.throw_net");
		if (throwNet != null && throwNet.m.MaxRange < 3)
		{
			throwNet.m.MaxRange += 1;
		}
	}

	function onAdded()
	{
		local offhand = this.getContainer().getActor().getOffhandItem();
		if (offhand != null) this.onEquip(offhand);
	}

	function onEquip( _item )
	{
		if (_item.getSlotType() == ::Const.ItemSlot.Offhand && this.getContainer().hasSkill("actives.throw_net"))
		{
			_item.addSkill(::new("scripts/skills/actives/rf_net_pull_skill"));
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.getID() == "actives.throw_net")
		{
			_tooltip.push({
				id = 100,
				type = "text",
				icon = this.getIconColored(),
				text = ::Reforged.Mod.Tooltips.parseString("When used at a distance of " + this.m.MaxDistanceForAPCostMult + " or fewer tiles the target must spend " + ::MSU.Text.colorizeMultWithText(this.m.BreakFreeAPCostMult) + " [Action Points|Concept.ActionPoints] to [break free|Skill+break_free_skill]")
			});
		}
	}
});
