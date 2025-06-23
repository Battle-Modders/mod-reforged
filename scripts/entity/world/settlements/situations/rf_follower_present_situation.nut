this.rf_follower_present_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {
		BaseID = "situation.rf_follower_present.%s",
		BaseIcon = "ui/settlement_status/%s.png"
	},
	function create()
	{
		this.situation.create();
		this.m.ID = "";
		this.m.Name = "";
		this.m.Description = "";

		this.m.Icon = "ui/settlement_status/settlement_effect_02.png";
		this.m.Rumors = [
		];
		this.m.IsStacking = false;
	}

	function setFollower( _follower )
	{
		// TODO BETTER TEXT
		// TODO RUMORS
		this.m.ID = format(this.m.BaseID, _follower.getID());
		this.m.Icon = format(this.m.BaseIcon, _follower.getID());
		this.m.Name = format("%s present", _follower.getName());
		this.m.Description = format("%s is present and ready to join your company - if you've got the coin.", _follower.getName());
	}

	function onAdded( _settlement )
	{
	}

	function onUpdate( _modifiers )
	{
	}

	//TODO EITHER SERDE OR COPYPASTE
});

