this.perk_rf_second_wind <- ::inherit("scripts/skills/skill", {
	m = {
		ActionPointsTarget = 4	// set the current Action Points to this value if it's lower
	},
	function create()
	{
		this.m.ID = "perk.rf_second_wind";
		this.m.Name = ::Const.Strings.PerkName.RF_SecondWind;
		this.m.Description = "Upon waiting for a moment, this character will regain the strength for one more push.";
		this.m.Icon = "ui/perks/perk_rf_second_wind.png";
		this.m.Overlay = "perk_rf_second_wind";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return ::Tactical.isActive() && !this.getContainer().getActor().isWaitActionSpent();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will recover [Action Points|Concept.ActionPoints] upon [waiting|Concept.Wait] to end up with " + ::MSU.Text.colorPositive(this.m.ActionPointsTarget) + " total [Action Points|Concept.ActionPoints]")
		});
		return ret;
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
