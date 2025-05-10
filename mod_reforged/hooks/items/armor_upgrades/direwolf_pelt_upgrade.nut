// Add hyperlinks to tooltip entry about resolve malus and clarify that it is only during morale check
local function RF_getResolveTooltipText( _text )
{
	_text = ::String.replace(_text, "Resolve", "[Resolve|Concept.Bravery]");
	_text = ::String.replace(_text, "engaged", "[engaged|Concept.ZoneOfControl]");
	_text += "during [morale checks|Concept.Morale]";
	return ::Reforged.Mod.Tooltips.parseString(_text);
}

::Reforged.HooksMod.hook("scripts/items/armor_upgrades/direwolf_pelt_upgrade", function(q) {
	// Add hyperlinks to tooltip entry about resolve malus and clarify that it is only during morale check
	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			if (entry.id == 15)
			{
				entry.text = RF_getResolveTooltipText(entry.text);
				break;
			}
		}
		return ret;
	}

	// Add hyperlinks to tooltip entry about resolve malus and clarify that it is only during morale check
	q.onArmorTooltip = @(__original) function( _result )
	{
		local idx = _result.len() - 1;
		__original(_result);
		for (local i = idx + 1; i < _result.len(); i++)
		{
			local entry = _result[i];
			if (entry.id == 15)
			{
				entry.text = RF_getResolveTooltipText(entry.text);
				break;
			}
		}
	}
});
