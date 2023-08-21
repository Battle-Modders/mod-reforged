::mods_hookBaseClass("items/item", function(o) {
	o = o[o.SuperName];

	o.m.FlipIconX <- false;			// If set to true then this Icon will be flipped along the vertical axis
	o.m.FlipIconY <- false;			// If set to true then this Icon will be flipped along the horizontal axis
	o.m.FlipIconLargeX <- false;	// If set to true then this IconLarge will be flipped along the vertical axis
	o.m.FlipIconLargeY <- false;	// If set to true then this IconLarge will be flipped along the horizontal axis

	local getIcon = o.getIcon;
	o.getIcon = function()
	{
		local ret = getIcon();

		local codeCount = (2 * this.m.FlipIconX.tointeger()) + this.m.FlipIconY.tointeger();
		if (codeCount != 0)
		{
			local substring = ret.slice(0, ret.find("/"));
			for (local i = 1; i <= codeCount; i++)
			{
				ret = ::MSU.String.replace(ret, substring, substring + "/../" + substring);
			}
		}

		return ret;
	}

	local getIconLarge = o.getIconLarge;
	o.getIconLarge = function()
	{
		local ret = getIconLarge();

		local codeCount = (2 * this.m.FlipIconLargeX.tointeger()) + this.m.FlipIconLargeY.tointeger();

		if (codeCount != 0)
		{
			local substring = ret.slice(0, ret.find("/"));
			for (local i = 1; i <= codeCount; i++)
			{
				ret = ::MSU.String.replace(ret, substring, substring + "/../" + substring);
			}
		}

		return ret;
	}
});
