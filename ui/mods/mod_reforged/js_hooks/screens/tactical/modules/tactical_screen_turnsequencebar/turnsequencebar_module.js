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
		self.RF_notifyBackendWaitTurnAllButtonPressed();
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
TacticalScreenTurnSequenceBarModule.prototype.RF_notifyBackendWaitTurnAllButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'RF_onWaitTurnAllButtonPressed');
};

TacticalScreenTurnSequenceBarModule.prototype.RF_setWaitTurnAllButtonVisible = function (_visible)
{
	this.mWaitTurnAllButton.enableButton(_visible);
}


TacticalScreenTurnSequenceBarModule.prototype.removeEntity = function (_entityId)
{
	if(_entityId === null)
	{
		console.error('ERROR: Failed to remove entity. Reason: Entity has no id.');
		return;
	}

	// search entity
	var entityDIV = this.findEntityDIV(_entityId);
	if(entityDIV === null)
	{
		console.error('ERROR: Failed to remove entity. Reason: Entity id: ' + _entityId + ' not found.');
		return;
	}

	// sanity check
	if(entityDIV.div.is('[in-removal]'))
	{
		var success = false;

		this.mEntitySliderContainer.find('.l-entity').each(function (_index, _element)
		{
			var possibleEntityDIV = $(_element);
			var possibleEntity = possibleEntityDIV.data('entity');

			if(possibleEntity !== null && 'id' in possibleEntity && possibleEntity.id === _entityId && !possibleEntityDIV.is('[in-removal]'))
			{
				entityDIV = { div: possibleEntityDIV, index: _index };
				success = true;
			}
		});

		if(!success)
		{
			console.error('WARNING: Entity (' + _entityId + ') is about to get removed. Be patient!');
			return;
		}
	}

	// mark this entity as about to get removed for possible further removal chaining of following entities
	entityDIV.div.attr('in-removal', true);

	var entityImage = entityDIV.div.find('img:first');
	entityImage.data('placeholder').addClass('opacity-none');

	// get the immediately following entity
	var nextEntityIsVisibleToPlayer = false;
	var hideStatusPanel = true;
	var nextEntityDIV = entityDIV.div.next();

	if(nextEntityDIV.length > 0)
	{
		hideStatusPanel = false;
		nextEntityIsVisibleToPlayer = nextEntityDIV.attr('is-hidden-to-player') !== 'true';

		var entityPlayoad = nextEntityDIV.data('entity');
		if(entityPlayoad !== null && typeof(entityPlayoad) == 'object')
		{
			hideStatusPanel = entityPlayoad.isEnemy;
		}
	}

	// get the previous ones to check if one or more are scheduled to be removed but not finished yet, thus we have to chain the first slot selection further down the row
	var selectNewFirstEntity = (entityDIV.index === 0);
	var prevEntityDIV = entityDIV.div.prev();
	var prevEntityCount = 1;

	while(prevEntityDIV.length > 0)
	{
		selectNewFirstEntity = prevEntityDIV.is('[in-removal]');
		prevEntityDIV = prevEntityDIV.prev();

		if (selectNewFirstEntity)
		{
			++prevEntityCount;
		}
	}

	// fade the entity image out
	// take possible next visible entity into account
	var isVisibleToPlayer = nextEntityIsVisibleToPlayer ? true : entityDIV.div.attr('is-hidden-to-player') !== 'true';
	var fadeOutDuration = isVisibleToPlayer ? this.mFadeOutDuration : this.mFadeOutDurationIfHiddenToPlayer;
	var slideOutDuration = isVisibleToPlayer ? this.mSlideOutDuration : this.mSlideOutDurationIfHiddenToPlayer;

	var self = this;
	var firstSlotEntered = false;
	var entityImageLayer = entityDIV.div.find('.image-layer:first');
	var entityImage = entityImageLayer.find('img:first');
	entityImage.velocity({ opacity: 0 },
	{
		duration: fadeOutDuration,
		begin: function(_animation)
		{
			if (selectNewFirstEntity)
				self.enableFirstEntitySelection(true);

			// if this is the first entity, hide the skills & status effects
			if (entityDIV.index === 0)
			{
				self.showEntitySkillbar(false);
				self.showEntityStatusEffectbar(false);

				// if there is no following entity or the entity is an enemy - hide the status panel also
				if (hideStatusPanel)
				{
					self.showStatsPanel(false);
				}
			}

			// Note: see tooltip.js
			entityImageLayer.unbindTooltip();
		},
		complete: function()
		{
			// slide the entity out and if needed a new in
			entityDIV.div.velocity({ width: 0 },
			{
				duration: slideOutDuration, // * prevEntityCount,
				easing: 'swing',
				begin: function(_animation)
				{
					// notifiy the sq backend that the first entity is about to get removed
					if(selectNewFirstEntity)
					{
						self.notifyBackendEntityLeftFirstSlot(_entityId);
					}
				},
				complete: function()
				{
					// notify sq that the entity has being removed
					self.notifyBackendEntityRemoved(_entityId);
					$(this).remove();
				}
			});
		}
	});
};
