::Reforged.HooksMod.hook("scripts/skills/skill", function(q) {
	q.isDuelistValid <- function()
	{
		return this.isAttack() && !this.isRanged() && !this.isAOE() && this.getBaseValue("MaxRange") == 1;
	}

	q.getHitFactors = @(__original) function( _targetTile )
	{
		local ret = __original(_targetTile);
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
						ret[index].text = ::MSU.Text.colorNegative(this.m.HitChanceBonus + "% ") + ret[index].text;
					}
					else
					{
						ret[index].text = ::MSU.Text.colorPositive(this.m.HitChanceBonus + "% ") + ret[index].text;
					}
					break;

				case "Height disadvantage":
					ret[index].text = ::MSU.Text.colorNegative((::Const.Combat.LevelDifferenceToHitMalus * (_targetTile.Level - this.m.Container.getActor().getTile().Level)) + "% ") + " Height Disadvantage";
					break;

				case "Height advantage":
					ret[index].text = ::MSU.Text.colorPositive(::Const.Combat.LevelDifferenceToHitBonus + "% ") + " Height Advantage";
					break;
				case "Surrounded":
					if (_targetTile.IsOccupiedByActor)
					{
						local bonus = this.getContainer().getActor().getSurroundedBonus(_targetTile.getEntity());
						if (bonus > 0) ret[index].text = ::MSU.Text.colorPositive(bonus + "%") + " Surrounded";
					}
					break;

			}
		}

		// New Entries
		if (!this.m.IsShieldRelevant && _targetTile.IsOccupiedByActor && _targetTile.getEntity().isArmedWithShield())
		{
			local shield = _targetTile.getEntity().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
			local bonus = (this.isRanged()) ? shield.getRangedDefenseBonus() : shield.getMeleeDefenseBonus();
			if (bonus > 0)
			{
				ret.push({
					icon = "ui/tooltips/positive.png",
					text = ::MSU.Text.colorPositive(bonus + "%") + " Ignores Shield"
				});
			}
		}

		return ret;
	}
});

::Reforged.HooksMod.hookTree("scripts/skills/skill", function(q) {
	if (q.contains("create"))
	{
		q.create = @(__original) function()
		{
			__original();

			// VanillaFix: Some vanilla skills for AI entities have IconDisabled same as Icon or are missing IconDisabled
			// they are missing the _sw gfx in the game files. In Reforged we have created
			// _sw variants of those gfx and therefore we fix the IconDisabled to use the _sw variant
			if (this.m.Icon == this.m.IconDisabled || this.m.IconDisabled == "")
			{
				this.m.IconDisabled = ::String.replace(this.m.Icon, ".png", "_sw.png");
			}
		}
	}
});
