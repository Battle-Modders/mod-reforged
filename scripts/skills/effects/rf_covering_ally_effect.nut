this.rf_covering_ally_effect <- ::inherit("scripts/skills/skill", {
	m = {
		Ally = null,
		SelfSkillMalus = -15,
		SelfDefenseMalus = -15
	},
	function setAlly( _ally )
	{
		this.m.Ally = ::MSU.asWeakTableRef(_ally);
	}

	function create()
	{
		this.m.ID = "effects.rf_covering_ally";
		this.m.Name = "Covering an Ally";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("This character is using the shield to help an ally move ignoring [Zone of Control.|Concept.ZoneOfControl] This takes up significant effort, resulting in reduced combat effectiveness.");
		this.m.Icon = "ui/perks/perk_rf_cover_ally.png";
		this.m.IconMini = "rf_covering_ally_effect_mini";
		this.m.Overlay = "rf_covering_ally_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.SelfDefenseMalus) + " [Melee Defense|Concept.MeleeDefense]")
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.SelfDefenseMalus) + " [Ranged Defense|Concept.RangeDefense]")
		});

		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.SelfSkillMalus) + " [Melee Skill|Concept.MeleeSkill]")
		});

		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.SelfSkillMalus) + " [Ranged Skill|Concept.RangeSkill]")
		});

		return ret;
	}

	function onUpdate( _properties )
	{
		if (::MSU.isNull(this.m.Ally) || !this.m.Ally.isPlacedOnMap() || _properties.IsRooted || _properties.IsStunned || this.getContainer().getActor().getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			this.removeSelf();
			this.onRemoved();
			return;
		}

		_properties.MeleeDefense += this.m.SelfDefenseMalus;
		_properties.RangedDefense += this.m.SelfDefenseMalus;
		_properties.MeleeSkill += this.m.SelfSkillMalus;
		_properties.RangedSkill += this.m.SelfSkillMalus;
	}

	function onMovementFinished( _tile )
	{
		if (::MSU.isNull(this.m.Ally) || !this.m.Ally.isPlacedOnMap() || _tile.getDistanceTo(this.m.Ally.getTile()) > 1)
		{
			this.removeSelf();
		}
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

	function onRemoved()
	{
		this.m.IsHidden = true;
		if (!::MSU.isNull(this.m.Ally) && this.m.Ally.isAlive())
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " is no longer providing cover to " + ::Const.UI.getColorizedEntityName(this.m.Ally));
			local skill = this.m.Ally.getSkills().getSkillByID("effects.rf_covered_by_ally");

			if (skill != null)
			{
				skill.setCoverProvider(null);
				this.m.Ally.getSkills().remove(skill);
			}
		}
	}
});
