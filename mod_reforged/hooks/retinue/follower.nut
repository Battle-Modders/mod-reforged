::Reforged.HooksMod.hook("scripts/retinue/follower", function(q) {
	q.m.PerkTree <- null;
	q.m.Skills <- null;
	q.m.IsHired <- false;
	q.m.CurrentTownID <- null;
	q.m.ArrivedInTownDay <- null;
	q.m.IsKnownCurrentLocation <- false;

	q.create = @(__original) function()
	{
		__original();
		// TODO
		this.m.PerkTree = [[
		{
			ID = "perk.test",
			Script = "scripts/skills/rf_follower/perk_test",
			Name = "Test",
			Tooltip = "TestTooltip",
			Icon = "ui/perks/perk_rf_calculated_strikes.png",
			IconDisabled = "ui/perks/perk_rf_calculated_strikes_sw.png"
		},]];
		this.m.Skills = ::new("scripts/skills/rf_follower_skill_container");
	}

	q.getPerkTree <- function()
	{
		return this.m.PerkTree;
	}

	q.isHired <- function()
	{
		return this.m.IsHired;
	}

	q.isAlive <- function()
	{
		// Stub to play nice with the skill container
		return true;
	}

	q.hasPerk <- function( _id )
	{
		return this.m.Skills.hasSkill(_id);
	}

	q.unlockPerk <- function( _id )
	{
		// TODO
		if (this.hasPerk(_id))
		{
			return true;
		}

		// local perk = this.Const.Perks.findById(_id);
		local perk = {Script = "scripts/skills/rf_follower/perk_test"};

		if (perk == null)
		{
			return false;
		}

		this.m.Skills.add(this.new(perk.Script));
		this.m.Skills.update();

		return true;
	}

	q.onHired <- function()
	{
		this.m.IsHired <- true;
	}

	q.onDismiss <- function()
	{
		this.m.IsHired <- false;
	}

	q.getUIData <- function()
	{
		local currentTown = this.getCurrentTown();
		return {
			ImagePath = this.getImage() + ".png",
			ID = this.getID(),
			Name = this.getName(),
			Description = this.getDescription(),
			Cost = this.getCost(),
			Effects = this.getEffects(),
			Requirements = this.getRequirements(),
			IsUnlocked = this.isUnlocked(),

			PerkTree = this.getPerkTree(),
			Perks = this.m.Skills.query(this.Const.SkillType.Perk, true).map(@(_idx, _perk) _perk.getID()),
			IsAvailableForHire = this.isAvailableForHire(),
			IsHired = this.isHired(),
			IsInCurrentTown = this.isInCurrentTown(),
			IsKnownCurrentLocation = this.m.IsKnownCurrentLocation,
			CurrentTownID = this.m.CurrentTownID,
			CurrentTownName = currentTown == null ? null : currentTown.getName(),
		};
	}

	q.onNewDay = @(__original) function()
	{
		__original();
		if (this.shouldLeaveTown())
		{
			this.leaveTown()
		}
	}

	q.isAvailableForHire <- function()
	{
		// Requirements for a follower to show up in a tavern
		// Vanilla uses this.isUnlocked()
		return true;
	}

	q.isInTown <- function()
	{
		return this.m.CurrentTownID != null && !this.isHired();
	}

	q.isInCurrentTown <- function()
	{
		return this.isInTown() && ::World.State.getCurrentTown().getID() == this.m.CurrentTownID;
	}

	q.enterTown <- function(_town)
	{
		this.m.CurrentTownID = _town.getID();
		this.m.ArrivedInTownDay = ::World.getTime().Days;
	}

	q.getCurrentTownID <- function()
	{
		return this.m.CurrentTownID;
	}

	q.getCurrentTown <- function()
	{
		 return this.isInTown() ? ::MSU.asWeakTableRef(this.World.getEntityByID(this.m.CurrentTownID)) : null;
	}

	q.shouldLeaveTown <- function()
	{
		return ::World.getTime().Days > this.m.ArrivedInTownDay + ::Reforged.Retinue.DaysFollowerStaysInTown;
	}

	q.leaveTown <- function()
	{
		this.m.CurrentTownID <- null;
		this.m.IsKnownCurrentLocation <- false;
	}
})
