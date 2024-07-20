// Replaces the Vanilla Combat-Log container with a new bigger version.
// This very close to the solution implemented by Enduriel into Legends about 1 year ago. According to that commit this was originally made by Leonion as a standalone mod.
Reforged.Hooks.TacticalScreenTopbarEventLogModule_createDIV = TacticalScreenTopbarEventLogModule.prototype.createDIV;
TacticalScreenTopbarEventLogModule.prototype.createDIV = function(_parentDiv)
{
	// Change some constants from the constructor
	this.mMaxVisibleEntries = 150;
	this.mNormalHeight = '13.0rem';

	var grandpa = _parentDiv.parent();
	_parentDiv.css('opacity', '0');

	var newParentDiv = $('<div class="new-log-container"/>');
	grandpa.append(newParentDiv);

	// This solution defines a dymanic width for the combat log which is dependant on the current resolution
	var width = Math.max(200, Math.min(grandpa.parent().width() / 3.5, 800));
	newParentDiv.css('width', width);
	newParentDiv.css('background-size', newParentDiv.width() + " " + newParentDiv.height());

	Reforged.Hooks.TacticalScreenTopbarEventLogModule_createDIV.call(this, newParentDiv);

	// Now we retroactively adjust the width of some child elements according to the 'width' calculated above
	var eventLogsContainerLayout = this.mContainer.find('.l-event-logs-container:first');
	eventLogsContainerLayout.css('width', newParentDiv.width() - 60);

	this.mEventsListContainer.css('background-size', newParentDiv.width() - 75, + " " + newParentDiv.height());
};
