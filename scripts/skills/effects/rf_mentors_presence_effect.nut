this.rf_mentors_presence_effect <- ::inherit("scripts/skills/skill", {
	m = {
		Mentor = null, // an instance of perk_rf_mentor
		MeleeSkillAdd = 10,
		MeleeDefenseAdd = 10,
		BraveryAdd = 20,
		MoraleStateOnMentorDeathAdd = -2
	},
	function create()
	{
		this.m.ID = "effects.rf_mentors_presence";
		this.m.Name = "Mentor\'s Presence";
		this.m.Description = "This character is in the presence of his mentor.";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Icon = "skills/rf_mentors_presence_effect.png";
		this.m.IconMini = "rf_mentors_presence_effect_mini";
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}
	function setMentor( _skill )
	{
		if (_skill != null && !::MSU.isKindOf(_skill, "perk_rf_mentor"))
		{
			::logError("_skill must be an instance of perk_rf_mentor or its descendant");
			throw ::MSU.Exception.InvalidValue(_skill.ClassName);
		}

		if (_skill == null)
		{
			this.m.Mentor = null;
			local bodyguardSkill = this.getContainer().getSkillByID("special.rf_bodyguard");
			if (bodyguardSkill != null) bodyguardSkill.setVIP(null);
			return;
		}

		this.m.Mentor = ::MSU.asWeakTableRef(_skill);
		local bodyguardSkill = this.getContainer().getSkillByID("special.rf_bodyguard");
		if (bodyguardSkill != null) bodyguardSkill.setVIP(_skill.getContainer().getActor());
	}

	function isHidden()
	{
		return ::MSU.isNull(this.m.Mentor);
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.MeleeSkillAdd, {AddSign = true}) + " [Melee Skill|Concept.MeleeSkill]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.MeleeDefenseAdd, {AddSign = true}) + " [Melee Defense|Concept.MeleeDefense]")
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.BraveryAdd, {AddSign = true}) + " [Resolve|Concept.Bravery]")
			}
		]);

		if (this.getContainer().getActor().getMoraleState() != ::Const.MoraleState.Ignore)
		{
			ret.extend([
				{
					id = 13,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = ::Reforged.Mod.Tooltips.parseString("At the start of every [turn|Concept.Turn] become [Confident|Concept.Morale]")
				},
				{
					id = 14,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = ::Reforged.Mod.Tooltips.parseString("Will lose " + ::MSU.Text.colorizeValue(this.m.MoraleStateOnMentorDeathAdd) + " levels of [morale|Concept.Morale] upon the mentor\'s death")
				}
			]);
		}

		return ret;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/special/rf_bodyguard"));
	}

	function onCombatStarted()
	{
		// Choose the nearest same faction ally with perk.rf_mentor that can accept one more student and set that perk as your mentor
		local actor = this.getContainer().getActor();
		local distance = 99;
		local mentor;
		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(actor.getFaction()))
		{
			local s = ally.getSkills().getSkillByID("perk.rf_mentor");
			if (s == null || !s.canAddStudent())
				continue;

			local distanceToAlly = ally.getTile().getDistanceTo(actor.getTile());
			if (distanceToAlly < distance)
			{
				distance = distanceToAlly;
				mentor = s;
			}
		}

		if (mentor != null)
		{
			mentor.addStudent(this);
			this.setMentor(mentor);
			actor.setName(mentor.getContainer().getActor().getName() + "\'s Squire");
		}
	}

	function onUpdate( _properties )
	{
		if (::MSU.isNull(this.m.Mentor))
			return;

		_properties.MeleeSkill += 10;
		_properties.MeleeDefense += 10;
		_properties.Bravery += 20;
	}

	function removeFromMentor()
	{
		if (::MSU.isNull(this.m.Mentor))
			return;
		this.m.Mentor.removeStudent(this);
		this.setMentor(null);
	}

	function onRemoved()
	{
		this.removeFromMentor();
	}

	function onDeath( _fatalityType )
	{
		if (!::MSU.isNull(this.m.Mentor))
			this.m.Mentor.onStudentDeath(_fatalityType);
		this.removeFromMentor();
	}

	function onMentorDeath( _fatalityType )
	{
		local actor = this.getContainer().getActor();
		if (actor.getMoraleState() != ::Const.MoraleState.Ignore && actor.getMoraleState() != ::Const.MoraleState.Fleeing && actor.isPlacedOnMap())
		{
			actor.setMoraleState(::Math.max(::Const.MoraleState.Fleeing, actor.getMoraleState() + this.m.MoraleStateOnMentorDeathAdd));
		}
	}

	function onTurnStart()
	{
		if (::MSU.isNull(this.m.Mentor) || this.m.Mentor.getContainer().getActor().getMoraleState() == ::Const.MoraleState.Fleeing)
			return;

		local actor = this.getContainer().getActor();
		if (actor.getMoraleState() < ::Const.MoraleState.Confident)
		{
			actor.setMoraleState(::Const.MoraleState.Confident);
			this.spawnIcon("rf_mentors_presence_effect", actor.getTile());
		}
	}
});
