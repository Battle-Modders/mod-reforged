this.perk_rf_mentor <- ::inherit("scripts/skills/skill", {
	m = {
		Students = [], // array of instances of rf_mentors_presence_effect
		MaxStudents = 1
	},
	function create()
	{
		this.m.ID = "perk.rf_mentor";
		this.m.Name = ::Const.Strings.PerkName.RF_Mentor;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Mentor;
		this.m.Icon = "ui/perks/rf_mentor.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.SoundOnUse = [
			"sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		];
	}

	function verifyStudentSkill( _skill )
	{
		if (!::MSU.isKindOf(_skill, "rf_mentors_presence_effect"))
		{
			::logError("_skill must be rf_mentors_presence_effect or its descendant");
			throw ::MSU.Exception.InvalidValue(_skill.ClassName);
		}
	}

	function hasStudent( _skill )
	{
		this.verifyStudentSkill(_skill);
		foreach (student in this.m.Students)
		{
			if (::MSU.isEqual(student, _skill))
				return true;
		}
		return false;
	}

	function addStudent( _skill )
	{
		this.verifyStudentSkill(_skill);
		if (!this.hasStudent(_skill))
			this.m.Students.push(::MSU.asWeakTableRef(_skill))
	}

	function removeStudent( _skill )
	{
		foreach (i, student in this.m.Students)
		{
			if (::MSU.isEqual(student, _skill))
			{
				this.m.Students.remove(i);
				return;
			}
		}
	}

	function canAddStudent()
	{
		return this.m.Students.len() < this.m.MaxStudents;
	}

	function onStudentDeath( _fatalityType )
	{
		local actor = this.getContainer().getActor();
		local adrenaline = ::new("scripts/skills/effects/adrenaline_effect");
		if (!actor.isTurnStarted() && !actor.isTurnDone())
		{
			// If this guy hasn't started his turn in this round yet, add 1 more turn to adrenaline
			// So the adrenaline doesn't expire after he ends his turn this round
			adrenaline.m.TurnsLeft++;
		}
		this.getContainer().add(adrenaline);
		actor.setFatigue(::Math.max(0, actor.getFatigue() * 0.5));
		::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Actor, actor.getPos(), ::Math.rand(100, 115) * 0.01 * this.getContainer().getActor().getSoundPitch());
	}

	function removeFromAllStudents()
	{
		foreach (student in this.m.Students)
		{
			if (!::MSU.isNull(student))
				student.setMentor(null);
		}
	}

	function onDeath( _fatalityType )
	{
		foreach (student in this.m.Students)
		{
			if (!::MSU.isNull(student))
				student.onMentorDeath(_fatalityType);
		}
		this.removeFromAllStudents();
	}

	function onRemoved()
	{
		this.removeFromAllStudents();
	}
});
