::Reforged.HooksMod.hook("scripts/entity/world/settlement", function(q) {
	q.m.RF_LastVisitSituations <- [];
	q.m.RF_LastVisitContracts <- [];

	q.RF_clearLastVisitInfo <- { function RF_clearLastVisitInfo()
	{
		this.getFlags().remove("RF_LastVisitDay");
		this.m.RF_LastVisitContracts.clear();
		this.m.RF_LastVisitSituations.clear();
		foreach (s in this.getSituations())
		{
			s.m.RF_LastVisitContracts.clear();
		}
	}}.RF_clearLastVisitInfo;

	q.RF_saveLastVisitInfo <- { function RF_saveLastVisitInfo()
	{
		this.getFlags().set("RF_LastVisitDay", ::World.getTime().Days);
		this.m.RF_LastVisitSituations = clone this.getSituations();

		foreach (c in this.getContracts())
		{
			if (::MSU.isEqual(c, ::World.Contracts.getActiveContract()))
				continue;

			this.m.RF_LastVisitContracts.push(c);
			if (c.m.SituationID == 0)
				continue;

			foreach (s in this.m.RF_LastVisitSituations)
			{
				if (s.getInstanceID() == c.m.SituationID)
				{
					s.m.RF_LastVisitContracts.push(::MSU.asWeakTableRef(c));
					break;
				}
			}
		}

		::World.Contracts.m.RF_LastVisitContracts[this.getName()] <- this.m.RF_LastVisitContracts;
	}}.RF_saveLastVisitInfo;

	// Add character image to the UI information for the character offering this contract.
	q.getUIContractInformation = @(__original) { function getUIContractInformation()
	{
		local ret = __original();
		foreach (c in ret.Contracts)
		{
			foreach (contract in this.getContracts())
			{
				if (contract.getID() == c.ID)
				{
					c.CharacterImagePath <- contract.getCharacter().getImagePath();
					break;
				}
			}
		}
		return ret;
	}}.getUIContractInformation;

	// Add character image to the UI information for the character offering this contract.
	q.getUIInformation = @(__original) { function getUIInformation()
	{
		local ret = __original();
		foreach (c in ret.Contracts)
		{
			foreach (contract in this.getContracts())
			{
				if (contract.getID() == c.ID)
				{
					c.CharacterImagePath <- contract.getCharacter().getImagePath();
					break;
				}
			}
		}
		return ret;
	}}.getUIInformation;

	q.RF_getLastVisitInfoTooltip <- { function RF_getLastVisitInfoTooltip()
	{
		if (!this.getFlags().has("RF_LastVisitDay"))
			return [];

		local entry = {
			id = 10, type = "hint", icon = "ui/icons/action_points.png",
			text = format("You were there %s", ::Reforged.Text.getDaysAgoAsText(::World.getTime().Days - this.getFlags().get("RF_LastVisitDay")))
		};

		if (this.RF_isShowingLastVisitInfo())
		{
			local list = this.RF_getLastVisitSituationsTooltip();
			list.extend(this.RF_getLastVisitContractsTooltip())

			if (list.len() != 0)
			{
				entry.text += " and noticed";
				entry.children <- list;
			}
		}

		return [entry];
	}}.RF_getLastVisitInfoTooltip;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();

		ret.extend(this.RF_getLastVisitInfoTooltip());

		// Convert situations and contracts to nested tooltips
		// e.g. the ones added by Agent follower.
		local contractNames = this.getContracts().map(@(_c) _c.getName());
		local situationNames = this.getSituations().map(@(_s) _s.getName());
		// Convert building names to nested tooltips.
		local buildingNames = this.m.Buildings.map(@(_b) _b == null ? null : _b.getName());
		foreach (entry in ret)
		{
			local idx = contractNames.find(entry.text);
			if (idx != null)
			{
				local c = this.getContracts()[idx];
				entry.text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedObjectName(c, "func:RF_getTooltip,contentType:settlement-status-effect"));
				continue;
			}
			idx = situationNames.find(entry.text);
			if (idx != null)
			{
				local s = this.getSituations()[idx];
				entry.text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedObjectName(s, "contentType:settlement-status-effect"))
				continue;
			}
			idx = buildingNames.find(entry.text);
			if (idx != null)
			{
				local b = this.m.Buildings[idx];
				entry.text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedObjectName(b, "func:RF_getTooltip,contentType:settlement-status-effect"))
			}
		}
		return ret;
	}}.getTooltip;

	q.RF_isShowingLastVisitInfo <- { function RF_isShowingLastVisitInfo()
	{
		return !::World.Retinue.hasFollower("follower.agent");
	}}.RF_isShowingLastVisitInfo;

	q.RF_getLastVisitSituationsTooltip <- { function RF_getLastVisitSituationsTooltip()
	{
		local ret = [];
		local addedSituations = [];
		foreach (s in this.m.RF_LastVisitSituations)
		{
			if (addedSituations.find(s.getName()) != null)
				continue;

			addedSituations.push(s.getName());
			ret.push({
				id = 100, type = "text", icon = s.getIcon(),
				text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedObjectName(s, "contentType:settlement-status-effect"))
			});
		}
		return ret;
	}}.RF_getLastVisitSituationsTooltip;

	q.RF_getLastVisitContractsTooltip <- { function RF_getLastVisitContractsTooltip()
	{
		return this.m.RF_LastVisitContracts.map(@(_c) {
			id = 200, type = "text", icon = _c.RF_getTooltipIcon(),
			text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedObjectName(_c, "func:RF_getTooltip,contentType:settlement-status-effect"))
		});
	}}.RF_getLastVisitContractsTooltip;

	q.setOwner = @(__original) { function setOwner( _owner )
	{
		__original(_owner);
		this.adjustBannerOffset();
	}}.setOwner;

	q.setActive = @(__original) { function setActive( _a, _burn = true )
	{
		__original(_a, _burn);
		this.adjustBannerOffset();
	}}.setActive;


	q.addSituation = @(__original) { function addSituation( _s, _validForDays = 0 )
	{
		_s.m.RF_Settlement = ::MSU.asWeakTableRef(this);
		return __original(_s, _validForDays);
	}}.addSituation;

	q.onSerialize = @(__original) { function onSerialize( _out )
	{
		__original(_out);

		_out.writeU8(this.m.RF_LastVisitSituations.len());
		foreach (s in this.m.RF_LastVisitSituations)
		{
			_out.writeI32(s.ClassNameHash);
			s.onSerialize(_out);
		}
	}}.onSerialize;

	q.onDeserialize = @(__original) { function onDeserialize( _in )
	{
		__original(_in);

		foreach (s in this.getSituations())
		{
			s.m.RF_Settlement = ::MSU.asWeakTableRef(this);
		}

		if (::Reforged.Mod.Serialization.isSavedVersionAtLeast("0.8.5", _in.getMetaData()))
		{
			local count = _in.readU8();
			this.m.RF_LastVisitSituations = array(count);
			for (local i = 0; i < count; i++)
			{
				local s = ::new(::IO.scriptFilenameByHash(_in.readI32()));
				s.onDeserialize(_in);
				this.m.RF_LastVisitSituations[i] = s;
				s.m.RF_Settlement = ::MSU.asWeakTableRef(this);
			}
		}
	}}.onDeserialize;
});

::Reforged.HooksMod.hookTree("scripts/entity/world/settlement", function(q) {
	q.onEnter = @(__original) { function onEnter()
	{
		local ret = __original();

		// If ret is true that means we successfully entered the settlement.
		// We check for isEnterable() because when entering a *hostile* town via world_state.enterLocation
		// the game will call `onEnter` even though the town returns false for `isEnterable`. In this case,
		// the world_state.m.LastEnteredTown will be null which breaks the starting of contracts that need
		// it for setting their m.Home.
		if (ret && this.isEnterable())
		{
			this.RF_clearLastVisitInfo();

			// Have to switcheroo the last entered town because contract.start() often needs
			// getCurrentTown() to set some stuff. Sometimes, this is necessary even to set the
			// m.Home of the contract. And in some cases (e.g. traveling by Port) the last town
			// entered is not set until after onEnter.
			local original_LastEnteredTown = ::World.State.m.LastEnteredTown;
			::World.State.m.LastEnteredTown = ::MSU.asWeakTableRef(this);

			// Start all contracts present in this settlement.
			// Starting the contract sets up its origin/home/payment/destination etc.
			foreach (c in this.getContracts())
			{
				if (!c.isStarted())
					c.start();
			}

			::World.State.m.LastEnteredTown = original_LastEnteredTown;
		}
		return ret;
	}}.onEnter;

	q.onLeave = @(__original) { function onLeave()
	{
		__original();
		this.RF_saveLastVisitInfo();
	}}.onLeave;
});
