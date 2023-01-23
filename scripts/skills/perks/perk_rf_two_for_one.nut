this.perk_rf_two_for_one <- ::inherit("scripts/skills/skill", {
	m = {
		DamageMultAtTwoTiles = 0.8
	},
	function create()
	{
		this.m.ID = "perk.rf_two_for_one";
		this.m.Name = ::Const.Strings.PerkName.RF_TwoForOne;
		this.m.Description = ::Const.Strings.PerkDescription.RF_TwoForOne;
		this.m.Icon = "ui/perks/rf_two_for_one.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null)
			return;

		foreach (skill in weapon.getSkills())
		{
			switch (skill.getID())
			{
				case "actives.thrust":
					skill.m.MaxRange += 1;
				case "actives.prong":
				case "actives.rf_glaive_slash":
					if (skill.m.ActionPointCost > 1) skill.m.ActionPointCost -= 1;
					break;
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == "actives.thrust")
		{
			if (_targetEntity != null && this.getContainer().getActor().isDoubleGrippingWeapon())
			{
				local targetTile = _targetEntity.getTile();
				local myTile = this.getContainer().getActor().getTile();

				if (myTile.getDistanceTo(targetTile) == 2)
				{
					_properties.DamageTotalMult *= this.m.DamageMultAtTwoTiles;

					local betweenTiles = [];
					local malus = _skill.m.HitChanceBonus;

					for (local i = 0; i < 6; i++)
					{
						if (targetTile.hasNextTile(i))
						{
							local nextTile = targetTile.getNextTile(i);
							if (nextTile.getDistanceTo(myTile) == 1)
							{
								betweenTiles.push(nextTile);
								if (betweenTiles.len() == 2)
								{
									break;
								}
							}
						}
					}

					foreach (tile in betweenTiles)
					{
						if (tile.IsOccupiedByActor)
						{
							malus += 20;
						}
					}

					_skill.m.HitChanceBonus -= malus;
					_properties.MeleeSkill -= malus;
				}
			}
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.getID() == "actives.thrust")
		{
			if (this.getContainer().getActor().isDoubleGrippingWeapon())
			{
				foreach (entry in _tooltip)
				{
					if (entry.text.find("chance to hit") != null)
					{
						entry.text += " adjacent targets";
						break;
					}
				}

				_tooltip.push(
					{
						id = 6,
						type = "text",
						icon = "ui/icons/hitchance.png",
						text = "Has [color=" + ::Const.UI.Color.NegativeValue + "]-20%[/color] chance to hit per character between you and the target"
					}
				);

				_tooltip.push(
					{
						id = 6,
						type = "text",
						icon = "ui/icons/damage_dealt.png",
						text = "When attacking at a distance of 2 tiles, damage is reduced by [color=" + ::Const.UI.Color.NegativeValue + "]20%[/color]"
					}
				);
			}
		}
	}
});
