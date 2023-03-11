::mods_hookBaseClass("skills/skill", function(o) {
	o = o[o.SuperName];

	o.isDuelistValid <- function()
	{
		return this.isAttack() && !this.isRanged() && this.getBaseValue("ActionPointCost") <= 4 && this.getBaseValue("MaxRange") == 1;
	}

	local getHitFactors = o.getHitFactors;
	o.getHitFactors = function( _targetTile )
	{
		local ret = getHitFactors(_targetTile);
		for (local index = (ret.len() - 1); index >= 0; index--)	// We traverse it in reverse because we want to remove entries during the loop
		{
			switch (ret[index].text)
			{
				// For these entries we switch out the Icon for a better one
				case "Immune to stun":
				case "Immune to being rooted":
				case "Immune to being disarmed":
				case "Immune to being knocked back or hooked":
					ret[index].icon = "ui/tooltips/warning.png";	// These cases should be a warnings and not hide in-between hit-chance lines
					break;

				// We remove these entries from ever displaying because they are mostly redundant and take away space
				case "Fast Adaption":		// This should be handled by the perk itself if it really feels like this information is important
				case "Armed with shield":	// Already displayed on the stats of the character and shield is visible
				case "Shieldwall":			// Already displayed on the stats of the character and in the effects section
				case "Riposte":				// This has nothing to do with hitchance and there is already a mini-icon for it anyways
				case "Resistance against ranged weapons":	// This was never followed through for anything other than skeletons
				case "Resistance against piercing attacks":	// This was never followed through for anything other than skeletons
				case "Nighttime":			// Already displayed on the stats of the character and in the effects section
					ret.remove(index);
					break;

				// We add additional hit-chance numbers for some other entries
				case "Too close":
				case this.getName():
					if (this.m.HitChanceBonus == 0) break;	// MSU pushes a raw 'this.getName()' string sometimes even when HitChanceBonus is 0. Currently this is with ranged attacks based on AdditionalAccuracy
					if (this.m.HitChanceBonus < 0)
					{
						ret[index].text = ::MSU.Text.colorRed(this.m.HitChanceBonus + "% ") + ret[index].text;
					}
					else
					{
						ret[index].text = ::MSU.Text.colorGreen(this.m.HitChanceBonus + "% ") + ret[index].text;
					}
					break;

				case "Height disadvantage":
					ret[index].text = ::MSU.Text.colorRed((::Const.Combat.LevelDifferenceToHitMalus * (_targetTile.Level - this.m.Container.getActor().getTile().Level)) + "% ") + " Height Disadvantage";
					break;

				case "Height advantage":
					ret[index].text = ::MSU.Text.colorGreen(::Const.Combat.LevelDifferenceToHitBonus + "% ") + " Height Advantage";
					break;
				case "Surrounded":
					if (_targetTile.IsOccupiedByActor)
					{
						local bonus = this.getContainer().getActor().getSurroundedBonus(_targetTile.getEntity());
						ret[index].text = ::MSU.Text.colorGreen(bonus + "%") + " Surrounded";
					}
					break;

			}
		}

		// New Entries
		if (!this.m.IsShieldRelevant && _targetTile.IsOccupiedByActor && _targetTile.getEntity().isArmedWithShield())
		{
			local shield = _targetTile.getEntity().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
			local bonus = (this.isRanged()) ? shield.getRangedDefenseBonus() : shield.getMeleeDefenseBonus();
			ret.push({
				icon = "ui/tooltips/positive.png",
				text = ::MSU.Text.colorGreen(bonus + "%") + " Ignores Shield"
			});
		}

		return ret;
	}
});
