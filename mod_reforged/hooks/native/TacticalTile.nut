// Hook to return as if the previewing entity has ZoC on this tile. Relevant for hit-chance prediction during movement preview.
local hasZoneOfControlOtherThan = ::TacticalTile.hasZoneOfControlOtherThan;
::TacticalTile.hasZoneOfControlOtherThan <- { function hasZoneOfControlOtherThan( _factions )
{
	return hasZoneOfControlOtherThan(_factions) || (this.Properties.has("RF_PreviewZOCFaction") && _factions.find(this.Properties.get("RF_PreviewZOCFaction")) == null)
}}.hasZoneOfControlOtherThan;

// Hook to return as if the previewing entity has ZoC on this tile. Relevant for hit-chance prediction during movement preview.
local getZoneOfControlCount = ::TacticalTile.getZoneOfControlCount;
::TacticalTile.getZoneOfControlCount <- { function getZoneOfControlCount( _faction )
{
	if (!this.Properties.has("RF_PreviewZOCFaction") || this.Properties.get("RF_PreviewZOCFaction") != _faction)
		return getZoneOfControlCount(_faction);

	return getZoneOfControlCount(_faction) + 1;
}}.getZoneOfControlCount;

// Hook to return as if the previewing entity has ZoC on this tile. Relevant for hit-chance prediction during movement preview.
local getZoneOfControlCountOtherThan = ::TacticalTile.getZoneOfControlCountOtherThan;
::TacticalTile.getZoneOfControlCountOtherThan <- { function getZoneOfControlCountOtherThan( _factions )
{
	if (!this.Properties.has("RF_PreviewZOCFaction") || _factions.find(this.Properties.get("RF_PreviewZOCFaction")) != null)
		return getZoneOfControlCountOtherThan(_factions);

	return getZoneOfControlCountOtherThan(_factions) + 1;
}}.getZoneOfControlCountOtherThan;

// Hook to return as if the previewing entity is present in this tile. Relevant for hit-chance prediction during movement preview.
local getEntity = ::TacticalTile.getEntity;
::TacticalTile.getEntity <- { function getEntity()
{
	return this.Properties.has("RF_PreviewEntity") ? this.Properties.get("RF_PreviewEntity") : getEntity();
}}.getEntity;

// Hook to return as if the previewing entity is present in this tile. Relevant for hit-chance prediction during movement preview.
local IsOccupiedByActor = ::TacticalTile.__getTable.IsOccupiedByActor;
::TacticalTile.__getTable.IsOccupiedByActor <- { function IsOccupiedByActor()
{
	return IsOccupiedByActor() || this.Properties.has("RF_PreviewEntity");
}}.IsOccupiedByActor;

// Hook to return as if the previewing entity is present in this tile. Relevant for hit-chance prediction during movement preview.
local IsEmpty = ::TacticalTile.__getTable.IsEmpty;
::TacticalTile.__getTable.IsEmpty <- { function IsEmpty()
{
	return IsEmpty() && !this.Properties.has("RF_PreviewEntity");
}}.IsEmpty;
