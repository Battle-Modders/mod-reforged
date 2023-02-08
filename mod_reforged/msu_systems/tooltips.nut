::Reforged.Mod.Tooltips.setTooltips({
	HireScreen = {
		DescriptionContainer = ::MSU.Class.CustomTooltip(function(_data){
			local states = [
				"Switch to Perk Groups",
				"Switch to Perk Tree",
				"Switch to Description"
			]
			return [
				{
					id = 1,
					type = "title",
					text = "Click to switch"
				},
				{
					id = 2,
					type = "description",
					text = states[_data.ExtraData.tointeger()]
				}
			];
		})
	},
	Contract = {
		FocusOnObjective = ::MSU.Class.BasicTooltip("Click to focus", "Click to focus on the objectives for this contract")
	}
});
