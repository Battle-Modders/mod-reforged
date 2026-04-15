Reforged.Hooks.TooltipModule_buildFromData = TooltipModule.prototype.buildFromData;
TooltipModule.prototype.buildFromData = function(_data, _shouldBeUpdated, _contentType)
{
	Reforged.Hooks.TooltipModule_buildFromData.call(this, _data, _shouldBeUpdated, _contentType);

	// Add rf_image to tooltip
	if (_data !== null && jQuery.isArray(_data))
	{
		for (var i = 0; i < _data.length; ++i)
		{
			if (_data[i].type === 'rf_image' && 'image' in _data[i] && 'cssClass' in _data[i])
			{
				var image = $('<img class="' + _data[i].cssClass + '"/>');
				image.attr('src', Path.GFX + _data[i].image);
				this.mContainer.append(image);
			}
		}
	}
};

TooltipModule.prototype.rf_unescapeTagsOnElement = function(_elem)
{
	// TODO: integrate into MSU (need to do this for other tooltip elements too)
	var text = _elem.html();
	text = text.replace(/&lt;/g, "<"); // unescape HTML tag brackets
	text = text.replace(/&gt;/g, ">"); // unescape HTML tag brackets
	_elem.html(text);
}

Reforged.Hooks.TooltipModule_addHeaderDescriptionDiv = TooltipModule.prototype.addHeaderDescriptionDiv;
TooltipModule.prototype.addHeaderDescriptionDiv = function(_parentDIV, _data)
{
	var ret = Reforged.Hooks.TooltipModule_addHeaderDescriptionDiv.call(this, _parentDIV, _data);
	if (ret === null || _data.rawHTMLInText !== true )
		return ret;
	this.rf_unescapeTagsOnElement(ret.find(".description:first"));
	return ret;
};

Reforged.Hooks.TooltipModule_addContentTextDiv = TooltipModule.prototype.addContentTextDiv;
TooltipModule.prototype.addContentTextDiv = function(_parentDIV, _data, _isChildRow, _isParentFullWidth)
{
	// Add ability to add dividers in text entries.
	if (_data !== null && 'text' in _data && _data.text === 'rf_divider')
	{
		var container = $('<div class="row ui-control-tooltip-module-bottom-devider"/>');
		_parentDIV.append(container);
		return container;
	}
	var ret = Reforged.Hooks.TooltipModule_addContentTextDiv.call(this, _parentDIV, _data, _isChildRow, _isParentFullWidth);
	if (ret === null || _data.rawHTMLInText !== true )
		return ret;
	this.rf_unescapeTagsOnElement(ret.find(".text:first"));
	return ret;
};

Reforged.Hooks.TooltipModule_addHintDiv = TooltipModule.prototype.addHintDiv;
TooltipModule.prototype.addHintDiv = function(_parentDIV, _data, _isChildRow, _isParentFullWidth)
{
	// Add ability to add dividers in hint entries.
	if (_data !== null && 'text' in _data && _data.text === 'rf_divider')
	{
		var container = $('<div class="row ui-control-tooltip-module-bottom-devider"/>');
		_parentDIV.append(container);
		return container;
	}
	return Reforged.Hooks.TooltipModule_addHintDiv.call(this, _parentDIV, _data, _isChildRow, _isParentFullWidth);
};
