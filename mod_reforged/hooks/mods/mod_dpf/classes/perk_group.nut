::mods_hookExactClass(::DynamicPerks.Class.PerkGroup.slice(8), function(o) { // slice(8) to remove "scripts/"
	o.getTooltip = function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		foreach (i, row in this.getTree())
		{
			local perks = [];
			foreach (j, perkID in row)
			{
				local perkDef = ::Const.Perks.findById(perkID);
				perks.push({
					id = 10,
					type = "text",
					icon = perkDef.Icon,
					text = format("[tooltip=mod_msu.Perk+%s]%s[/tooltip]", split(perkDef.Script, "/").top(), perkDef.Name)
				});
			}

			ret.push({
				id = 3 + i,
				type = "text",
				text = "Tier " + (i + 1) + ":",
				children = perks
			});
		}

		return ret;
	}
});
