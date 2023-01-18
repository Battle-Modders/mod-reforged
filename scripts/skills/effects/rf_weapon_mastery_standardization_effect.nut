this.rf_weapon_mastery_standardization_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_weapon_mastery_standardization";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsRemovedAfterBattle = false;
	}

	function onUpdate( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();

		if (weapon != null)
		{
			foreach (key, weaponType in ::Const.Items.WeaponType)
			{
				if (weapon.isWeaponType(weaponType))
				{
					if (key in ::Reforged.WMS.WeaponTypeAlias) key = ::Reforged.WMS.WeaponTypeAlias[key];
					if (key in ::Reforged.WMS.WeaponTypeMastery && _properties[::Reforged.WMS.WeaponTypeMastery[key]])
					{
						foreach (key2, weaponType2 in ::Const.Items.WeaponType)
						{
							if (key2 == key) continue;

							if (weapon.isWeaponType(weaponType2))
							{
								if (key2 in ::Reforged.WMS.WeaponTypeAlias) key2 = ::Reforged.WMS.WeaponTypeAlias[key2];
								if (key2 in ::Reforged.WMS.WeaponTypeMastery) _properties[::Reforged.WMS.WeaponTypeMastery[key2]] = true;
							}
						}
						break;
					}
				}
			}
		}
	}
});
