var Reforged = {
	mID : "mod_reforged",
	mJSConnectionID : "ReforgedJSConnection"
}

var addHeaderDescriptionDiv = TooltipModule.prototype.addHeaderDescriptionDiv;
TooltipModule.prototype.addHeaderDescriptionDiv = function(_parentDIV, _data)
{
	var ret = addHeaderDescriptionDiv.call(this, _parentDIV, _data);
	if (ret === null || _data.rawHTML === undefined || _data.rawHTML === "")
		return ret;
	var description = ret.find(".description:first");
	description.html(description.html() + _data.rawHTML);
	return ret;
};
