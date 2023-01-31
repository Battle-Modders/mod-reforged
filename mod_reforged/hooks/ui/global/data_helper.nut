::mods_hookNewObject("ui/global/data_helper", function(o) {
	local convertEntityHireInformationToUIData = o.convertEntityHireInformationToUIData;
	o.convertEntityHireInformationToUIData = function(_entity)
	{
		local ret = convertEntityHireInformationToUIData(_entity);
		if (_entity.isTryoutDone())
		{
			ret.BackgroundText = _entity.getBackground().getPerkGroupsHTML() + ret.BackgroundText;
		}
		return ret;
	}
})
