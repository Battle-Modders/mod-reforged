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
			WaitTurnAllButton = ::MSU.Class.CustomTooltip(function( _ ) {
				return [
					{
						id = 1,
						type = "title",
						text = format("Wait Round (%s)", ::MSU.System.Keybinds.KeybindsByMod["mod_reforged"]["Tactical_WaitRound"].getKeyCombinations())
					},
					{
						id = 2,
						type = "description",
						text = ::Reforged.Mod.Tooltips.parseString("Have all your characters use [Wait|Concept.Wait] on their [turn.|Concept.Turn]")
					}
				];
			})
		}
	}
});

local tooltipImageKeywords = {
	"ui/icons/rf_reach.png" 				: "Concept.Reach",
	"ui/icons/rf_reach_attack.png" 		: "Concept.ReachIgnoreOffensive",
	"ui/icons/rf_reach_defense.png" 		: "Concept.ReachIgnoreDefensive"
}

::Reforged.Mod.Tooltips.setTooltipImageKeywords(tooltipImageKeywords);

::Reforged.Mod.Tooltips.generateNestedTextFromObjCallback = function( _field, _key, _extraData )
{
	if (split(_key, ".")[0] == "Concept")
	{
		local tooltip = this.getTooltip(_key).Tooltip;
		switch (_field)
		{
			case "Name":
				return tooltip.getUIData(_extraData)[0].text;
		}
	}
}
