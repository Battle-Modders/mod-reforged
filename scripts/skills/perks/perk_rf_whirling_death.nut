this.perk_rf_whirling_death <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		Chance = 33,
		Stacks = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_whirling_death";
		this.m.Name = ::Const.Strings.PerkName.RF_WhirlingDeath;
		this.m.Description = ::Const.Strings.PerkDescription.RF_WhirlingDeath;
		this.m.Icon = "ui/perks/rf_whirling_death.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/reach.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.Stacks) + " [Reach|Concept.Reach]")
		});
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = ::MSU.Text.colorRed("Will expire upon swapping your weapon")
		});

		return ret;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();		
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Flail))
		{
			return false;
		}

		return true;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.isAttack() && _skill.m.IsWeaponSkill && this.isEnabled())
			this.m.Stacks++;
	}

	function onTurnStart()
	{
		this.m.Stacks = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
	}

	function onPayForItemAction( _skill, _items )
	{
		foreach (item in _items)
		{
			if (_item != null && _item.getSlotType() == ::Const.ItemSlot.Mainhand)
			{
				this.m.Stacks = 0;
				return;
			}
		}
	}
	
	function onMovementFinished( _tile )
	{
		if (!this.isEnabled() || ::Math.rand(1, 100) > this.m.Chance)
			return;

		local aoo = this.getContainer().getAttackOfOpportunity();
		if (aoo == null)
			return;

		local actor = this.getContainer().getActor();
		local targetTiles = [];
		for (local i = 0; i < 6; i++)
		{
			if (!_tile.hasNextTile(i))
				continue;

			local nextTile = _tile.getNextTile();
			if (!nextTile.IsOccupiedByActor)
				continue;

			local entity = nextTile.getEntity();
			if (!entity.isAlliedWith(actor) && entity.getCurrentProperties().getReach() < actor.getCurrentProperties().getReach())
				targetTiles.push(nextTile);
		}

		if (targetTiles.len() == 0)
			return;

		aoo.useForFree(::MSU.Array.rand(targetTiles));
	}
});

