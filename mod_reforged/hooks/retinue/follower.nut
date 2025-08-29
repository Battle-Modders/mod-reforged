::Reforged.HooksMod.hook("scripts/retinue/follower", function(q) {
	q.m.PerkTree <- null;
	q.m.Skills <- null;

	q.m.IsDiscovered <- false;
	q.m.IsHired <- false;

	q.m.CurrentTownTable <- null;
	q.m.HiredFromTownID <- -1;

	q.m.DailyWage <- 10;
	q.m.DailyWageMult <- 1.0;
	q.m.DailyFood <- 2.0;

	q.m.BaseSpawnChance <- 1.0;

	q.create = @(__original) function()
	{
		__original();
		this.m.CurrentTownTable = {};
		// TODO
		if (this.m.ID in ::Reforged.Retinue.FollowerDefs)
		{
			this.m.PerkTree = ::Reforged.Retinue.FollowerDefs[this.m.ID].PerkTree;
		}
		else
		{
			this.m.PerkTree = ::Reforged.Retinue.FollowerDefs["follower.debug"].PerkTree;
		}
		this.m.Skills = ::new("scripts/skills/rf_follower_skill_container");
	}

	q.discover <- function()
	{
		this.m.IsDiscovered = true;
		local persistentDiscoveredFollowers = ::Reforged.Mod.PersistentData.hasFile("DiscoveredFollowers") ? ::Reforged.Mod.PersistentData.readFile("DiscoveredFollowers") : [];
		if (!(this.getID() in persistentDiscoveredFollowers))
		{
			persistentDiscoveredFollowers.push(this.getID());
			::Reforged.Mod.PersistentData.createFile("DiscoveredFollowers", persistentDiscoveredFollowers);
		}
	}

	q.getDailyCost <- function()
	{
		return this.Math.max(0, this.m.DailyWage * this.m.DailyWageMult * (("State" in this.World) && this.World.State != null ? this.World.Assets.m.DailyWageMult : 1.0));
	}

	q.getDailyFood <- function()
	{
		return this.Math.maxf(0.0, this.m.DailyFood);
	}

	q.getPerkTreeForUI <- function()
	{
		local arePerksUnlockable = this.isHired();
		local perkTree = [];
		foreach (row in this.m.PerkTree)
		{
			local perkTreeRow = [];
			perkTree.push(perkTreeRow)
			foreach(perkID in row)
			{
				local perkDef = ::Reforged.Retinue.getPerk(perkID);
				perkTreeRow.push(perkDef);
				perkDef.Requirements <- ::Reforged.Retinue.getPerkRequirementsUIData(perkDef, this);
				perkDef.IsUnlockable <- arePerksUnlockable;
				foreach (req in perkDef.Requirements)
				{
					if (!req.isValid)
					{
						perkDef.IsUnlockable = false;
					}
				}
			}
		}
		return perkTree;
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


		local perk = ::Reforged.Retinue.getPerk(_id);

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
		local data = {
			ImagePath = this.getImage() + ".png",
			ID = this.getID(),
			Name = this.getName(),
			Description = this.getDescription(),
			Cost = this.getCost(),
			Effects = this.getEffects(),
			Requirements = this.getRequirements(),
			IsUnlocked = true,

			PerkTree = this.getPerkTreeForUI(),
			Perks = this.m.Skills.getAllSkills().map(@(_perk) _perk.getID()),
			IsAvailableForHire = this.isAvailableForHire(),
			IsHired = this.isHired(),
			IsInCurrentTown = this.isInCurrentTown(),
			IsDiscovered = this.m.IsDiscovered || ::Reforged.Mod.ModSettings.getSetting("RevealFollowers").getValue(),
			Towns = ::MSU.Table.values(this.m.CurrentTownTable),
			LastKnownLocation = this.getLastKnownLocation(),
			IsKnownLocation = this.getLastKnownLocation() != null,

			DailyMoneyCost = this.getDailyCost(),
			DailyFood = this.getDailyFood(),
		};
		return data;
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
			local adaptedWeight = this.getSpawnChance(_weightedContainer.getWeight(this.getID()));
			_weightedContainer.setWeight(this.getID(), adaptedWeight);
		}
	}

	q.adaptTownWeightsForSpawning <- function(_weightedContainer)
	{

	}

	q.getSpawnChance <- function(_baseWeight)
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
			RemainingDays = ::Reforged.Retinue.DaysFollowerStaysInTown,
			LastSeenDate = -1,
		}

		local situation = ::new("scripts/entity/world/settlements/situations/rf_follower_present_situation");
		situation.setFollower(this);
		town.addSituation(situation, this.m.CurrentTownTable[_townID].RemainingDays);
	}

	q.leaveTown <- function(_townID)
	{
		local town = this.m.CurrentTownTable[_townID];
		local situationID = format("situation.rf_follower_present.%s", this.getID());
		town.removeSituationByID(situationID);
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
			if (lastDate != -1 && lastDate > newest)
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
			this.discover();
		}
	}

	q.onSerialize = @(__original) function(_out)
	{
		__original(_out)
		this.m.Skills.onSerialize(_out);
		_out.writeBool(this.m.IsDiscovered);
		_out.writeBool(this.m.IsHired);
		_out.writeI8(this.m.HiredFromTownID);
		_out.writeU8(this.m.DailyWage);
		::MSU.Serialization.serialize(this.m.CurrentTownTable, _out);
	}

	q.onDeserialize = @(__original) function(_in)
	{
		__original(_in);
		this.m.Skills.onDeserialize(_in);
		this.m.IsDiscovered = _in.readBool();
		this.m.IsHired = _in.readBool();
		this.m.HiredFromTownID = _in.readI8();
		this.m.DailyWage = _in.readU8();

		this.m.CurrentTownTable.clear()
		::MSU.Serialization.deserializeInto(this.m.CurrentTownTable, _in);
	}
})
