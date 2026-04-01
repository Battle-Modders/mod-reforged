local getDefaultFaction = ::Const.EntityType.getDefaultFaction;
::Const.EntityType.getDefaultFaction = function( _id )
{
	return _id in ::Reforged.Entities.DefaultFaction ? ::Reforged.Entities.DefaultFaction[_id] : getDefaultFaction(_id);
}
