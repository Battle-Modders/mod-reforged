this.rf_covered_by_ally_effect <- ::inherit("scripts/skills/skill", {
	m = {
		CoverProvider = null
	},
	function setCoverProvider( _ally )
	{
		this.m.CoverProvider = ::MSU.asWeakTableRef(_ally);
	}

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

	function onUpdate( _properties )
	{
		if (::MSU.isNull(this.m.CoverProvider) || _properties.IsRooted || _properties.IsStunned)
		{
			this.onRemoved();
			this.removeSelf();
			return;
		}

		_properties.InitiativeForTurnOrderAdditional += 5000;
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
		if (::MSU.isNull(this.m.CoverProvider) || !this.m.CoverProvider.isPlacedOnMap() || _tile.getDistanceTo(this.m.CoverProvider.getTile()) > 1)
		{
			this.removeSelf();
		}
	}

	function onRemoved()
	{
		this.m.IsHidden = true;
		if (!::MSU.isNull(this.m.CoverProvider) && this.m.CoverProvider.isAlive())
		{
			local skill = this.m.CoverProvider.getSkills().getSkillByID("effects.rf_covering_ally");

			if (skill != null)
			{
				skill.setAlly(null);
				this.m.CoverProvider.getSkills().remove(skill);
			}
		}

		this.getContainer().removeByID("actives.rf_move_under_cover");
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}
});
