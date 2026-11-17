// Movement preview (hit-chance prediction, ::Reforged.HitchanceOverlay.applyMovementPreview): tiles report as if
// the previewing entity already stood on the destination tile. Tile properties set during the preview:
// - RF_PreviewEntity on the destination tile: occupied by the previewing entity.
// - RF_PreviewVacated on the entity's current tile: empty.
// - RF_PreviewZOCFaction on the destination tile and its neighbors: the entity's faction gains ZoC there.
// - RF_PreviewZOCRemovedFaction on the current tile and its neighbors: the entity's faction loses its ZoC there.
// Tiles next to both get both, which cancels out.

// Change of the ZoC count of faction _f on this tile by the preview
local function getPreviewZOCDelta( _tile, _f )
{
	local ret = 0;
	if (_tile.Properties.has("RF_PreviewZOCFaction") && _tile.Properties.get("RF_PreviewZOCFaction") == _f)
		ret++;
	if (_tile.Properties.has("RF_PreviewZOCRemovedFaction") && _tile.Properties.get("RF_PreviewZOCRemovedFaction") == _f)
		ret--;
	return ret;
}

// Change of the ZoC count of all factions other than _factions on this tile by the preview
local function getPreviewZOCDeltaOtherThan( _tile, _factions )
{
	local ret = 0;
	if (_tile.Properties.has("RF_PreviewZOCFaction") && _factions.find(_tile.Properties.get("RF_PreviewZOCFaction")) == null)
		ret++;
	if (_tile.Properties.has("RF_PreviewZOCRemovedFaction") && _factions.find(_tile.Properties.get("RF_PreviewZOCRemovedFaction")) == null)
		ret--;
	return ret;
}

local getZoneOfControlCountOtherThan = ::TacticalTile.getZoneOfControlCountOtherThan;
::TacticalTile.getZoneOfControlCountOtherThan <- { function getZoneOfControlCountOtherThan( _factions )
{
	return getZoneOfControlCountOtherThan(_factions) + getPreviewZOCDeltaOtherThan(this, _factions);
}}.getZoneOfControlCountOtherThan;

local hasZoneOfControlOtherThan = ::TacticalTile.hasZoneOfControlOtherThan;
::TacticalTile.hasZoneOfControlOtherThan <- { function hasZoneOfControlOtherThan( _factions )
{
	local delta = getPreviewZOCDeltaOtherThan(this, _factions);
	if (delta == 0)
		return hasZoneOfControlOtherThan(_factions);
	return this.getZoneOfControlCountOtherThan(_factions) > 0;
}}.hasZoneOfControlOtherThan;

local getZoneOfControlCount = ::TacticalTile.getZoneOfControlCount;
::TacticalTile.getZoneOfControlCount <- { function getZoneOfControlCount( _faction )
{
	return getZoneOfControlCount(_faction) + getPreviewZOCDelta(this, _faction);
}}.getZoneOfControlCount;

local getEntity = ::TacticalTile.getEntity;
::TacticalTile.getEntity <- { function getEntity()
{
	if (this.Properties.has("RF_PreviewEntity"))
		return this.Properties.get("RF_PreviewEntity");
	if (this.Properties.has("RF_PreviewVacated"))
		return null;
	return getEntity();
}}.getEntity;

local IsOccupiedByActor = ::TacticalTile.__getTable.IsOccupiedByActor;
::TacticalTile.__getTable.IsOccupiedByActor <- { function IsOccupiedByActor()
{
	if (this.Properties.has("RF_PreviewEntity"))
		return true;
	if (this.Properties.has("RF_PreviewVacated"))
		return false;
	return IsOccupiedByActor();
}}.IsOccupiedByActor;

local IsEmpty = ::TacticalTile.__getTable.IsEmpty;
::TacticalTile.__getTable.IsEmpty <- { function IsEmpty()
{
	if (this.Properties.has("RF_PreviewEntity"))
		return false;
	if (this.Properties.has("RF_PreviewVacated"))
		return true;
	return IsEmpty();
}}.IsEmpty;
