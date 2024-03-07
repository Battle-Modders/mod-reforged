this.rf_dynamic_duo_partner <- ::inherit("scripts/skills/skill", {
	m = {
		PartnerSkill = null
	},
	function create()
	{
		this.m.ID = "special.rf_dynamic_duo_partner";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsSerialized = true;
	}

	function setPartner( _skill )
	{
		if (_skill == null)
		{
			if (!::MSU.isNull(this.m.PartnerSkill))
				this.m.PartnerSkill.setPartner(null);

			this.m.PartnerSkill = null;
			return;
		}

		this.m.PartnerSkill = ::MSU.asWeakTableRef(_skill);
		this.getContainer().getActor().getFlags().set("RF_DynamicDuoPartner", _skill.getContainer().getActor().getPlaceInFormation());
	}

	function onRemoved()
	{
		this.setPartner(null);
	}

	function onDeath( _fatalityType )
	{
		this.setPartner(null);
	}

	function onDismiss()
	{
		this.setPartner(null);
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		if (!::MSU.isNull(this.m.PartnerSkill))
		{
			_out.writeBool(true);
			_out.writeU8(this.m.PartnerSkill.getContainer().getActor().getPlaceInFormation());
			// this.getContainer().getActor().getFlags().set("RF_DynamicDuoPartner", this.m.PartnerSkill.getContainer().getActor().getPlaceInFormation());
		}
		else
		{
			_out.writeBool(false);
		}
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);

		local hasPartner = _in.readBool();
		if (hasPartner)
		{
			local partnerPlace = _in.readU8();
			foreach (bro in ::World.getPlayerRoster().getAll())
			{
				if (bro.getPlaceInFormation() == partnerPlace)
				{
					this.m.PartnerSkill = ::MSU.asWeakTableRef(bro.getSkills().getSkillByID("perk.rf_dynamic_duo"));
					this.m.PartnerSkill.setPartner(this);
					break;
				}
			}
		}

		// if (this.getContainer().getActor().getFlags().has("RF_DynamicDuoPartner"))
		// {
		// 	local partnerPlace = this.getContainer().getActor().getFlags().get("RF_DynamicDuoPartner");
		// 	foreach (bro in ::World.getPlayerRoster().getAll())
		// 	{
		// 		if (bro.getPlaceInFormation() == partnerPlace)
		// 		{
		// 			this.m.PartnerSkill = ::MSU.asWeakTableRef(bro.getSkills().getSkillByID("perk.rf_dynamic_duo"));
		// 			this.m.PartnerSkill.setPartner(this);
		// 			break;
		// 		}
		// 	}
		// }
	}
});
