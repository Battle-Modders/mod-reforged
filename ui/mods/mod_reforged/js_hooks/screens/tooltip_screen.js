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
	var ret = Reforged.Hooks.TooltipModule_addContentTextDiv.call(this, _parentDIV, _data, _isChildRow, _isParentFullWidth);
	if (ret === null || _data.rawHTMLInText !== true )
		return ret;
	this.rf_unescapeTagsOnElement(ret.find(".text:first"));
	return ret;
};
