"use strict";


Reforged.RetinuePerksModule = function(_parentDiv, _parent)
{
    this.mParent = _parent;

	// container
	this.mContainer = null;

    this.mTreeContainer = null;

    // perks
    this.mPerkTree = null;
    this.mPerkRows = [];
    this.createDIV(_parentDiv)
};


Reforged.RetinuePerksModule.prototype.createDIV = function (_parentDiv)
{
	this.mContainer = $('<div class="generic-perks-module"/>');
	_parentDiv.append(this.mContainer);

    this.mTreeContainer = $('<div class="perks-tree"/>');
    this.mContainer.append(this.mTreeContainer);
};

Reforged.RetinuePerksModule.prototype.destroyDIV = function ()
{
    this.mTreeContainer.remove();
    this.mTreeContainer = null;

    this.mContainer.remove();
    this.mContainer = null;
};


Reforged.RetinuePerksModule.prototype.createPerkTreeDIV = function (_perkTree, _parentDiv)
{
	// Enduriel wants to refactor this
	var self = this;

	for (var row = 0; row < _perkTree.length; ++row)
	{
		var rowDIV = $('<div class="perks-row"/>');
		_parentDiv.append(rowDIV);

		this.mPerkRows[row] = rowDIV;

		for (var i = 0; i < _perkTree[row].length; ++i)
		{
			var perk = _perkTree[row][i];
			perk.Unlocked = true;

			perk.Container = $('<div class="dpf-l-perk-container"/>');
			rowDIV.append(perk.Container);

			var perkSelectionImage = $('<img class="selection-image-layer display-none"/>');
			perkSelectionImage.attr('src', Path.GFX + Asset.PERK_SELECTION_FRAME);
			perk.Container.append(perkSelectionImage);

			perk.Image = $('<img class="dpf-perk-image-layer"/>');
			perk.Image.attr('src', Path.GFX + perk.Icon);
			perk.Container.append(perk.Image);
		}
	}
};

Reforged.RetinuePerksModule.prototype.setupPerkTreeTooltips = function(_entityID)
{
	// Enduriel probably wants to refactor this
	for (var row = 0; row < this.mPerkTree.length; ++row)
	{
		for (var i = 0; i < this.mPerkTree[row].length; ++i)
		{
			var perk = this.mPerkTree[row][i];
			perk.Image.unbindTooltip();
			perk.Image.bindTooltip({ contentType: 'ui-perk', entityId: _entityID || null, perkId: perk.ID });
		}
	}
};

Reforged.RetinuePerksModule.prototype.setupPerkTree = function ()
{
	// Enduriel wants to refactor this
    this.mTreeContainer.empty();
    this.createPerkTreeDIV(this.mPerkTree, this.mTreeContainer);
    this.setupPerksEventHandlers(this.mPerkTree);
};

Reforged.RetinuePerksModule.prototype.loadFromData = function (_perkTree, _entityID)
{
	if (_perkTree === undefined || _perkTree === null)
		return;
    this.mPerkTree = _perkTree;
    this.setupPerkTree();
    this.setupPerkTreeTooltips(_entityID);
};

Reforged.RetinuePerksModule.prototype.attachEventHandler = function(_perk)
{
	var self = this;

	_perk.Container.on('mouseenter focus' + CharacterScreenIdentifier.KeyEvent.PerksModuleNamespace, null, this, function (_event)
	{
		var selectable = !_perk.Unlocked && self.isPerkUnlockable(_perk);

		if (selectable === true)
		{
			var selectionLayer = $(this).find('.selection-image-layer:first');
			selectionLayer.removeClass('display-none').addClass('display-block');
		}
	});

	_perk.Container.on('mouseleave blur' + CharacterScreenIdentifier.KeyEvent.PerksModuleNamespace, null, this, function (_event)
	{
		var selectable = !_perk.Unlocked && self.isPerkUnlockable(_perk);

		if (selectable === true)
		{
			var selectionLayer = $(this).find('.selection-image-layer:first');
			selectionLayer.removeClass('display-block').addClass('display-none');
		}
	});

	_perk.Container.click(this, function (_event)
	{
		self.showPerkUnlockDialog(_perk);
	});
}

Reforged.RetinuePerksModule.prototype.removePerksEventHandler = function (_perkTree)
{
	for (var row = 0; row < _perkTree.length; ++row)
	{
		for (var i = 0; i < _perkTree[row].length; ++i)
		{
			var perk = _perkTree[row][i];

			perk.Container.off(CharacterScreenIdentifier.KeyEvent.PerksModuleNamespace);
			perk.Container.unbind('click');
		}
	}
};

Reforged.RetinuePerksModule.prototype.setupPerksEventHandlers = function(_perkTree)
{
	this.removePerksEventHandlers();

	for (var row = 0; row < _perkTree.length; ++row)
	{
		for (var i = 0; i < _perkTree[row].length; ++i)
		{
			var perk = _perkTree[row][i];
			this.attachEventHandler(perk);
		}
	}
};

Reforged.RetinuePerksModule.prototype.removePerksEventHandlers = function()
{
    this.removePerksEventHandler(this.mPerkTree);
};

Reforged.RetinuePerksModule.prototype.showPerkUnlockDialog = function(_perk)
{
    this.mParent.notifyBackendPopupDialogIsVisible(true);

    var self = this;
    var popupDialog = $('.character-screen').createPopupDialog('Unlock Perk', null, null, 'unlock-perk-popup');

    popupDialog.addPopupDialogContent(this.createPerkUnlockDialogContent(_perk));

    popupDialog.addPopupDialogOkButton(jQuery.proxy(function (_dialog)
    {
    	self.mParent.unlockPerk(null, _perk.ID);
        _dialog.destroyPopupDialog();
        self.mParent.notifyBackendPopupDialogIsVisible(false);
    }, this));

    popupDialog.addPopupDialogCancelButton(function (_dialog)
    {
        _dialog.destroyPopupDialog();
        self.mParent.notifyBackendPopupDialogIsVisible(false);
    });
};


Reforged.RetinuePerksModule.prototype.createPerkUnlockDialogContent = function (_perk)
{
	var result = $('<div class="unlock-perk-popup-dialog-content-container"/>');

    var leftColumn = $('<div class="left-column"/>');
    result.append(leftColumn);

    var perkImage = $('<img/>');
    perkImage.attr('src', Path.GFX + _perk.Icon);
    leftColumn.append(perkImage);

    var rightColumn = $('<div class="right-column"/>');
    result.append(rightColumn);

    var perkNameLabel = $('<div class="name title-font-normal font-bold font-color-title">' + _perk.Name + '</div>');
    rightColumn.append(perkNameLabel);

    var descriptionText = _perk.Tooltip.replace(/#135213/gi, "#1e861e"); // positive values
    descriptionText = descriptionText.replace(/#8f1e1e/gi, "#a22424"); // negative values

    var parsedDescriptionText = XBBCODE.process({
    	text: descriptionText,
        removeMisalignedTags: false,
        addInLineBreaks: true
    });

    var perkDescriptionLabel = $('<div class="description description-font-small font-style-italic font-color-description">' + parsedDescriptionText.html + '</div>');
    rightColumn.append(perkDescriptionLabel);

    return result;
};
