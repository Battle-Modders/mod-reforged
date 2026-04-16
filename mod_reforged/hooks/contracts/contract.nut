::Reforged.HooksMod.hook("scripts/contracts/contract", function(q)
{
	// Is used to "start" a contract so that its home, origin, destination, payment etc.
	// is fully set and generated.
	q.RF_fakeStart <- { function RF_fakeStart()
	{
		if (this.isStarted())
			return;

		// If the faction of this contract has only a single settlement, and the contract doesn't have
		// a home set, then we can safely set that settlement as its home.
		if (::MSU.isNull(this.getHome()))
		{
			local settlements = ::World.FactionManager.getFaction(this.getFaction()).getSettlements();
			if (settlements.len() == 1)
			{
				this.setHome(settlements[0]);
			}
		}

		// If the contract HAS a home set, then we start it.
		if (!::MSU.isNull(this.getHome()))
		{
			// Have to switcheroo the last entered town because contract.start()
			// often needs getCurrentTown() to set some stuff.
			local original_LastEnteredTown = ::World.State.m.LastEnteredTown;
			::World.State.m.LastEnteredTown = ::MSU.asWeakTableRef(this.getHome());

			this.start();

			::World.State.m.LastEnteredTown = original_LastEnteredTown;
		}
	}}.RF_fakeStart;

	q.RF_getDescription <- { function RF_getDescription()
	{
		local ret = this.RF_getOriginText();
		if (ret != "")
		{
			ret += "\n\n";
		}
		return ret + this.RF_getOfferedByText();
	}}.RF_getDescription;

	// Returns text showing who is offering this contract and where.
	q.RF_getOfferedByText <- { function RF_getOfferedByText()
	{
		local faction = ::World.FactionManager.getFaction(this.getFaction());
		// TODO: Currently we use parseTooltip to just show the name of the character
		// just like vanilla shows only name on faction relations screen for character tooltips.
		// Perhaps we can implement a better/more beautiful tooltip for such characters at some point.
		local characterString = ::MSU.isNull(this.getCharacter()) ? "someone" : format("[%s|Tooltip+%s]", this.getCharacter().getName(), ::Reforged.Mod.Tooltips.parseTooltip([{id = 1, type = "title", text = this.getCharacter().getName()}]));
		local factionString = "";
		local homeString = "";
		if (::MSU.isNull(this.getHome()))
		{
			homeString = " somewhere";
		}
		else if (!::MSU.isEqual(::World.State.getCurrentTown(), this.getHome()))
		{
			homeString = " in " + ::Reforged.NestedTooltips.getNestedObjectName(this.getHome(), "contentType:settlement-status-effect");
		}

		if (::MSU.isNull(this.getHome()) || faction.getName() != this.getHome().getName())
		{
			factionString = " of " + ::Reforged.NestedTooltips.getNestedObjectName(faction, "func:RF_getTooltip,contentType:settlement-status-effect");
		}

		return ::Reforged.Mod.Tooltips.parseString(format("Offered by %s%s%s", characterString, factionString, homeString));
	}}.RF_getOfferedByText;

	// Returns text that shows the origin, direction and destination of this contract and the distance.
	q.RF_getOriginText <- { function RF_getOriginText()
	{
		local ret = "";

		// Origin is a location from which directions are based off of.
		local origin = ::MSU.isNull(this.getOrigin()) ? this.getHome() : this.getOrigin();
		if (!::MSU.isNull(origin))
		{
			local destinations = this.RF_getDestinations();
			foreach (i, d in destinations)
			{
				if (i != 0)
				{
					ret += " then ";
				}
				if (::MSU.isEqual(origin, d))
				{
					ret += i == 0 ? "Around " : "around ";
				}
				else if (!::MSU.isNull(d))
				{
					local distance = this.RF_getDaysRequiredToTravel(origin, d);
					ret += format("%s about %s %s of ",
									::Reforged.NestedTooltips.getNestedObjectName(d),
									::Reforged.Text.getDaysAndHalf(distance),
									::Const.Strings.Direction8[origin.getTile().getDirection8To(d.getTile())]);
				}

				if (i != 0)
				{
					ret += "there";
				}
				else
				{
					// If origin is the same as the town we are in, then say "here" instead of town name
					ret += ::MSU.isEqual(::World.State.getCurrentTown(), origin) ? "here" : ::Reforged.NestedTooltips.getNestedObjectName(origin, "contentType:settlement-status-effect");

					if (!::MSU.isNull(this.getHome()) && !::MSU.isEqual(origin, this.getHome()))
					{
						local distance = this.RF_getDaysRequiredToTravel(origin, this.getHome());
						ret += format(" about %s %s of ", ::Reforged.Text.getDaysAndHalf(distance), ::Const.Strings.Direction8[this.getHome().getTile().getDirection8To(origin.getTile())]);
						ret += ::MSU.isEqual(::World.State.getCurrentTown(), this.getHome()) ? "here" : ::Reforged.NestedTooltips.getNestedObjectName(this.getHome(), "contentType:settlement-status-effect");
					}
				}

				origin = d;
			}
		}

		return ::Reforged.Mod.Tooltips.parseString(ret);
	}}.RF_getOriginText;

	// Returns the goal location of this contract, if one exists.
	// Necessary to calculate the correct distance and location in the contract tooltip.
	// Most of the times it is Origin. But some contracts have custom members like m.Destination, m.Location.
	q.RF_getDestinations <- { function RF_getDestinations()
	{
		return ::MSU.isIn("Destination", this.m, true) && !::MSU.isNull(this.m.Destination) ? [this.m.Destination] : [this.getOrigin()];
	}}.RF_getDestinations;

	// Returns the days required to travel for the purposes of showing in the contract tooltip.
	// Should be ovewritten by child contracts if they have a different speed or road restriction e.g. escort_caravan_contract.
	q.RF_getDaysRequiredToTravel <- { function RF_getDaysRequiredToTravel( _start, _dest )
	{
		return this.getDaysRequiredToTravel(_start.getTile().getDistanceTo(_dest.getTile()), ::Const.World.MovementSettings.Speed, false);
	}}.RF_getDaysRequiredToTravel;

	q.RF_getTooltip <- { function RF_getTooltip()
	{
		local daysRemaining = (this.m.TimeOut - ::Time.getVirtualTimeF()) / ::World.getTime().SecondsPerDay;

		local ret = [
			{
				id = 1, type = "title", text = this.getName()
			},
			{
				id = 2, type = "description", text = this.RF_getDescription()
			},
			{
				// daysRemaining < 0 will only be true for "last-known" contracts from your last visit
				id = 3, type = "hint", icon = "ui/icons/action_points.png",
				text = daysRemaining < 0 ? "Is likely no longer available" : "Will be available for " + ::Reforged.Text.getDaysRemainingText(daysRemaining)
			},
			{
				id = 100, type = "rf_image", image = ::String.replace(this.getUIDifficultySmall(), "difficulty", "rf_difficulty") + "_tooltip.png", cssClass = "rf-contract-difficulty-tooltip"
			}
		];

		if (this.m.IsStarted || this.isNegotiated())
		{
			local payment = this.getPayment();
			local advance = payment.getInAdvance();
			local completion = payment.getOnCompletion();
			local perCount = payment.getPerCount();
			local strs = [];
			if (advance != 0)
			{
				strs.push(advance + " crowns in advance");
			}
			if (completion != 0)
			{
				strs.push(completion + " crowns on completion");
			}
			if (perCount != 0)
			{
				strs.push(perCount + " crowns per head");
			}
			if (strs.len() != 0)
			{
				local str = format("%s %s", this.isNegotiated() ? "You negotiated this contract for" : "Offering", strs[0]);
				for (local i = 1; i < strs.len(); i++)
				{
					if (i != strs.len() - 1)
					{
						str += ", ";
					}
					else
					{
						str += " and ";
					}
					str += ::String.replace(strs[i], "crowns ", "");
				}
				ret.push({
					id = 4, type = "hint", icon = "ui/icons/asset_money.png",
					text = str
				});
			}
		}

		if (this.m.SituationID != null)
		{
			local hasAgent = ::World.Retinue.hasFollower("follower.agent");
			local situations = [];
			foreach (settlement in ::World.EntityManager.getSettlements())
			{
				if (hasAgent)
				{
					situations.extend(settlement.getSituations());
				}
				// Without Agent we only know the last visit situations of all settlements
				// and current situations of currently being visited settlement.
				else
				{
					if (::MSU.isEqual(::World.State.getCurrentTown(), settlement))
					{
						situations.extend(settlement.getSituations());
					}
					else
					{
						situations.extend(settlement.m.RF_LastVisitSituations);
					}
				}
			}

			foreach (s in situations)
			{
				if (s.getInstanceID() == this.m.SituationID)
				{
					ret.push({
						id = 100, type = "hint", icon = s.getIcon(),
						text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedObjectName(s, "contentType:settlement-status-effect"))
					});
					break;
				}
			}
		}

		return ret;
	}}.RF_getTooltip;

	q.RF_getTooltipIcon <- { function RF_getTooltipIcon()
	{
		return this.isNegotiated() ? "ui/icons/rf_contract_scroll_negotiated.png" : "ui/icons/contract_scroll.png";
	}}.RF_getTooltipIcon;

	// This is a close copy of how vanilla calculates their distance duration in getDaysRequiredToTravel
	q.getSecondsRequiredToTravel <- { function getSecondsRequiredToTravel( _numTiles, _speed, _onRoadOnly = false )
	{
		_speed *= ::Const.World.MovementSettings.GlobalMult;
		if (_onRoadOnly) _speed *= ::Const.World.MovementSettings.RoadMult;
		return _numTiles * 170.0 / _speed;
	}}.getSecondsRequiredToTravel;

	// Returns a TooltipID used to bind the tooltip of the character/banner/destination being displayed
	// on the screen. Similar to the usage of the vanilla `getUICharacterImage` function.
	q.RF_getUICharacterTooltipID <- { function RF_getUICharacterTooltipID( _index = 0 )
	{
		local image = this.getUICharacterImage(_index);
		if (image == null)
			return null;

		local imagePath = image.Image;

		// In Reforged we pass the destination's image sometimes, so we handle that here.
		if ("Destination" in this.m && !::MSU.isNull(this.m.Destination) && this.m.Destination.getImagePath() == imagePath)
		{
			return "WorldEntity+" + this.m.Destination.getID();
		}

		if ("Characters" in this.m.ActiveScreen && this.m.ActiveScreen.Characters.len() > _index)
		{
			// Vanilla stores references to actors in the `m` table of the contract. So we have to iterate
			// over that and use the imagePath to detect if this is the actor we are looking for.
			foreach (k, v in this.m)
			{
				// We cannot compare getImagePath to the imagePath stored here because
				// actor.getImagePath adds m.ContendID to it which can be different every time.
				// We instead check if the actor's ID is present in the imagePath between two commas.
				if (::MSU.isKindOf(v, "actor") && imagePath.find("," + v.getID() + ",") != null)
				{
					return "EventActor+" + v.getID();
				}
			}
		}

		if ("Banner" in this.m.ActiveScreen && imagePath == this.m.ActiveScreen.Banner)
		{
			foreach (f in ::World.FactionManager.getFactions())
			{
				if (f != null && (imagePath == f.getUIBanner() || imagePath == f.getUIBannerSmall()))
				{
					return "Faction+" + f.getID();
				}
			}
		}

		if (("ShowEmployer" in this.m.ActiveScreen) && this.m.ActiveScreen.ShowEmployer)
		{
			if (_index == 0)
			{
				return "EventActor+" + this.m.EmployerID;
			}
			else if (::World.FactionManager.getFaction(this.m.Faction).getType() == ::Const.FactionType.NobleHouse)
			{
				return "Faction+" + this.getFaction().getID();
			}
			else
			{
				return null;
			}
		}
	}}.RF_getUICharacterTooltipID;

	q.getUICharacterImage = @(__original) { function getUICharacterImage( _index = 0 )
	{
		if ((!("Characters" in this.m.ActiveScreen) || !this.m.ActiveScreen.Characters.len()) &&
			(!("Banner" in this.m.ActiveScreen) || _index == 0) &&
			"ShowEmployer" in this.m.ActiveScreen &&
			this.m.ActiveScreen.ShowEmployer &&
			_index != 0 &&
			"Destination" in this.m &&
			this.m.Destination != null &&
			!this.m.Destination.isNull() &&
			this.m.Destination.isLocation() &&
			this.m.Destination.isLocationType(::Const.World.LocationType.Settlement) &&
			this.m.Destination.isDiscovered()
		)
		{
			return {
				Image = this.m.Destination.getImagePath(),
				IsProcedural = false
			};
		}
		else
		{
			return __original(_index);
		}
	}}.getUICharacterImage;

	q.addUnitsToEntity = @(__original) { function addUnitsToEntity( _entity, _partyList, _resources )
	{
		::Const.World.Common.RF_addSpawnlistInfo(_entity, _partyList);
		__original(_entity, _partyList, _resources);
	}}.addUnitsToEntity;

	q.setScreen = @(__original) { function setScreen( _screen, _restartIfAlreadyActive = true )
	{
		::Reforged.NestedTooltips.setApplyNestingForEvents(true);
		__original(_screen, _restartIfAlreadyActive);
		::Reforged.NestedTooltips.setApplyNestingForEvents(false);
	}}.setScreen;
});

::Reforged.HooksMod.hookTree("scripts/contracts/contract", function(q) {
	q.onPrepareVariables = @(__original) { function onPrepareVariables( _vars )
	{
		::Reforged.NestedTooltips.setApplyNestingForEvents(true);
		__original(_vars);
		::Reforged.NestedTooltips.setApplyNestingForEvents(false);
	}}.onPrepareVariables;
});
