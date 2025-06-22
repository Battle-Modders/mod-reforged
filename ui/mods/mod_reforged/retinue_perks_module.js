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
	this.mContainer = $('<div class="generic-perks-module rf-retinue-perks-module"/>');
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

Reforged.RetinuePerksModule.prototype.loadFromData = function (_data, _followerTools)
{
	if (_data === undefined || _data === null)
		return;
    this.mPerkTree = _data.PerkTree;
    this.mUnlockedPerks = _data.Perks;
    this.mEntityID = _data.ID;
    this.mFollowerTools = _followerTools;
    this.setupPerkTree();
};

Reforged.RetinuePerksModule.prototype.setupPerkTree = function ()
{
    this.mTreeContainer.empty();
    this.createPerkTreeDIV(this.mPerkTree, this.mUnlockedPerks, this.mTreeContainer, this.mEntityID);
};

Reforged.RetinuePerksModule.prototype.parsePerkID = function (_perkID)
{
	return _perkID.replace(".", "-").replace("_", "-");
}

Reforged.RetinuePerksModule.prototype.createPerkTreeDIV = function (_perkTree, _perksUnlocked, _parentDiv, _entityID)
{
	var self = this;
	var unlockedPerksMap = {};
	$.each(_perksUnlocked, function(_idx, _id)
	{
		unlockedPerksMap[_id] = true;
	});

	// Helper function to create proper closures
	function createPerkHandlers(perkData) {
		return {
			click: function(_event) {
				self.showPerkUnlockDialog(perkData);
			},
			mouseenter: function(_event) {
				if (perkData.RequiredPerks === undefined) {
					return;
				}
				$.each(perkData.RequiredPerks, function(_idx, _parentPerkID) {
					var parents = $(".dpf-l-perk-container." + self.parsePerkID(_parentPerkID));
					parents.addClass("is-child-hovered");
				});
			},
			mouseleave: function(_event) {
				if (perkData.RequiredPerks === undefined) {
					return;
				}
				$.each(perkData.RequiredPerks, function(_idx, _parentPerkID) {
					var parents = $(".dpf-l-perk-container." + self.parsePerkID(_parentPerkID));
					parents.removeClass("is-child-hovered");
				});
			}
		};
	}

	for (var row = 0; row < _perkTree.length; ++row)
	{
		var rowDIV = $('<div class="perks-row"/>');
		_parentDiv.append(rowDIV);
		this.mPerkRows[row] = rowDIV;
		for (var i = 0; i < _perkTree[row].length; ++i)
		{
			var perk = _perkTree[row][i];
			perk.Container = $('<div class="dpf-l-perk-container"/>');
			rowDIV.append(perk.Container);
			perk.Container.addClass(this.parsePerkID(perk.ID));

			var perkSelectionImage = $('<img class="selection-image-layer display-none"/>');
			perkSelectionImage.attr('src', Path.GFX + Asset.PERK_SELECTION_FRAME);
			perk.Container.append(perkSelectionImage);
			perk.Image = $('<img class="dpf-perk-image-layer"/>');
			perk.Image.attr('src', Path.GFX + perk.Icon);
			perk.Image.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "Retinue.Perk+" + perk.ID, followerId: _entityID});
			perk.Container.append(perk.Image);
			if (unlockedPerksMap[perk.ID] === true)
			{
				perk.Unlocked = true;
			}
			else
			{
				perk.Unlocked = false;
				perk.Container.addClass("is-locked");
			}

			var handlers = createPerkHandlers(perk);
			if (perk.IsUnlockable)
			{
				perk.Container.click(this, handlers.click);
				perk.Container.addClass("is-unlockable")
			}
			perk.Container.hover(handlers.mouseenter, handlers.mouseleave);
		}
	}
};

Reforged.RetinuePerksModule.prototype.showPerkUnlockDialog = function(_perk)
{
    this.mParent.notifyBackendPopupDialogIsVisible(true);

    var self = this;
    var popupDialog = $('.world-campfire-screen').createPopupDialog('Unlock Perk', null, null, 'unlock-perk-popup');

    popupDialog.addPopupDialogContent(this.createPerkUnlockDialogContent(_perk));

    popupDialog.addPopupDialogOkButton(jQuery.proxy(function (_dialog)
    {
    	self.mParent.unlockPerk(null, _perk.ID);
        _dialog.destroyPopupDialog();
        self.mParent.notifyBackendPopupDialogIsVisible(false);
    }, this));
    popupDialog.findPopupDialogOkButton().enableButton(_perk.ToolCost <= self.mFollowerTools);

    popupDialog.addPopupDialogCancelButton(function (_dialog)
    {
        _dialog.destroyPopupDialog();
        self.mParent.notifyBackendPopupDialogIsVisible(false);
    });
};


Reforged.RetinuePerksModule.prototype.createPerkUnlockDialogContent = function (_perk)
{
	var self = this;
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

    var requirementsContainer = $('<div class="is-perk-requirements-container"/>')
    	.appendTo(rightColumn);
    var requirementsHeader = $('<div class="label title-font-normal font-bold font-bottom-shadow font-color-title">Requirements</div>')
    	.appendTo(requirementsContainer);
    var requirementsTable = $('<table/>')
    	.appendTo(requirementsContainer);
    $.each(_perk.Requirements, function(_idx, _data){
    	self.addRequirementRow(requirementsTable, _data)
    })

    return result;
};

Reforged.RetinuePerksModule.prototype.addRequirementRow = function(_table, _requirement)
{

	var html = "<tr><td class='is-icon is-valid-icon'/><td class='is-description-text-abc'/></tr>";
	var tr = $(html)
		.appendTo(_table)
		.data("IsValid", _requirement.isValid);

	// Add locked icon
	if (_requirement.isValid === true)
		tr.find(".is-valid-icon").append($("<img src='" + Path.GFX + "ui/icons/unlocked_small.png'/>"));
	else if (_requirement.isValid === false)
		tr.find(".is-valid-icon").append($("<img src='" + Path.GFX + "ui/icons/locked_small.png'/>"));

	if (_requirement.tooltip)
	{
		tr.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: _requirement.tooltip});
	}

	var fontColor = _requirement.isValid ? "font-color-label" : "font-color-disabled";
	var descriptionText = $("<div class='text-font-medium'/>")
		.html(_requirement.text)
		.appendTo(tr.find(".is-description-text-abc"))
		.addClass(fontColor)
		.find("*")
			.addClass(fontColor);
};
