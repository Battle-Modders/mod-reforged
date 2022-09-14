this.perk_rf_vengeful_spite <- ::inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		BonusPerStack = 5
	},
	function create()
	{
		this.m.ID = "perk.rf_vengeful_spite";
		this.m.Name = ::Const.Strings.PerkName.RF_VengefulSpite;
		this.m.Description = "This character deals increasingly more damage as allies die nearby.";
		this.m.Icon = "ui/perks/rf_vengeful_spite.png";
		this.m.IconMini = "rf_vengeful_spite_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getName()
	{
		return this.m.Stacks > 0 ? this.m.Name + " (x" + this.m.Stacks + ")" : this.m.Name;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]" + this.getBonus() + "%[/color] increased damage dealt"
		});

		return tooltip;
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		local actor = this.getContainer().getActor();
		if (_victim.getFaction() == actor.getFaction() && _deathTile.getDistanceTo(actor.getTile()) == 1)
		{
			this.m.Stacks++;
		}
	}

	function getBonus()
	{
		return this.m.Stacks * this.m.BonusPerStack;
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 1.0 + this.getBonus() * 0.01;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
	}
});
