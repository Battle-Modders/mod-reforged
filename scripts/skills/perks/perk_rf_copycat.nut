this.perk_rf_copycat <- ::inherit("scripts/skills/skill", {
	m = {
		BorrowedSkills = [],	// array of weakrefs to borrowedSkills

		// Const
		RangeOfCopying = 1
	},
	function create()
	{
		this.m.ID = "perk.rf_copycat";
		this.m.Name = ::Const.Strings.PerkName.RF_Copycat;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Copycat;
		this.m.Icon = "ui/perks/rf_copycat.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
	}

	function onTurnStart()
	{
		this.borrowSkills();
	}

	function onMovementFinished( _tile )
	{
		this.borrowSkills();
	}

	function onRemoved()
	{
		this.cleanUpBorrowed();
	}

	function onCombatFinsished()
	{
		this.cleanUpBorrowed();
	}

// New Functions
	// We could first delete all currently borrowed skills and then add all currently borrowable skills. But that might create more noise in the logs/game.
	// And more importantly it will destroy any cooldowns or other internal states from active abilities
	function borrowSkills()
	{
		local actor = this.getContainer().getActor();

		// Discover every adjacent active skill
		local discoveredSkillsToBorrow = {};	// Table with skillIDs as the key and their script path (for intantiating a clone) as the value
		foreach (ally in ::Tactical.Entities.getAlliedActors(actor.getFaction(), actor.getTile(), this.m.RangeOfCopying, true))
		{
			foreach(activeSkill in ally.getSkills().getAllSkillsOfType(::Const.SkillType.Active))
			{
				if (this.isAllowedSkill(activeSkill))
				{
					// Discovering multiple of the same skill will still just amount to adding it once
					discoveredSkillsToBorrow[activeSkill.getID()] <- ::IO.scriptFilenameByHash(activeSkill.ClassNameHash);
				}
			}
		}

		// Now we build a new BorrowedSkills array from the skills in discoveredSkillsToBorrow while weeding out all previously skills that don't have a source anymore
		local newBorrowedSkillReferences = [];
		foreach (oldBorrowedSkill in this.m.BorrowedSkills)	// view current skills
		{
			if (oldBorrowedSkill == null) continue;	// skip skills that have been removed automatically by virtue of being a weakref

			if (oldBorrowedSkill.getID() in discoveredSkillsToBorrow)	// all current skills that are still found adjacently
			{
				newBorrowedSkillReferences.push(oldBorrowedSkill);	// are being copied into the new array
				delete discoveredSkillsToBorrow[oldBorrowedSkill.getID()];	// and removed from the newly discovered skills
			}
			else	// otherwise those current skills now need to be removed from the actor
			{
				this.getContainer().removeByID(oldBorrowedSkill.getID());
			}
		}

		// Instantiate and Add all remaining newly discovered skills to the character
		foreach (skillID, path in discoveredSkillsToBorrow)	// view current skills
		{
			if (this.getContainer().hasSkill(skillID)) continue;	// No duplicate skills allowed

			local addedSkill = ::new(path);
			this.getContainer().add(addedSkill);
			newBorrowedSkillReferences.push(::MSU.asWeakTableRef(addedSkill));	// are being copied into the new array
		}

		this.m.BorrowedSkills = newBorrowedSkillReferences;
	}

	function isAllowedSkill( _activeSkill )
	{
		if (_activeSkill.getItem() != null) return false;		// Skills granted by items are not allowed

		return true;
	}

	// Remove all borrowed skills from this character
	function cleanUpBorrowed()
	{
		foreach (borrowedSkill in this.m.BorrowedSkills)
		{
			if (borrowedSkill == null) continue;

			this.getContainer().remove(borrowedSkill);
		}
		this.m.BorrowedSkills = [];
	}

});
