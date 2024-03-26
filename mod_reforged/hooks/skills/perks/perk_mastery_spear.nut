::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_spear", function(q) {
	q.m.IsSpent <- true;
	q.m.DamageMult <- 0.75;
	q.m.Skills <- [
		"actives.thrust",
		"actives.prong"
	];

	q.create = @(__original) function()
	{
		__original();
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("This character has mastered the art of fighting with the spear allowing him to attack for free once per [turn|Concept.Turn].");
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
			text = ::Reforged.Mod.Tooltips.parseString("The next [Thrust|Skill+thrust] or [Prong|Skill+prong_skill] costs " + ::MSU.Text.colorGreen("0") + " [Action Points|Concept.ActionPoints], builds " + ::MSU.Text.colorGreen("0") + " [Fatigue|Concept.Fatigue] but does " + ::MSU.Text.colorizeMult(this.m.DamageMult) + " reduced damage")
		});
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::MSU.Text.colorRed("Will expire upon switching your weapon!")
		});

		return ret;
	}

	q.onAfterUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		local spearwall = this.getContainer().getSkillByID("actives.spearwall");
		if (spearwall != null && spearwall.m.ActionPointCost > 1)
			spearwall.m.ActionPointCost -= 1;

		local perk = this;
		foreach (skill in this.getContainer().getSkillsByFunction((@(s) perk.m.Skills.find(s.getID()) != null)))
		{
			skill.m.ActionPointCost = 0;
			skill.m.FatigueCostMult *= 0;
		}
	}

	q.onAffordablePreview = @(__original) function( _skill, _movementTile )
	{
		__original(_skill, _movementTile);

		if (_skill != null)
		{
			local perk = this;
			foreach (skill in this.getContainer().getSkillsByFunction((@(s) perk.m.Skills.find(s.getID()) != null)))
			{
				this.modifyPreviewField(skill, "ActionPointCost", 0, false);
				this.modifyPreviewField(skill, "FatigueCostMult", 1, true);
			}
		}
	}

	q.onAnySkillExecuted = @(__original) function( _skill, _targetTile, _targetEntity, _forFree )
	{
		__original(_skill, _targetTile, _targetEntity, _forFree);

		if (_targetEntity != null && this.m.Skills.find(_skill.getID()) != null && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			this.m.IsSpent = true;
		}
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

		if (!this.m.IsSpent && this.m.Skills.find(_skill.getID()) != null && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			_properties.MeleeDamageMult *= this.m.DamageMult;
		}
	}

	q.onTurnStart = @(__original) function()
	{
		__original();

		if (this.isEnabled())
			this.m.IsSpent = false;
	}

	q.onCombatFinished = @(__original) function()
	{
		__original();
		this.m.IsSpent = true;
	}
});
