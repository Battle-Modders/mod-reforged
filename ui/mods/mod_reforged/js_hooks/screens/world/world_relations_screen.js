Reforged.Hooks.WorldRelationsScreen_addListEntry = WorldRelationsScreen.prototype.addListEntry;
WorldRelationsScreen.prototype.addListEntry = function (_data)
{
	// Call the original function to create the entry and its elements
	Reforged.Hooks.WorldRelationsScreen_addListEntry.call(this, _data);

	// Add tooltip to faction's image for that faction.
	var entry = this.mListScrollContainer.find('.list-entry').last();
	var image = entry.find('.column.is-left img:first');
	image.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: 'Faction+' + _data.ID });
}
