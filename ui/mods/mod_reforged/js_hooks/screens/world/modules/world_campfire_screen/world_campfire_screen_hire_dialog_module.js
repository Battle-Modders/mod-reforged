WorldCampfireScreenHireDialogModule.prototype.loadFromData = function (_data)
{
    if (_data === undefined || _data === null || !jQuery.isArray(_data))
    {
        return;
    }

	this.mRoster = this.sortEntries(_data);

    this.mListScrollContainer.empty();

    for(var i = 0; i < _data.length; ++i)
    {
        var entry = _data[i];
        this.addListEntry(entry);
    }

    this.selectListEntry(this.mListContainer.findListEntryByIndex(0), true);
};

WorldCampfireScreenHireDialogModule.prototype.sortEntries = function(_followers)
{
	return _followers.sort(this.sortCompareEntries);
}

WorldCampfireScreenHireDialogModule.prototype.sortCompareEntries = function(_follower_a, _follower_b)
{
	// Sort by:
	// - In current town
	// - Hired
	// - Not hired, not in current town
	var sortAlphabetically = function(a, b)
	{
		var textA = a.Name.toUpperCase();
		var textB = b.Name.toUpperCase();
		return (textA < textB) ? -1 : (textA > textB) ? 1 : 0;
	}
	if (_follower_a.IsInCurrentTown)
	{
		if (!_follower_b.IsInCurrentTown)
		{
			return -1;
		}
		return sortAlphabetically(_follower_a, _follower_b);
	}
	else if (_follower_b.IsInCurrentTown)
	{
		return 1;
	}
	if (_follower_a.IsHired)
	{
		if (!_follower_b.IsHired)
		{
			return -1;
		}
		return sortAlphabetically(_follower_a, _follower_b);
	}
	else if (_follower_b.IsHired)
	{
		return 1;
	}

	if (_follower_a.LastKnownLocation != null)
	{
		if (_follower_b.LastKnownLocation == null)
		{
			return -1;
		}
		return sortAlphabetically(_follower_a, _follower_b);
	}
	else if (_follower_b.LastKnownLocation != null)
	{
		return 1;
	}

	if (_follower_a.IsDiscovered)
	{
		if (!_follower_b.IsDiscovered)
		{
			return -1;
		}
		return sortAlphabetically(_follower_a, _follower_b);
	}
	else if (_follower_b.IsDiscovered)
	{
		return 1;
	}

	return sortAlphabetically(_follower_a, _follower_b);
}

Reforged.Hooks.WorldCampfireScreenHireDialogModule_addListEntry = WorldCampfireScreenHireDialogModule.prototype.addListEntry;
WorldCampfireScreenHireDialogModule.prototype.addListEntry = function (_data)
{
	Reforged.Hooks.WorldCampfireScreenHireDialogModule_addListEntry.call(this, _data);
	var entry = this.mListScrollContainer.find('.list-entry').last();
	if (!_data.IsDiscovered)
	{
		entry.find("img").addClass("is-grayscale");
		entry.find(".name").html("Unknown Follower");
	}
	if (_data.LastKnownLocation == null && !_data.IsHired)
	{
		entry.find(".name").removeClass("font-color-brother-name").addClass("font-color-disabled");
	}
	if (_data.IsInCurrentTown)
	{
		entry.parent().addClass("is-in-current-town");
		entry.removeClass('is-disabled');
	}
	else
	{
		// Hide money container if hired or not in town
		entry.find(".row.is-bottom").hide();
		if (!_data.IsHired) {
			entry.addClass('is-disabled');
		}
		else
		{
			entry.removeClass('is-disabled');
		}
	}
}

// This hook adds the ability to toggle between description and perks display for followers
Reforged.Hooks.WorldCampfireScreenHireDialogModule_createDIV = WorldCampfireScreenHireDialogModule.prototype.createDIV;
WorldCampfireScreenHireDialogModule.prototype.createDIV = function (_parentDiv)
{
	Reforged.Hooks.WorldCampfireScreenHireDialogModule_createDIV.call(this, _parentDiv);
	var self = this;



	this.mDetailsPanel.CharacterBackgroundPerksContainer = this.mDetailsPanel.Container.find(".is-ingredients-container");

	var perksHeader = $('<div class="row is-header"/>')
		.appendTo(this.mDetailsPanel.CharacterBackgroundPerksContainer)
		.append($('<div class="label title-font-normal font-bold font-bottom-shadow font-color-title">Perks</div>'));

	this.mDetailsPanel.mPerksModule = new Reforged.RetinuePerksModule(this.mDetailsPanel.CharacterBackgroundPerksContainer, this);


	this.mDetailsPanel.mModules = [
		this.mDetailsPanel.Container.find(".is-components-container"),
		this.mDetailsPanel.CharacterBackgroundPerksContainer
	];
	this.mDetailsPanel.SwitchModuleContainer = $("<div class='hire-screen-switch-module-container'/>")
		.hide()
		.appendTo(this.mDetailsPanel.Container);
	this.mDetailsPanel.SwitchModuleButton = this.mDetailsPanel.SwitchModuleContainer.createImageButton(Path.GFX + Asset.BUTTON_PLAY, function ()
	{
		self.toggleModule();
	}, '', 6);
	this.mDetailsPanel.ActiveModule = this.mDetailsPanel.mModules[0];
	this.mDetailsPanel.ActiveModuleIdx = 0;
	this.toggleModule(1);

	this.mDetailsPanel.CharacterBackgroundTextContainer.hide();

	// Dismiss button button:
	var dismissButtonLayout = $('<div class="l-hire-button"/>')
		.appendTo(this.mDetailsPanel.Container.find('.is-button-container'));
    this.mDetailsPanel.DismissButton = dismissButtonLayout.createTextButton("Dismiss", function()
	{
        if(self.mSelectedEntry !== null)
        {
            var data = self.mSelectedEntry.data('entry');
            if('ID' in data && data['ID'] !== null)
            {
                self.dismissRosterEntry(data['ID']);
            }
        }
    }, '', 1);


	// details: costs
	var costsRow = this.mDetailsPanel.Container.find(".is-initial-costs");
	var costsLabel = $('<div class="costs-label is-daily title-font-normal font-bold font-bottom-shadow font-color-title">Daily</div>');
	costsRow.append(costsLabel);
	var costsContainer = $('<div class="l-costs-container is-daily"/>');
	costsRow.append(costsContainer);
	var costsImage = $('<img/>');
	costsImage.attr('src', Path.GFX + Asset.ICON_ASSET_MONEY);
	costsContainer.append(costsImage);
	costsImage.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.DailyMoney });
	this.mDetailsPanel.DailyMoneyCostsText = $('<div class="label text-font-normal font-bottom-shadow font-color-description"/>');
	costsContainer.append(this.mDetailsPanel.DailyMoneyCostsText);

	// Change requirements for "current location"
	this.mDetailsPanel.Container.find(".is-requirements-container .label").html("Location");
}

Reforged.Hooks.WorldCampfireScreenHireDialogModule_destroyDIV = WorldCampfireScreenHireDialogModule.prototype.destroyDIV
WorldCampfireScreenHireDialogModule.prototype.destroyDIV = function()
{
	this.mDetailsPanel.mPerksModule.destroyDIV();
	this.mDetailsPanel.mPerksModule = null;
	this.mDetailsPanel.CharacterBackgroundPerksContainer.remove();
	this.mDetailsPanel.CharacterBackgroundPerksContainer = null;
	this.mDetailsPanel.ActiveModule = null;
	this.mDetailsPanel.ActiveModuleIdx = 0;

	Reforged.Hooks.WorldCampfireScreenHireDialogModule_destroyDIV.call(this);
}

Reforged.Hooks.WorldCampfireScreenHireDialogModule_updateDetailsPanel = WorldCampfireScreenHireDialogModule.prototype.updateDetailsPanel;
WorldCampfireScreenHireDialogModule.prototype.updateDetailsPanel = function(_element)
{
	Reforged.Hooks.WorldCampfireScreenHireDialogModule_updateDetailsPanel.call(this, _element);
	var data = _element.data('entry');
	this.mDetailsPanel.SwitchModuleContainer.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "HireScreen.DescriptionContainer+1"});
	// this.toggleModule(1);
	this.mDetailsPanel.SwitchModuleContainer.show();

	if (!data.IsDiscovered)
	{
		this.mDetailsPanel.CharacterImage.addClass("is-grayscale");
		this.mDetailsPanel.CharacterName.html("Unknown Follower");
		this.mDetailsPanel.InitialMoneyCostsText.html("-");
		this.mDetailsPanel.DailyMoneyCostsText.html("-");
		this.mDetailsPanel.EffectsContainer.empty();
		this.mDetailsPanel.mPerksModule.mTreeContainer.empty();
		this.mDetailsPanel.DismissButton.parent().toggle(false);
		this.mDetailsPanel.HireButton.parent().toggle(false);
	}
	else
	{
		this.mDetailsPanel.CharacterImage.removeClass("is-grayscale");
		this.mDetailsPanel.mPerksModule.loadFromData(data, this.mAssets.getValues().FollowerTools);
		this.mDetailsPanel.DailyMoneyCostsText.html(Helper.numberWithCommas(data.DailyMoneyCost));
		this.mDetailsPanel.HireButton.enableButton(data.IsInCurrentTown);
		this.mDetailsPanel.HireButton.parent().toggle(!data.IsHired);
		this.mDetailsPanel.DismissButton.parent().toggle(data.IsHired);
		var currentMoney = this.mAssets.getValues().Money;
		var data = _element.data('entry');
		var initialMoneyCost = data.Cost;
		this.mDetailsPanel.HireButton.enableButton(currentMoney >= initialMoneyCost && !data.IsHired && data.IsInCurrentTown);
	}

	// update current location
	this.mDetailsPanel.RequirementsContainer.empty();
	var townLabel = $("<div class='text-font-medium font-color-label'></div>")
		.appendTo(this.mDetailsPanel.RequirementsContainer);
	if (data.IsHired)
	{
		townLabel.html("In your party.");
	}
	else if (data.IsInCurrentTown)
	{
		townLabel.html("In this town - you can hire them!");
	}
	else if (data.LastKnownLocation != null)
	{
		// TODO
		townLabel.html("Last seen in " + data.LastKnownLocation.Name + " , " + data.LastKnownLocation.LastSeenDate + " days ago.<br>Will move in " + data.LastKnownLocation.RemainingDays + " days.");
	}
	else
	{
		townLabel.html("Location not known. Visit towns and listen to tavern rumours to find followers.");
	}
}

WorldCampfireScreenHireDialogModule.prototype.toggleModule = function(_idx)
{
	var oldIdx = this.mDetailsPanel.ActiveModuleIdx;
	this.mDetailsPanel.ActiveModuleIdx = _idx === undefined ? this.mDetailsPanel.ActiveModuleIdx + 1 : _idx;
	if (this.mDetailsPanel.ActiveModuleIdx > this.mDetailsPanel.mModules.length - 1)
		this.mDetailsPanel.ActiveModuleIdx = 0;

	if (oldIdx != this.mDetailsPanel.ActiveModuleIdx)
	{
		this.mDetailsPanel.ActiveModule.hide();
		this.mDetailsPanel.ActiveModule = this.mDetailsPanel.mModules[this.mDetailsPanel.ActiveModuleIdx];
		this.mDetailsPanel.ActiveModule.show();
		this.mDetailsPanel.SwitchModuleContainer.updateTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "HireScreen.DescriptionContainer+" + this.mDetailsPanel.ActiveModuleIdx});
	}
}

WorldCampfireScreenHireDialogModule.prototype.unlockPerk = function(_brotherId, _perkId)
{
    var brotherId = _brotherId;
    if (brotherId === null)
    {
        var selectedBrother = this.mSelectedEntry;
        if (selectedBrother === null)
        {
            console.error('ERROR: Failed to unlock perk. No entity selected.');
            return;
        }

        var data = selectedBrother.data('entry');
        if('ID' in data && data['ID'] !== null)
        {
            brotherId = data['ID']
        }
        else
        {
    	    console.error('ERROR: Failed to unlock perk. Entity does not have ID.');
    	    return;
        }
    }
    console.error("Unlocking perk " + _perkId + " for follower " + brotherId)

    var self = this;
    this.notifyBackendUnlockPerk(brotherId, _perkId, function (data)
    {
        if (data === undefined || data === null || typeof (data) !== 'object')
        {
            console.error('ERROR: Failed to unlock perk. Invalid data result.');
            return;
        }

        // check if we have an error
        if (ErrorCode.Key in data)
        {
            self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
        }
        else
        {
            self.loadFromData(data.Roster);
            self.updateAssets(data.Assets);
            self.mListScrollContainer.find(".list-entry").each(function(_idx){
            	if ($(this).data("entry").ID == brotherId) {
            		self.selectListEntry($(this));
            		return false;
            	}
            })
        }
    });
};

WorldCampfireScreenHireDialogModule.prototype.notifyBackendUnlockPerk = function (_brotherId, _perkId, _callback)
{
    SQ.call(this.mSQHandle, 'onUnlockPerk', [_brotherId, _perkId], _callback);
};

WorldCampfireScreenHireDialogModule.prototype.notifyBackendPopupDialogIsVisible = function (_visible)
{
	// TODO: check if this member is necessary - I think not
    this.mIsPopupOpen = _visible;
    SQ.call(this.mSQHandle, 'onPopupDialogIsVisible', [_visible]);
};

WorldCampfireScreenHireDialogModule.prototype.dismissRosterEntry = function(_brotherId)
{
	// TODO
}
