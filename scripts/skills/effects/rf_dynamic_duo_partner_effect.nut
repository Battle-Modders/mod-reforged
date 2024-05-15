this.rf_dynamic_duo_partner_effect <- ::inherit("scripts/skills/perks/perk_rf_dynamic_duo_abstract", {
	m = {},
	function create()
	{
		this.perk_rf_dynamic_duo_abstract.create();
		this.m.ID = "effects.rf_dynamic_duo_partner";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Overlay = "rf_dynamic_duo_partner_effect";
	}

	function setPartnerSkill( _skill )
	{
		this.perk_rf_dynamic_duo_abstract.setPartnerSkill(_skill);
		if (_skill == null)
		{
			local perk = this.getContainer().getSkillByID("perk.rf_dynamic_duo");
			if (perk != null)
				perk.setPartnerSkill(null);
		}
	}

	function onDeserialize( _in )
	{
		this.perk_rf_dynamic_duo_abstract.onDeserialize(_in);

		local hasPartner = _in.readBool();
		if (hasPartner)
		{
			local partnerPlace = _in.readU8();
			foreach (bro in ::World.getPlayerRoster().getAll())
			{
				if (bro.getPlaceInFormation() == partnerPlace)
				{
					this.m.PartnerSkill = ::MSU.asWeakTableRef(bro.getSkills().getSkillByID("perk.rf_dynamic_duo"));
					this.m.PartnerSkill.setPartnerSkill(this);
					break;
				}
			}
		}
	}
});
