::Reforged.HooksMod.hook("scripts/skills/skill", function(q) {
	// Temporary variable for switcheroo
	q.m.oldIsShieldRelevant <- null;
	q.m.executingGetHitchance <- false;
	q.m.executingAttackEntityFirstHalf <- false;	// Used for a IsShieldRelevant switcheroo

	q.isDuelistValid <- function()
	{
		return this.isAttack() && !this.isRanged() && this.getBaseValue("ActionPointCost") <= 4 && this.getBaseValue("MaxRange") == 1;
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
						if (bonus > 0) ret[index].text = ::MSU.Text.colorGreen(bonus + "%") + " Surrounded";
					}
					break;

			}
		}

		// New Entries
		if (!this.m.IsShieldRelevant && _targetTile.IsOccupiedByActor && _targetTile.getEntity().isArmedWithShield())
		{
			local shield = _targetTile.getEntity().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
			local ignoredBonus = (this.isRanged()) ? shield.getRangedDefense(true, false) : shield.getMeleeDefense(true, false);
			if (ignoredBonus > 0)
			{
				ret.push({
					icon = "ui/tooltips/positive.png",
					text = ::MSU.Text.colorGreen(ignoredBonus + "%") + " Ignores Shield"
				});
			}
		}

		return ret;
	}

	q.attackEntity = @(__original) function( _user, _targetEntity, _allowDiversion = true )
	{
		this.m.executingAttackEntityFirstHalf = true;

		return __original(_user, _targetEntity, _allowDiversion);
	}

	q.isUsingHitChance = @(__original) function()
	{
		if (this.m.oldIsShieldRelevant != null)
		{
			this.m.IsShieldRelevant = this.m.oldIsShieldRelevant;	// Revert Switcheroo early (no need to do it at the end of attackEntity) so that vanilla behavior like diverting and shield damage taken work correctly
			this.m.oldIsShieldRelevant = null;
		}
		this.m.executingAttackEntityFirstHalf = false;	// The "first half" in our case ends with the call of isUsingHitChance

		return __original();
	}

	q.getHitchance = @(__original) function( _targetEntity )
	{
		this.m.executingGetHitchance = true;

		local ret = __original(_targetEntity);

		if (this.m.oldIsShieldRelevant != null)
		{
			this.m.IsShieldRelevant = this.m.oldIsShieldRelevant;	// Revert Switcheroo
			this.m.oldIsShieldRelevant = null;
		}

		this.m.executingGetHitchance = false;
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

	q.onBeingAttacked = @(__original) function( _attacker, _skill, _properties )
	{
		if (this.m.executingAttackEntityFirstHalf || this.m.executingGetHitchance)	// We only want to switcheroo during these two specific functions to prevent collateral
		{
			if (!_skill.m.IsShieldRelevant)
			{
				_properties.ShieldDefenseMult = -1.0 * ::Math.abs(_properties.ShieldDefenseMult);	// Attacks that ignore Shields now instead set the ShieldDefenseMult of the target to a negative value;
			}

			// Switcheroo
			oldIsShieldRelevant = _skill.m.IsShieldRelevant;
			_skill.m.IsShieldRelevant = true;	// We prevent vanilla from changing hitchance calculations from this variable being on false
		}
	}
});
