::Reforged.HooksMod.hook("scripts/ui/screens/world/modules/world_town_screen/town_training_dialog_module", function(q) {
	q.queryRosterInformation = @(__original) function()
	{
		local ret = __original();
		local settlement = this.World.State.getCurrentTown();
		local perkGroupOffer = settlement.getFlags().get("rf_perkGroupOffer");
		if (perkGroupOffer == false){
			::logWarning("Reforged: Settlement with Name " + settlement.getName() + " does not have rf_perkGroupOffer flag! (during queryRosterInformation hook)");
			return ret;
		}
		perkGroupOffer = split(perkGroupOffer, ",");

		local function getPerkGroupUIData(_bro)
		{
			local perkGroupUIData = [];
			foreach (idx, perkGroupId in perkGroupOffer)
			{
				if (_bro.getPerkTree().hasPerkGroup(perkGroupId)) continue;
				local perkgroup = ::DynamicPerks.PerkGroups.findById(perkGroupId);
				perkGroupUIData.push({
					id = perkgroup.getID(), // will be needed to unlock the perk. vanilla has IDs from 0-2 here.
					icon = perkgroup.getIcon(),
					name = "Unlock " + perkgroup.getName(),
					tooltip = "world-town-screen.training-dialog-module.Train1",
					price = 3000 // tbd
				});
			}
			return perkGroupUIData;
		}

		local alreadyIn = [];
		foreach (broEntry in ret.Roster)
		{
			local bro = this.Tactical.getEntityByID(broEntry.ID);
			alreadyIn.append(bro.getID());
			// limit of 1 group right now
			if (bro.getFlags().get("rf_perkGroupAdded")) continue;

			local perkGroupUIData = getPerkGroupUIData(bro);
			::MSU.Log.printData(perkGroupUIData, 5, true);
			broEntry.Training.extend(perkGroupUIData);
		}

		// re-add the bros that were not included in vanilla (for example, level 11+)
		local brothers = this.World.getPlayerRoster().getAll();
		foreach(bro in brothers)
		{
			if (alreadyIn.find(bro.getID()) != null) continue;
			local perkGroupUIData = getPerkGroupUIData(bro);
			if (perkGroupUIData.len() > 0)
			{
				local background = bro.getBackground();
				local broEntry = {
					ID = bro.getID(),
					Name = bro.getName(),
					Level = bro.getLevel(),
					ImagePath = bro.getImagePath(),
					ImageOffsetX = bro.getImageOffsetX(),
					ImageOffsetY = bro.getImageOffsetY(),
					BackgroundImagePath = background.getIconColored(),
					BackgroundText = background.getDescription(),
					Training = perkGroupUIData,
					Effects = []
				};
				ret.Roster.push(broEntry)
			}
		}
		return ret;
	}


	q.onTrain = @(__original) function( _data )
	{
		local entityID = _data[0];
		local trainingID = _data[1];

		if ([0, 1, 2].find(trainingID) != null)
			return __original(_data);

		local perkGroup = ::DynamicPerks.PerkGroups.findById(trainingID);
		if (perkGroup == null)
		{
			::logWarning("Reforged: perkGroupId of training could not be found! ID: " + trainingID);
			return __original(_data); // should be OK
		}
		local entity = this.Tactical.getEntityByID(entityID);
		entity.getPerkTree().addPerkGroup(trainingID);
		entity.getFlags().set("rf_perkGroupAdded", trainingID);

		local price = 3000; //tbd
		this.World.Assets.addMoney(-price);

		// TODO discuss timer
		local effect = this.new("scripts/skills/effects_world/exhausted_effect");
		entity.getSkills().add(effect);

		local background = entity.getBackground();
		local e = {
			ID = entity.getID(),
			Name = entity.getName(),
			Level = entity.getLevel(),
			ImagePath = entity.getImagePath(),
			ImageOffsetX = entity.getImageOffsetX(),
			ImageOffsetY = entity.getImageOffsetY(),
			BackgroundImagePath = background.getIconColored(),
			BackgroundText = background.getDescription(),
			Training = [],
			Effects = []
		};
		e.Effects.push({
			id = effect.getID(),
			icon = effect.getIcon()
		});
		local r = {
			Entity = e,
			Assets = this.m.Parent.queryAssetsInformation()
		};
		return r;
	}
});
