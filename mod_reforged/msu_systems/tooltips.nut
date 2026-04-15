::Reforged.Mod.Tooltips.setTooltips({
	EventActor = ::MSU.Class.CustomTooltip(function( _data ) {
		local entity = ::Tactical.getEntityByID(_data.ExtraData.tointeger());
		if (entity == null)
			return null;

		if (::MSU.isKindOf(entity, "player"))
		{
			local ret = entity.getRosterTooltip();
			ret.push({id = 124, type = "text", text = "rf_divider"});
			ret.extend([::Reforged.TacticalTooltip.getTooltipAttributesSmall(entity, 100)]);
			ret.push({id = 124, type = "text", text = "rf_divider"});
			ret.extend(::Reforged.TacticalTooltip.getTooltipTraits(entity, 200));
			ret.extend(::Reforged.TacticalTooltip.getTooltipEffects(entity, 300));
			ret.extend(::Reforged.TacticalTooltip.getTooltipPerks(entity, 400));
			ret.extend(::Reforged.TacticalTooltip.getTooltipEquippedItems(entity, 500));
			ret.extend(::Reforged.TacticalTooltip.getTooltipBagItems(entity, 600));
			return ret;
		}

		return ::TooltipEvents.general_queryUIElementTooltipData(entity.getID(), "CharacterNameAndTitles", null);
	}),
	Faction = ::MSU.Class.CustomTooltip(function( _data ) {
		local ret = [
			{ contentType = "settlement-status-effect" }
		];

		ret.extend(::World.FactionManager.getFaction(_data.ExtraData.tointeger()).RF_getTooltip());
		return ret;
	}),
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
		FocusOnObjective = ::MSU.Class.BasicTooltip("Click to focus", "Click to focus on the objectives for this contract"),
		Tooltip = ::MSU.Class.CustomTooltip(function(_data) {
			local id = _data.ExtraData.tointeger();
			local contract;
			local active = ::World.Contracts.getActiveContract();
			if (active != null && active.getID() == id)
			{
				contract = active;
			}
			else
			{
				foreach (c in ::World.Contracts.m.Open)
				{
					if (c.getID() == id)
					{
						contract = c;
						break;
					}
				}
			}

			if (contract != null)
			{
				local ret = contract.RF_getTooltip();
				ret.insert(0, {contentType = "settlement-status-effect"});
				if (active != null)
				{
					ret.push({
						id = 100, type = "hint", icon = "ui/icons/locked_small.png",
						text = "You can only have one contract active at a time"
					})
				}
				ret.push({
					id = 300, type = "hint", icon = "ui/icons/mouse_right_button.png",
					text = "Dismiss contract"
				});
				return ret;
			}
		})
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
						text = ::Reforged.Mod.Tooltips.parseString("Have all your characters use [Wait|Concept.Wait] on their [turn|Concept.Turn].")
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
