::Reforged.HooksMod.hook("scripts/events/events/dlc2/location/witchhut_destroyed_event", function(q) {
	q.create = @(__original) function()
	{
		__original();

		foreach (screen in this.m.Screens)
		{
			if (screen.ID == "Leave")
			{
				screen.Text = ::MSU.String.replace(screen.Text, "115.png[/img]{", "115.png[/img]{Before leaving, you notice an old mirror standing in the corner beneath a cloth. The witch looks at it for a long moment before telling you to take it. She does not explain why.\n\n");

				local original_start = screen.start;
				screen.start = function( _event )
				{
					original_start(_event);
					::World.Assets.getStash().makeEmptySlots(1);
					local item = ::new("scripts/items/consumable/rf_magic_mirror");
					::World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + ::Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
			}
			else if (screen.ID == "Kill")
			{
				screen.Text += "\n\nA final search of the hut reveals a mirror standing in the corner beneath an old cloth. The frame is plain, the craftsmanship good, and the glass clearer than any you have seen in a long while.";

				local original_start = screen.start;
				screen.start = function( _event )
				{
					original_start(_event);
					::World.Assets.getStash().makeEmptySlots(1);
					local item = ::new("scripts/items/consumable/rf_magic_mirror");
					::World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + ::Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
			}
		}
	}
});
