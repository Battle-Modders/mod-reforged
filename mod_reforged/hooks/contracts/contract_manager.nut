::Reforged.HooksMod.hook("scripts/contracts/contract_manager", function(q) {
	// Map of SettlementName to an array of contracts.
	// Is used to serialize last known contracts of settlements.
	// We need to serialize contracts from contract_manager as settlements
	// need to be fully deserialized before any contract is deserialized.
	q.m.RF_LastVisitContracts <- {};

	// Returns an array of contracts that are known to the player. This is all the contracts
	// if the player has Agent. Otherwise all the last known contracts from visited settlements.
	q.RF_getKnownContracts <- { function RF_getKnownContracts( _includeActive = false )
	{
		local ret;
		if (::World.Retinue.hasFollower("follower.agent"))
		{
			ret = this.getOpenContracts();
		}
		else
		{
			// We first put in the list the last known contracts.
			// Afterwards we extend it with current open contracts.
			// Because after deserialization, we need to ensure that the last known
			// contracts take priority in being displayed in the tooltip.
			ret = [];
			foreach (list in this.m.RF_LastVisitContracts)
			{
				ret.extend(list);
			}

			// We set contract to started whenever we visit its settlement. So isStarted() means
			// that the player knows about this contract.
			// We have to do "uniques" by comparing IDs because after deserialization
			// contracts with identical IDs will be present in OpenContracts and LastVisitContracts.
			local ids = ret.map(@(_c) _c.getID());
			ret.extend(this.getOpenContracts().filter(@(_, _c) _c.isStarted() && ids.find(_c.getID()) == null));
		}

		if (_includeActive && !::MSU.isNull(this.getActiveContract()))
		{
			ret.insert(0, this.getActiveContract());
		}

		return ret;
	}}.RF_getKnownContracts;

	q.addContract = @(__original) { function addContract( _contract, _isNewContract = true )
	{
		if (!_isNewContract)
		{
			__original(_contract, _isNewContract);
			return;
		}

		// original function can result in the contract not being added. If it was
		// successfully added, it will be assigned a new ID. So we check for that.
		local IDBefore = _contract.m.ID;

		__original(_contract, _isNewContract);

		// We "start" the contract if the player has Agent follower immediately upon contract
		// being added. This enables the nested tooltip of this contract to show the origin/home/payment properly.
		if (_contract.m.ID != IDBefore && ::World.Retinue.hasFollower("follower.agent"))
		{
			_contract.RF_fakeStart();
		}
	}}.addContract;

	q.onSerialize = @(__original) { function onSerialize( _out )
	{
		__original(_out);

		_out.writeU16(this.m.RF_LastVisitContracts.len());
		foreach (settlementName, contracts in this.m.RF_LastVisitContracts)
		{
			_out.writeString(settlementName);
			_out.writeU8(contracts.len());
			foreach (c in contracts)
			{
				_out.writeI32(c.ClassNameHash);
				c.onSerialize(_out);
			}
		}
	}}.onSerialize;

	q.onDeserialize = @(__original) { function onDeserialize( _in )
	{
		__original(_in);

		if (::Reforged.Mod.Serialization.isSavedVersionAtLeast("0.8.5", _in.getMetaData()))
		{
			// This array is populated with the last visit situations of all settlements.
			// It is used to re-attach the deserialized last visit contracts to their situations.
			local situations = [];
			foreach (settlement in ::World.EntityManager.getSettlements())
			{
				situations.extend(settlement.m.RF_LastVisitSituations);
			}

			this.m.RF_LastVisitContracts = {};

			local count = _in.readU16();
			for (local i = 0; i < count; i++)
			{
				local settlementName = _in.readString();

				local contracts = [];
				local contractsCount = _in.readU8();
				for (local j = 0; j < contractsCount; j++)
				{
					local c = ::new(::IO.scriptFilenameByHash(_in.readI32()));
					c.onDeserialize(_in);
					contracts.push(c);

					if (c.m.SituationID == null)
						continue;

					// Re-attach this contract to the last known situation it belongs to.
					foreach (s in situations)
					{
						if (s.getInstanceID() == c.m.SituationID)
						{
							s.m.RF_LastVisitContracts.push(::MSU.asWeakTableRef(c));
							break;
						}
					}
				}

				this.m.RF_LastVisitContracts[settlementName] <- contracts;

				// Re-populate the last visit contracts of the settlement
				// this contracts array was originally from.
				foreach (s in ::World.EntityManager.getSettlements())
				{
					if (s.getName() == settlementName)
					{
						s.m.RF_LastVisitContracts = contracts;
						break;
					}
				}
			}
		}
	}}.onDeserialize;
});
