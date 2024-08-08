// Original feature request: https://github.com/MSUTeam/MSU/issues/220

// Goal:
// - Add a new function to all actors which can be used to modify the existing loot they drop on death, or to add new loot.

::Reforged.HooksMod.hook("scripts/entity/tactical/actor", function(q) {
	q.onDropLoot <- function( _originalLoot, _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			foreach (item in _originalLoot)
			{
				item.drop(_tile);
			}
		}
	}
});

::Reforged.QueueBucket.VeryLate.push(function() {
	::Reforged.HooksMod.hookTree("scripts/entity/tactical/actor", function(q) {
		q.onDeath = @(__original) function( _killer, _skill, _tile, _fatalityType )
		{
			local loot = [];

			// Switcheroo the ::new function to detect the creation of an item.
			// Then switcheroo the `drop` function of the item to instead push the item
			// to our local `loot` array. This will be used to pass this item to the `onDropLoot`
			// function as the _originalLoot.
			local new = ::new;
			::new = function( _script )
			{
				local item = new(_script);
				if (::isKindOf(item, "item"))
				{
					item.drop_temp <- item.drop;
					item.drop = @(_t) loot.push(this);
				}
				return item;
			}

			__original(_killer, _skill, _tile, _fatalityType);

			// Revert the switcheroo on ::new
			::new = new;

			// Revert the switcheroo on the drop function of all dropped items
			foreach (item in loot)
			{
				item.drop = item.drop_temp;
				delete item.drop_temp;
			}

			// Note: `loot` here only contains the items that actually got dropped.
			// It doesn't contain all the possible items that could be dropped, as items
			// created for dropping are gated behind random rolls and if/else statements.

			this.onDropLoot(loot, _killer, _skill, _tile, _fatalityType);
		}
	});
});
