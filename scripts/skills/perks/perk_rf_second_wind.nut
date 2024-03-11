this.perk_rf_second_wind <- ::inherit("scripts/skills/skill", {
	m = {
		RecoverActionPointTarget = 4
	},
	function create()
	{
		this.m.ID = "perk.rf_second_wind";
		this.m.Name = ::Const.Strings.PerkName.RF_SecondWind;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SecondWind;
		// this.m.Icon = "ui/perks/rf_second_wind.png";		// TODO: add icon for this perk
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk - 5;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onWaitTurn()
	{
		local actor = this.getContainer().getActor();

		local recoveredActionPoints = this.m.RecoverActionPointTarget - actor.getActionPoints();
		if (recoveredActionPoints > 0)
		{
			actor.setActionPoints(actor.getActionPoints() + recoveredActionPoints);
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " recovers " + ::MSU.Text.colorGreen(recoveredActionPoints) + " Action Point(s)");

			// this.spawnIcon("rf_second_effect", _targetTile);		// TODO: add effect icon
		}
	}
});
