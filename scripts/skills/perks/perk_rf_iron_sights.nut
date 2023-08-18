this.perk_rf_iron_sights <- ::inherit("scripts/skills/skill", {
	m = {
		BonusHitHeadChance = 25,
		BonusArmorPen = 0.25
	},
	function create()
	{
		this.m.ID = "perk.rf_iron_sights";
		this.m.Name = ::Const.Strings.PerkName.RF_IronSights;
		this.m.Description = ::Const.Strings.PerkDescription.RF_IronSights;
		this.m.Icon = "ui/perks/rf_iron_sights.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!_skill.isAttack() || !_skill.isRanged() || _targetEntity == null) return;

		local item = _skill.getItem();
		if (item == null) return;

		if (item.isWeaponType(::Const.Items.WeaponType.Crossbow) || item.isWeaponType(::Const.Items.WeaponType.Firearm))
		{
			local myActor = this.getContainer().getActor();
			local blockedTiles = ::Const.Tactical.Common.getBlockedTiles(myActor.getTile(), _targetEntity.getTile(), myActor.getFaction(), false);

			if (blockedTiles.len() == 0)
			{
				_properties.DamageDirectAdd += this.m.BonusArmorPen;
			}
			else
			{
				_properties.HitChance[::Const.BodyPart.Head] += this.m.BonusHitHeadChance;
			}
		}
	}
});
