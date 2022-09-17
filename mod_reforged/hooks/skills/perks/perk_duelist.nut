::mods_hookExactClass("skills/perks/perk_duelist", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Description = "This duelist is better at defending melee attacks when engaged with fewer than 3 opponents.";
	}

	o.isHidden <- function()
	{
		return this.getDefenseBonus() != 0;
	}

	o.getTooltip <- function()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.DefenseBonus + "[/color] Melee Defense against adjacent opponents"
		});

		return tooltip;
	}

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
		if (_skill.isDuelistValid())
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			if (weapon == null || weapon.isItemType((::Const.Items.ItemType.OneHanded)))
			{
				_properties.DamageDirectAdd += 0.25;
			}
			else
			{
				_properties.DamageDirectAdd += 0.15;
			}
		}
	}

	o.getDefenseBonus <- function()
	{
		if (!this.getContainer().getActor().isPlacedOnMap()) return 0;

		local numAdjacentEnemies = ::Tactical.Entities.getHostileActors(this.getContainer().getActor().getFaction(), this.getContainer().getActor().getTile(), 1, true).len();

		if (numAdjacentEnemies > 2) return 0;

		return ::Math.max(0, (numAdjacentEnemies == 2 ? 0.05 : 0.1) * this.getContainer().getActor().getCurrentProperties().getMeleeSkill());
	}

	o.onBeingAttacked <- function( _attacker, _skill, _properties )
	{
		if (!_skill.isRanged() && _attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) == 1 && this.isEnabled())
		{
			_properties.MeleeDefense += this.getDefenseBonus();
		}
	}
});
