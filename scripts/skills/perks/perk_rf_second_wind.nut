this.perk_rf_second_wind <- ::inherit("scripts/skills/skill", {
	m = {
		ActionPointsTarget = 4	// set the current Action Points to this value if it's lower
	},
	function create()
	{
		this.m.ID = "perk.rf_second_wind";
		this.m.Name = ::Const.Strings.PerkName.RF_SecondWind;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SecondWind;
		this.m.Icon = "ui/perks/rf_second_wind.png";
		this.m.Overlay = "perk_rf_second_wind";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onWaitTurn()
	{
		local actor = this.getContainer().getActor();

		local recoveredActionPoints = ::Math.min(this.m.ActionPointsTarget, actor.getActionPointsMax()) - actor.getActionPoints();
		if (recoveredActionPoints > 0)
		{
			actor.setActionPoints(actor.getActionPoints() + recoveredActionPoints);
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " recovers " + ::MSU.Text.colorPositive(recoveredActionPoints) + " Action Point(s)");
			this.spawnIcon(this.m.Overlay, actor.getTile());
		}
	}
});
