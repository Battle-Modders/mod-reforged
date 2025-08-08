::Reforged.Const.TrainablePGC <- [	// Perk Group Category
	{
		Id = "pgc.rf_weapon",
		Excluded = [],	// Array of PerkGroup Ids that should never be offered
		Price = 2500
	},
	{
		Id = "pgc.rf_armor",
		Excluded = [],	// Array of PerkGroup Ids that should never be offered
		Price = 3000
	}
];

::Reforged.HooksMod.hook("scripts/ui/screens/world/modules/world_town_screen/town_training_dialog_module", function(q) {
	q.queryRosterInformation = @(__original) function()
	{
		local ret = __original();

		// First we add Perk Training Options to any Bro-Entry who already exists in ret
		local alreadyIn = [];
		foreach (broEntry in ret.Roster)
		{
			local bro = ::Tactical.getEntityByID(broEntry.ID);
			alreadyIn.push(bro.getID());
			broEntry.Training = this.queryBroInformation(bro).Training;
		}

		// Then we add brother entries for anyone, who has any Training option available
		foreach (bro in ::World.getPlayerRoster().getAll())
		{
			if (alreadyIn.find(bro.getID()) != null) continue;

			local broEntry = this.queryBroInformation(bro);
			if (broEntry.Training.len() == 0) continue;
			ret.Roster.push(broEntry);
		}
		return ret;
	}

	q.onTrain = @(__original) function( _data )
	{
		local entityID = _data[0];
		local trainingID = _data[1];

		local bro = ::Tactical.getEntityByID(entityID);

		if (typeof trainingID == "integer")		// Vanilla training options have integer ids
		{
			__original(_data);
		}
		else
		{
			if (::DynamicPerks.PerkGroups.findById(trainingID) == null)
			{
				::logWarning("Reforged: perkGroupId of training could not be found! ID: " + trainingID);
			}
			else
			{
				local broInfo = this.queryBroInformation(bro);
				bro.getFlags().set("rf_perkGroupAdded", trainingID);
				bro.getPerkTree().addPerkGroup(trainingID);
				bro.getSkills().add(::new("scripts/skills/effects_world/exhausted_effect"));

				foreach (trainingOption in broInfo.Training)
				{
					if (trainingOption.id == trainingID)
					{
						::World.Assets.addMoney(-trainingOption.price);
						break;
					}
				}
			}
		}

		local ret = {};
		ret.Assets <- this.m.Parent.queryAssetsInformation();
		ret.Entity <- this.queryBroInformation(bro);
		return ret;
	}

// New Functions
	// Query the UI information for a single brother including all training options available
	// This function is now the "one source of truth" for the vanilla training options
	// @return table with the UI information related to the brother
	q.queryBroInformation <- function( _bro )
	{
		local background = _bro.getBackground();
		local broEntry = {
			ID = _bro.getID(),
			Name = _bro.getName(),
			Level = _bro.getLevel(),
			ImagePath = _bro.getImagePath(),
			ImageOffsetX = _bro.getImageOffsetX(),
			ImageOffsetY = _bro.getImageOffsetY(),
			BackgroundImagePath = background.getIconColored(),
			BackgroundText = background.getDescription(),
			Training = [],
			Effects = []
		};

		if (!_bro.getSkills().hasSkill("effects.trained"))
		{
			broEntry.Training.push({
				id = 0,
				icon = "skills/status_effect_75.png",
				name = "Sparring Fight",
				tooltip = "world-town-screen.training-dialog-module.Train1",
				price = 80 + 50 * _bro.getLevel()
			});
			broEntry.Training.push({
				id = 1,
				icon = "skills/status_effect_76.png",
				name = "Veteran\'s Lessons",
				tooltip = "world-town-screen.training-dialog-module.Train2",
				price = 100 + 60 * _bro.getLevel()
			});
			broEntry.Training.push({
				id = 2,
				icon = "skills/status_effect_77.png",
				name = "Rigorous Schooling",
				tooltip = "world-town-screen.training-dialog-module.Train3",
				price = 90 + 55 * _bro.getLevel()
			});
		}

		if (!_bro.getFlags().get("rf_perkGroupAdded"))		// limit of 1 group right now
		{
			// @return array with a table for every perk group that can be learned by this brother
			// Those tables have the same structure as the vanilla training offer tables
			local function getPerkGroupUIData(_bro)
			{
				local possiblePerkGroupIDs = {};
				foreach (trainablePGC in ::Reforged.Const.TrainablePGC)
				{
					foreach (perkGroupID in ::DynamicPerks.PerkGroupCategories.findById(trainablePGC.Id).getGroups())
					{
						if (perkGroupID in possiblePerkGroupIDs) continue;	// We don't want duplicates
						if (perkGroupID in trainablePGC.Excluded) continue;	// We don't want groups that are marked as excluded
						possiblePerkGroupIDs[perkGroupID] <- trainablePGC.Price;
					}
				}

				local perkGroupUIData = [];
				foreach (perkGroupId, price in possiblePerkGroupIDs)
				{
					if (_bro.getPerkTree().hasPerkGroup(perkGroupId)) continue;		// We don't want groups that the brother already knows

					local perkgroup = ::DynamicPerks.PerkGroups.findById(perkGroupId);
					perkGroupUIData.push({
						id = perkgroup.getID(), // will be needed to unlock the perk. vanilla has IDs from 0-2 here.
						icon = perkgroup.getIcon(),
						name = "Unlock " + perkgroup.getName(),
						tooltip = "world-town-screen.training-dialog-module.Train1",
						price = price,
					});
				}
				return perkGroupUIData;
			}

			local perkGroupUIData = getPerkGroupUIData(_bro);
			broEntry.Training.extend(perkGroupUIData);
		}

		return broEntry;
	}
});
