this.rf_obsidian_stab_skill <- ::inherit("scripts/skills/actives/stab", {
    m = {},
    function create()
    {
        this.stab.create();
        // does not change id or name of the skill here
        this.m.Description = "A foul stab with malice that causes your target to wither away.";
        this.m.KilledString = "Sacrificed";
        // TODO: make cooler art for legendary weapon
		this.m.Icon = "skills/active_03.png";
		this.m.IconDisabled = "skills/active_03_sw.png";
		this.m.Overlay = "active_03";
    }

    function getTooltip()
	{
		local ret = this.stab.getTooltip();

        ret.push({
            id = 8,
            type = "text",
            icon = "ui/icons/special.png",
            text = ::Reforged.Mod.Tooltips.parseString("Applies [$ $|Skill+withered_effect] when inflicting at least " + ::MSU.Text.color(::Const.UI.Color.DamageValue, ::Const.Combat.PoisonEffectMinDamage) + " damage to [Hitpoints|Concept.Hitpoints]")
        });

		return ret;
	}
});