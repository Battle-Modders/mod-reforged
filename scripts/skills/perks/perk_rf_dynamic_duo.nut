this.perk_rf_dynamic_duo <- ::inherit("scripts/skills/skill", {
	m = {
		PartnerSkill = null,
		AttackBonusEnemies = [],
		DefenseBonusEnemies = []
	},
	function create()
	{
		this.m.ID = "perk.rf_dynamic_duo";
		this.m.Name = ::Const.Strings.PerkName.RF_DynamicDuo;
		this.m.Description = "Instead of fighting in a larger formation, this character has trained to fight as a duo and gains bonuses while there is only one nearby ally."
		this.m.Icon = "ui/perks/rf_dynamic_duo.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (::MSU.isNull(this.m.PartnerSkill))
			return false;

		local actor = this.getContainer().getActor();
		local partner = this.m.PartnerSkill.getContainer().getActor();
		if (!actor.isPlacedOnMap() || !partner.isPlacedOnMap())
			return false;

		local myTile = actor.getTile();
		local partnerTile = partner.getTile();
		if (myTile.getDistanceTo(partnerTile) > 1)
			return false;

		for (local i = 0; i < 6; i++)
		{
			if (myTile.hasNextTile(i))
			{
				local nextTile = myTile.getNextTile(i);
				if (nextTile.IsOccupiedByActor)
				{
					local entity = nextTile.getEntity();
					if (entity.getFaction() == actor.getFaction() && entity.getID() != partner.getID())
						return false;
				}
			}
			if (partnerTile.hasNextTile(i))
			{
				local nextTile = partnerTile.getNextTile(i);
				if (nextTile.IsOccupiedByActor)
				{
					local entity = nextTile.getEntity();
					if (entity.getFaction() == actor.getFaction() && entity.getID() != actor.getID())
						return false;
				}
			}
		}

		return true;
	}

	function isHidden()
	{
		return !this.isEnabled();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Partner: " + this.m.PartnerSkill.getContainer().getActor().getName()
		});

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::MSU.Text.colorGreen("+20") + " Resolve"
		});

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::MSU.Text.colorGreen("+20") + " Initiative"
		});

		return ret;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_dynamic_duo_select_partner_skill"));
	}

	function setPartnerSkill( _skill )
	{
		if (_skill == null)
		{
			if (!::MSU.isNull(this.m.PartnerSkill))
			{
				local partnerSkill = this.m.PartnerSkill;
				this.m.PartnerSkill = null;
				partnerSkill.setPartnerSkill(null);
			}

			this.m.PartnerSkill = null;
			this.getContainer().add(::new("scripts/skills/actives/rf_dynamic_duo_select_partner_skill"));
			this.getContainer().removeByID("actives.rf_dynamic_duo_shuffle");
			return;
		}

		this.m.PartnerSkill = ::MSU.asWeakTableRef(_skill);
		this.getContainer().removeByID("actives.rf_dynamic_duo_select_partner");
		local shuffle = ::new("scripts/skills/actives/rf_dynamic_duo_shuffle_skill");
		shuffle.m.DynamicDuoPerk = ::MSU.asWeakTableRef(this);
		this.getContainer().add(shuffle);
	}

	function getPartner()
	{
		return ::MSU.isNull(this.m.PartnerSkill) ? null : this.m.PartnerSkill.getContainer().getActor();
	}

	function onUpdate( _properties )
	{
		if (this.isEnabled())
		{
			_properties.Bravery += 20;
			_properties.Initiative += 20;
		}
	}

	function onRemoved()
	{
		this.setPartnerSkill(null);
		this.getContainer().removeByID("actives.rf_dynamic_duo_select_partner");
	}

	function onDeath( _fatalityType )
	{
		this.setPartnerSkill(null);
	}

	function onDismiss()
	{
		this.setPartnerSkill(null);
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		if (!::MSU.isNull(this.m.PartnerSkill))
		{
			_out.writeBool(true);
			_out.writeU8(this.m.PartnerSkill.getContainer().getActor().getPlaceInFormation());
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
					this.m.PartnerSkill = ::MSU.asWeakTableRef(bro.getSkills().getSkillByID(this.getID()));
					this.m.PartnerSkill.setPartnerSkill(this);
					break;
				}
			}
		}
	}
});
