this.rf_follow_up_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_follow_up";
		this.m.Name = "Follow Up";
		this.m.Description = "Prepare to attack any target in your attack range who gets hit by an ally.";
		this.m.Icon = "skills/rf_follow_up_skill.png";
		this.m.IconDisabled = "skills/rf_follow_up_skill_sw.png";
		this.m.Overlay = "rf_follow_up_skill";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 30;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_FollowUp;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "The damage dealt is reduced by " + ::MSU.Text.colorNegative("30%") + " and by an additional " + ::MSU.Text.colorNegative("10%") + " for every next attack up to a maximum of " + ::MSU.Text.colorNegative("90%")
		});

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Cannot be used while [engaged|Concept.ZoneOfControl] in melee"))
			});
		}

		if (!this.isEnabled())
		{
			ret.push({
				id = 21,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Only usable with Two-Handed Melee weapons")
			});
		}

		return ret;
	}

	function isEnabled()
	{
		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isItemType(::Const.Items.ItemType.TwoHanded) || !weapon.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			return false;
		}

		return true;
	}

	function isUsable()
	{
		return !this.getContainer().getActor().isEngagedInMelee() && this.skill.isUsable() && this.isEnabled() && !this.getContainer().hasSkill("effects.rf_follow_up");
	}

	function isHidden()
	{
		return !this.getContainer().getActor().isArmedWithMeleeWeapon();
	}

	function onUse( _user, _targetTile )
	{
		this.getContainer().add(::new("scripts/skills/effects/rf_follow_up_effect"));
		return true;
	}
});
