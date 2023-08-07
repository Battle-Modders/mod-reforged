this.perk_rf_guardian <- ::inherit("scripts/skills/skill", {
	m = {
		RangedDefenseBonus = 10
	},
	function create()
	{
		this.m.ID = "perk.rf_guardian";
		this.m.Name = ::Const.Strings.PerkName.RF_Guardian;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Guardian;
		this.m.Icon = "ui/perks/rf_phalanx.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onAdded()
	{
		this.skill.onAdded();
		local shield = this.getContainer().getActor().getOffhandItem();
		if (shield != null) this.onEquip(shield);
	}

	function onAfterUpdate( _properties )
	{
		if (this.getContainer().getActor().isEngagedInMelee()) return;

		foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
		{
			if (skill.getID() == "actives.shieldwall" || skill.getID() == "actives.rf_cover_ally")
			{
				skill.m.ActionPointCost -= 1;
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.getID() == "actives.shieldwall")
		{
			local actor = this.getContainer().getActor();
			local allies = ::Tactical.Entities.getFactionActors(actor.getFaction(), actor.getTile(), 1, true);
			foreach (ally in allies)
			{
				if (ally.isEngagedInMelee()) continue;
				if (ally.getSkills().hasSkill("effects.rf_under_cover")) continue;

				ally.getSkills().add(::new("scripts/skills/effects/rf_under_cover_effect").init(actor, this.m.RangedDefenseBonus));
			}
		}
	}

	// MSU function
	function onEquip( _shield )
	{
		if (_shield.isItemType(::Const.Items.ItemType.Shield) && _shield.getID().find("buckler") == null)
		{
			_shield.addSkill(::new("scripts/skills/actives/rf_cover_ally_skill"));
		}
	}

	function onAffordablePreview( _skill, _movementTile )
	{
		if (_movementTile == null || _movementTile.hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions())) return;

		if (skill.getID() == "actives.shieldwall" || skill.getID() == "actives.rf_cover_ally")
		{
			this.modifyPreviewField(skill, "ActionPointCost", -1, false);
		}
	}
});
