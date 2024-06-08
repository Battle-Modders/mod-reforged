::Reforged.HooksMod.hook("scripts/entity/world/party", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		local worth = 0;
		foreach (t in this.m.Troops)
		{
			worth += t.Cost;
		}

		if (!this.isHiddenToPlayer() && this.m.Troops.len() != 0)
		{
			ret.push({
				id = 100,
				type = "text",
				icon = "ui/icons/icon_contract_swords.png",
				text = format("Strength: %s / %s", ::MSU.Text.colorGreen(::World.State.getPlayer().getStrength()), ::MSU.Text.colorRed(worth))
			});
		}
		return ret;
	}
});
