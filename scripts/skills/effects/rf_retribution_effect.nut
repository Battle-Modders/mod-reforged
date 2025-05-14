this.rf_retribution_effect <- ::inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		MaximumStackSize = 1,
		BonusPerStack = 25
	},
	function create()
	{
		this.m.ID = "effects.rf_retribution";
		this.m.Name = "Retribution";
		this.m.Description = "This character hits significantly harder after taking a hit from an enemy.";
		this.m.Icon = "ui/perks/perk_rf_retribution.png";
		this.m.IconMini = "";	// A mini-icon would be useful
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsRemovedAfterBattle = true;
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		if (::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()))
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::MSU.Text.colorPositive((this.m.BonusPerStack) + "%") + " more damage dealt"
			});
		}
		else
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::MSU.Text.colorPositive((this.m.Stacks * this.m.BonusPerStack) + "%") + " more damage dealt"
			});
		}

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire upon performing an attack or ending the [turn|Concept.Turn]")
		});

		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 1.0 + this.m.Stacks * this.m.BonusPerStack * 0.01;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor();
		if (_attacker == null || _attacker.getID() == actor.getID() || _attacker.isAlliedWith(actor))
			return;

		this.m.Stacks = ::Math.min(this.m.MaximumStackSize, this.m.Stacks + 1);
	}

	function onAnySkillExecutedFully( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.isAttack())
		{
			this.m.Stacks = 0;
		}
	}

	function onTurnEnd()
	{
		this.m.Stacks = 0;
	}
});
