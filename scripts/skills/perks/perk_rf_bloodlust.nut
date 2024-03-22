this.perk_rf_bloodlust <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		RequiresWeapon = true,
		Stacks = 0,
		MultPerStack = 0.25
	},
	function create()
	{
		this.m.ID = "perk.rf_bloodlust";
		this.m.Name = ::Const.Strings.PerkName.RF_Bloodlust;
		this.m.Description = "This character gains increased vigor when inflicting fatalities.";
		this.m.Icon = "ui/perks/rf_bloodlust.png";
		this.m.IconMini = "rf_bloodlust_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.Stacks == 0 || !this.isEnabled();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local mult = 1.0 + (this.m.Stacks * this.m.MultPerStack);
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/resolve.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(mult) + " increased [Resolve|Concept.Bravery]")
		});
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(mult) + " increased [Initiative|Concept.Initiative]")
		});
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::Reforged.Mod.Tooltips.parseString("Skills build up " + ::MSU.Text.colorizeMult(2.0 - mult, {InvertColor = true}) + " less [Fatigue Cost|Concept.Fatigue]")
		});
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("These effects are reduced by -" + (this.m.MultPerStack * 100) "% every [turn|Concept.Turn] until another fatality")
		});
		return ret;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled || !this.m.RequiresWeapon)
			return true;

		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Cleaver);
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		if (_fatalityType != ::Const.FatalityType.None && _killer != null && _killer.getID() == this.getContainer().getActor().getID() && this.isEnabled())
		{
			this.m.Stacks = 2;
		}
	}

	function onUpdate( _properties )
	{
		if (this.m.Stacks == 0 || !this.isEnabled())
			return;

		local mult = this.m.MultPerStack * this.m.Stacks;
		_properties.BraveryMult *= 1.0 + mult;
		_properties.InitiativeMult *= 1.0 + mult;
	}

	function onAfterUpdate( _properties )
	{
		if (this.m.Stacks == 0 || !this.isEnabled())
			return;

		foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
		{
			skill.m.FatigueCostMult *= 1.0 - (this.m.MultPerStack * this.m.Stacks);
		}
	}

	function onTurnEnd()
	{
		this.m.Stacks--;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
	}
});
