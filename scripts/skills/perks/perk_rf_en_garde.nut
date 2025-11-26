this.perk_rf_en_garde <- ::inherit("scripts/skills/skill", {
	m = {
		// The bonuses for southern swords only apply with less weight than this in offhand
		OffhandStaminaModifierThreshold = -10
	},
	function create()
	{
		this.m.ID = "perk.rf_en_garde";
		this.m.Name = ::Const.Strings.PerkName.RF_EnGarde;
		this.m.Description = ::Const.Strings.PerkDescription.RF_EnGarde;
		this.m.Icon = "ui/perks/perk_rf_en_garde.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_en_garde_toggle_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_en_garde_toggle");
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local offhandItem = actor.getOffhandItem();
		if (offhandItem != null && !this.isOffhandItemValid(offhandItem))
			return;

		local weapon = actor.getMainhandItem();
		if (!this.isWeaponValid(weapon))
			return;

		local slash, gash;

		foreach (s in weapon.m.SkillPtrs)
		{
			switch (s.getID())
			{
				case "actives.slash":
					slash = s;
					break;

				case "actives.gash":
					gash = s;
					break;
			}
		}

		// If both Slash and Gash are present, then make Gash the AOO instead of Slash.
		// This requires that IsIgnoredAsAOO is added to softReset of both those skills.
		if (slash != null && gash != null)
		{
			slash.m.IsIgnoredAsAOO = true;
			gash.m.IsIgnoredAsAOO = false;
		}
	}

	function isOffhandItemValid( _item )
	{
		return _item.getStaminaModifier() > this.m.OffhandStaminaModifierThreshold;
	}

	function isWeaponValid( _weapon )
	{
		return _weapon.isItemType(::Const.Items.ItemType.RF_Southern) && ::MSU.isKindOf(_weapon, "weapon") && _weapon.isWeaponType(::Const.Items.WeaponType.Sword);
	}
});
