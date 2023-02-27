
::mods_hookBaseClass("events/event", function(o)
{
    o = o[o.SuperName];
	// Refactors uses of "Max Fatigue" into "Stamina" for all list entries used in events
	local getUIList = o.getUIList;
	o.getUIList = function ()
	{
        local ret = getUIList();
        if (ret.len() == 0) return ret;
        foreach (listEntry in ret[0].items)
        {
            if (!("text" in listEntry)) continue;
			listEntry.text = ::MSU.String.replace(listEntry.text, "Max Fatigue", "Stamina");
        }
        return ret;
	}
});
