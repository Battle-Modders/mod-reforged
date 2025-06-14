::Reforged.HooksMod.hook("scripts/retinue/follower", function(q) {
	q.m.PerkTree <- null;
	q.m.Skills <- null;
	q.m.IsHired <- false;
	q.m.CurrentTownID <- null;
	q.m.CurrentTownArrivalDay <- null;
	q.m.IsKnownCurrentLocation <- false;
	q.m.HiredFromTownID <- null;

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
		this.m.IsHired = true;
		this.m.CurrentTownID = null;
		if (::World.State.getCurrentTown() != null)
		{
			this.m.HiredFromTownID = ::World.State.getCurrentTown().getID();
		}
	}

	q.onDismiss <- function()
	{
		this.m.IsHired = false;
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
			IsUnlocked = true,

			PerkTree = this.getPerkTree(),
			Perks = this.m.Skills.query(this.Const.SkillType.Perk, true).map(@(_idx, _perk) _perk.getID()),
			IsAvailableForHire = this.isAvailableForHire(),
			IsHired = this.isHired(),
			IsInCurrentTown = this.isInCurrentTown(),
			IsKnownCurrentLocation = this.m.IsKnownCurrentLocation,
			CurrentTownID = this.m.CurrentTownID,
			CurrentTownName = currentTown == null ? null : currentTown.getName(),
			CurrentTownArrivalDay = this.m.CurrentTownArrivalDay,
			TimeRemainingInCurrentTown = this.getTimeRemainingInCurrentTown()
		};
	}

	q.onNewDay = @(__original) function()
	{
		__original();
		if (this.shouldLeaveTown())
		{
			this.setCurrentTown(null);
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
		return this.m.CurrentTownID != null;
	}

	q.isInCurrentTown <- function()
	{
		local currentTown = this.getCurrentTown();
		local currentPlayerTown = ::World.State.getCurrentTown();
		// return currentTown != null && currentTown.getID() == this.m.CurrentTownID;
		local ret = currentTown != null && currentPlayerTown != null && currentTown.getID() == currentPlayerTown.getID();
		::logInfo("Follower in town? " + this.getName() + " " + (currentTown == null ? "FALSE" : currentTown.getName()));
		return ret;
		// return currentTown != null && ::World.State.getPlayer().getTile().getDistanceTo(currentTown.getTile()) < 10;
	}

	q.setCurrentTown <- function(_town)
	{
		if (_town != null)
		{
			this.m.CurrentTownID = _town.getID();
			this.m.CurrentTownArrivalDay = ::World.getTime().Days;
		}
		else
		{
			this.m.CurrentTownID = null;
			this.setKnownCurrentLocation(false);
		}
	}

	q.getCurrentTownID <- function()
	{
		return this.m.CurrentTownID;
	}

	q.getCurrentTown <- function()
	{
		 return this.isInTown() ? this.World.getEntityByID(this.m.CurrentTownID) : null;
	}

	q.getTimeRemainingInCurrentTown <- function()
	{
		// returns null when not in town
		return this.isInTown() ? (this.m.CurrentTownArrivalDay + ::Reforged.Retinue.DaysFollowerStaysInTown - ::World.getTime().Days) : null;
	}

	q.shouldLeaveTown <- function()
	{
		return this.isInTown() && this.getTimeRemainingInCurrentTown() <= 0;
	}

	q.setKnownCurrentLocation <- function(_bool)
	{
		this.m.IsKnownCurrentLocation = _bool;
	}

	q.getKnownCurrentLocation <- function(_bool)
	{
		return this.m.IsKnownCurrentLocation;
	}

	q.onEnterTown <- function(_town)
	{
		if (this.m.CurrentTownID == _town.getID())
		{
			this.setKnownCurrentLocation(true);
		}
	}
})
