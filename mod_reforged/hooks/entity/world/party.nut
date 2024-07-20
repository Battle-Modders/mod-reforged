::Reforged.HooksMod.hook("scripts/entity/world/party", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		if (!this.isHiddenToPlayer() && this.m.Troops.len() != 0)
		{
			ret.push({
				id = 100,
				type = "text",
				icon = "ui/icons/icon_contract_swords.png",
				text = format("Strength: %s / %s", ::MSU.Text.colorPositive(::World.State.getPlayer().getStrength()), ::MSU.Text.colorNegative(this.getStrength()))
			});
		}
		return ret;
	}
});
