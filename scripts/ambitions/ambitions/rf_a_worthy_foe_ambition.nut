this.rf_a_worthy_foe_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {
		CompletionStateFlag = "RF_AWorthyFoeCompleted",
		ChampionChancePassive = 5,	// Additional global Champion Chance while this ambition is active. Implemented inside resetToDefaults
		ChampionChanceReward = 1			// Additional global Champion Chance after this ambition has been completed. Implemented inside resetToDefaults
	},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.rf_a_worthy_foe";
		this.m.Duration = 14.0 * ::World.getTime().SecondsPerDay;
		this.m.ButtonText = "We\'ve made a name for ourselves, but there are warriors out there whose names carry even further. Let us seek one out and prove who is better!";
		this.m.RewardTooltip = "You\'ll be awarded a unique accessory that grants the wearer additional resolve.";
		this.m.UIText = "Defeat a Champion";
		this.m.TooltipText = "Defeat a Champion in battle while this ambition is active.\nWhile pursuing this ambition, Champions are " + ::MSU.Text.colorPositive("+" + this.m.ChampionChancePassive + "%") + " more likely to appear.";
		this.m.SuccessText = "[img]gfx/ui/events/event_87.png[/img]The champion lying dead before you had earned a reputation few fighting men ever will. It did him little good against the %companyname%.\n\nWord of the victory will travel, and other renowned warriors may now be more eager to test themselves against the company.";
		this.m.SuccessButtonText = "A worthy foe indeed.";
		// This reward is implemented in the resetToDefaults function from asset_manager.nut
		this.m.RewardTooltip = "Permanently increases the chance for Champions to appear by " + ::MSU.Text.colorPositive(this.m.ChampionChanceReward + "%");

		this.m.ButtonIcon = "skills/status_effect_108.png";		// champion racial icon
	}

	function onUpdateScore()
	{
		if (!::World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
			return;

		this.m.Score = 10;
	}

	function onCheckSuccess()
	{
		// This condition is checked during the kill function from actor.nut
		return ::World.Statistics.getFlags().has(this.m.CompletionStateFlag);
	}

	function onReward()
	{
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/icons/miniboss.png",
			text = ::MSU.Text.color(::Const.UI.Color.PositiveEventValue, "+" + this.m.ChampionChanceReward + "%") + " chance for Champions to appear",
		});
	}

	function onStart()
	{
		// Make sure that champion chance is up to date with ambition state
		::World.Assets.resetToDefaults();
	}

	function onClear()
	{
		// Make sure that champion chance is up to date with ambition state
		::World.Assets.resetToDefaults();
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
	}

});

