this.rf_weapon_mastery_standardization <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.rf_weapon_mastery_standardization";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Type = ::Const.SkillType.Special;
		this.m.Order = ::Const.SkillOrder.Background;
		this.m.IsSerialized = false;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();

		if (weapon != null)
		{
			foreach (weaponType in ::Const.Items.WeaponType)
			{
				if (weapon.isWeaponType(weaponType))
				{
					if (weaponType in ::Reforged.WMS.WeaponTypeAlias) weaponType = ::Reforged.WMS.WeaponTypeAlias[weaponType];
					if (weaponType in ::Reforged.WMS.WeaponTypeMastery && _properties[::Reforged.WMS.WeaponTypeMastery[weaponType]])
					{
						foreach (weaponType2 in ::Const.Items.WeaponType)
						{
							if (weaponType == weaponType2) continue;

							if (weapon.isWeaponType(weaponType2))
							{
								if (weaponType2 in ::Reforged.WMS.WeaponTypeAlias) weaponType2 = ::Reforged.WMS.WeaponTypeAlias[weaponType2];
								if (weaponType2 in ::Reforged.WMS.WeaponTypeMastery) _properties[::Reforged.WMS.WeaponTypeMastery[weaponType2]] = true;
							}
						}
					}
				}
			}
		}
	}
});
