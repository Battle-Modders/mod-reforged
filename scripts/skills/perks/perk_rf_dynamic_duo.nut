this.perk_rf_dynamic_duo <- ::inherit("scripts/skills/perks/perk_rf_dynamic_duo_abstract", {
	m = {},
	function create()
	{
		this.perk_rf_dynamic_duo_abstract.create();
		this.m.ID = "perk.rf_dynamic_duo";
	}

	function setPartnerSkill( _skill )
	{
		this.perk_rf_dynamic_duo_abstract.setPartnerSkill(_skill);
		if (_skill == null)
		{
			this.getContainer().add(::new("scripts/skills/actives/rf_dynamic_duo_select_partner_skill"));
			this.getContainer().removeByID("actives.rf_dynamic_duo_shuffle");
		}
	}

	function onAdded()
	{
		this.perk_rf_dynamic_duo_abstract.onAdded();
		if (!this.getContainer().getActor().getFlags().has("RF_IsDynamicDuo"))
			this.getContainer().add(::new("scripts/skills/actives/rf_dynamic_duo_select_partner_skill"));
	}

	function onRemoved()
	{
		this.perk_rf_dynamic_duo_abstract.onRemoved();
		this.getContainer().removeByID("actives.rf_dynamic_duo_select_partner");
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
					this.m.PartnerSkill = ::MSU.asWeakTableRef(bro.getSkills().getSkillByID("effects.rf_dynamic_duo_partner"));
					this.m.PartnerSkill.setPartnerSkill(this);
					break;
				}
			}
		}
	}
});
