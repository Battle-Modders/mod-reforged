Reforged.Hooks.TacticalScreenTurnSequenceBarModule_createDIV = TacticalScreenTurnSequenceBarModule.prototype.createDIV;
TacticalScreenTurnSequenceBarModule.prototype.createDIV = function (_parentDiv)
{
	this.mLeftStatsRows["Morale"].ImagePath = Path.GFX + Asset.rf_Reach;
	this.mLeftStatsRows["Morale"].StyleName = ProgressbarStyleIdentifier.rf_Reach;

	Reforged.Hooks.TacticalScreenTurnSequenceBarModule_createDIV.call(this, _parentDiv);

	// Declare Variables
	this.mWaitTurnAllButton = null;
	this.mWaitTurnAllButtonContainer = null;

	// Create WaitAllButton
	var buttonBackground = $('<div class="l-button-container"/>');
	var layout = $('<div class="l-button"/>');
	buttonBackground.append(layout);
	var self = this;
	this.mWaitTurnAllButton = layout.createImageButton(Path.GFX + Reforged.Asset.BUTTON_WAIT_ALL_TURNS, function ()
	{
		self.notifyBackendWaitTurnAllButtonPressed();
	}, '', 6);
	this.mWaitTurnAllButtonContainer = buttonBackground;

	// var buttonsContainer = this.mContainer.find('.buttons-container:first');	// We find the element that the other 3 vanilla buttons are appended to
	this.mEndTurnButtonContainer.parent().append(buttonBackground);
}

Reforged.Hooks.TacticalScreenTurnSequenceBarModule_destroyDIV = TacticalScreenTurnSequenceBarModule.prototype.destroyDIV;
TacticalScreenTurnSequenceBarModule.prototype.destroyDIV = function ()
{
	this.mWaitTurnAllButton.remove();
	this.mWaitTurnAllButton = null;
	this.mWaitTurnAllButtonContainer.remove();
	this.mWaitTurnAllButtonContainer = null;

	Reforged.Hooks.TacticalScreenTurnSequenceBarModule_destroyDIV.call(this);
}

Reforged.Hooks.TacticalScreenTurnSequenceBarModule_updateButtonBar = TacticalScreenTurnSequenceBarModule.prototype.updateButtonBar;
TacticalScreenTurnSequenceBarModule.prototype.updateButtonBar = function (_entityData)
{
	Reforged.Hooks.TacticalScreenTurnSequenceBarModule_updateButtonBar.call(this, _entityData);

	if (_entityData === null || typeof(_entityData) !== 'object') return;

	if ('isWaitActionSpent' in _entityData && _entityData.isWaitActionSpent === true)
	{
		// This is an approximation: In 99%+ of the cases WaitAll is redundant here because everyone spend their wait or ended their turn while already in the second half of the turn
		this.mWaitTurnAllButton.enableButton(false);
	}
}

Reforged.Hooks.TacticalScreenTurnSequenceBarModule_bindTooltips = TacticalScreenTurnSequenceBarModule.prototype.bindTooltips;
TacticalScreenTurnSequenceBarModule.prototype.bindTooltips = function ()
{
	this.mWaitTurnAllButton.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "Tactical.Button.WaitTurnAllButton" });
	Reforged.Hooks.TacticalScreenTurnSequenceBarModule_bindTooltips.call(this);

	$.each(this.mLeftStatsRows, function (_key, _value)
	{
		if (_value.StyleName == ProgressbarStyleIdentifier.rf_Reach)
		{
			_value.Row.unbindTooltip();
			_value.Row.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "Concept.Reach" });
			return false;	// break out of the for loop early as we are done
		}
	});
}

Reforged.Hooks.TacticalScreenTurnSequenceBarModule_unbindTooltips = TacticalScreenTurnSequenceBarModule.prototype.unbindTooltips;
TacticalScreenTurnSequenceBarModule.prototype.unbindTooltips = function ()
{
	this.mWaitTurnAllButton.unbindTooltip();
	Reforged.Hooks.TacticalScreenTurnSequenceBarModule_unbindTooltips.call(this);
}

// Not sure when exactly this is important. Maybe to hide this interface at the end of combat but before this screen is destroyed
// The code inside this hook is 100% the same as vanilla except that 'mEndTurnAllButtonContainer' is switched out with 'mWaitTurnAllButtonContainer'
Reforged.Hooks.TacticalScreenTurnSequenceBarModule_showStatsPanel = TacticalScreenTurnSequenceBarModule.prototype.showStatsPanel;
TacticalScreenTurnSequenceBarModule.prototype.showStatsPanel = function (_show, _instant)
{
	if (_instant !== undefined && typeof(_instant) == 'boolean')
	{
		this.mWaitTurnAllButtonContainer.css({ opacity: _show ? 1 : 0 });
		if (_show) this.mWaitTurnAllButtonContainer.removeClass('display-none').addClass('display-block');
		else this.mWaitTurnAllButtonContainer.addClass('display-none').removeClass('display-block');
	}
	else
	{
		this.mWaitTurnAllButtonContainer.velocity("finish", true).velocity({ opacity: _show ? 1 : 0 },
		{
			duration: _show ? this.mStatsPanelFadeInTime : this.mStatsPanelFadeOutTime,
			easing: 'swing',
			begin: function ()
			{
				if (_show)
					$(this).removeClass('display-none').addClass('display-block');
			},
			complete: function ()
			{
				if (!_show)
					$(this).removeClass('display-block').addClass('display-none');
			}
		});
	}
	Reforged.Hooks.TacticalScreenTurnSequenceBarModule_showStatsPanel.call(this, _show, _instant);
}

// New Functions:
TacticalScreenTurnSequenceBarModule.prototype.notifyBackendWaitTurnAllButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onWaitTurnAllButtonPressed');
};

TacticalScreenTurnSequenceBarModule.prototype.setWaitTurnAllButtonVisible = function (_visible)
{
	this.mWaitTurnAllButton.enableButton(_visible);
}
