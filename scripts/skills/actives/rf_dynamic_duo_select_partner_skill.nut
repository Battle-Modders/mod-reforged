this.rf_dynamic_duo_select_partner_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_dynamic_duo_select_partner";
		this.m.Name = "Select Partner";
		this.m.Description = "Select a partner for your Dynamic Duo perk."
		this.m.Icon = "skills/rf_dynamic_duo_select_partner_skill.png";
		this.m.IconDisabled = "skills/rf_dynamic_duo_select_partner_skill_sw.png";
		// this.m.Overlay = "rf_dynamic_duo_select_partner_skill"; // No need to spawn an overlay for this skill.
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.NonTargeted; // We want it to appear after other "more useful" skills
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 99;
		this.m.IsVisibleTileNeeded = false;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "The selected character will remain your partner until one of you dies or leaves the company"
		});
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.getEntity().getFaction() == this.getContainer().getActor().getFaction() && !_targetTile.getEntity().getFlags().has("RF_IsDynamicDuo");
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		local partnerSkill = ::new("scripts/skills/effects/rf_dynamic_duo_partner_effect");
		target.getSkills().add(partnerSkill);

		local myPerk = _user.getSkills().getSkillByID("perk.rf_dynamic_duo");
		myPerk.setPartnerSkill(partnerSkill);
		partnerSkill.setPartnerSkill(myPerk);

		return true;
	}
});
