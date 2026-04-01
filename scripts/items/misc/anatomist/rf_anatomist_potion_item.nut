// Base abstract class for anatomist potion items. Automatically adds tooltip from the relevant
// effect based on Reforged.Items.AnatomistPotions.Infos and adds the effect during onUse.
this.rf_anatomist_potion_item <- ::inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.Value = 0;
	}

	function getTooltip()
	{
		local ret = this.anatomist_potion_item.getTooltip();

		local path = ::IO.scriptFilenameByHash(this.ClassNameHash);
		foreach (info in ::Reforged.Items.AnatomistPotions.Infos)
		{
			if (info.ItemScript == path)
			{
				ret.extend(::new(info.EffectScript).getTooltip().slice(2)); // slice 2 to remove name and description
			}
		}

		ret.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process"
		});
		ret.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Mutates the body, causing sickness"
		});
		return ret;
	}

	function onUse( _actor, _item = null )
	{
		local path = ::IO.scriptFilenameByHash(this.ClassNameHash);
		foreach (info in ::Reforged.Items.AnatomistPotions.Infos)
		{
			if (info.ItemScript == path)
			{
				_actor.getSkills().add(::new(info.EffectScript));
			}
		}
		return this.anatomist_potion_item.onUse(_actor, _item);
	}
});

