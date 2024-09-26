::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_spear", function(q) {
	q.m.IsSpent <- true;
	q.m.DamageTotalMult <- 0.75;

	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = ::Const.Perks.findById(this.getID()).Icon; // Vanilla uses the wrong icon i.e. `perk_10.png` which is the Anticipation icon.
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("This character has mastered the art of fighting with the spear allowing him to attack for free once per [turn.|Concept.Turn]");
	}

	q.isHidden = @() function()
	{
		return this.m.IsSpent;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The next spear attack costs " + ::MSU.Text.colorPositive("0") + " [Action Points|Concept.ActionPoints] and builds " + ::MSU.Text.colorPositive("0") + " [Fatigue|Concept.Fatigue] but does " + ::MSU.Text.colorizeMult(this.m.DamageTotalMult) + " less damage")
		});
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "Will expire upon switching your weapon!"
		});

		return ret;
	}

	q.onAfterUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		local spearwall = this.getContainer().getSkillByID("actives.spearwall");
		if (spearwall != null && spearwall.m.ActionPointCost > 0)
			spearwall.m.ActionPointCost -= 1;

		if (this.m.IsSpent)
			return;

		local actor = this.getContainer().getActor();

		if (!actor.isPreviewing() || actor.getPreviewMovement() != null || !this.isSkillValid(actor.getPreviewSkill()))
		{
			foreach (skill in this.getContainer().m.Skills)
			{
				if (this.isSkillValid(skill))
				{
					skill.m.ActionPointCost = 0;
					skill.m.FatigueCostMult *= 0;
				}
			}
		}
	}

	q.onAnySkillExecuted = @(__original) function( _skill, _targetTile, _targetEntity, _forFree )
	{
		__original(_skill, _targetTile, _targetEntity, _forFree);

		if (this.isSkillValid(_skill) && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
			this.m.IsSpent = true;
	}

	q.onPayForItemAction = @(__original) function( _skill, _items )
	{
		__original(_skill, _items);

		foreach (item in _items)
		{
			if (item != null && item.getSlotType() == ::Const.ItemSlot.Mainhand)
			{
				this.m.IsSpent = true;
				return;
			}
		}
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		if (!this.m.IsSpent && this.isSkillValid(_skill) && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
			_properties.DamageTotalMult *= this.m.DamageTotalMult;
	}

	q.onTurnStart = @(__original) function()
	{
		__original();

		local actor = this.getContainer().getActor();
		if (actor.isDisarmed())
			return;

		local weapon = actor.getMainhandItem();
		if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Spear))
			this.m.IsSpent = false;
	}

	q.onCombatFinished = @(__original) function()
	{
		__original();
		this.m.IsSpent = true;
	}

	q.isSkillValid <- function( _skill )
	{
		if (_skill.isRanged() || !_skill.isAttack())
			return false;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Spear);
	}
});
