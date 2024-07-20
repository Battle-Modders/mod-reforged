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
					}
				}
			}
		}
	}
});
