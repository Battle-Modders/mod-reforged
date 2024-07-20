this.perk_rf_fencer <- ::inherit("scripts/skills/skill", {
	m = {
		FatigueMult = 0.80,
		Bonus = 10
	},
	function create()
	{
		this.m.ID = "perk.rf_fencer";
		this.m.Name = ::Const.Strings.PerkName.RF_Fencer;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Fencer;
		this.m.Icon = "ui/perks/rf_fencer.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Any;
	}

	function isEnabled()
	{
		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isItemType(::Const.Items.ItemType.RF_Fencing))
		{
			return false;
		}

		return true;
	}

	function onAfterUpdate( _properties )
	{
		if (!this.isEnabled()) return;

		local weapon = this.getContainer().getActor().getMainhandItem();

		foreach (skill in weapon.getSkills())
		{
			skill.m.FatigueCostMult *= this.m.FatigueMult;

			if (weapon.isItemType(::Const.Items.ItemType.OneHanded)) skill.m.ActionPointCost -= 1;
			else if (skill.getID() == "actives.lunge")
			{
				skill.m.MaxRange += 1;
				skill.m.Description = "A swift lunge towards a target up to 3 tiles away, followed by a precise thrusting attack to catch them unprepared. The faster you are, the more damage you do.";
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!this.getContainer().getActor().isPlayerControlled() || !this.isEnabled())
		{
			return;
		}

		if (_skill.getID() == "actives.lunge" || _skill.getID() == "actives.rf_sword_thrust")
		{
			_properties.MeleeSkill += this.m.Bonus;
			_skill.m.HitChanceBonus += this.m.Bonus;
		}
	}
});

