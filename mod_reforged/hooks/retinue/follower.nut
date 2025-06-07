::Reforged.HooksMod.hook("scripts/retinue/follower", function(q) {
	q.m.PerkTree <- null;
	q.m.IsHired <- false;
	q.m.CurrentTownID <- null;
	q.m.ArrivedInTownDay <- null;

	q.create = @(__original) function()
	{
		__original();
		// TODO
		this.m.PerkTree = [];
	}

	q.getPerkTree <- function()
	{
		return this.m.PerkTree;
	}

	q.isHired <- function()
	{
		return this.m.IsHired;
	}

	o.unlockPerk <- function( _id )
	{
		// TODO
		if (this.hasPerk(_id))
		{
			return true;
		}

		local perk = this.Const.Perks.findById(_id);

		if (perk == null)
		{
			return false;
		}

		++this.m.PerkPointsSpent;
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

	q.onNewDay = @(__original) function()
	{
		__original();
		if (this.shouldLeavetown())
		{
			this.leaveTown()
		}
	}

	q.getUIData <- function()
	{
		return {
			ImagePath = this.getImage() + ".png",
			ID = this.getID(),
			Name = this.getName(),
			Description = this.getDescription(),
			isAvailableForHire = this.isAvailableForHire(),
			isHired = this.isHired(),
			Cost = this.getCost(),
			Effects = this.getEffects(),
			Requirements = this.getRequirements(),
			perkTree = this.getPerks(),
		};
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

	q.enterTown <- function(_town)
	{
		this.m.CurrentTownID = _town.getID();
		this.m.ArrivedInTownDay = ::World.getTime().Days;
	}

	q.getCurrentTownID <- function()
	{
		return this.m.CurrentTownID;
	}

	q.shouldLeavetown <- function()
	{
		return ::World.getTime().Days > this.m.ArrivedInTownDay + ::Reforged.Retinue.DaysFollowerStaysInTown;
	}

	q.leaveTown <- function()
	{
		this.m.CurrentTownID <- null;
	}
})
