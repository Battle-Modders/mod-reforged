this.perk_rf_angler <- ::inherit("scripts/skills/skill", {
	m = {
		BreakFreeAPCostMult = 1.5
	},
	function create()
	{
		this.m.ID = "perk.rf_angler";
		this.m.Name = ::Const.Strings.PerkName.RF_Angler;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Angler;
		this.m.Icon = "ui/perks/rf_angler.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.getID() == "actives.throw_net")
		{
			local breakFreeSkill = _targetEntity.getSkills().getSkillByID("actives.break_free");
			breakFreeSkill.setBaseValue("ActionPointCost", ::Math.floor(breakFreeSkill.getBaseValue("ActionPointCost") * this.m.BreakFreeAPCostMult));
		}
	}

	function onEquip( _item )
	{
		if (_item.getSlotType() == ::Const.ItemSlot.Offhand && this.getContainer().hasSkill("actives.throw_net"))
		{
			_item.addSkill(::new("scripts/skills/actives/rf_net_pull_skill"));
		}
	}
});
