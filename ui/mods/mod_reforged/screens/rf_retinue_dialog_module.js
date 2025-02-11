
"use strict";

var RF_RetinueDialogModule = function(_parent)
{
	this.mSQHandle = null;
	this.mParent = _parent;

	this.mRoster = null;

	// event listener
	this.mEventListener = null;

	// generic containers
	this.mContainer = null;
	this.mDialogContainer = null;
	this.mListContainer = null;
	this.mListScrollContainer = null;
	this.mDetailsPanel =
	{
		Container: null,
		CharacterImage: null,
		CharacterName: null,
		CharacterBackgroundTextContainer: null,
		CharacterBackgroundTextScrollContainer: null,
		InitialMoneyCostsText: null,
		HireButton: null
	};

	// assets labels
	this.mAssets = new WorldCampfireScreenAssets(_parent);

	// buttons
	this.mLeaveButton = null;

	// generics
	this.mIsVisible = false;

	// selected entry
	this.mSelectedEntry = null;

	this.mFollowerStateOrder = [
		"Local",
		"Hired",
		"KnownLocation",
		"UnknownLocation",
	]
};


RF_RetinueDialogModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

RF_RetinueDialogModule.prototype.onConnection = function (_handle)
{

	this.mSQHandle = _handle;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

RF_RetinueDialogModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};

RF_RetinueDialogModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

RF_RetinueDialogModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};

RF_RetinueDialogModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: containers (init hidden!)
	this.mContainer = $('<div class="l-hire-dialog-container display-none opacity-none"/>')
		.appendTo(_parentDiv);
	this.mDialogContainer = this.mContainer.createDialog('Hire Follower', null, '', true, 'dialog-1024-768');


	// create assets
	var tabButtonsContainer = $('<div class="l-tab-container"/>')
		.appendTo(this.mDialogContainer.findDialogTabContainer());
	this.mAssets.createDIV(tabButtonsContainer);


	// create content
	var content = this.mDialogContainer.findDialogContentContainer();

	// left column
	var column = $('<div class="column is-left"/>')
		.appendTo(content);
	var listContainerLayout = $('<div class="l-list-container"/>')
		.appendTo(column);
	this.mListContainer = listContainerLayout.createList(1.77/*8.85*/);
	this.mListScrollContainer = this.mListContainer.findListScrollContainer();

	// right column
	column = $('<div class="column is-right"/>')
		.appendTo(content);

	// details container
	var detailsFrame = $('<div class="l-details-frame"/>')
		.appendTo(column);
	this.mDetailsPanel.Container = $('<div class="details-container display-none"/>')
		.appendTo(detailsFrame);

	// details: character container
	var detailsRow = $('<div class="row is-character-container"/>')
		.appendTo(this.mDetailsPanel.Container);

	// character image
	var detailsColumn = $('<div class="column is-character-portrait-container"/>')
		.appendTo(detailsRow);
	this.mDetailsPanel.CharacterImage = detailsColumn.createImage(null, function (_image)
	{
		var offsetX = 0;
		var offsetY = 0;

		if(self.mSelectedEntry !== null)
		{
			var data = self.mSelectedEntry.data('entry');
			if('ImageOffsetX' in data && data['ImageOffsetX'] !== null &&
				'ImageOffsetY' in data && data['ImageOffsetY'] !== null)
			{
				offsetX = data['ImageOffsetX'];
				offsetY = data['ImageOffsetY'];
			}
		}

		_image.centerImageWithinParent(offsetX, offsetY, 1.0);
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');

	//character description
	detailsColumn = $('<div class="column is-character-background-container"/>')
		.appendTo(detailsRow);
	var backgroundRow = $('<div class="row is-top"/>')
		.appendTo(detailsColumn);
	var backgroundRowBorder = $('<div class="row is-top border"/>')
		.appendTo(backgroundRow);

	this.mDetailsPanel.CharacterName = $('<div class="name title-font-normal font-bold font-color-brother-name"/>')
		.appendTo(backgroundRow);



	backgroundRow = $('<div class="row is-bottom"/>')
		.appendTo(detailsColumn);
	this.mDetailsPanel.CharacterBackgroundTextContainer = backgroundRow.createList(20, 'description-font-medium font-bottom-shadow font-color-description', true);
	this.mDetailsPanel.CharacterBackgroundTextScrollContainer = this.mDetailsPanel.CharacterBackgroundTextContainer.findListScrollContainer();


	this.mDetailsPanel.PerksContainer = $("<div class='retinue-screen-perks-container'/>")
		.append($("<div class='name title-font-normal font-bold font-color-brother-name'>Perks</div>"))
		.hide()
		.appendTo(this.mDetailsPanel.Container);
	this.mDetailsPanel.mPerksModule = new DynamicPerks.GenericPerksModule(this.mDetailsPanel.PerksContainer);

	// details: costs
	detailsRow = $('<div class="row is-costs-container"/>')
		.appendTo(this.mDetailsPanel.Container);
	var costsHeader = $('<div class="row is-header"/>')
		.appendTo(detailsRow);
	var costsHeaderLabel = $('<div class="label title-font-normal font-bold font-bottom-shadow font-color-title">Costs</div>')
		.appendTo(costsHeader);
	var costsInitial = $('<div class="row is-initial-costs"/>')
		.appendTo(detailsRow);
	var costsLabel = $('<div class="costs-label title-font-normal font-bold font-bottom-shadow font-color-title">Up Front</div>')
		.appendTo(costsInitial);
	var costsContainer = $('<div class="l-costs-container"/>')
		.appendTo(costsInitial);

	var costsImage = $('<img/>')
		.attr('src', Path.GFX + Asset.ICON_ASSET_MONEY)
		.appendTo(costsContainer);
	costsImage.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.InitialMoney });

	this.mDetailsPanel.InitialMoneyCostsText = $('<div class="label text-font-normal font-bottom-shadow font-color-description"/>')
		.appendTo(costsContainer);

	// details: buttons
	detailsRow = $('<div class="row is-button-container"/>')
		.appendTo(this.mDetailsPanel.Container);
	var hireButtonLayout = $('<div class="l-hire-button"/>')
		.appendTo(detailsRow);
	this.mDetailsPanel.HireButton = hireButtonLayout.createTextButton("Hire", function()
	{
		if(self.mSelectedEntry !== null)
		{
			var data = self.mSelectedEntry.data('entry');
			if('ID' in data && data['ID'] !== null)
			{
				self.hireRosterEntry(data['ID']);
			}
		}
	}, '', 1);
	var fireButtonLayout = $('<div class="l-hire-button"/>')
		.appendTo(detailsRow);
	this.mDetailsPanel.FireButton = fireButtonLayout.createTextButton("Dismiss", function()
	{
		if(self.mSelectedEntry !== null)
		{
			var data = self.mSelectedEntry.data('entry');
			if('ID' in data && data['ID'] !== null)
			{
				self.fireRosterEntry(data['ID']);
			}
		}
	}, '', 1);

	// create footer button bar
	var footerButtonBar = $('<div class="l-button-bar"/>')
		.appendTo(this.mDialogContainer.findDialogFooterContainer());

	// create: buttons
	var layout = $('<div class="l-leave-button"/>')
		.appendTo(footerButtonBar);
	this.mLeaveButton = layout.createTextButton("Leave", function ()
	{
		self.notifyBackendLeaveButtonPressed();
	}, '', 1);

	this.mIsVisible = false;
};

RF_RetinueDialogModule.prototype.destroyDIV = function ()
{
	this.mAssets.destroyDIV();

	this.mSelectedEntry = null;

	this.mDetailsPanel.HireButton.remove();
	this.mDetailsPanel.HireButton = null;

	this.mDetailsPanel.InitialMoneyCostsText.empty();
	this.mDetailsPanel.InitialMoneyCostsText.remove();
	this.mDetailsPanel.InitialMoneyCostsText = null;

	this.mDetailsPanel.CharacterBackgroundTextScrollContainer.empty();
	this.mDetailsPanel.CharacterBackgroundTextScrollContainer = null;
	this.mDetailsPanel.CharacterBackgroundTextContainer.destroyList();
	this.mDetailsPanel.CharacterBackgroundTextContainer.remove();
	this.mDetailsPanel.CharacterBackgroundTextContainer = null;

	this.mDetailsPanel.CharacterName.empty();
	this.mDetailsPanel.CharacterName.remove();
	this.mDetailsPanel.CharacterName = null;

	this.mDetailsPanel.CharacterImage.empty();
	this.mDetailsPanel.CharacterImage.remove();
	this.mDetailsPanel.CharacterImage = null;

	this.mDetailsPanel.Container.empty();
	this.mDetailsPanel.Container.remove();
	this.mDetailsPanel.Container = null;

	this.mListScrollContainer.empty();
	this.mListScrollContainer = null;
	this.mListContainer.destroyList();
	this.mListContainer.remove();
	this.mListContainer = null;

	this.mLeaveButton.remove();
	this.mLeaveButton = null;

	this.mDialogContainer.empty();
	this.mDialogContainer.remove();
	this.mDialogContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};

RF_RetinueDialogModule.prototype.bindTooltips = function ()
{
	this.mAssets.bindTooltips();
	this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.LeaveButton });
	this.mDetailsPanel.HireButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.HireButton });
};

RF_RetinueDialogModule.prototype.unbindTooltips = function ()
{
	this.mAssets.unbindTooltips();
	this.mLeaveButton.unbindTooltip();
	this.mDetailsPanel.HireButton.unbindTooltip();
};

RF_RetinueDialogModule.prototype.addListEntry = function (_data)
{
	var result = $('<div class="l-row"/>')
		.appendTo(this.mListScrollContainer);

	var entry = $('<div class="ui-control list-entry"/>')
		.appendTo(result);
	entry.data('entry', _data);
	entry.click(this, function(_event)
	{
		var self = _event.data;
		self.selectListEntry($(this));
	});

	if (!_data.IsUnlocked)
		entry.addClass('is-disabled');

	// left column
	var column = $('<div class="column is-left"/>')
		.appendTo(entry);

	var imageOffsetX = ('ImageOffsetX' in _data ? _data['ImageOffsetX'] : 0);
	var imageOffsetY = ('ImageOffsetY' in _data ? _data['ImageOffsetY'] : 0);
	column.createImage(Path.GFX + _data['ImagePath'], function (_image)
	{
		_image.centerImageWithinParent(imageOffsetX, imageOffsetY, 0.33, false);
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');

	if(!_data.IsUnlocked)
		column.createImage(Path.GFX + Asset.ICON_LOCKED, null, null, 'is-locked-icon');

	// right column
	column = $('<div class="column is-right"/>')
		.appendTo(entry);

	// top row
	var row = $('<div class="row is-top"/>')
		.appendTo(column);
	var name = $('<div class="name title-font-normal font-bold font-color-brother-name">' + _data.Name + '</div>')
		.appendTo(row);
	row = $('<div class="row is-bottom"/>')
		.appendTo(column);

	switch(_data.FollowerState) {
	  	case "Local":
		  	this.addLocalListEntry(_data, result);
		    break;
		case "Hired":
			this.addHiredListEntry(_data, result);
		  	break;
		case "KnownLocation":
			this.addKnownLocationListEntry(_data, result);
		  	break;
		default:
			console.error("Unknown follower state " + _data.FollowerState)
	}
};

RF_RetinueDialogModule.prototype.addLocalListEntry = function(_data, _result)
{
	_result.addClass("follower-state-local");
	// cost to hire
	var row = _result.find(".row.is-bottom");
	var assetsCenterContainer = $('<div class="l-assets-center-container"/>')
		.appendTo(row);
	var assetsContainer = $('<div class="l-assets-container"/>')
		.appendTo(assetsCenterContainer);
	var image = $('<img/>');
	image.attr('src', Path.GFX + Asset.ICON_ASSET_MONEY)
		.appendTo(assetsContainer);
	image.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.InitialMoney });
	var text = $('<div class="label is-initial-money-cost text-font-normal font-color-subtitle">' + Helper.numberWithCommas(_data.Cost) + '</div>')
		.appendTo(assetsContainer);
}

RF_RetinueDialogModule.prototype.addHiredListEntry = function(_data, _result)
{
	_result.addClass("follower-state-hired");
}

RF_RetinueDialogModule.prototype.addKnownLocationListEntry = function(_data, _result)
{
	_result.addClass("follower-state-known-location");
	var row = _result.find(".row.is-bottom");
	// current location
	var assetsCenterContainer = $('<div class="l-assets-center-container"/>')
		.appendTo(row);
	var assetsContainer = $('<div class="l-assets-container"/>')
		.appendTo(assetsCenterContainer);
	var text = $('<div class="label follower-location text-font-normal font-color-subtitle">' + _data.Location + '</div>')
		.appendTo(assetsContainer);
}

RF_RetinueDialogModule.prototype.selectListEntry = function(_element, _scrollToEntry)
{
	if (_element !== null && _element.length > 0)
	{
		this.mListContainer.deselectListEntries();
		_element.addClass('is-selected');

		// give the renderer some time to layout his shit...
		if (_scrollToEntry !== undefined && _scrollToEntry === true)
		{
			this.mListContainer.scrollListToElement(_element);
		}

		this.mSelectedEntry = _element;
		this.mDetailsPanel.mPerksModule.loadFromData(_element.data('entry').perkTree);
		this.updateDetailsPanel(this.mSelectedEntry);
		this.updateListEntryValues();
	}
	else
	{
		this.mSelectedEntry = null;
		this.updateDetailsPanel(this.mSelectedEntry);
		this.updateListEntryValues();
	}
};

WorldCampfireScreenHireDialogModule.prototype.updateDetailsPanel = function(_element)
{
	if (_element !== null && _element.length > 0)
    {
        this.mDetailsPanel.CharacterImage.attr('src', Path.GFX + data.ImagePath);
        this.mDetailsPanel.CharacterImage.centerImageWithinParent(0, 0, 1.0);

        this.mDetailsPanel.CharacterName.html(data.Name);
        this.mDetailsPanel.CharacterBackgroundTextScrollContainer.html(data.Description);

        switch(_data.FollowerState) {
          	case "Local":
        	  	this.updateLocalDetailsPanel(_data, result);
        	    break;
        	case "Hired":
        		this.updateHiredDetailsPanel(_data, result);
        	  	break;
        	case "KnownLocation":
        		this.updateKnownLocationDetailsPanel(_data, result);
        	  	break;
        	default:
        		console.error("Unknown follower state " + _data.FollowerState)
        }

        this.mDetailsPanel.Container.removeClass('display-none').addClass('display-block');
    }
    else
    {
        this.mDetailsPanel.Container.removeClass('display-block').addClass('display-none');
    }
};
WorldCampfireScreenHireDialogModule.prototype.updateLocalDetailsPanel = function(_element) {
	var currentMoney = this.mAssets.getValues().Money;
	var data = _element.data('entry');
	var initialMoneyCost = data.Cost;
	this.mDetailsPanel.InitialMoneyCostsText.html(Helper.numberWithCommas(data.Cost));

	// special cases for not enough resources
	if(currentMoney < initialMoneyCost)
	{
	    this.mDetailsPanel.InitialMoneyCostsText.removeClass('font-color-description').addClass('font-color-assets-negative-value');
	    this.mDetailsPanel.HireButton.enableButton(false);
	}
	else
	{
	    this.mDetailsPanel.HireButton.enableButton(data.IsUnlocked);
	    this.mDetailsPanel.InitialMoneyCostsText.removeClass('font-color-assets-negative-value').addClass('font-color-description');
	}
}
WorldCampfireScreenHireDialogModule.prototype.updateHiredDetailsPanel = function(_element) {}
WorldCampfireScreenHireDialogModule.prototype.updateKnownLocationDetailsPanel = function(_element) {}

WorldCampfireScreenHireDialogModule.prototype.updateListEntryValues = function()
{
    var currentMoney = this.mAssets.getValues().Money;
    var container = this.mListContainer.findListScrollContainer();
    container.find('.list-entry.follower-state-local').each(function(index, element)
	{
    	var entry = $(element);
        var initialMoneyCostElement = entry.find('.is-initial-money-cost');
        var traitsContainer = entry.find('.is-traits-container');
        var data = entry.data('entry');
        var initialMoneyCost = data.Cost;
        initialMoneyCostElement.html(Helper.numberWithCommas(data.Cost));
        if (currentMoney < initialMoneyCost)
        {
        	initialMoneyCostElement.removeClass('font-color-subtitle').addClass('font-color-assets-negative-value');
        }
        else
        {
            initialMoneyCostElement.removeClass('font-color-assets-negative-value').addClass('font-color-subtitle');
        }
    });
};


RF_RetinueDialogModule.prototype.register = function (_parentDiv)
{
	console.log('RF_RetinueDialogModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register World Campfire Screen Hire Dialog Module. Reason: World Campfire Screen Hire Dialog Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

RF_RetinueDialogModule.prototype.unregister = function ()
{
	console.log('RF_RetinueDialogModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister World Town Screen Hire Dialog Module. Reason: World Town Screen Hire Dialog Module is not initialized.');
		return;
	}

	this.destroy();
};

RF_RetinueDialogModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


RF_RetinueDialogModule.prototype.registerEventListener = function(_listener)
{
	this.mEventListener = _listener;
};


RF_RetinueDialogModule.prototype.show = function (_withSlideAnimation)
{
	var self = this;

	var withAnimation = (_withSlideAnimation !== undefined && _withSlideAnimation !== null) ? _withSlideAnimation : true;
	if (withAnimation === true)
	{
		var offset = -(this.mContainer.parent().width() + this.mContainer.width());
		this.mContainer.css({ 'left': offset });
		this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' },
		{
			duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
			easing: 'swing',
			begin: function ()
			{
				$(this).removeClass('display-none').addClass('display-block');
				self.notifyBackendModuleAnimating();
			},
			complete: function ()
			{
				self.mIsVisible = true;
				self.notifyBackendModuleShown();
			}
		});
	}
	else
	{
		this.mContainer.css({ opacity: 0 });
		this.mContainer.velocity("finish", true).velocity({ opacity: 1 },
		{
			duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
			easing: 'swing',
			begin: function ()
			{
				$(this).removeClass('display-none').addClass('display-block');
				self.notifyBackendModuleAnimating();
			},
			complete: function ()
			{
				self.mIsVisible = true;
				self.notifyBackendModuleShown();
			}
		});
	}
};

RF_RetinueDialogModule.prototype.hide = function ()
{
	var self = this;

	var offset = -(this.mContainer.parent().width() + this.mContainer.width());
	this.mContainer.velocity("finish", true).velocity({ opacity: 0, left: offset },
	{
		duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function ()
		{
			$(this).removeClass('is-center');
			self.notifyBackendModuleAnimating();
		},
		complete: function ()
		{
			self.mIsVisible = false;
			self.mListScrollContainer.empty();
			$(this).removeClass('display-block').addClass('display-none');
			self.notifyBackendModuleHidden();
		}
	});
};

RF_RetinueDialogModule.prototype.isVisible = function ()
{
	return this.mIsVisible;
};


RF_RetinueDialogModule.prototype.updateAssets = function (_data)
{
	this.mAssets.loadFromData(_data);
	this.updateListEntryValues();
}

RF_RetinueDialogModule.prototype.loadFromData = function (_data)
{
	var self = this;
	if (_data === undefined || _data === null || !jQuery.isArray(_data))
	{
		return;
	}
	_data.sort(function(_a, _b){
		return self.mFollowerStateOrder[_a.State] - self.mFollowerStateOrder[_b.State];
	})

	this.mRoster = _data;

	this.mListScrollContainer.empty();

	for(var i = 0; i < _data.length; ++i)
	{
		var entry = _data[i];
		this.addListEntry(entry);
	}

	this.selectListEntry(this.mListContainer.findListEntryByIndex(0), true);
};

WorldCampfireScreenHireDialogModule.prototype.hireRosterEntry = function (_entryID)
{
    var self = this;
    this.notifyBackendHireRosterEntry(_entryID, function (data)
    {
        // error?
        if (data.Result != 0)
        {
            if (data.Result == ErrorCode.NotEnoughMoney)
            {
                self.mAssets.mMoneyAsset.shakeLeftRight();
            }
            else
            {
                console.error("Failed to hire. Reason: Unknown");
            }

            return;
        }
        else
        {
            self.loadFromData();
        }
    });
};

WorldCampfireScreenHireDialogModule.prototype.fireRosterEntry = function (_entryID)
{
    var self = this;
    this.notifyBackendHireRosterEntry(_entryID, function (data)
    {
        // error?
        if (data.Result != 0)
        {
            if (data.Result == ErrorCode.NotEnoughMoney)
            {
                self.mAssets.mMoneyAsset.shakeLeftRight();
            }
            else
            {
                console.error("Failed to hire. Reason: Unknown");
            }

            return;
        }
        else
        {
            self.loadFromData();
        }
    });
};

RF_RetinueDialogModule.prototype.notifyBackendHireRosterEntry = function (_entryID, _callback)
{
	SQ.call(this.mSQHandle, 'onHireFollower', _entryID, _callback);
};

RF_RetinueDialogModule.prototype.notifyBackendFireRosterEntry = function (_entryID, _callback)
{
	SQ.call(this.mSQHandle, 'onFireFollower', _entryID, _callback);
};



RF_RetinueDialogModule.prototype.notifyBackendModuleShown = function ()
{
	SQ.call(this.mSQHandle, 'onModuleShown');
};

RF_RetinueDialogModule.prototype.notifyBackendModuleHidden = function ()
{
	SQ.call(this.mSQHandle, 'onModuleHidden');
};

RF_RetinueDialogModule.prototype.notifyBackendModuleAnimating = function ()
{
	SQ.call(this.mSQHandle, 'onModuleAnimating');
};

RF_RetinueDialogModule.prototype.notifyBackendLeaveButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onLeaveButtonPressed');
};
