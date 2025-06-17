this.rf_dynamic_duo_partner_effect <- ::inherit("scripts/skills/perks/perk_rf_dynamic_duo_abstract", {
	m = {},
	function create()
	{
		this.perk_rf_dynamic_duo_abstract.create();
		this.m.ID = "effects.rf_dynamic_duo_partner";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Overlay = "rf_dynamic_duo_partner_effect";
	}

	function onPartnerRemoved()
	{
		this.perk_rf_dynamic_duo_abstract.onPartnerRemoved();
		local perk = this.getContainer().getSkillByID("perk.rf_dynamic_duo");
		if (perk != null)
			perk.onPartnerRemoved(); // So that it adds the select partner skill to the actor

		this.getContainer().remove(this); // instead of this.removeSelf() so that it is removed immediately instead of waiting for next update
	}

	function onDeserialize( _in )
	{
		this.perk_rf_dynamic_duo_abstract.onDeserialize(_in);

		local hasPartner = _in.readBool();
		if (hasPartner)
		{
			local partner = ::MSU.getEntityByUID(_in.readI32());
			if (partner != null)
			{
				this.m.PartnerSkill = ::MSU.asWeakTableRef(partner.getSkills().getSkillByID("perk.rf_dynamic_duo"));
				this.m.PartnerSkill.setPartnerSkill(this);
			}
		}
	}
});
