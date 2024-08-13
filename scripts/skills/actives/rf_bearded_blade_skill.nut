this.rf_bearded_blade_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_bearded_blade";
		this.m.Name = "Bearded Blade";
		this.m.Description = "Prepare to use the bearded blade of your axe to disarm your opponent.";
		this.m.Icon = "skills/rf_bearded_blade_skill.png";
		this.m.IconDisabled = "skills/rf_bearded_blade_skill_sw.png";
		this.m.Overlay = "rf_bearded_blade_skill";
		this.m.SoundOnUse = [
			"sounds/combat/riposte_01.wav",
			"sounds/combat/riposte_02.wav",
			"sounds/combat/riposte_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 15;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Gain the [Bearded Blade|Skill+rf_bearded_blade_effect] effect that allows you to [Disarm|Skill+disarmed_effect] your opponents")
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInAxes ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.rf_bearded_blade");
	}

	function onUse( _user, _targetTile )
	{
		this.m.Container.add(::new("scripts/skills/effects/rf_bearded_blade_effect"));

		if (!_user.isHiddenToPlayer())
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses Bearded Blade");
		}

		return true;
	}

	function onRemoved()
	{
		this.m.Container.removeByID("effects.rf_bearded_blade");
	}
});
