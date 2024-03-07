this.rf_dynamic_duo_select_partner_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_dynamic_duo_select_partner";
		this.m.Name = "Select Partner";
		this.m.Description = "Select a partner for your Dynamic Duo perk."
		this.m.Icon = "skills/rf_dynamic_duo_select_partner_skill.png";
		this.m.IconDisabled = "skills/rf_dynamic_duo_select_partner_skill_sw.png";
		this.m.Overlay = "rf_dynamic_duo_select_partner_skill";
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 99;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::MSU.Text.colorRed("The selected partner will remain your partner until one of you dies or leaves the company")
		});
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.getEntity().getFaction() == this.getContainer().getActor().getFaction() && !_targetTile.getEntity().getSkills().hasSkill("perk.rf_dynamic_duo");
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		// local skill = ::new("scripts/skills/special/rf_dynamic_duo_partner");
		// target.getSkills().add(skill);
		local targetPerk = target.getSkills().getSkillByID("perk.rf_dynamic_duo");
		if (targetPerk == null)
		{
			targetPerk = ::new("scripts/skills/perks/perk_rf_dynamic_duo");
			targetPerk.m.IsRefundable = false;
			target.getSkills().add(targetPerk);
		}

		local myPerk = _user.getSkills().getSkillByID("perk.rf_dynamic_duo");
		myPerk.setPartnerSkill(targetPerk);
		targetPerk.setPartnerSkill(myPerk);

		return true;
	}
});
