"use strict";

// Hit-chance overlay of Reforged: labels beside opponents in tactical combat.
// Data and screen positions come from Squirrel (::Reforged.HitchanceOverlay.getLabelsUIData / getLabelPosition).
// Positions are in px relative to the screen center and denote the label's anchor; `side` and `valign` say how
// the label sits relative to it (see positionLabels).
var RF_HitchanceOverlay = function( _onHoverChanged )
{
	this.mContainer = null;
	this.mLabels = {};				// id -> label element
	this.mHoveredLabel = null;		// label element currently hovered by the mouse
	this.mIsKeyHeld = false;
	this.mIsHoverable = null;
	this.mOnHoverChanged = _onHoverChanged;	// function( bool )

	this.mKeyDownListener = null;
	this.mKeyUpListener = null;
	this.mBlurListener = null;
};

RF_HitchanceOverlay.KeybindID = "Tactical_HitchanceOverlayInteraction";

RF_HitchanceOverlay.prototype.create = function( _parentDiv )
{
	var self = this;
	this.mContainer = $('<div class="rf-hitchance-overlay"/>');
	// Prepend so that all other tactical screen elements (topbar, turn sequence bar, orientation overlays) draw above it
	_parentDiv.prepend(this.mContainer);

	this.mKeyDownListener = function( _event )
	{
		if (!self.mIsKeyHeld && MSU.Keybinds.isKeybindPressed(Reforged.ID, RF_HitchanceOverlay.KeybindID, _event))
		{
			self.mIsKeyHeld = true;
			self.updateInteraction();
		}
	};
	this.mKeyUpListener = function( _event )
	{
		// Releasing any key of the keybind ends the hold, also a modifier released first
		if (self.mIsKeyHeld && RF_HitchanceOverlay.isKeyOfKeybind(_event))
		{
			self.mIsKeyHeld = false;
			self.updateInteraction();
		}
	};
	this.mBlurListener = function()
	{
		if (self.mIsKeyHeld)
		{
			self.mIsKeyHeld = false;
			self.updateInteraction();
		}
	};
	document.addEventListener('keydown', this.mKeyDownListener);
	document.addEventListener('keyup', this.mKeyUpListener);
	window.addEventListener('blur', this.mBlurListener);

	this.updateInteraction();
};

RF_HitchanceOverlay.prototype.destroy = function()
{
	this.clear();
	document.removeEventListener('keydown', this.mKeyDownListener);
	document.removeEventListener('keyup', this.mKeyUpListener);
	window.removeEventListener('blur', this.mBlurListener);
	this.mKeyDownListener = null;
	this.mKeyUpListener = null;
	this.mBlurListener = null;

	this.mContainer.remove();
	this.mContainer = null;
};

// Whether the key of _event is part of any key combination of the interaction keybind (e.g. "ctrl+x")
RF_HitchanceOverlay.isKeyOfKeybind = function( _event )
{
	var key = MSU.Key.KeyMapJS[_event.keyCode];
	var keybinds = MSU.Keybinds.KeybindsByMod[Reforged.ID];
	if (key === undefined || keybinds === undefined || !(RF_HitchanceOverlay.KeybindID in keybinds))
		return true;

	var combinations = keybinds[RF_HitchanceOverlay.KeybindID].getRawKeyCombinations();
	for (var i = 0; i < combinations.length; i++)
	{
		if (combinations[i].split('+').indexOf(key) !== -1)
			return true;
	}
	return false;
};

// Labels are hoverable (they have a nested tooltip) or click-through (the map below them can be hovered).
// The setting decides the default and holding the keybind inverts it.
RF_HitchanceOverlay.prototype.updateInteraction = function()
{
	if (this.mContainer === null)
		return;

	var hoverableByDefault = MSU.getSettingValue(Reforged.ID, "HitchanceOverlay_LabelInteraction") !== "Click-through";
	var hoverable = hoverableByDefault !== this.mIsKeyHeld;
	if (hoverable === this.mIsHoverable)
		return;

	this.mIsHoverable = hoverable;
	this.mContainer.toggleClass('rf-hoverable', hoverable);

	// A label stops receiving mouse events when it becomes click-through, so it gets no mouseleave.
	// Close its tooltip and release the frozen overlay ourselves.
	if (!hoverable && this.mHoveredLabel !== null)
	{
		this.hideTooltip();
		this.setHoveredLabel(null);
	}
};

RF_HitchanceOverlay.prototype.hideTooltip = function()
{
	if (Screens.Tooltip === null || Screens.Tooltip === undefined || !Screens.Tooltip.isConnected())
		return;

	var tooltip = Screens.Tooltip.getModule('TooltipModule');
	if (tooltip !== null)
		tooltip.hideTooltip();
};

RF_HitchanceOverlay.prototype.setHoveredLabel = function( _label )
{
	var wasHovered = this.mHoveredLabel !== null;
	this.mHoveredLabel = _label;
	var isHovered = _label !== null;
	if (wasHovered !== isHovered)
		this.mOnHoverChanged(isHovered);
};

RF_HitchanceOverlay.prototype.createLabel = function( _id )
{
	var self = this;
	var label = $('<div class="rf-hitchance-label"/>');
	label.mouseenter(function()
	{
		self.setHoveredLabel(label);
	});
	label.mouseleave(function()
	{
		if (self.mHoveredLabel === label)
			self.setHoveredLabel(null);
	});
	label.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: 'HitchanceOverlay.Label+' + _id });
	this.mContainer.append(label);
	this.mLabels[_id] = label;

	var fadeTime = RF_HitchanceOverlay.getFadeTime();
	if (fadeTime > 0)
		label.css('opacity', 0).fadeTo(fadeTime, 1);
	else
		label.css('opacity', 1);
	return label;
};

// _isImmediate: remove without fading out, e.g. when the overlay is cleared
RF_HitchanceOverlay.prototype.removeLabel = function( _id, _isImmediate )
{
	var label = this.mLabels[_id];
	if (label === undefined)
		return;

	if (this.mHoveredLabel === label)
	{
		this.hideTooltip();
		this.setHoveredLabel(null);
	}
	label.unbindTooltip();
	label.off('mouseenter mouseleave');
	delete this.mLabels[_id];

	var fadeTime = _isImmediate === true ? 0 : RF_HitchanceOverlay.getFadeTime();
	if (fadeTime > 0)
	{
		// A label with the same id that comes back meanwhile is a new element
		label.addClass('rf-removing');
		label.stop(true).fadeTo(fadeTime, 0, function()
		{
			label.remove();
		});
	}
	else
	{
		label.stop(true);
		label.remove();
	}
};

RF_HitchanceOverlay.getFadeTime = function()
{
	var value = MSU.getSettingValue(Reforged.ID, "HitchanceOverlay_FadeTime");
	return (typeof value === 'number' && value > 0) ? value : 0;
};

// 'compact' (sword icons on the map), 'icons' (skill icons on the map) or 'parchment' (skill icons on paper)
RF_HitchanceOverlay.getStyle = function()
{
	switch (MSU.getSettingValue(Reforged.ID, "HitchanceOverlay_Style"))
	{
		case "Parchment": return 'parchment';
		case "Skill Icons": return 'icons';
		default: return 'compact';
	}
};

// Value colors from bad over neutral to good: light ones for values drawn on the map, dark ones on paper
RF_HitchanceOverlay.ValueColors = {
	// neutral is a warm amber rather than a light cream, which blended into snow and sand
	map: { bad: [224, 83, 63], neutral: [240, 190, 70], good: [124, 207, 90] },
	paper: { bad: [143, 30, 30], neutral: [43, 29, 14], good: [19, 82, 19] }
};
RF_HitchanceOverlay.BadHitchance = 25;
RF_HitchanceOverlay.GoodHitchance = 75;

// A high chance is good for the subject's attack and bad for the opponent's attack
RF_HitchanceOverlay.getValueColor = function( _hitchance, _isOpponentAttack, _isOnMap )
{
	var colors = _isOnMap ? RF_HitchanceOverlay.ValueColors.map : RF_HitchanceOverlay.ValueColors.paper;
	var goodness = _isOpponentAttack ? 100 - _hitchance : _hitchance;
	var bad = RF_HitchanceOverlay.BadHitchance, good = RF_HitchanceOverlay.GoodHitchance, mid = (bad + good) / 2;

	var from, to, t;
	if (goodness <= mid)
	{
		from = colors.bad; to = colors.neutral;
		t = (goodness - bad) / (mid - bad);
	}
	else
	{
		from = colors.neutral; to = colors.good;
		t = (goodness - mid) / (good - mid);
	}
	t = Math.max(0, Math.min(1, t));

	var rgb = [];
	for (var i = 0; i < 3; i++)
		rgb.push(Math.round(from[i] + (to[i] - from[i]) * t));
	return 'rgb(' + rgb.join(',') + ')';
};

RF_HitchanceOverlay.prototype.createPart = function( _cssClass, _icon, _value, _color )
{
	var part = $('<div class="rf-hitchance-part ' + _cssClass + '"/>');
	part.append($('<img class="rf-hitchance-icon"/>').attr('src', Path.GFX + _icon));
	part.append($('<span class="rf-hitchance-value"/>').text(_value + '%').css('color', _color));
	return part;
};

// Compact icons: a sword pointing at the opponent (to hit) and back at the subject (to be hit). The CSS mirrors one of them.
RF_HitchanceOverlay.CompactIcon = 'ui/icons/damage_dealt.png';

// Settings that apply to all labels, read once per update. Also sets the style classes of the container.
RF_HitchanceOverlay.prototype.getStyleContext = function()
{
	var style = RF_HitchanceOverlay.getStyle();
	var isOnMap = style !== 'parchment';
	this.mContainer.toggleClass('rf-style-compact', style === 'compact');
	this.mContainer.toggleClass('rf-style-icons', style === 'icons');
	this.mContainer.toggleClass('rf-style-parchment', style === 'parchment');
	this.mContainer.toggleClass('rf-on-map', isOnMap);
	this.mContainer.toggleClass('rf-placement-above', MSU.getSettingValue(Reforged.ID, "HitchanceOverlay_Placement") === "Above");
	return {
		style: style,
		isOnMap: isOnMap,
		paperOpacity: RF_HitchanceOverlay.getOpacitySetting("HitchanceOverlay_ParchmentOpacity"),
		contentOpacity: RF_HitchanceOverlay.getOpacitySetting("HitchanceOverlay_ContentOpacity")
	};
};

// At most two parts, each an icon and a hit chance: to hit (by the subject) and to be hit (by this opponent).
// The last part gets a warning icon when the opponent attacks the subject on movement or arrival.
// _context: see getStyleContext
RF_HitchanceOverlay.prototype.fillLabel = function( _label, _data, _context )
{
	_label.empty();
	_label.removeData('rf-size');
	var style = _context.style;
	var isOnMap = _context.isOnMap;

	var getIcon = function( _value, _fallback )
	{
		if (style === 'compact')
			return RF_HitchanceOverlay.CompactIcon;
		return (_value.icon !== null && _value.icon !== undefined) ? _value.icon : _fallback;
	};

	// The parchment is a miniature vanilla tooltip: the whole paper plus the wooden ornament on top.
	// It is a separate layer, so that the paper and the content have their own opacity settings.
	if (!isOnMap)
	{
		var paper = $('<div class="rf-hitchance-paper"/>');
		paper.append($('<div class="rf-hitchance-ornament"/>'));
		paper.css('opacity', _context.paperOpacity);
		_label.append(paper);
	}

	var lastPart = null;
	var toHit = _data.toHit;
	if (toHit !== null && toHit !== undefined)
	{
		lastPart = this.createPart('rf-hitchance-to-hit', getIcon(toHit, 'ui/icons/hitchance.png'), toHit.hitchance, RF_HitchanceOverlay.getValueColor(toHit.hitchance, false, isOnMap));
		_label.append(lastPart);
	}

	var toBeHit = _data.toBeHit;
	if (toBeHit !== null && toBeHit !== undefined)
	{
		lastPart = this.createPart('rf-hitchance-to-be-hit', getIcon(toBeHit, 'ui/icons/melee_defense.png'), toBeHit.hitchance, RF_HitchanceOverlay.getValueColor(toBeHit.hitchance, true, isOnMap));
		// dimmed rows fade further via CSS on their children
		if (toBeHit.dimmed === true)
			lastPart.addClass('rf-dimmed');
		_label.append(lastPart);
	}

	if (_data.warning === true && lastPart !== null)
		lastPart.append($('<img class="rf-hitchance-warning"/>').attr('src', Path.GFX + 'ui/icons/warning.png'));

	// Icons and values in all styles
	if (_context.contentOpacity < 1)
		_label.children('.rf-hitchance-part').css('opacity', _context.contentOpacity);
};

// Size multiplier of the labels on top of the camera zoom scaling
RF_HitchanceOverlay.getScaleSetting = function()
{
	var value = MSU.getSettingValue(Reforged.ID, "HitchanceOverlay_Scale");
	return (typeof value === 'number' && value > 0) ? value : 1;
};

RF_HitchanceOverlay.getOpacitySetting = function( _settingID )
{
	var value = MSU.getSettingValue(Reforged.ID, _settingID);
	return typeof value === 'number' ? Math.max(0, Math.min(1, value)) : 1;
};

// Distance in px between the anchor (the hex corner) and the label
RF_HitchanceOverlay.Gap = 2;

// Size of a label, measured once per content and font size (cached in its data 'rf-size', cleared by fillLabel):
// { width, height, firstTop, firstCenter } where first* are of its first row relative to the label's top
RF_HitchanceOverlay.measureLabel = function( _label )
{
	var size = _label.data('rf-size');
	if (size !== undefined)
		return size;

	var first = _label.children('.rf-hitchance-part').first();
	var height = _label.outerHeight();
	size = {
		width: _label.outerWidth(),
		height: height,
		firstTop: first.length !== 0 ? first.position().top : 0,
		firstCenter: first.length !== 0 ? first.position().top + first.outerHeight() / 2 : height / 2
	};
	_label.data('rf-size', size);
	return size;
};

// _items: array of { label, pos } with pos from Squirrel (getLabelPosition).
// All writes that change sizes come first, then all reads, then the positions, so that the layout is calculated
// once instead of once per label.
RF_HitchanceOverlay.prototype.positionLabels = function( _items )
{
	var scaleSetting = RF_HitchanceOverlay.getScaleSetting();
	var i, label, pos;

	// Visibility and font size; all sizes of a label are in em, so the font size scales the whole label with the camera zoom
	for (i = 0; i < _items.length; i++)
	{
		label = _items[i].label;
		pos = _items[i].pos;
		label.toggleClass('rf-hidden-label', !pos.visible);
		if (!pos.visible)
			continue;

		var fontSize = 1.4 * pos.scale * scaleSetting;
		if (label.data('rf-font-size') !== fontSize)
		{
			label.data('rf-font-size', fontSize);
			label.css('font-size', fontSize + 'rem');
			label.removeData('rf-size');
		}
	}

	var centerX = this.mContainer.width() / 2;
	var centerY = this.mContainer.height() / 2;
	var layouts = [];
	for (i = 0; i < _items.length; i++)
	{
		if (_items[i].pos.visible)
			layouts.push({ label: _items[i].label, pos: _items[i].pos, size: RF_HitchanceOverlay.measureLabel(_items[i].label) });
	}

	for (i = 0; i < layouts.length; i++)
	{
		pos = layouts[i].pos;
		var size = layouts[i].size;
		var left = centerX + pos.x;
		var top;
		if (pos.side === 'above')
		{
			// Horizontal label above the unit: the anchor is its bottom center
			left -= size.width / 2;
			top = centerY + pos.y - size.height;
		}
		else
		{
			if (pos.side === 'left')
				left -= size.width + RF_HitchanceOverlay.Gap;
			else
				left += RF_HitchanceOverlay.Gap;

			if (pos.valign === 'center')
				top = centerY + pos.y - size.height / 2;	// beside a portrait marker: the whole label is centered on it
			else if (pos.valign === 'first-center')
				top = centerY + pos.y - size.firstCenter;	// bars hidden: the first row is centered on the anchor (torso height)
			else
				top = centerY + pos.y - size.firstTop;		// the anchor is the top of the first row, just below vanilla's bars
			// further rows extend downward
		}
		layouts[i].label.css({ left: left + 'px', top: top + 'px' });
	}
};

// _labels: array of label data (Squirrel getLabelsUIData): position { id, x, y, side, scale, visible, valign }
// plus { toHit, toBeHit, warning }
RF_HitchanceOverlay.prototype.setLabels = function( _labels )
{
	if (this.mContainer === null)
		return;

	this.updateInteraction();
	var context = this.getStyleContext();

	var keep = {};
	var items = [];
	for (var i = 0; i < _labels.length; i++)
	{
		var data = _labels[i];
		keep[data.id] = true;
		var label = this.mLabels[data.id];
		if (label === undefined)
			label = this.createLabel(data.id);
		this.fillLabel(label, data, context);
		items.push({ label: label, pos: data });
	}
	this.positionLabels(items);

	var self = this;
	Object.keys(this.mLabels).forEach(function( _id )
	{
		if (!(_id in keep))
			self.removeLabel(_id);
	});
};

// _positions: array of positions { id, x, y, side, scale, visible, valign } (Squirrel getLabelPosition)
RF_HitchanceOverlay.prototype.updatePositions = function( _positions )
{
	if (this.mContainer === null)
		return;

	var items = [];
	for (var i = 0; i < _positions.length; i++)
	{
		var label = this.mLabels[_positions[i].id];
		if (label !== undefined)
			items.push({ label: label, pos: _positions[i] });
	}
	this.positionLabels(items);
};

RF_HitchanceOverlay.prototype.clear = function()
{
	var self = this;
	Object.keys(this.mLabels).forEach(function( _id )
	{
		self.removeLabel(_id, true);
	});
	// Labels still fading out
	if (this.mContainer !== null)
		this.mContainer.children('.rf-removing').stop(true).remove();
};
