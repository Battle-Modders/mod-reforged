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
	},
	Tactical = {
		Button = {
			WaitTurnAllButton = ::MSU.Class.BasicTooltip("Wait Round", "Have all your characters use \'Wait\' on their turn.")
		}
	}
});
local tooltipImageKeywords = {
	"ui/icons/reach.png" 				: "Concept.Reach",
	"ui/icons/reach_attack.png" 		: "Concept.ReachIgnoreOffensive",
	"ui/icons/reach_defense.png" 		: "Concept.ReachIgnoreDefensive"
}

::Reforged.Mod.Tooltips.setTooltipImageKeywords(tooltipImageKeywords);
