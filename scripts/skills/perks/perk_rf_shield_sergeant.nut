this.perk_rf_shield_sergeant <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_shield_sergeant";
		this.m.Name = ::Const.Strings.PerkName.RF_ShieldSergeant;
		this.m.Description = ::Const.Strings.PerkDescription.RF_ShieldSergeant;
		this.m.Icon = "ui/perks/perk_rf_shield_sergeant.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onCombatStarted()
	{
		local allies = ::Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());
		foreach (ally in allies)
		{
			local skill = ally.getSkills().getSkillByID("actives.shieldwall");
			if (skill != null)
			{
				ally.getSkills().add(::new("scripts/skills/effects/shieldwall_effect"));
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(ally) + " uses Shieldwall due to " + ::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "\'s " + this.getName() + " perk");
			}
		}
	}

	// This perk has part of its functionality written in a hook on skills/actives/shieldwall
});
