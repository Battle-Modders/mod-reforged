::Reforged.Items <- {}

// This function adjusts a loaded-weapon with the essential functions and variables to support this loading playstyle. Examples are Crossbow and Handgonne
::Reforged.Items.makeWeaponLoaded <- function( o )
{
	local parentName = o.SuperName;		// Since mods may introduce new intermediate parent classes we have to dynamically get the parentname instead of hoping on 'weapon' always being it

	o.m.IsLoaded <- false;	// In vanilla this is true by default. But we don't want to hand out free ammunition
	o.m.LoadedAmmunitionItem <- null;	// Reference to the "quiver" that this weapon was loaded with last. A quiver that was deleted during combat will still exist as this reference during that battle

	o.getLoadedAmmunitionItem <- function()
	{
		return this.m.LoadedAmmunitionItem;
	}

	if (!"isLoaded" in o)
	{
		o.isLoaded <- function()
		{
			return this.m.IsLoaded;
		}
	}


	local setLoaded = ("setLoaded" in o) ? o.setLoaded : null;
	o.setLoaded <- function( _loaded, _quiverItem = null )
	{
		if (setLoaded != null) setLoaded(_loaded);
		this.m.IsLoaded = _loaded;
		this.m.LoadedAmmunitionItem = _quiverItem;
	}

	if (!"getTooltip" in o)
	{
		o.getTooltip <- function()
		{
			local result = this[parentName].getTooltip();
			if (!this.getContainer().getActor().isPlacedOnMap()) return result;		// Outside of battle we show no warning

			if (!this.m.IsLoaded)
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = ::MSU.Text.colorRed("Must be reloaded before shooting again")
				});
			}

			return result;
		}
	}

	// In onCombatFinished we now unload the weapon.
	local onCombatFinished = ("onCombatFinished" in o) ? o.onCombatFinished : null;	// In Vanilla this function always exists for loaded ranged weapons. But a/our mod may introduce weapons that do not have it
	o.onCombatFinished <- function()
	{
		local oldIsLoadedResult = this.isLoaded();	// Vanilla usually sets isLoaded to true here for loaded weapons but we are interested in their state BEFORE that happens

		if (onCombatFinished == null)
		{
			this[parentName].onCombatFinished();
		}
		else
		{
			onCombatFinished();
		}

		if (oldIsLoadedResult)
		{
			::World.Assets.addAmmo((this.m.LoadedAmmunitionItem == null) ? 1 : this.m.LoadedAmmunitionItem.getAmmoCost());
			this.setLoaded(false);
		}
		// Since onCombatFinished is not called for many/most/all NPC's the use of LoadedAmmunitionItem may cause a memory leak
		this.m.LoadedAmmunitionItem = null;		// Clear strong reference
	}

// New Functions
	local onCombatStarted = ("onCombatStarted" in o) ? o.onCombatStarted : null;	// In Vanilla this base function is not used and does not exist but maybe some mod makes use of it
	o.onCombatStarted <- function()
	{
		if (onCombatStarted == null)
		{
			this[parentName].onCombatStarted();
		}
		else
		{
			onCombatStarted();
		}

		if (this.isLoaded()) return;

		local ammoItem = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Ammo);
		if (ammoItem == null) return;
		if (ammoItem.getAmmo() == 0) return;
		if (this.getRequiredAmmoType() != ammoItem.getAmmoType()) return;

		this.setLoaded(true);
		ammoItem.consumeAmmo();
	}
}
