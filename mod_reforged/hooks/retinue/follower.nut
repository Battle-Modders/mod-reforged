::Reforged.HooksMod.hook("scripts/retinue/follower", function(q) {
	q.m.PerkTree <- null;
	q.m.Skills <- null;
	q.m.IsHired <- false;

	q.m.CurrentTownTable <- null;
	q.m.HiredFromTownID <- null;

	q.m.DailyWage <- 10;
	q.m.DailyWageMult <- 1.0;
	q.m.DailyFood <- 2.0;

	q.create = @(__original) function()
	{
		__original();
		this.m.CurrentTownTable = {};
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

	q.getDailyCost <- function()
	{
		return this.Math.max(0, this.m.DailyWage * this.m.DailyWageMult * (("State" in this.World) && this.World.State != null ? this.World.Assets.m.DailyWageMult : 1.0));
	}

	q.getDailyFood <- function()
	{
		return this.Math.maxf(0.0, this.m.DailyFood);
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
		this.m.CurrentTownTable.clear();
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
			Towns = this.m.CurrentTownTable,
			LastKnownLocation = this.getLastKnownLocation(),

			DailyMoneyCost = this.getDailyCost(),
			DailyFood = this.getDailyFood(),
		};
	}

	q.isAvailableForHire <- function()
	{
		// Requirements for a follower to show up in a tavern
		// Vanilla uses this.isUnlocked()
		return true;
	}

	q.adaptFollowerSpawnChance <- function(_weightedContainer)
	{
		if (this.isHired())
		{
			_weightedContainer.setWeight(this.getID(), 0);
		}
		else
		{
			_weightedContainer.setWeight(this.getID(), this.getFollowerSpawnChance(_weightedContainer.getWeight(this.getID())));
		}
	}

	q.adaptSpawnInTownChance <- function(_weightedContainer)
	{
		_weightedContainer.setWeight(this.getID(), this.getFollowerSpawnChance(_weightedContainer.getWeight(this.getID())));
	}

	q.getFollowerSpawnChance <- function(_baseWeight)
	{
		return _baseWeight;
	}

	q.onNewDay = @(__original) function()
	{
		__original();
		foreach (townID, townInfo in this.m.CurrentTownTable)
		{
			townInfo.RemainingDays -= 1;
			if (townInfo.RemainingDays <= 0)
			{
				this.leaveTown(townID);
			}
		}
	}

	q.isInAnyTown <- function(_town)
	{
		return this.m.CurrentTownTable.len() > 0;
	}

	q.isInTown <- function(_townID)
	{
		return _townID in this.m.CurrentTownTable;
	}

	q.isInCurrentTown <- function()
	{
		local currentPlayerTown = ::World.State.getCurrentTown();
		return currentPlayerTown == null ? false : this.isInTown(currentPlayerTown.getID());
	}

	q.enterTown <- function(_townID)
	{
		local town = this.World.getEntityByID(_townID);
		this.m.CurrentTownTable[_townID] <- {
			ID = _townID,
			Name = town.getName(),
			ArrivalDay = ::World.getTime().Days,
			RemainingDays = ::World.getTime().Days + ::Reforged.Retinue.DaysFollowerStaysInTown,
			LastSeenDate = null,
		}
	}

	q.leaveTown <- function(_townID)
	{
		delete this.m.CurrentTownTable[_townID];
	}

	q.getCurrentTownIDs <- function()
	{
		// TODO Check if table supports map
		local ret = [];
		foreach (townID, _ in this.m.CurrentTownTable)
		{
			ret.append(townID);
		}
		return ret;
	}

	q.getCurrentTowns <- function()
	{
		local ret = [];
		foreach (townID, _ in this.m.CurrentTownTable)
		{
			ret.append(this.World.getEntityByID(townID));
		}
		return ret;
	}

	q.getLastKnownLocation <- function()
	{
		if (this.m.CurrentTownTable.len() == 0)
			return null;

		local newest = 0;
		local ret = null
		foreach (_, townInfo in this.m.CurrentTownTable)
		{
			local lastDate = townInfo.LastSeenDate;
			if (lastDate != null && lastDate > newest)
			{
				newest = lastDate;
				ret = townInfo;
			}
		}
		return ret;
	}

	q.onPlayerEnterTown <- function(_town)
	{
		if (this.isInTown(_town.getID()))
		{
			this.m.CurrentTownTable[_town.getID()].LastSeenDate = ::World.getTime().Days;
		}
	}
})
