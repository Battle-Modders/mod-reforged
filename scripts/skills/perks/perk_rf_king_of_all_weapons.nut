this.perk_rf_king_of_all_weapons <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		IsSpent = true,
		Skills = [
			"actives.thrust",
			"actives.prong"
		]
	},
	function create()
	{
		this.m.ID = "perk.rf_king_of_all_weapons";
		this.m.Name = ::Const.Strings.PerkName.RF_KingOfAllWeapons;
		this.m.Description = "This character is exceptionally skilled with the spear, which is known by many to be the king of all weapons.";
		this.m.Icon = "ui/perks/rf_king_of_all_weapons.png";
		this.m.IconMini = "rf_king_of_all_weapons_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled)
			return true;

		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Spear);
	}

	function isHidden()
	{
		return this.m.IsSpent || !this.isEnabled();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The next [Thrust|Skill+thrust] or [Prong|Skill+prong_skill] during your [turn|Concept.Turn] will target the body part with the lowest armor")
		});

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		if (!this.isEnabled())
			return;

		local perk = this;
		foreach (skill in this.getContainer().getSkillsByFunction((@(s) perk.m.Skills.find(s.getID()) != null && s.m.ActionPointCost > 1)))
		{
			skill.m.ActionPointCost -= 1;
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_targetEntity != null && this.m.Skills.find(_skill.getID()) != null && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()) && this.isEnabled())
		{
			this.m.IsSpent = true;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!this.m.IsSpent && this.m.Skills.find(_skill.getID()) != null && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()) && this.isEnabled())
		{
			local headArmor = _targetEntity.getArmor(::Const.BodyPart.Head);
			local bodyArmor = _targetEntity.getArmor(::Const.BodyPart.Body);
			if (headArmor < bodyArmor)
				_properties.HitChanceMult[::Const.BodyPart.Body] = 0.0;
			else if (bodyArmor < headArmor)
				_properties.HitChanceMult[::Const.BodyPart.Head] = 0.0;
		}
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = true;
	}
});
