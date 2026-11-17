// Hit-chance overlay: labels beside opponents in tactical combat showing the chance of a player character
// (the "subject") to hit them and their chance to hit the subject. Shown only while the active character previews
// a movement or a hit-chance attack, or while the player hovers a character (see getSubject).
// The data is also used by the movement preview tile tooltip (see hooks/ui/screens/tooltip/tooltip_events.nut).
// The labels are drawn in JS (ui/mods/mod_reforged/rf_hitchance_overlay.js); the per-frame driver is the
// hook on the vanilla orientation_overlay module's update().
// Members prefixed with __ are internal. The others are meant to be adjusted by mods.
::Reforged.HitchanceOverlay <- {
	// Placement Beside: ::Const.EntityType -> extra horizontal offset in world units. Empty by default, so labels
	// sit at the same spot relative to vanilla's bars on every unit.
	SideOffsetByType = {},

	// Geometry of what the engine draws, measured in world units at zoom 1 (screen px where noted); the same for
	// all units (human, Lindwurm, Unhold, Orc Warlord). Must match the engine; mods that replace the sprites of
	// the bars, status icons or portrait markers with other sizes can adjust them.
	Vanilla = {
		HeadOffset = 82.0,		// from tile center up to the bottom of the health/armor bars
		BarsHeight = 20.0,		// height of the bars
		StatusIconsPerRow = 4,	// status icons above the bars (only while the bars are shown); which ones count: getStatusIconRows
		StatusRowHeight = 19.0,
		LevelOffset = 40.0,		// screen drop per tile level above the camera level
		MarkerRadius = 20.0		// screen px: the portrait marker drawn for units above the camera level (fixed at any zoom and UI scale)
	},

	// Placement of the labels relative to the geometry above. Screen offset from the screen center in CSS px is
	// (world offset) / camera.Zoom / UIScale. Beside labels sit at the outer corner of the (flat-topped) hex, in the
	// gap between its NE and SE (or NW and SW) neighbors: opponents on the right as they face left, allies on the left.
	Layout = {
		BesideBarsGap = 4.0,	// Beside: the top of the first row sits this far below the bottom of the bars (HeadOffset)
		TorsoOffset = 45.0,		// Beside while the bars are hidden: from tile center up to the torso, where the first row is centered
		AboveGap = 3.0,			// Above: between the bars or status icons and the bottom of the label
		MarkerGap = 4.0,		// screen px between a portrait marker and the label
		// Multiplier of the hex circumradius for the horizontal offset of Beside labels, see getCornerFactor.
		// Smaller labels only cover the narrow torso band, so they can sit closer to the unit.
		CornerFactor = 0.5,			// for full size labels (label size relative to the hex 1.0)
		CornerFactorSmall = 0.3,	// for labels of size CornerSmallSize; linear in between and beyond
		CornerSmallSize = 0.7,
		MinCornerFactor = 0.1,
		// Label scale limits; the scale follows the camera zoom so labels shrink with the hexes
		MinScale = 0.55,
		MaxScale = 1.0,
		// Labels are sized like the map (units, bars), not like the UI: the label CSS is in rem, which follows the
		// UI scale, so the scale sent to JS cancels it. At this UI scale the sizes are as designed.
		ReferenceUIScale = 1.7
	},

	// Values of the setting HitchanceDisplay_Mode (its option array gives the cycle order)
	__Modes = {
		["Overlay"] = { Overlay = true, Tooltip = false, Description = "Labels next to opponents." },
		["Overlay + Tooltip"] = { Overlay = true, Tooltip = true, Description = "Labels next to opponents and a list in the tile tooltip during movement preview." },
		["Tooltip"] = { Overlay = false, Tooltip = true, Description = "A list in the tile tooltip during movement preview." },
		["Off"] = { Overlay = false, Tooltip = false, Description = "No hit chances are shown." }
	},

	// What the subject is doing, see getSubject
	__SubjectMode = {
		Move = "Move",		// the active character previews a movement to the tile marked by clicking
		Skill = "Skill",	// the active character has a hit-chance attack selected
		Hover = "Hover"		// a hovered player character at his current tile
	},

	__RecomputeInterval = 0.1,	// seconds; minimum time between two recomputes caused by dirty state (not by subject/tile changes)

	__State = null,		// see reset

	function reset()
	{
		this.__State = {
			IsDirty = true,
			IsComputing = false,
			IsFrozen = false,		// true while the player hovers a label; the snapshot is kept unchanged
			LastKey = null,			// subject key of the snapshot, see getSubjectKey
			LastComputeTime = -1.0,
			LastPositionKey = null,	// camera state and travelling labeled actors when positions were last sent, see getPositionKey
			HexSideX = null,		// measured circumradius of a hex in world units, see getHexSideX
			StatusIconRows = {},	// actor ID -> rows of status icons above its bars, see getCachedStatusIconRows
			Snapshot = null			// the data shown, see compute; labels are shown while it is set
		};
	}

	// Settings helpers
	function getSettingValue( _id )
	{
		return ::Reforged.Mod.ModSettings.getSetting(_id).getValue();
	}

	function getMode()
	{
		return this.getSettingValue("HitchanceDisplay_Mode");
	}

	function getModeInfo( _mode = null )
	{
		return this.__Modes[_mode == null ? this.getMode() : _mode];
	}

	function isOverlayShown()
	{
		return this.getModeInfo().Overlay;
	}

	function isTooltipShown()
	{
		return this.getModeInfo().Tooltip;
	}

	function cycleMode()
	{
		local setting = ::Reforged.Mod.ModSettings.getSetting("HitchanceDisplay_Mode");
		local idx = setting.Array.find(setting.getValue());
		local next = setting.Array[idx == null ? 0 : (idx + 1) % setting.Array.len()];
		setting.set(next);
		return next;
	}

	// After-change callback of the HitchanceDisplay_Mode setting. MSU also calls it when loading settings, also outside of combat.
	function onModeChanged()
	{
		this.__State.IsDirty = true;
		this.__State.LastKey = null;
		this.updateTopbarButton();
	}

	function updateTopbarButton()
	{
		if (!::Tactical.isActive() || !("State" in ::Tactical) || ::Tactical.State == null)
			return;

		local screen = ::Tactical.State.m.TacticalScreen;
		if (screen != null)
			screen.getTopbarOptionsModule().RF_updateHitchanceDisplayButton();
	}

	// Which halves to calculate and show, in the overlay and the tooltip
	function getShowFlags()
	{
		switch (this.getSettingValue("HitchanceDisplay_Shown"))
		{
			case "None": return { Player = false, Enemy = false };
			case "Player Only": return { Player = true, Enemy = false };
			case "AI Only": return { Player = false, Enemy = true };
		}
		return { Player = true, Enemy = true };
	}

	// Whether attacks on movement and on arrival (zone of control) are shown regardless of the display mode and
	// getShowFlags: listed in the tile tooltip and marked by a warning icon in the overlay
	function isZOCAlwaysShown()
	{
		return this.getSettingValue("HitchanceDisplay_ZOCAttacks") == "Always";
	}

	// Which attack of an opponent the "to be hit" value uses: its primary attack or its best hit chance
	function isEnemyPrimaryAttackShown()
	{
		return this.getSettingValue("HitchanceOverlay_EnemyAttack") == "Primary Attack";
	}

	function setDirty()
	{
		if (!this.__State.IsComputing)
			this.__State.IsDirty = true;
	}

	function logError( _message )
	{
		::logError("Reforged hit-chance overlay: " + _message);
	}

	function isShowingLabels()
	{
		return this.__State.Snapshot != null;
	}

	// Subject, checked in this order:
	// 1. The active player character has a skill selected: if it is a hit-chance attack, he is the subject at his
	//    current tile with only that skill (Mode Skill); any other selected skill shows nothing. A selected skill
	//    beats hovering, as hovering a unit on the map while aiming also sets ActiveEntityMouseHover.
	// 2. A hovered player character (also the active one) at his current tile (Mode Hover).
	// 3. The active player character at his movement target tile (Mode Move). The movement target is the tile the
	//    player marked by clicking (vanilla computeEntityPath), so it doesn't change while the mouse moves, e.g. to
	//    a label. It may lie beyond the affordable end of the path.
	// Otherwise there is no subject and no overlay. There is none outside the player's turn either (AI turns), when the
	// active entity isn't a player character, also not for hovering.
	// Returns null or { Entity, Mode, IsPreview, Tile, Skill }
	function getSubject()
	{
		local active = ::Tactical.TurnSequenceBar.getActiveEntity();
		if (active == null || !active.isAlive() || !active.isPlacedOnMap() || !active.isPlayerControlled())
			return null;

		local state = ::Tactical.State;
		if (state.getCurrentActionState() == ::Const.Tactical.ActionState.SkillSelected)
		{
			local skill = active.getSkills().getSkillByID(state.getSelectedSkillID());
			if (skill == null || skill.isGarbage() || skill.isHidden() || !skill.isAttack() || !skill.isUsingHitchance())
				return null;

			return { Entity = active, Mode = this.__SubjectMode.Skill, IsPreview = false, Tile = active.getTile(), Skill = skill };
		}

		local hovered = ::Tactical.TurnSequenceBar.m.ActiveEntityMouseHover;
		if (hovered != null && hovered.isAlive() && hovered.isPlacedOnMap() && hovered.isPlayerControlled())
			return { Entity = hovered, Mode = this.__SubjectMode.Hover, IsPreview = false, Tile = hovered.getTile(), Skill = null };

		local target = this.getMovementTarget(active);
		if (target != null)
			return this.getMoveSubject(active, target);

		return null;
	}

	function getMoveSubject( _entity, _tile )
	{
		return { Entity = _entity, Mode = this.__SubjectMode.Move, IsPreview = true, Tile = _tile, Skill = null };
	}

	// The tile the active entity _entity is about to move to, or null
	function getMovementTarget( _entity )
	{
		local state = ::Tactical.State;
		if (state.getCurrentActionState() != ::Const.Tactical.ActionState.ComputePath)
			return null;

		local tile = state.m.LastTileSelected;
		if (tile == null || !tile.IsEmpty || tile.ID == _entity.getTile().ID)
			return null;

		return tile;
	}

	function getSubjectKey( _subject )
	{
		return format("%i|%i,%i|%s|%s", _subject.Entity.getID(), _subject.Tile.Coords.X, _subject.Tile.Coords.Y, _subject.Mode, _subject.Skill == null ? "" : _subject.Skill.getID());
	}

	// Calculation
	// A snapshot: { SubjectID, SubjectName, Mode, IsPreview, SkillName, ZOCFatigue, Entries = [entry], EntriesByID = { [id] = entry } }
	// entry: { ID, ToHit, ToHitSkill, ToBeHit, ToBeHitSkill, LeaveAttack, ArriveAttack }
	// where *Skill are weakrefs to skills and the attacks are null or { Hitchance, Skill }.
	function createSnapshot( _subject )
	{
		local entity = _subject.Entity;
		return {
			SubjectID = entity.getID(),
			SubjectName = entity.getName(),
			Mode = _subject.Mode,
			IsPreview = _subject.IsPreview,
			SkillName = _subject.Skill == null ? null : _subject.Skill.getName(),
			ZOCFatigue = 0,
			Entries = [],
			EntriesByID = {}
		};
	}

	// Calls _function (with this table as this) with IsComputing set, so that our own updates don't mark the overlay as dirty.
	// Callbacks are called via bindenv rather than call(), as an error passing a native call() is logged by the engine
	// on top of the error handling of the callers.
	function withComputing( _function )
	{
		this.__State.IsComputing = true;
		try
		{
			_function.bindenv(this)();
		}
		catch (error)
		{
			this.__State.IsComputing = false;
			throw error;
		}
		this.__State.IsComputing = false;
	}

	// Returns the snapshot for _subject
	function compute( _subject )
	{
		local ret = this.createSnapshot(_subject);
		this.withComputing(function() {
			if (!_subject.IsPreview)
			{
				this.addHitchances(_subject.Entity, _subject.Tile, ret, null, _subject.Skill);
				return;
			}

			this.addLeaveAttacks(_subject.Entity, ret);
			this.runMovementPreview(_subject.Entity, _subject.Tile, function( _tag ) {
				this.addArriveAttacks(ret, _tag);
				this.addHitchances(_tag.Entity, _tag.DestTile, ret, _tag);
			});
		});
		return ret;
	}

	// Snapshot with only the attacks on movement and on arrival for the movement of _entity to _tile: without the
	// hit chances at the destination, which cost the most.
	function computeZOCAttacks( _entity, _tile )
	{
		local ret = this.createSnapshot(this.getMoveSubject(_entity, _tile));
		this.withComputing(function() {
			this.addLeaveAttacks(_entity, ret);
			this.runMovementPreview(_entity, _tile, @( _tag ) this.addArriveAttacks(ret, _tag));
		});
		return ret;
	}

	// Snapshot for the movement of _entity to its movement target tile, used by the tile tooltip, or null without a
	// movement target. Reuses the overlay's snapshot when it is up to date for the same subject and tile.
	// _isZOCOnly: only the attacks on movement and on arrival are needed (see computeZOCAttacks)
	function computeMovementPreview( _entity, _isZOCOnly = false )
	{
		local target = this.getMovementTarget(_entity);
		if (target == null)
			return null;

		local subject = this.getMoveSubject(_entity, target);
		local s = this.__State;
		if (s.Snapshot != null && !s.IsDirty && s.LastKey == this.getSubjectKey(subject))
			return s.Snapshot;

		return _isZOCOnly ? this.computeZOCAttacks(_entity, target) : this.compute(subject);
	}

	function getOrCreateEntry( _snapshot, _actor )
	{
		local id = _actor.getID();
		if (id in _snapshot.EntriesByID)
			return _snapshot.EntriesByID[id];

		local entry = {
			ID = id,
			ToHit = null,
			ToHitSkill = null,
			ToBeHit = null,
			ToBeHitSkill = null,
			LeaveAttack = null,
			ArriveAttack = null
		};
		_snapshot.EntriesByID[id] <- entry;
		_snapshot.Entries.push(entry);
		return entry;
	}

	function isZOCAttackPossibleAt( _entity, _tile )
	{
		return !_entity.getCurrentProperties().IsImmuneToZoneOfControl && (_tile.Properties.Effect == null || _tile.Properties.Effect.Type != "smoke");
	}

	// Attack of opportunity of _actor on _entity at _tile, like vanilla actor.onAttackOfOpportunity, or null.
	// _isOnEnter: on arrival at _tile (e.g. Spearwall), otherwise when leaving it.
	function getZOCAttack( _actor, _entity, _tile, _isOnEnter )
	{
		if (_actor.isAlliedWith(_entity) || !_actor.onMovementInZoneOfControl(_entity, _isOnEnter))
			return null;

		local aoo = _actor.getSkills().getAttackOfOpportunity();
		// use() checks the target too, e.g. a height difference too large to attack
		if (aoo == null || !aoo.onVerifyTarget(_actor.getTile(), _tile))
			return null;

		return aoo;
	}

	// Zone of control attacks when leaving the current tile
	function addLeaveAttacks( _entity, _snapshot )
	{
		local tile = _entity.getTile();
		if (!this.isZOCAttackPossibleAt(_entity, tile))
			return;

		local hasAny = false;
		foreach (a in ::Tactical.Entities.getAdjacentActors(tile))
		{
			local aoo = this.getZOCAttack(a, _entity, tile, false);
			if (aoo == null)
				continue;

			this.getOrCreateEntry(_snapshot, a).LeaveAttack = { Hitchance = aoo.getHitchance(_entity), Skill = ::MSU.asWeakTableRef(aoo) };
			hasAny = true;
		}

		if (hasAny)
			_snapshot.ZOCFatigue = _entity.RF_getZOCEvasionFatigue();
	}

	// Attacks on arrival at the destination, e.g. Spearwall. Called with the movement preview applied.
	function addArriveAttacks( _snapshot, _tag )
	{
		local entity = _tag.Entity;
		local destTile = _tag.DestTile;
		if (!this.isZOCAttackPossibleAt(entity, destTile))
			return;

		foreach (a in ::Tactical.Entities.getAdjacentActors(destTile))
		{
			if (a.isAlliedWith(entity))
				continue;

			this.updateForPreviewOnce(a, _tag);
			local aoo = this.getZOCAttack(a, entity, destTile, true);
			if (aoo != null)
				this.getOrCreateEntry(_snapshot, a).ArriveAttack = { Hitchance = aoo.getHitchance(entity), Skill = ::MSU.asWeakTableRef(aoo) };
		}
	}

	// Whether any hit-chance attack of _actor is in range of _tile (cheap checks only). Skips the costly part of
	// addHitchances for opponents that can't reach the subject, which would give no result for them anyway.
	function canAnyAttackReach( _actor, _tile )
	{
		foreach (s in _actor.getSkills().m.Skills)
		{
			if (s.isAttack() && !s.isGarbage() && s.isType(::Const.SkillType.Active) && !s.isHidden() && s.isUsingHitchance() && s.isInRange(_tile))
				return true;
		}
		return false;
	}

	// Recalculates the properties of _actor with a Modular Vanilla preview update: like skill_container.update, but it
	// doesn't change hitpoints, action points or fatigue and has no side effects (overlay, zone of control, dirty flags).
	// _isPreviewing: MV's preview state (costs of the previewed action), for the previewing entity.
	// After an error MV's flags are restored, so that later regular updates aren't treated as preview updates.
	function doPreviewUpdate( _actor, _isPreviewing )
	{
		local wasPreviewing = _actor.m.MV_IsPreviewing;
		try
		{
			_actor.getSkills().MV_doPreviewUpdate(_isPreviewing);
		}
		catch (error)
		{
			_actor.m.MV_IsDoingPreviewUpdate = false;
			_actor.m.MV_IsPreviewing = wasPreviewing;
			throw error;
		}
	}

	// Recalculates the properties of _actor (another actor than the previewing one) for the movement preview, once.
	// The cleanup of the preview updates it again.
	function updateForPreviewOnce( _actor, _tag )
	{
		local id = _actor.getID();
		if (id in _tag.ActorsToUpdate)
			return;

		_tag.ActorsToUpdate[id] <- _actor;
		this.doPreviewUpdate(_actor, false);
	}

	// Best chance of _entity at _tile to hit each opponent and of each opponent to hit _entity.
	// _tag is the movement preview tag or null when not previewing.
	// With _onlySkill (a selected attack), only opponents that skill can target get an entry, with its hit chance.
	function addHitchances( _entity, _tile, _snapshot, _tag, _onlySkill = null )
	{
		local flags = this.getShowFlags();
		if (!flags.Player && !flags.Enemy)
			return;

		// isUsable doesn't depend on the target, so it is checked once here
		local myAttacks;
		if (_onlySkill != null)
			myAttacks = _onlySkill.isUsable() ? [_onlySkill] : [];	// checked for valid targets even when the player half is hidden
		else
			myAttacks = flags.Player ? _entity.getSkills().getAllSkillsOfType(::Const.SkillType.Active).filter(@(_, _s) _s.isAttack() && _s.isUsingHitchance() && _s.isUsable()) : [];
		local primaryOnly = this.isEnemyPrimaryAttackShown();
		local myVision = _entity.getCurrentProperties().getVision();

		foreach (enemy in ::Tactical.Entities.getAllInstancesAsArray())
		{
			if (!enemy.isAlive() || !enemy.isPlacedOnMap() || enemy.isAlliedWith(_entity) || enemy.isHiddenToPlayer())
				continue;

			local enemyTile = enemy.getTile();

			// Cheap range checks first; the rest only for opponents that get a row
			local isTargetable = false;
			foreach (s in myAttacks)
			{
				if (s.isInRange(enemyTile))
				{
					isTargetable = true;
					break;
				}
			}
			if (_onlySkill != null && !isTargetable)
				continue;

			local canReach = flags.Enemy && this.canAnyAttackReach(enemy, _tile);
			if (!isTargetable && !canReach)
				continue;

			// During preview the opponent's properties must consider the previewing entity at the destination tile,
			// for both halves (e.g. its defense when the entity is adjacent). The cleanup updates it again.
			if (_tag != null)
				this.updateForPreviewOnce(enemy, _tag);

			local toHit = null, toHitSkill = null;
			if (isTargetable)
			{
				foreach (s in myAttacks)
				{
					// onVerifyTarget covers target requirements of the skill (e.g. Split Shield needs a shield) and height differences
					if (s.isInRange(enemyTile) && (!s.isVisibleTileNeeded() || _tile.hasLineOfSightTo(enemyTile, myVision)) && s.onVerifyTarget(_tile, enemyTile))
					{
						local hc = s.getHitchance(enemy);
						if (toHit == null || hc > toHit)
						{
							toHit = hc;
							toHitSkill = s;
						}
					}
				}
			}

			if (_onlySkill != null)
			{
				if (toHitSkill == null)
					continue;

				if (!flags.Player)
				{
					toHit = null;
					toHitSkill = null;
				}
			}

			local toBeHit = null, toBeHitSkill = null;
			if (canReach)
			{
				local enemyVision = enemy.getCurrentProperties().getVision();
				// Primary: the first attack in skill bar order that can target the subject; otherwise the best hit chance
				local enemySkills = primaryOnly ? enemy.getSkills().query(::Const.SkillType.Active, false, true) : enemy.getSkills().getAllSkillsOfType(::Const.SkillType.Active);
				foreach (s in enemySkills)
				{
					// During preview _tile reports the previewing entity as its occupant (RF_PreviewEntity)
					if (!s.isAttack() || !s.isUsingHitchance() || !s.isInRange(_tile) || !s.isUsable() || (s.isVisibleTileNeeded() && !enemyTile.hasLineOfSightTo(_tile, enemyVision)) || !s.onVerifyTarget(enemyTile, _tile))
						continue;

					local hc = s.getHitchance(_entity);
					if (toBeHit == null || hc > toBeHit)
					{
						toBeHit = hc;
						toBeHitSkill = s;
					}
					if (primaryOnly)
						break;
				}
			}

			if (toHit == null && toBeHit == null)
				continue;

			local entry = this.getOrCreateEntry(_snapshot, enemy);
			entry.ToHit = toHit;
			entry.ToHitSkill = toHitSkill == null ? null : ::MSU.asWeakTableRef(toHitSkill);
			entry.ToBeHit = toBeHit;
			entry.ToBeHitSkill = toBeHitSkill == null ? null : ::MSU.asWeakTableRef(toBeHitSkill);
		}
	}

	// Runs _function(_tag) as if _entity stood on _destTile: with the changes of applyMovementPreview and with
	// _entity in Modular Vanilla's preview state, like MV_runBetweenPreviewUpdates. Everything is restored also
	// when an error occurs, as a leftover would break the rest of the battle.
	function runMovementPreview( _entity, _destTile, _function )
	{
		local tag = this.createPreviewTag(_entity, _destTile);
		try
		{
			this.applyMovementPreview(tag);
			this.doPreviewUpdate(_entity, true);
			_function.bindenv(this)(tag);
			this.cleanupMovementPreview(tag);
			this.doPreviewUpdate(_entity, false);
		}
		catch (error)
		{
			try
			{
				if (!tag.IsCleanedUp)
					this.cleanupMovementPreview(tag);
				this.doPreviewUpdate(_entity, false);
			}
			catch (cleanupError)
			{
				this.logError("error while restoring the movement preview: " + cleanupError);
			}
			throw error;
		}
	}

	// The state of a movement preview of _entity to _destTile, filled by applyMovementPreview and undone by cleanupMovementPreview
	function createPreviewTag( _entity, _destTile )
	{
		return {
			Entity = _entity,
			original_getTile = _entity.getTile,
			CurrTile = _entity.getTile(),
			DestTile = _destTile,
			DestTerrainEffect = null,
			CurrTerrainEffect = null,
			CurrTerrainEffectIdx = null,
			// Actors whose properties were recalculated for the preview (ID -> actor), see updateForPreviewOnce.
			// The cleanup recalculates them again.
			ActorsToUpdate = {},
			IsCleanedUp = false
		};
	}

	// Change and switcheroo various things so that the hit-chance calculations
	// are done as if the previewing entity is already on the previewed tile.
	// Fills _tag (see runMovementPreview) as it goes, so that cleanupMovementPreview can undo a partial apply.
	function applyMovementPreview( _tag )
	{
		local entity = _tag.Entity;
		local currTile = _tag.CurrTile;
		local destTile = _tag.DestTile;

		// Switcheroo the entity's getTile function to return the destination tile
		// so that hitchances of enemies are calculated with that. E.g. in case any skill
		// on the enemies wants to check distance to the target in its onAnySkillUsed function.
		// Similarly, height advantage etc. is properly accounted for.
		entity.getTile = @() destTile;

		// Goal:
		// - Consider the destination tile as occupied by the previewing entity and its current tile as empty,
		//   e.g. so that a reach attack from the destination isn't blocked by the entity's own current tile.
		// - Consider the destination tile and its neighbors part of the ZoC of the previewing entity,
		//   and its current tile and neighbors no longer.
		// This is achieved by hooking the relevant functions of TacticalTile class (hooks/native/TacticalTile.nut)
		// and checking for these specific data in the tile's Properties.
		// This is important so that any skill.isUsable checks or hit-chances or skill effects
		// behave more accurately when predicting during the preview.
		destTile.Properties.set("RF_PreviewEntity", entity);
		currTile.Properties.set("RF_PreviewVacated", true);
		local f = entity.getFaction();
		if (entity.m.IsExertingZoneOfControl)
		{
			currTile.Properties.set("RF_PreviewZOCRemovedFaction", f);
			foreach (t in ::MSU.Tile.getNeighbors(currTile))
			{
				t.Properties.set("RF_PreviewZOCRemovedFaction", f);
			}
		}
		if (entity.hasZoneOfControl())
		{
			destTile.Properties.set("RF_PreviewZOCFaction", f);
			foreach (t in ::MSU.Tile.getNeighbors(destTile))
			{
				t.Properties.set("RF_PreviewZOCFaction", f);
			}
		}

		// Remove the current terrain effect from the previewing entity and add the
		// terrain effect of the destination tile. This ensures that hit-chances are
		// properly calculated based on the effects of the terrain.
		// We make this addition directly into the `m.Skills` of the skills container
		// instead of doing `container.add` because we don't want to *actually* add or remove
		// the terrain effects and don't want to trigger their `onAdded` or `onRemoved`.
		local skills = entity.getSkills();
		if (::Const.Tactical.TerrainEffect[currTile.Type].len() > 0)
		{
			local id = ::Const.Tactical.TerrainEffectID[currTile.Type];
			foreach (i, s in skills.m.Skills)
			{
				if (s.getID() == id)
				{
					_tag.CurrTerrainEffectIdx = i;
					_tag.CurrTerrainEffect = skills.m.Skills.remove(i);
					break;
				}
			}
		}

		if (::Const.Tactical.TerrainEffect[destTile.Type].len() > 0 && !skills.hasSkill(::Const.Tactical.TerrainEffectID[destTile.Type]))
		{
			local effect = ::new(::Const.Tactical.TerrainEffect[destTile.Type]);
			// Like setContainer, but without the side effects of its hooks; the effect is discarded in the cleanup
			effect.m.Container = ::MSU.asWeakTableRef(skills);
			effect.saveBaseValues();
			skills.m.Skills.push(effect);
			_tag.DestTerrainEffect = effect;
		}
	}

	// Between the two preview updates we must clean up all the switcheroos and other
	// data injections we made for the previewing entity. This function reverses all the
	// changes made in the applyMovementPreview function.
	function cleanupMovementPreview( _tag )
	{
		_tag.IsCleanedUp = true;
		local entity = _tag.Entity;
		entity.getTile = _tag.original_getTile;

		local destTile = _tag.DestTile;
		destTile.Properties.remove("RF_PreviewEntity");
		destTile.Properties.remove("RF_PreviewZOCFaction");
		foreach (t in ::MSU.Tile.getNeighbors(destTile))
		{
			t.Properties.remove("RF_PreviewZOCFaction");
		}

		local currTile = _tag.CurrTile;
		currTile.Properties.remove("RF_PreviewVacated");
		currTile.Properties.remove("RF_PreviewZOCRemovedFaction");
		foreach (t in ::MSU.Tile.getNeighbors(currTile))
		{
			t.Properties.remove("RF_PreviewZOCRemovedFaction");
		}

		local skills = entity.getSkills().m.Skills;
		if (_tag.DestTerrainEffect != null)
		{
			for (local i = skills.len() - 1; i >= 0; i--)
			{
				if (skills[i] == _tag.DestTerrainEffect)
				{
					skills.remove(i);
					break;
				}
			}
		}

		if (_tag.CurrTerrainEffect != null)
			skills.insert(_tag.CurrTerrainEffectIdx, _tag.CurrTerrainEffect);

		foreach (a in _tag.ActorsToUpdate)
		{
			this.doPreviewUpdate(a, false);
		}
	}

	// Screen positions
	function getCameraState()
	{
		local camera = ::Tactical.getCamera();
		local pos = camera.getPos();
		return {
			X = pos.X,
			Y = pos.Y,
			Zoom = camera.Zoom,
			Level = camera.Level,
			UIScale = ::Settings.getVideoMode().UIScale,
			// Labels placed above units move up while the bars are shown; part of the state so that toggling them repositions
			ShowOverlayStats = ::Settings.getTempGameplaySettings().ShowOverlayStats
		};
	}

	// What the label positions depend on besides the snapshot: the camera state and which labeled actors are
	// travelling (their labels are hidden meanwhile)
	function getPositionKey( _camera )
	{
		local ret = format("%f,%f,%f,%i,%f,%s", _camera.X, _camera.Y, _camera.Zoom, _camera.Level, _camera.UIScale, _camera.ShowOverlayStats + "");
		local navigator = ::Tactical.getNavigator();
		foreach (entry in this.__State.Snapshot.Entries)
		{
			local actor = ::Tactical.getEntityByID(entry.ID);
			if (actor != null && navigator.isTravelling(actor))
				ret += "|" + entry.ID;
		}
		return ret;
	}

	// Circumradius of a hex in world units, measured from the distance between neighboring tiles:
	// for flat-topped hexes the horizontal distance between the centers of NE/SE neighbors is 1.5 * radius.
	function getHexSideX()
	{
		local s = this.__State;
		if (s.HexSideX != null)
			return s.HexSideX;

		local tile = ::Tactical.getTileSquare(1, 1);
		for (local i = 0; i < 6; i++)
		{
			if (tile.hasNextTile(i))
			{
				local dx = ::Math.abs(tile.getNextTile(i).Pos.X - tile.Pos.X);
				if (dx > 0)
				{
					s.HexSideX = dx / 1.5;
					return s.HexSideX;
				}
			}
		}
		return 0;
	}

	// Extra horizontal offset in world units of Beside labels for _type, see SideOffsetByType
	function getSideOffset( _type )
	{
		return _type in this.SideOffsetByType ? this.SideOffsetByType[_type] : 0.0;
	}

	// Number of rows of status icons vanilla shows above the bars of _actor (actor.updateOverlay)
	function getStatusIconRows( _actor )
	{
		local n = 0;
		foreach (s in _actor.getSkills().query(::Const.SkillType.StatusEffect | ::Const.SkillType.Terrain))
		{
			if (s.getIconMini().len() != 0)
				n++;
		}
		local perRow = this.Vanilla.StatusIconsPerRow;
		return (n + perRow - 1) / perRow;
	}

	// getStatusIconRows of _actor, cached until the next snapshot: positions are recalculated on every camera change,
	// while a change of status effects updates the actor's skills, which marks the overlay dirty and recomputes it
	function getCachedStatusIconRows( _actor )
	{
		local cache = this.__State.StatusIconRows;
		local id = _actor.getID();
		if (!(id in cache))
			cache[id] <- this.getStatusIconRows(_actor);
		return cache[id];
	}

	function clearStatusIconRows()
	{
		this.__State.StatusIconRows = {};
	}

	function isPlacedAbove()
	{
		return this.getSettingValue("HitchanceOverlay_Placement") == "Above";
	}

	// Label scale sent to JS: follows the camera zoom so labels shrink with the hexes, within MinScale..MaxScale
	function getZoomScale( _camera )
	{
		return ::Math.maxf(this.Layout.MinScale, ::Math.minf(this.Layout.MaxScale, 1.0 / _camera.Zoom));
	}

	// CornerFactor for the current label size relative to the hex: the size setting times the zoom scale, relative to
	// the hex's size on screen (1 / Zoom). It is 1.0 for setting 1.0 while the zoom scale isn't clamped; zooming out
	// beyond MaxScale makes labels smaller relative to the hexes.
	function getCornerFactor( _camera )
	{
		local l = this.Layout;
		local size = this.getSettingValue("HitchanceOverlay_Scale") * this.getZoomScale(_camera) * _camera.Zoom;
		local slope = (l.CornerFactor - l.CornerFactorSmall) / (1.0 - l.CornerSmallSize);
		return ::Math.maxf(l.MinCornerFactor, l.CornerFactor + (size - 1.0) * slope);
	}

	// Returns { id, x, y, side, scale, visible, valign? }: x/y in CSS px relative to the screen center for the label anchor.
	// Placement Beside: the anchor is the top of the first row at the outer corner of the unit's hex, just below
	// vanilla's bars; side is "left" or "right" of it. While the bars are hidden, the first row is centered on the
	// anchor instead (valign "first-center").
	// Placement Above: the anchor is the label's bottom center just above vanilla's bars and status icons; side is "above".
	// Units above the camera level: the anchor is beside (valign "center") or above the portrait marker.
	function getLabelPosition( _actor, _camera )
	{
		local ret = { id = _actor.getID(), x = 0, y = 0, side = "right", scale = 1.0, visible = false };
		if (!_actor.isAlive() || !_actor.isPlacedOnMap() || _actor.isHiddenToPlayer() || ::Tactical.getNavigator().isTravelling(_actor))
			return ret;

		local v = this.Vanilla;
		local tile = _actor.getTile();
		local f = 1.0 / (_camera.Zoom * _camera.UIScale);
		ret.scale = this.getZoomScale(_camera) * this.Layout.ReferenceUIScale / _camera.UIScale;
		ret.visible = true;
		local isAbove = this.isPlacedAbove();

		// Above the camera level, vanilla draws the unit as a portrait marker without bars or status icons. Its center
		// is the tile center dropped by LevelOffset per level, and its size is fixed in screen px (any zoom, UI scale).
		if (tile.Level > _camera.Level)
		{
			ret.x = (tile.Pos.X - _camera.X) * f;
			ret.y = (_camera.Y - tile.Pos.Y + (tile.Level - _camera.Level) * v.LevelOffset) * f;
			local markerOffset = (v.MarkerRadius + this.Layout.MarkerGap) / _camera.UIScale;	// screen px -> CSS px
			if (isAbove)
			{
				ret.side = "above";
				ret.y -= markerOffset;
			}
			else
			{
				ret.side = _actor.isAlliedWithPlayer() ? "left" : "right";
				ret.x += ret.side == "left" ? -markerOffset : markerOffset;
				ret.valign <- "center";	// the whole label is centered on the marker
			}
			return ret;
		}

		local offsetX = 0.0, offsetY;
		if (isAbove)
		{
			ret.side = "above";
			// The bottom of the label sits just above vanilla's bars and status icons, or where the bars would be while they are hidden
			offsetY = v.HeadOffset;
			if (_camera.ShowOverlayStats)
				offsetY += v.BarsHeight + this.getCachedStatusIconRows(_actor) * v.StatusRowHeight + this.Layout.AboveGap;
		}
		else
		{
			// The anchor is the top of the first row, just below vanilla's bars. While they are hidden, that spot is at
			// the base of the unit on the tile above, so the first row is instead centered at torso height.
			if (_camera.ShowOverlayStats)
			{
				offsetY = v.HeadOffset - this.Layout.BesideBarsGap;
			}
			else
			{
				offsetY = this.Layout.TorsoOffset;
				ret.valign <- "first-center";
			}

			offsetX = this.getHexSideX() * this.getCornerFactor(_camera) + this.getSideOffset(_actor.getType());
			if (_actor.isAlliedWithPlayer())
			{
				ret.side = "left";
				offsetX = -offsetX;
			}
		}
		ret.x = (tile.Pos.X + offsetX - _camera.X) * f;
		ret.y = (_camera.Y - tile.Pos.Y - offsetY) * f;
		return ret;
	}

	// Position of the label of the actor of _entry, or a hidden one when the actor is gone
	function getEntryPosition( _entry, _camera )
	{
		local actor = ::Tactical.getEntityByID(_entry.ID);
		return actor == null ? { id = _entry.ID, x = 0, y = 0, side = "right", scale = 1.0, visible = false } : this.getLabelPosition(actor, _camera);
	}

	function getLabelPositions( _camera )
	{
		local ret = [];
		if (this.__State.Snapshot == null)
			return ret;

		foreach (entry in this.__State.Snapshot.Entries)
		{
			ret.push(this.getEntryPosition(entry, _camera));
		}
		return ret;
	}

	// UI data for the labels
	function getSkillIcon( _skillRef )
	{
		return ::MSU.isNull(_skillRef) ? null : _skillRef.getIcon();
	}

	// Array of label data: the position (see getLabelPosition) plus
	// { toHit = null or { hitchance, icon }, toBeHit = null or { hitchance, icon, dimmed }, warning }.
	// Entries without any row get no label.
	function getLabelsUIData( _camera )
	{
		local flags = this.getShowFlags();
		// Attacks on movement and on arrival: a warning icon, and an opponent row without a regular attack, see isZOCAlwaysShown
		local isZOCShown = flags.Enemy || this.isZOCAlwaysShown();
		local ret = [];
		foreach (entry in this.__State.Snapshot.Entries)
		{
			local toHit = entry.ToHit == null ? null : { hitchance = entry.ToHit, icon = this.getSkillIcon(entry.ToHitSkill) };

			// At most two rows: to hit and to be hit. Attacks on movement and on arrival only add a warning
			// (the label's nested tooltip lists them). Without a regular attack the enemy row shows the best of them.
			local toBeHit = entry.ToBeHit == null ? null : { hitchance = entry.ToBeHit, icon = this.getSkillIcon(entry.ToBeHitSkill) };
			if (toBeHit == null && flags.Enemy)
			{
				foreach (attack in [entry.LeaveAttack, entry.ArriveAttack])
				{
					if (attack != null && (toBeHit == null || attack.Hitchance > toBeHit.hitchance))
						toBeHit = { hitchance = attack.Hitchance, icon = this.getSkillIcon(attack.Skill) };
				}
			}

			if (toHit == null && toBeHit == null)
				continue;

			local actor = ::Tactical.getEntityByID(entry.ID);
			// An opponent that has acted this round can't attack before the next one (except attacks on movement)
			if (toBeHit != null)
				toBeHit.dimmed <- entry.ToBeHit != null && actor != null && actor.isTurnDone();

			local data = this.getEntryPosition(entry, _camera);
			data.toHit <- toHit;
			data.toBeHit <- toBeHit;
			data.warning <- isZOCShown && (entry.LeaveAttack != null || entry.ArriveAttack != null);
			ret.push(data);
		}
		return ret;
	}

	function callJS( _function, _data )
	{
		::Tactical.State.m.TacticalScreen.m.JSHandle.asyncCall(_function, _data);
	}

	function clear()
	{
		local s = this.__State;
		s.LastKey = null;
		s.IsFrozen = false;
		this.clearLabels();
	}

	function clearLabels()
	{
		local s = this.__State;
		if (s.Snapshot == null)
			return;

		s.Snapshot = null;
		this.callJS("RF_clearHitchanceLabels", null);
	}

	function canShowLabels()
	{
		local state = ::Tactical.State;
		return this.isOverlayShown() && !state.isBattleEnded() && !state.isInCharacterScreen() && !state.isInLoadingScreen();
	}

	// Called every frame from the orientation_overlay.update hook
	function onFrame()
	{
		if (!this.canShowLabels())
		{
			this.clear();
			return;
		}

		local s = this.__State;
		if (!s.IsFrozen)
		{
			local subject = this.getSubject();
			if (subject == null || ::Tactical.getNavigator().isTravelling(subject.Entity))
			{
				this.clear();
				return;
			}

			local key = this.getSubjectKey(subject);
			local now = ::Time.getRealTimeF();
			if (key != s.LastKey || (s.IsDirty && now - s.LastComputeTime >= this.__RecomputeInterval))
			{
				s.LastKey = key;
				s.LastComputeTime = now;
				s.IsDirty = false;

				local snapshot;
				try
				{
					snapshot = this.compute(subject);
				}
				catch (error)
				{
					// Not retried every frame: only when the subject changes or something marks the overlay dirty
					this.logError(error);
					this.clearLabels();
					return;
				}

				s.Snapshot = snapshot;
				this.clearStatusIconRows();
				local camera = this.getCameraState();
				s.LastPositionKey = this.getPositionKey(camera);
				this.callJS("RF_setHitchanceLabels", this.getLabelsUIData(camera));
				return;
			}
		}

		if (s.Snapshot == null)
			return;

		local camera = this.getCameraState();
		local positionKey = this.getPositionKey(camera);
		if (positionKey != s.LastPositionKey)
		{
			s.LastPositionKey = positionKey;
			this.callJS("RF_updateHitchanceLabelPositions", this.getLabelPositions(camera));
		}
	}

	// Called from JS when a label is hovered or unhovered (or forced unhovered when labels become click-through)
	function onLabelHovered( _isHovered )
	{
		local s = this.__State;
		s.IsFrozen = _isHovered && s.Snapshot != null;
		if (!s.IsFrozen)
			s.IsDirty = true;
	}

	// Tooltip of a label, built from the (frozen) snapshot
	function getLabelTooltip( _entityID )
	{
		local snapshot = this.__State.Snapshot;
		if (snapshot == null || !(_entityID in snapshot.EntriesByID))
			return null;

		local entry = snapshot.EntriesByID[_entityID];
		local enemy = ::Tactical.getEntityByID(_entityID);
		if (enemy == null)
			return null;

		local subjectName = snapshot.SubjectName;
		local where;
		switch (snapshot.Mode)
		{
			case this.__SubjectMode.Move: where = "at the tile he is about to move to"; break;
			case this.__SubjectMode.Skill: where = "at his current tile using " + snapshot.SkillName; break;
			default: where = "at his current tile";
		}
		local ret = [
			{ id = 1, type = "title", text = enemy.getName() },
			{ id = 2, type = "description", text = format("Predicted chances for %s %s.", subjectName, where) }
		];

		local function skillLink( _skillRef, _owner )
		{
			if (::MSU.isNull(_skillRef))
				return "an attack";
			return ::Reforged.NestedTooltips.getNestedSkillName(_skillRef.get(), "entityId:" + _owner.getID());
		}

		local subject = ::Tactical.getEntityByID(snapshot.SubjectID);
		if (entry.ToHit != null && subject != null)
		{
			ret.push({ id = 10, type = "text", icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("%s to hit with %s", ::MSU.Text.colorPositive(entry.ToHit + "%"), skillLink(entry.ToHitSkill, subject)))
			});
		}

		if (entry.ToBeHit != null)
		{
			ret.push({ id = 11, type = "text", icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("%s to be hit by %s%s", ::MSU.Text.colorNegative(entry.ToBeHit + "%"), skillLink(entry.ToBeHitSkill, enemy), this.getNextTurnSuffix(enemy)))
			});
		}

		if (!this.getShowFlags().Enemy && !this.isZOCAlwaysShown())
			return ret;

		if (entry.LeaveAttack != null)
		{
			ret.push({ id = 12, type = "text", icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("[Attacks on movement|Concept.ZoneOfControl] when %s leaves his tile: %s to hit with %s", subjectName, ::MSU.Text.colorNegative(entry.LeaveAttack.Hitchance + "%"), skillLink(entry.LeaveAttack.Skill, enemy)))
			});
		}

		if (entry.ArriveAttack != null)
		{
			ret.push({ id = 13, type = "text", icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("Attacks on arrival at the previewed tile: %s to hit with %s", ::MSU.Text.colorNegative(entry.ArriveAttack.Hitchance + "%"), skillLink(entry.ArriveAttack.Skill, enemy)))
			});
		}

		return ret;
	}

	// " (next turn)" for an opponent that has acted this round (its overlay row is dimmed), otherwise ""
	function getNextTurnSuffix( _enemy )
	{
		return _enemy.isTurnDone() ? " (next turn)" : "";
	}
};

::Reforged.HitchanceOverlay.reset();
