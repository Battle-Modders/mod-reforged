::Reforged.Skills <- {
	function addPerkGroup( _entity, _perkGroupID, _maxTier = 7 )
	{
		foreach (i, row in ::DynamicPerks.PerkGroups.findById(_perkGroupID).getTree())
		{
			if (i >= _maxTier) return;

			foreach (perkID in row)
			{
				_entity.getSkills().add(::new(::Const.Perks.findById(perkID).Script));
			}
		}
	}

	function addPerkGroupOfEquippedWeapon( _entity, _maxTier = 7 )
	{
		local weapon = _entity.getMainhandItem();
		if (weapon == null) return;

		local trees = [];

		if (weapon.isWeaponType(this.Const.Items.WeaponType.Axe))
		{
			trees.push("pg.rf_axe");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow))
		{
			trees.push("pg.rf_bow");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Cleaver))
		{
			trees.push("pg.rf_cleaver");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
		{
			trees.push("pg.rf_crossbow");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Dagger))
		{
			trees.push("pg.rf_dagger");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Flail))
		{
			trees.push("pg.rf_flail");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Hammer))
		{
			trees.push("pg.rf_hammer");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Mace))
		{
			trees.push("pg.rf_mace");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Polearm))
		{
			trees.push("pg.rf_polearm");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Spear))
		{
			trees.push("pg.rf_spear");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Sword))
		{
			trees.push("pg.rf_sword");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
		{
			trees.push("pg.rf_throwing");
		}

		if (trees.len() == 0)
			return;

		this.addPerkGroup(_entity, ::MSU.Array.rand(trees), _maxTier);
	}

	function addMasteryOfEquippedWeapon( _entity )
	{
		local weapon = _entity.getMainhandItem();
		if (weapon == null) return;

		if (weapon.isWeaponType(this.Const.Items.WeaponType.Axe))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_axe"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_bow"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Cleaver))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_cleaver"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_crossbow"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Dagger))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_dagger"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Flail))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_flail"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Hammer))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_hammer"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Mace))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_mace"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Polearm))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_polearm"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Spear))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_spear"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Sword))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_sword"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_throwing"));
		}
	}

	function makeTrapped( _trappedEffect )
	{
		// New Variables
		_trappedEffect.m.Stage <- 1;
		_trappedEffect.m.StageMax <- 1;
		// Variables Imported from Break_Free_Skill
        _trappedEffect.m.BonusChancePerFail <- 10,    // ChanceBonus is increased by this value every time someone fails
		_trappedEffect.m.BonusChance <- -10,          // Some effects may want to reduce or increase the initial ChanceBonus

		// These Icons are now defined in the trap-effect rather than in the break-free abilities
		_trappedEffect.m.BreakFreeIcon <- _trappedEffect.m.Icon;
		_trappedEffect.m.BreakFreeIconDisabled <- _trappedEffect.m.IconDisabled;
		_trappedEffect.m.BreakFreeOverlay <- _trappedEffect.m.Overlay;
		_trappedEffect.m.BreakAllyFreeIcon <- _trappedEffect.m.Icon;
		_trappedEffect.m.BreakAllyFreeIconDisabled <- _trappedEffect.m.IconDisabled;
		_trappedEffect.m.BreakAllyFreeOverlay <- _trappedEffect.m.Overlay;
		_trappedEffect.m.Decal <- "";		// Decal that will spawn when this effect is broken out of

		// Private Variables
		_trappedEffect.m.BreakFreeSkill <- null;	// Allows multiple trap effects. Break-Free-Ally will now be able to find the correct BreakFree skil

		// Hooks
		local onUpdate = _trappedEffect.onUpdate;
		_trappedEffect.onUpdate = function( _properties )
		{
			if (this.isImmobilised()) _properties.IsRooted = true;

			// We nullify any changes made by the vanilla function
			local oldIsRooted = _properties.IsRooted;
			onUpdate(_properties);
			_properties.IsRooted = oldIsRooted;
		}

		_trappedEffect.onAdded <- function()
		{
			local breakFree = this.new("scripts/skills/special/rf_break_free_skill");
			this.m.BreakFreeSkill = breakFree.weakref();
			breakFree.m.TrappedEffect = this.weakref();
			breakFree.m.ID = breakFree.getID() + this.getID();	// We give every Break Free a unique ID so they can co-exist on the same entity when trapped by different effects
			breakFree.m.Icon = this.m.BreakFreeIcon;
			breakFree.m.IconDisabled = this.m.BreakFreeIconDisabled;
			breakFree.m.Overlay = this.m.BreakFreeOverlay;
			breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;
			this.getContainer().add(breakFree);
		}

		// New Functions
		_trappedEffect.increaseStages <- function( _amount = 1 )
		{
			this.m.Stage += _amount;
			if (this.m.Stage >= this.m.StageMax) this.m.Stage = this.m.StageMax;
		}

		_trappedEffect.decreaseStages <- function( _amount = 1, _chanceMessage = "" )
		{
			this.m.Stage -= _amount;
			if (this.m.Stage <= 0)
			{
				this.brokenFree(_chanceMessage);
			}
			else
			{
				::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " partly breaks free" + _chanceMessage);
			}
		}

		_trappedEffect.brokenFree <- function( _chanceMessage = "" )
		{
			this.spawnDecal();
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " breaks free" + _chanceMessage);
			this.getContainer().getActor().getSprite("status_rooted").Visible = false;
			this.getContainer().getActor().getSprite("status_rooted_back").Visible = false;
			this.m.BreakFreeSkill.removeSelf();
			this.removeSelf();
		}

		_trappedEffect.getBreakFreeSkill <- function()
		{
			return this.m.BreakFreeSkill;
		}

		// This will indicate to break-free skills and a variety of perks that this character is under a trappedEffect
		// We could instead use the SkillType system but I wasn't sure whether to add a whole new Type just for this small subset of skills
		_trappedEffect.isTrappedEffect <- function()
		{
			return true;
		}

		// By default every trapped effect also immobilizes its targed
		_trappedEffect.isImmobilised <- function()
		{
			return true;
		}

		_trappedEffect.spawnDecal <- function()		// In Vanilla this is handled by the break-free skill
		{
			if (this.m.Decal == "") return;
			local ourTile = this.getContainer().getActor().getTile();
			local candidates = [];

			if (ourTile.Properties.has("IsItemSpawned") || ourTile.IsCorpseSpawned)
			{
				for( local i = 0; i < ::Const.Direction.COUNT; i = ++i )
				{
					if (!ourTile.hasNextTile(i)) continue;

					local tile = ourTile.getNextTile(i);
					if (tile.IsEmpty && !tile.Properties.has("IsItemSpawned") && !tile.IsCorpseSpawned && tile.Level <= ourTile.Level + 1)
					{
						candidates.push(tile);
					}
				}
			}
			else
			{
				candidates.push(ourTile);
			}
			if (candidates.len() == 0) return;

			local tileToSpawnAt = candidates[::Math.rand(0, candidates.len() - 1)];
			tileToSpawnAt.spawnDetail(this.m.Decal);
			tileToSpawnAt.Properties.add("IsItemSpawned");
		}
	}
};
