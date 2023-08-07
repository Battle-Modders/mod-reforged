this.rf_covered_by_ally_effect <- ::inherit("scripts/skills/skill", {
	m = {
		CoverProvider = null,
		MeleeDefenseBonus = 0,
		InitiativeBonus = 0,
	},

	function create()
	{
		this.m.ID = "effects.rf_covered_by_ally";
		this.m.Name = "Covered by Ally";
		this.m.Description = "This character has received temporary cover from a shield-wielding ally, gaining protection from attacks of opportunity.";
		this.m.Icon = "skills/rf_covered_by_ally_effect.png";
		this.m.IconMini = "rf_covered_by_ally_effect_mini";
		this.m.Overlay = "rf_covered_by_ally_effect";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function init( _provider, _meleeDefenseBonus = 0, _initiativeBonus = 0)
	{
		this.m.CoverProvider = ::MSU.asWeakTableRef(_provider);
		this.m.MeleeDefenseBonus = _meleeDefenseBonus;
		this.m.InitiativeBonus = _initiativeBonus;
		return this;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.m.MeleeDefenseBonus != 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::MSU.Text.colorizeValue(this.m.MeleeDefenseBonus) + " Melee Defense"
			});
		}

		if (this.m.InitiativeBonus != 0)
		{
			tooltip.push({
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::MSU.Text.colorizeValue(this.m.InitiativeBonus) + " Initiative"
			});
		}

		return tooltip;
	}

	function onUpdate( _properties )
	{
		if (::MSU.isNull(this.m.CoverProvider))
		{
			this.onRemoved();
			this.removeSelf();
			return;
		}

		_properties.MeleeDefense += this.m.MeleeDefenseBonus;
		_properties.Initiative += this.m.InitiativeBonus;
	}

	function onMovementFinished( _tile )
	{
		if (::MSU.isNull(this.m.CoverProvider) || !this.m.CoverProvider.isPlacedOnMap() || _tile.getDistanceTo(this.m.CoverProvider.getTile()) > 1)
		{
			this.removeSelf();
		}
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_move_under_cover_skill"));
	}

	function onTurnEnd()
	{
		if (::MSU.isNull(this.m.CoverProvider) || !this.m.CoverProvider.isPlacedOnMap() || this.getContainer().getActor().getTile().getDistanceTo(this.m.CoverProvider.getTile()) > 1)
		{
			this.removeSelf();
		}
	}

	function onRemoved()
	{
		this.m.IsHidden = true;
		if (!::MSU.isNull(this.m.CoverProvider) && this.m.CoverProvider.isAlive())
		{
			this.m.CoverProvider.getSkills().removeByID("effects.rf_covering_ally");
		}

		this.getContainer().removeByID("actives.rf_move_under_cover");
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}
});
