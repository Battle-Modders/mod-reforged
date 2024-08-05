::logWarning("------ Applying Reforged modifications to MSU ------");

::Reforged.new <- function( _script, _function = null )
{
	local obj = ::new(_script);
	if (_function != null) _function(obj);
	return obj;
}

::logWarning("------ Reforged modifications to MSU Finished------");
