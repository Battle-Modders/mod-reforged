this.perk_rf_swordmaster_metzger <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {
		IsCleaverWeaponTypeAdded = false
	},
	function create()
	{
		this.perk_rf_swordmaster_abstract.create();
		this.m.ID = "perk.rf_swordmaster_metzger";
		this.m.Name = ::Const.Strings.PerkName.RF_SwordmasterMetzger;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SwordmasterMetzger;
		this.m.Icon = "ui/perks/perk_rf_swordmaster_metzger.png";
	}

	function isEnabled()
	{
		return this.m.IsForceEnabled || (this.perk_rf_swordmaster_abstract.isEnabled() && !this.getContainer().getActor().getMainhandItem().isItemType(::Const.Items.ItemType.RF_Fencing));
	}

	function onAdded()
	{
		local equippedItem = this.getContainer().getActor().getMainhandItem();
		if (equippedItem != null) this.onEquip(equippedItem);

		if (this.m.IsNew && ::MSU.isKindOf(this.getContainer().getActor(), "player"))
		{
			this.getContainer().getActor().getPerkTree().addPerkGroup("pg.rf_cleaver");
		}
	}

	function onRemoved()
	{
		local equippedItem = this.getContainer().getActor().getMainhandItem();
		if (equippedItem != null)
		{
			this.getContainer().getActor().getItems().unequip(equippedItem);
			this.getContainer().getActor().getItems().equip(equippedItem);
		}
	}

	function onEquip( _item )
	{
		if (!this.isEnabled() || _item.getSlotType() != ::Const.ItemSlot.Mainhand)
			return;

		// during deserialization if the user has an item that adds decapitate
		// then it is added to SkillsToAdd so we have to check there as well before trying to add our own
		local function hasSkill( _id )
		{
			if (this.getContainer().hasSkill(_id))
				return true;

			foreach (s in this.getContainer().m.SkillsToAdd)
			{
				if (s.getID() == _id && !s.isGarbage())
					return true;
			}

			return false;
		}

		if (!hasSkill("actives.decapitate"))
		{
			_item.addSkill(::Reforged.new("scripts/skills/actives/decapitate", function(o) {
				o.m.DirectDamageMult = _item.m.DirectDamageMult;
				foreach (skill in _item.getSkills())
				{
					if (skill.isAttack() && !skill.isRanged() && !skill.isIgnoredAsAOO())
					{
						o.m.ActionPointCost = skill.getBaseValue("ActionPointCost"); // Set the AP cost of Decapitate to that of the AOO of the weapon
						break;
					}
				}
			}));
		}

		if (!_item.isWeaponType(::Const.Items.WeaponType.Cleaver))
		{
			_item.m.WeaponType = _item.m.WeaponType | ::Const.Items.WeaponType.Cleaver;
			this.m.IsCleaverWeaponTypeAdded = true;
		}

		foreach (row in ::DynamicPerks.PerkGroups.findById("pg.rf_cleaver").getTree())
		{
			foreach (perkID in row)
			{
				this.getContainer().add(::Reforged.new(::Const.Perks.findById(perkID).Script, function(o) {
					o.m.IsSerialized = false;
					o.m.IsRefundable = false;
				}));
			}
		}
	}

	function onUnequip( _item )
	{
		if (!this.isEnabled() || _item.getSlotType() != ::Const.ItemSlot.Mainhand)
			return;

		foreach (row in ::DynamicPerks.PerkGroups.findById("pg.rf_cleaver").getTree())
		{
			foreach (perkID in row)
			{
				this.getContainer().removeByStackByID(perkID, false);
			}
		}

		if (this.m.IsCleaverWeaponTypeAdded)
		{
			_item.m.WeaponType -= ::Const.Items.WeaponType.Cleaver;
			this.m.IsCleaverWeaponTypeAdded = false;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || !this.isSkillValid(_skill) || !this.isEnabled())
			return;

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding || _damageInflictedHitpoints < ::Const.Combat.MinDamageToApplyBleeding)
			return;

		if (!this.getContainer().RF_isNewSkillUseOrEntity(_targetEntity))
			return;

		local actor = this.getContainer().getActor();
		local effect = ::new("scripts/skills/effects/bleeding_effect");
		effect.setDamage(10);

		_targetEntity.getSkills().add(effect);
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (this.isSkillValid(_skill) && this.isEnabled())
		{
			_tooltip.push({
				id = 100,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Applies [Bleeding|Skill+bleeding_effect] due to " + ::Reforged.NestedTooltips.getNestedPerkName(this))
			});
		}
	}

	function isSkillValid( _skill )
	{
		return _skill.isAttack() && _skill.m.IsWeaponSkill && _skill.getID() != "actives.cleave" && _skill.getDamageType().contains(::Const.Damage.DamageType.Cutting);
	}
});
