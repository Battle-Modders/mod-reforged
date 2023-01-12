::mods_hookExactClass("skills/perks/perk_duelist", function(o) {
	o.onUpdate = function( _properties )
	{
		// Overwrite vanilla function to make it empty
	}

	o.isEnabled <- function()
	{
		local aoo = this.getContainer().getAttackOfOpportunity();
		return aoo != null && aoo.isDuelistValid();
	}

	o.onAnySkillUsed <- function( _skill, _targetEntity, _properties )
	{
		if (!_skill.isDuelistValid())
			return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || weapon.isItemType((::Const.Items.ItemType.OneHanded)))
		{
			_properties.DamageDirectAdd += 0.25;
		}
		else
		{
			_properties.DamageDirectAdd += 0.15;
		}

		if (_targetEntity != null)
		{
			local numAdjacentEnemies = ::Tactical.Entities.getHostileActors(this.getContainer().getActor().getFaction(), this.getContainer().getActor().getTile(), 1, true).len();
			if (numAdjacentEnemies == 1) // _targetEntity only
			{
				_properties.Reach += 2;
			}
			else if (numAdjacentEnemies == 2) // _targetEntity + 1 other
			{
				_properties.Reach += 1;
			}
		}
	}

	o.onBeingAttacked <- function( _attacker, _skill, _properties )
	{
		if (_skill.isRanged() || _attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) > 1 || !this.isEnabled())
			return;

		local numAdjacentEnemies = ::Tactical.Entities.getHostileActors(this.getContainer().getActor().getFaction(), this.getContainer().getActor().getTile(), 1, true).len();
		if (numAdjacentEnemies == 1)
		{
			_properties.Reach += 2;
		}
		else if (numAdjacentEnemies == 2)
		{
			_properties.Reach += 1;
		}
	}
});
