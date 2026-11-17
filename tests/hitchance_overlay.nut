// Runtime tests of ::Reforged.HitchanceOverlay (hit-chance overlay and movement preview tooltip)

local function setMode( _mode )
{
	::Reforged.Mod.ModSettings.getSetting("HitchanceDisplay_Mode").set(_mode);
}

// Sets the display settings: HitchanceDisplay_Mode, HitchanceDisplay_Shown and HitchanceDisplay_ZOCAttacks
local function setDisplaySettings( _mode, _shown, _zoc )
{
	setMode(_mode);
	::Reforged.Mod.ModSettings.getSetting("HitchanceDisplay_Shown").set(_shown);
	::Reforged.Mod.ModSettings.getSetting("HitchanceDisplay_ZOCAttacks").set(_zoc);
}

// Movement preview tile tooltip of _entity with the given display settings (see setDisplaySettings)
local function getMovementTooltip( _entity, _mode, _shown, _zoc )
{
	setDisplaySettings(_mode, _shown, _zoc);
	return ::TooltipEvents.RF_getMovementPreviewTooltip(_entity);
}

// Whether _tooltip has a top-level entry with _icon
local function hasTooltipIcon( _icon, _tooltip )
{
	foreach (e in _tooltip)
	{
		if ("icon" in e && e.icon == _icon)
			return true;
	}
	return false;
}

local function setupBroNextToEnemy()
{
	local bro = ::BBTest.getPlayerBros()[0];
	local enemy = ::BBTest.getEnemies()[0];
	::BBTest.setUnlimited(bro);
	return { Bro = bro, Enemy = enemy, Tile = ::BBTest.findEmptyTileNear(enemy.getTile(), 1) };
}

local function makeSubject( _entity, _mode, _tile, _skill = null )
{
	return { Entity = _entity, Mode = _mode, IsPreview = _mode == "Move", Tile = _tile, Skill = _skill };
}

// Sets the action state of the tactical state and clears the hovered entity, as the overlay shows only for a
// previewed movement, a selected attack or a hovered character. Returns a function that restores the state.
local function setActionState( _actionState, _selectedTile = null, _skillID = null )
{
	local state = ::Tactical.State;
	local old = { Selected = state.m.LastTileSelected, ActionState = state.m.CurrentActionState, SkillID = state.m.SelectedSkillID };
	state.m.LastTileSelected = _selectedTile;
	state.m.CurrentActionState = _actionState;
	state.m.SelectedSkillID = _skillID;
	::Tactical.TurnSequenceBar.m.ActiveEntityMouseHover = null;
	return function() {
		state.m.LastTileSelected = old.Selected;
		state.m.CurrentActionState = old.ActionState;
		state.m.SelectedSkillID = old.SkillID;
	};
}

// Makes the active player character preview a movement to an empty tile next to the first enemy.
// Returns a function that restores the state, or null when no player character is active.
local function previewMoveNextToEnemy()
{
	local active = ::BBTest.getActiveEntity();
	if (active == null || !active.isPlayerControlled())
		return null;

	local dest = ::BBTest.findEmptyTileNear(::BBTest.getEnemies()[0].getTile(), 1);
	::BBTest.assert(dest != null, "no empty tile next to the enemy");
	return setActionState(::Const.Tactical.ActionState.ComputePath, dest);
}

::BBTest.add("hit-chance overlay: compute from current tile", function() {
	local s = setupBroNextToEnemy();
	if (s.Bro.getTile().getDistanceTo(s.Enemy.getTile()) != 1)
		yield ::BBTest.placeAt(s.Bro, s.Tile);

	local snapshot = ::Reforged.HitchanceOverlay.compute(makeSubject(s.Bro, "Hover", s.Bro.getTile()));
	::BBTest.assert(s.Enemy.getID() in snapshot.EntriesByID, "no entry for the adjacent enemy");
	local entry = snapshot.EntriesByID[s.Enemy.getID()];
	::BBTest.assert(entry.ToHit != null && entry.ToHit >= 5 && entry.ToHit <= 95, "ToHit out of range: " + entry.ToHit);
	::BBTest.assert(entry.ToBeHit != null && entry.ToBeHit >= 5 && entry.ToBeHit <= 95, "ToBeHit out of range: " + entry.ToBeHit);
	::BBTest.assert(!::MSU.isNull(entry.ToHitSkill) && !::MSU.isNull(entry.ToBeHitSkill), "skills missing");
	::BBTest.assert(entry.LeaveAttack == null && entry.ArriveAttack == null, "move attacks without preview");
	::BBTest.assert(!::Reforged.HitchanceOverlay.__State.IsComputing, "IsComputing left set");

	// Label data: skill icons for both halves, label at the right corner of the enemy's hex
	local overlay = ::Reforged.HitchanceOverlay;
	::Reforged.Mod.ModSettings.getSetting("HitchanceOverlay_Placement").set("Beside");
	local oldSnapshot = overlay.__State.Snapshot;
	overlay.__State.Snapshot = snapshot;
	local camera = overlay.getCameraState();
	local uiData = overlay.getLabelsUIData(camera);
	overlay.__State.Snapshot = oldSnapshot;
	local label = null;
	foreach (d in uiData)
	{
		if (d.id == s.Enemy.getID())
			label = d;
	}
	::BBTest.assert(label != null, "no label data for the enemy");
	::BBTest.assert(label.toHit.icon != null && label.toBeHit.icon != null, "skill icons missing");
	::BBTest.assert(!("leave" in label) && !("arrive" in label), "label data still has movement attack rows");
	::BBTest.assert("dimmed" in label.toBeHit && "warning" in label, "dimmed or warning missing");
	::BBTest.assert(entry.ToHitSkill.isUsingHitchance() && entry.ToBeHitSkill.isUsingHitchance(), "skill without hit chance chosen");
	::BBTest.assertEq("right", label.side);
	local f = 1.0 / (camera.Zoom * camera.UIScale);
	::BBTest.assert(label.x > (s.Enemy.getTile().Pos.X - camera.X) * f, "label not right of the enemy");
	::BBTest.assert(overlay.getHexSideX() > 0, "hex size not measured");
}, { Phase = ::BBTest.Phase.Tactical });

::BBTest.add("hit-chance overlay: preview restores state", function() {
	local s = setupBroNextToEnemy();
	if (s.Bro.getTile().getDistanceTo(s.Enemy.getTile()) != 1)
		yield ::BBTest.placeAt(s.Bro, s.Tile);

	// A destination tile also adjacent to the enemy, so the bro leaves and enters its zone of control
	local start = s.Bro.getTile();
	local dest = null;
	for (local i = 0; i < 6; i++)
	{
		if (!s.Enemy.getTile().hasNextTile(i))
			continue;
		local t = s.Enemy.getTile().getNextTile(i);
		if (t.IsEmpty && t.ID != start.ID && ::Math.abs(t.Level - start.Level) <= 1)
		{
			dest = t;
			break;
		}
	}
	::BBTest.assert(dest != null, "no destination tile");

	local enemyAttack = s.Enemy.getSkills().getAttackOfOpportunity();
	local hitchanceBefore = enemyAttack.getHitchance(s.Bro);
	local skillsBefore = s.Bro.getSkills().m.Skills.len();

	local state = ::Tactical.State;
	local oldSelected = state.m.LastTileSelected;
	local oldActionState = state.m.CurrentActionState;
	state.m.LastTileSelected = dest;
	state.m.CurrentActionState = ::Const.Tactical.ActionState.ComputePath;
	local restore = function() {
		state.m.LastTileSelected = oldSelected;
		state.m.CurrentActionState = oldActionState;
	};
	::BBTest.assertEq(dest.ID, ::Reforged.HitchanceOverlay.getMovementTarget(s.Bro).ID, "movement target is not the selected tile");
	local active = ::Tactical.TurnSequenceBar.getActiveEntity();
	if (active != null && active.getID() == s.Bro.getID() && ::Tactical.TurnSequenceBar.m.ActiveEntityMouseHover == null)
	{
		local subject = ::Reforged.HitchanceOverlay.getSubject();
		::BBTest.assert(subject.Mode == "Move" && subject.IsPreview && subject.Tile.ID == dest.ID, "subject is not previewing the selected tile");
	}

	local snapshot;
	try
	{
		snapshot = ::Reforged.HitchanceOverlay.compute(makeSubject(s.Bro, "Move", dest));
	}
	catch (error)
	{
		restore();
		throw error;
	}

	// Tooltip in the display modes and with the zone of control setting, built while the preview data is still set
	local tooltips = {};
	try
	{
		tooltips.List <- getMovementTooltip(s.Bro, "Tooltip", "All", "Always");
		tooltips.OverlayAlways <- getMovementTooltip(s.Bro, "Overlay", "All", "Always");
		tooltips.OffNoneAlways <- getMovementTooltip(s.Bro, "Off", "None", "Always");
		tooltips.OverlayFollow <- getMovementTooltip(s.Bro, "Overlay", "All", "Follow Display Settings");
		tooltips.PlayerOnlyFollow <- getMovementTooltip(s.Bro, "Tooltip", "Player Only", "Follow Display Settings");
	}
	catch (error)
	{
		setDisplaySettings("Overlay", "All", "Always");
		restore();
		throw error;
	}
	setDisplaySettings("Overlay", "All", "Always");

	restore();

	::BBTest.assertEq(start.ID, s.Bro.getTile().ID, "getTile not restored");
	::BBTest.assertEq(skillsBefore, s.Bro.getSkills().m.Skills.len(), "terrain effects not restored");
	::BBTest.assert(!dest.Properties.has("RF_PreviewEntity"), "RF_PreviewEntity left on the tile");
	::BBTest.assertEq(hitchanceBefore, enemyAttack.getHitchance(s.Bro), "enemy hit chance changed after the preview");

	::BBTest.assert(s.Enemy.getID() in snapshot.EntriesByID, "no entry for the enemy");
	local entry = snapshot.EntriesByID[s.Enemy.getID()];
	::BBTest.assert(entry.LeaveAttack != null, "no attack on leaving the enemy's zone of control");
	::BBTest.assert(entry.ToHit != null, "no ToHit at the destination");

	// The attack on leaving the zone of control becomes a warning on the opponent's row
	local overlay = ::Reforged.HitchanceOverlay;
	local oldSnapshot = overlay.__State.Snapshot;
	overlay.__State.Snapshot = snapshot;
	local uiData = overlay.getLabelsUIData(overlay.getCameraState());
	overlay.__State.Snapshot = oldSnapshot;
	local label = null;
	foreach (d in uiData)
	{
		if (d.id == s.Enemy.getID())
			label = d;
	}
	::BBTest.assert(label != null && label.warning, "no warning for the attack on movement");
	::BBTest.assert(label.toBeHit != null, "no opponent row with a warning");

	::BBTest.assert(hasTooltipIcon("ui/icons/warning.png", tooltips.List) && hasTooltipIcon("ui/icons/icon_contract_swords.png", tooltips.List), "tooltip list without attacks on movement or hit chances");
	::BBTest.assert(hasTooltipIcon("ui/icons/warning.png", tooltips.OverlayAlways) && !hasTooltipIcon("ui/icons/icon_contract_swords.png", tooltips.OverlayAlways), "overlay mode: attacks on movement not always listed, or hit chances listed");
	::BBTest.assert(hasTooltipIcon("ui/icons/warning.png", tooltips.OffNoneAlways), "attacks on movement not listed in Off mode with None shown");
	::BBTest.assertEq(0, tooltips.OverlayFollow.len(), "overlay mode tooltip not empty while following the display settings");
	::BBTest.assert(!hasTooltipIcon("ui/icons/warning.png", tooltips.PlayerOnlyFollow) && hasTooltipIcon("ui/icons/icon_contract_swords.png", tooltips.PlayerOnlyFollow), "Player Only: attacks on movement listed or hit chances missing while following the display settings");
}, { Phase = ::BBTest.Phase.Tactical });

::BBTest.add("hit-chance overlay: opponent attacks need a valid target", function() {
	local bro = null;
	foreach (b in ::BBTest.getPlayerBros())
	{
		if (!b.isArmedWithShield())
		{
			bro = b;
			break;
		}
	}
	if (bro == null)
	{
		::logWarning("[BBTEST] skipped: no bro without a shield");
		return;
	}

	local enemy = ::BBTest.getEnemies()[0];
	::BBTest.setUnlimited(bro);
	if (bro.getTile().getDistanceTo(enemy.getTile()) != 1)
		yield ::BBTest.placeAt(bro, ::BBTest.findEmptyTileNear(enemy.getTile(), 1));

	// Split Shield made to use and win on hit chance, so only its target check (needs a shield) excludes it
	local splitShield = ::new("scripts/skills/actives/split_shield");
	splitShield.m.IsUsingHitchance = true;
	splitShield.getHitchance = @( _target ) 95;
	enemy.getSkills().add(splitShield);

	local snapshot;
	try
	{
		::BBTest.assert(!splitShield.onVerifyTarget(enemy.getTile(), bro.getTile()), "Split Shield is valid against a bro without a shield");
		snapshot = ::Reforged.HitchanceOverlay.compute(makeSubject(bro, "Hover", bro.getTile()));
	}
	catch (error)
	{
		splitShield.removeSelf();
		enemy.getSkills().update();
		throw error;
	}
	splitShield.removeSelf();
	enemy.getSkills().update();

	::BBTest.assert(enemy.getID() in snapshot.EntriesByID, "no entry for the enemy");
	local entry = snapshot.EntriesByID[enemy.getID()];
	::BBTest.assert(::MSU.isNull(entry.ToBeHitSkill) || entry.ToBeHitSkill.getID() != "actives.split_shield", "Split Shield chosen against a bro without a shield");
}, { Phase = ::BBTest.Phase.Tactical });

::BBTest.add("hit-chance overlay: cycle modes and show labels", function() {
	local original = ::Reforged.HitchanceOverlay.getMode();
	::Reforged.Mod.ModSettings.getSetting("HitchanceOverlay_Placement").set("Beside");
	setMode("Overlay");
	local seen = [];
	for (local i = 0; i < 4; i++)
	{
		seen.push(::Reforged.HitchanceOverlay.cycleMode());
	}
	::BBTest.assertEq("Overlay + Tooltip", seen[0]);
	::BBTest.assertEq("Tooltip", seen[1]);
	::BBTest.assertEq("Off", seen[2]);
	::BBTest.assertEq("Overlay", seen[3]);

	local s = setupBroNextToEnemy();
	if (s.Bro.getTile().getDistanceTo(s.Enemy.getTile()) != 1)
		yield ::BBTest.placeAt(s.Bro, s.Tile);
	local restore = previewMoveNextToEnemy();
	::Reforged.HitchanceOverlay.setDirty();
	yield ::BBTest.waitFrames(5);

	if (restore != null)
	{
		::BBTest.assert(::Reforged.HitchanceOverlay.isShowingLabels(), "labels not shown in Overlay mode");
		::BBTest.assert(::Reforged.HitchanceOverlay.__State.Snapshot != null && ::Reforged.HitchanceOverlay.__State.Snapshot.Entries.len() != 0, "empty snapshot");
		yield ::BBTest.screenshot("hitchance_overlay");

		local styleSetting = ::Reforged.Mod.ModSettings.getSetting("HitchanceOverlay_Style");
		local oldStyle = styleSetting.getValue();
		styleSetting.set("Parchment");
		yield ::BBTest.waitFrames(5);
		yield ::BBTest.screenshot("hitchance_overlay_parchment");
		styleSetting.set("Skill Icons");
		yield ::BBTest.waitFrames(5);
		yield ::BBTest.evalJS("$('.rf-hitchance-overlay').hasClass('rf-style-icons') && $('.rf-hitchance-overlay').hasClass('rf-on-map') && $('.rf-hitchance-paper').length === 0");
		::BBTest.assert(::BBTest.LastJSResult, "Skill Icons style not applied or still has paper");
		yield ::BBTest.screenshot("hitchance_overlay_icons");
		// With vanilla's bars shown: the first row starts just below them
		if (!::Settings.getTempGameplaySettings().ShowOverlayStats)
			::Tactical.State.topbar_options_onToggleStatsOverlaysButtonClicked();
		yield ::BBTest.waitFrames(5);
		yield ::BBTest.screenshot("hitchance_overlay_bars");
		styleSetting.set(oldStyle);

		setMode("Off");
		yield ::BBTest.waitFrames(3);
		::BBTest.assert(!::Reforged.HitchanceOverlay.isShowingLabels(), "labels still shown in Off mode");
		restore();
	}

	setMode(original);
}, { Phase = ::BBTest.Phase.Tactical });

// Mouse: a locked tile tooltip next to a label must not block the label's own tooltip (Nested Tooltips
// hands the mouse over from the expanded tile div to tooltip sources below it)
::BBTest.add("hit-chance overlay: label tooltip opens over a locked tile tooltip", function() {
	local original = ::Reforged.HitchanceOverlay.getMode();
	setMode("Overlay");
	::Reforged.Mod.ModSettings.getSetting("HitchanceOverlay_LabelInteraction").set("Hoverable");
	local s = setupBroNextToEnemy();
	if (s.Bro.getTile().getDistanceTo(s.Enemy.getTile()) != 1)
		yield ::BBTest.placeAt(s.Bro, s.Tile);
	local restore = previewMoveNextToEnemy();
	::BBTest.assert(restore != null, "no active player character");
	::Reforged.HitchanceOverlay.setDirty();
	yield ::BBTest.waitFrames(10);

	yield ::BBTest.evalJS(::BBTest.jsElementRect(".rf-hitchance-label:not(.rf-removing):not(.rf-hidden-label)"));
	local label = ::BBTest.LastJSResult;
	if (label == null)
		restore();
	::BBTest.assert(label != null, "no visible overlay label");

	// Lock the tooltip of the tile just left of the label (the opponent's body), then move onto the label
	yield ::BBTest.moveMouse(label.left - 25, label.y);
	yield ::BBTest.waitForJS("MSU.NestedTooltip.TileTooltipDiv.isLocked()", 4000);
	yield ::BBTest.moveMouse(label.x, label.y, 150);
	yield ::BBTest.waitForJS("(function(){ var t = MSU.NestedTooltip.TooltipStack.peek(); return t !== null && t.sourceContainer.hasClass('rf-hitchance-label'); })()", 2000);
	::BBTest.log(format("label tooltip opened %i ms after reaching the label", ::BBTest.LastJSWaitMs.tointeger()));

	restore();
	setMode(original);
}, { Phase = ::BBTest.Phase.Tactical });

::BBTest.add("hit-chance overlay: placement above units", function() {
	local placement = ::Reforged.Mod.ModSettings.getSetting("HitchanceOverlay_Placement");
	local style = ::Reforged.Mod.ModSettings.getSetting("HitchanceOverlay_Style");
	local oldStyle = style.getValue();
	local original = ::Reforged.HitchanceOverlay.getMode();
	local enemy = ::BBTest.getEnemies()[0];
	local overlay = ::Reforged.HitchanceOverlay;
	local camera = overlay.getCameraState();

	placement.set("Beside");
	local beside = overlay.getLabelPosition(enemy, camera);
	placement.set("Above");
	local above = overlay.getLabelPosition(enemy, camera);
	::BBTest.assertEq("above", above.side);
	::BBTest.assert(above.y < beside.y, format("label above (y %.1f) not higher than beside (y %.1f)", above.y, beside.y));
	local f = 1.0 / (camera.Zoom * camera.UIScale);
	::BBTest.assertNear((enemy.getTile().Pos.X - camera.X) * f, above.x, 0.5, "label above not centered on the unit");

	// While vanilla's bars are shown, the label sits above them and rises with each row of status icons (4 per row);
	// while they are hidden, it sits where the bars would be
	local barsShown = clone camera;
	barsShown.ShowOverlayStats = true;
	local barsHidden = clone camera;
	barsHidden.ShowOverlayStats = false;
	overlay.clearStatusIconRows();
	local rows = overlay.getStatusIconRows(enemy);
	local yShown = overlay.getLabelPosition(enemy, barsShown).y;
	local yHidden = overlay.getLabelPosition(enemy, barsHidden).y;
	local added = [];
	foreach (effect in ["adrenaline_effect", "alp_potion_effect", "antidote_effect", "cat_potion_effect", "direwolf_potion_effect", "geist_potion_effect"])
	{
		local s = ::new("scripts/skills/effects/" + effect);
		enemy.getSkills().add(s);
		added.push(s);
	}
	local moreRows = overlay.getStatusIconRows(enemy);
	overlay.clearStatusIconRows();	// cached until the next snapshot
	local yMoreRows = overlay.getLabelPosition(enemy, barsShown).y;
	foreach (s in added)
		s.removeSelf();
	enemy.getSkills().update();
	::BBTest.assertNear(overlay.Vanilla.BarsHeight + rows * overlay.Vanilla.StatusRowHeight + overlay.Layout.AboveGap, (yHidden - yShown) / f, 0.5, "label above not just above the bars and status icons");
	::BBTest.assert(moreRows > rows, format("status icon rows did not grow (%i -> %i)", rows, moreRows));
	::BBTest.assertNear((moreRows - rows) * overlay.Vanilla.StatusRowHeight, (yShown - yMoreRows) / f, 0.5, "label above did not rise with the status icon rows");

	// Beside: the first row's top just below the bars while they are shown, the first row centered at torso height while hidden
	placement.set("Beside");
	local besideShown = overlay.getLabelPosition(enemy, barsShown);
	local besideHidden = overlay.getLabelPosition(enemy, barsHidden);
	placement.set("Above");
	local tileY = (camera.Y - enemy.getTile().Pos.Y) * f;
	::BBTest.assert(!("valign" in besideShown), "label beside not anchored by its first row's top while the bars are shown");
	::BBTest.assertNear(tileY - (overlay.Vanilla.HeadOffset - overlay.Layout.BesideBarsGap) * f, besideShown.y, 0.5, "label beside not just below the bars");
	::BBTest.assert("valign" in besideHidden && besideHidden.valign == "first-center", "label beside not centered by its first row while the bars are hidden");
	::BBTest.assertNear(tileY - overlay.Layout.TorsoOffset * f, besideHidden.y, 0.5, "label beside not at torso height while the bars are hidden");

	// A hovered label freezes the overlay (e.g. left there by the mouse test before): move onto the combat log
	yield ::BBTest.moveMouse(100, 60);
	local restore = previewMoveNextToEnemy();
	::BBTest.assert(restore != null, "no active player character");
	setMode("Overlay");
	overlay.setDirty();
	yield ::BBTest.waitFrames(10);
	yield ::BBTest.evalJS("({ above: $('.rf-hitchance-overlay').hasClass('rf-placement-above'), labels: $('.rf-hitchance-label').length, direction: $('.rf-hitchance-label').first().css('flex-direction') })");
	local js = ::BBTest.LastJSResult;
	::BBTest.log(format("above class %s, labels %s, flex-direction %s", js.above + "", js.labels + "", js.direction + ""));
	::BBTest.assert(js.above && js.labels > 0 && js.direction == "row", "labels not laid out in a row above the units");
	yield ::BBTest.screenshot("hitchance_overlay_above");
	style.set("Parchment");
	yield ::BBTest.waitFrames(10);
	yield ::BBTest.screenshot("hitchance_overlay_above_parchment");

	restore();
	style.set(oldStyle);
	placement.set("Beside");
	setMode(original);
}, { Phase = ::BBTest.Phase.Tactical });

// The previewing character's current tile counts as empty and loses his zone of control during the preview,
// e.g. so that Lunge from the destination can land on it (reported: surrounded except for the destination)
::BBTest.add("hit-chance overlay: preview vacates the current tile", function() {
	local s = setupBroNextToEnemy();
	if (s.Bro.getTile().getDistanceTo(s.Enemy.getTile()) != 1)
		yield ::BBTest.placeAt(s.Bro, s.Tile);

	local bro = s.Bro;
	local curr = bro.getTile();
	local dest = null;
	for (local i = 0; i < 6; i++)
	{
		if (curr.hasNextTile(i) && curr.getNextTile(i).IsEmpty && ::Math.abs(curr.getNextTile(i).Level - curr.Level) <= 1)
		{
			dest = curr.getNextTile(i);
			break;
		}
	}
	::BBTest.assert(dest != null, "no empty tile next to the bro");

	// ZoC probes: a neighbor of the current tile that isn't next to the destination, and the other way round
	local f = bro.getFaction();
	local onlyCurr = null, onlyDest = null;
	foreach (t in ::MSU.Tile.getNeighbors(curr))
	{
		if (t.ID != dest.ID && t.getDistanceTo(dest) > 1)
			onlyCurr = t;
	}
	foreach (t in ::MSU.Tile.getNeighbors(dest))
	{
		if (t.ID != curr.ID && t.getDistanceTo(curr) > 1)
			onlyDest = t;
	}
	local zocBefore = [onlyCurr.getZoneOfControlCount(f), onlyDest.getZoneOfControlCount(f)];
	local exerting = bro.m.IsExertingZoneOfControl;

	local lunge = ::new("scripts/skills/actives/lunge_skill");
	bro.getSkills().add(lunge);

	local overlay = ::Reforged.HitchanceOverlay;
	local tag = overlay.createPreviewTag(bro, dest);
	local during = {};
	try
	{
		overlay.applyMovementPreview(tag);
		during.CurrEmpty <- curr.IsEmpty;
		during.CurrOccupied <- curr.IsOccupiedByActor;
		during.CurrEntity <- curr.getEntity();
		during.DestEmpty <- dest.IsEmpty;
		during.DestEntityID <- dest.getEntity() == null ? -1 : dest.getEntity().getID();
		during.Zoc <- [onlyCurr.getZoneOfControlCount(f), onlyDest.getZoneOfControlCount(f)];
		// Lunge from the destination at the enemy next to the current tile may land on the current tile
		during.LungeLanding <- s.Enemy.getTile().getDistanceTo(curr) == 1 ? lunge.getDestinationTile(s.Enemy.getTile(), dest) : null;
	}
	catch (error)
	{
		overlay.cleanupMovementPreview(tag);
		lunge.removeSelf();
		bro.getSkills().update();
		throw error;
	}
	overlay.cleanupMovementPreview(tag);
	lunge.removeSelf();
	bro.getSkills().update();

	::BBTest.assert(during.CurrEmpty && !during.CurrOccupied && during.CurrEntity == null, "current tile not vacated during the preview");
	::BBTest.assert(!during.DestEmpty && during.DestEntityID == bro.getID(), "destination not occupied by the bro during the preview");
	if (exerting)
	{
		::BBTest.assertEq(zocBefore[0] - 1, during.Zoc[0], "ZoC next to the current tile not removed");
		::BBTest.assertEq(zocBefore[1] + 1, during.Zoc[1], "ZoC next to the destination not added");
	}
	::BBTest.assert(during.LungeLanding != null, "Lunge from the destination finds no landing tile");

	::BBTest.assert(!curr.IsEmpty && curr.getEntity().getID() == bro.getID(), "current tile not restored");
	::BBTest.assert(dest.IsEmpty, "destination not restored");
	::BBTest.assertEq(zocBefore[0], onlyCurr.getZoneOfControlCount(f), "ZoC next to the current tile not restored");
	::BBTest.assertEq(zocBefore[1], onlyDest.getZoneOfControlCount(f), "ZoC next to the destination not restored");
}, { Phase = ::BBTest.Phase.Tactical });

// The overlay shows only for a previewed movement, a selected hit-chance attack or a hovered player character
::BBTest.add("hit-chance overlay: subject cases", function() {
	local active = ::BBTest.getActiveEntity();
	if (active == null || !active.isPlayerControlled())
	{
		::logWarning("[BBTEST] skipped: no active player character");
		return;
	}

	local overlay = ::Reforged.HitchanceOverlay;
	local original = overlay.getMode();
	local showSetting = ::Reforged.Mod.ModSettings.getSetting("HitchanceDisplay_Shown");
	local oldShow = showSetting.getValue();
	showSetting.set("All");
	setMode("Overlay");
	::BBTest.setUnlimited(active);
	local enemy = ::BBTest.getEnemies()[0];
	if (active.getTile().getDistanceTo(enemy.getTile()) != 1)
		yield ::BBTest.placeAt(active, ::BBTest.findEmptyTileNear(enemy.getTile(), 1));
	yield ::BBTest.moveMouse(100, 60);	// over the combat log, so no tile is hovered

	local attack = null;
	foreach (s in active.getSkills().getAllSkillsOfType(::Const.SkillType.Active))
	{
		if (s.isAttack() && s.isUsingHitchance() && s.isUsable())
		{
			attack = s;
			break;
		}
	}
	local footwork = ::new("scripts/skills/actives/footwork");
	active.getSkills().add(footwork);

	local restore = setActionState(null);
	local result = {};
	{
		// Idle: no overlay
		overlay.setDirty();
		yield ::BBTest.waitFrames(20);
		result.IdleSubject <- overlay.getSubject();
		result.IdleShowing <- overlay.isShowingLabels();

		// Hovering the active character: from his current tile
		::Tactical.TurnSequenceBar.m.ActiveEntityMouseHover = active;
		local hover = overlay.getSubject();
		result.HoverMode <- hover == null ? null : hover.Mode;
		result.HoverTileOK <- hover != null && hover.Entity.getID() == active.getID() && hover.Tile.ID == active.getTile().ID;
		yield ::BBTest.waitUntil(@() ::Reforged.HitchanceOverlay.isShowingLabels(), 3000, "labels while hovering a character");
		::Tactical.TurnSequenceBar.m.ActiveEntityMouseHover = null;
		yield ::BBTest.waitUntil(@() !::Reforged.HitchanceOverlay.isShowingLabels(), 3000, "labels to go after the hover ended");

		// A selected skill that isn't a hit-chance attack: no overlay
		setActionState(::Const.Tactical.ActionState.SkillSelected, null, footwork.getID());
		result.FootworkSubject <- overlay.getSubject();

		// A selected attack: only that skill, only on its valid targets; it beats hovering
		if (attack != null)
		{
			setActionState(::Const.Tactical.ActionState.SkillSelected, null, attack.getID());
			::Tactical.TurnSequenceBar.m.ActiveEntityMouseHover = active;
			local sub = overlay.getSubject();
			result.SkillMode <- sub == null ? null : sub.Mode;
			result.SkillOK <- sub != null && sub.Skill.getID() == attack.getID() && sub.Tile.ID == active.getTile().ID;
			::Tactical.TurnSequenceBar.m.ActiveEntityMouseHover = null;
			result.Snapshot <- sub == null ? null : overlay.compute(sub);
			yield ::BBTest.waitUntil(@() ::Reforged.HitchanceOverlay.__State.Snapshot != null && ::Reforged.HitchanceOverlay.__State.Snapshot.Mode == "Skill", 3000, "labels during the skill preview");
		}
	}
	restore();
	footwork.removeSelf();
	active.getSkills().update();
	showSetting.set(oldShow);
	setMode(original);

	::BBTest.assert(result.IdleSubject == null && !result.IdleShowing, "overlay shown for the idle active character");
	::BBTest.assertEq("Hover", result.HoverMode, "hovered active character is not the subject");
	::BBTest.assert(result.HoverTileOK, "hover subject not at the character's tile");
	::BBTest.assert(result.FootworkSubject == null, "overlay shown for a selected skill without hit chance");

	if (attack == null)
	{
		::logWarning("[BBTEST] skill preview part skipped: the active character has no usable hit-chance attack");
		return;
	}
	::BBTest.assertEq("Skill", result.SkillMode, "selected attack is not the subject (or hovering beat it)");
	::BBTest.assert(result.SkillOK, "skill subject has the wrong skill or tile");
	foreach (entry in result.Snapshot.Entries)
	{
		::BBTest.assert(!::MSU.isNull(entry.ToHitSkill) && entry.ToHitSkill.getID() == attack.getID(), "entry without the selected skill");
		local t = ::Tactical.getEntityByID(entry.ID).getTile();
		::BBTest.assert(attack.isInRange(t) && attack.onVerifyTarget(active.getTile(), t), "entry for an opponent the selected skill can't target");
	}
	if (attack.isInRange(enemy.getTile()) && attack.onVerifyTarget(active.getTile(), enemy.getTile()))
		::BBTest.assert(enemy.getID() in result.Snapshot.EntriesByID, "no entry for the adjacent enemy the selected skill can target");
}, { Phase = ::BBTest.Phase.Tactical });

::BBTest.add("hit-chance overlay: corner factor follows the label size", function() {
	local overlay = ::Reforged.HitchanceOverlay;
	local setting = ::Reforged.Mod.ModSettings.getSetting("HitchanceOverlay_Scale");
	local old = setting.getValue();
	local values = [];
	foreach (s in [1.0, 0.7, 0.4])
	{
		setting.set(s);
		values.push(overlay.getCornerFactor({ Zoom = 1.0 }));
	}
	// Zoomed out beyond MaxScale: labels are smaller relative to the hexes (size 1.0 * 1.0 * 0.85)
	setting.set(1.0);
	values.push(overlay.getCornerFactor({ Zoom = 0.85 }));
	setting.set(old);

	::BBTest.assertNear(0.5, values[0], 0.001, "factor at full size");
	::BBTest.assertNear(0.3, values[1], 0.001, "factor at size 0.7");
	::BBTest.assertNear(overlay.Layout.MinCornerFactor, values[2], 0.001, "factor at size 0.4 not clamped");
	::BBTest.assertNear(0.4, values[3], 0.001, "factor when zoomed out beyond MaxScale");
}, { Phase = ::BBTest.Phase.Tactical });

// Opponents out of the player's sight (fog of war) get no entry and no label, also when they were seen before
::BBTest.add("hit-chance overlay: no labels for opponents out of sight", function() {
	local active = ::BBTest.getActiveEntity();
	if (active == null || !active.isPlayerControlled())
	{
		::logWarning("[BBTEST] skipped: no active player character");
		return;
	}

	local size = ::Tactical.getMapSize();
	local far = null;
	for (local x = 1; x < size.X - 1; x++)
	{
		for (local y = 1; y < size.Y - 1; y++)
		{
			local t = ::Tactical.getTileSquare(x, y);
			if (t.IsEmpty && !t.IsVisibleForPlayer && (far == null || t.getDistanceTo(active.getTile()) > far.getDistanceTo(active.getTile())))
				far = t;
		}
	}
	if (far == null)
	{
		::logWarning("[BBTEST] skipped: no tile out of the player's sight");
		return;
	}

	local overlay = ::Reforged.HitchanceOverlay;
	local enemy = ::BBTest.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", far);
	enemy.setDiscovered(true);	// seen before, now out of sight
	local hidden = enemy.isHiddenToPlayer();
	local snapshot = overlay.compute(makeSubject(active, "Hover", active.getTile()));
	local labelVisible = overlay.getLabelPosition(enemy, overlay.getCameraState()).visible;
	local inSnapshot = enemy.getID() in snapshot.EntriesByID;
	enemy.killSilently();

	::BBTest.assert(hidden, "an opponent out of sight is not hidden to the player");
	::BBTest.assert(!inSnapshot, "entry for an opponent out of sight");
	::BBTest.assert(!labelVisible, "label for an opponent out of sight");
}, { Phase = ::BBTest.Phase.Tactical });

// A unit above the camera level is drawn as a portrait marker (no bars): the label goes beside it (centered) or above it
::BBTest.add("hit-chance overlay: labels beside the marker of a unit above the camera level", function() {
	local size = ::Tactical.getMapSize();
	local tile = null;
	for (local x = 1; x < size.X - 1 && tile == null; x++)
	{
		for (local y = 1; y < size.Y - 1; y++)
		{
			local t = ::Tactical.getTileSquare(x, y);
			if (t.IsEmpty && t.IsVisibleForPlayer && t.Level >= 1)
			{
				tile = t;
				break;
			}
		}
	}
	if (tile == null)
	{
		::logWarning("[BBTEST] skipped: no raised tile");
		return;
	}

	local overlay = ::Reforged.HitchanceOverlay;
	local placement = ::Reforged.Mod.ModSettings.getSetting("HitchanceOverlay_Placement");
	local oldPlacement = placement.getValue();
	local enemy = ::BBTest.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", tile);
	local camera = clone overlay.getCameraState();
	camera.Level = tile.Level - 1;
	placement.set("Beside");
	local beside = overlay.getLabelPosition(enemy, camera);
	placement.set("Above");
	local above = overlay.getLabelPosition(enemy, camera);
	placement.set(oldPlacement);
	enemy.killSilently();

	local f = 1.0 / (camera.Zoom * camera.UIScale);
	local markerX = (tile.Pos.X - camera.X) * f;
	local markerY = (camera.Y - tile.Pos.Y + overlay.Vanilla.LevelOffset) * f;
	local offset = (overlay.Vanilla.MarkerRadius + overlay.Layout.MarkerGap) / camera.UIScale;
	::BBTest.assert("valign" in beside && beside.valign == "center", "label beside the marker not centered on it");
	::BBTest.assertEq("right", beside.side);
	::BBTest.assertNear(markerX + offset, beside.x, 0.5, "label not right of the marker");
	::BBTest.assertNear(markerY, beside.y, 0.5, "label not at the marker's height");
	::BBTest.assertEq("above", above.side);
	::BBTest.assertNear(markerX, above.x, 0.5, "label above not centered on the marker");
	::BBTest.assertNear(markerY - offset, above.y, 0.5, "label not just above the marker");
}, { Phase = ::BBTest.Phase.Tactical });

// No overlay outside the player's turn, also not for a hovered player character
::BBTest.add("hit-chance overlay: nothing during AI turns", function() {
	local active = ::BBTest.getActiveEntity();
	if (active == null || !active.isPlayerControlled())
	{
		::logWarning("[BBTEST] skipped: no active player character");
		return;
	}

	// The active entity stops being player-controlled as during an AI turn (synchronously, so no AI runs)
	local tsb = ::Tactical.TurnSequenceBar;
	local oldHover = tsb.m.ActiveEntityMouseHover;
	tsb.m.ActiveEntityMouseHover = active;
	local during = null, after = null;
	active.m.IsControlledByPlayer = false;
	try
	{
		during = ::Reforged.HitchanceOverlay.getSubject();
	}
	catch (error)
	{
		active.m.IsControlledByPlayer = true;
		tsb.m.ActiveEntityMouseHover = oldHover;
		throw error;
	}
	active.m.IsControlledByPlayer = true;
	after = ::Reforged.HitchanceOverlay.getSubject();
	tsb.m.ActiveEntityMouseHover = oldHover;

	::BBTest.assert(during == null, "overlay subject during an AI turn");
	::BBTest.assert(after != null && after.Mode == "Hover", "no hover subject during the player's turn");
}, { Phase = ::BBTest.Phase.Tactical });

// Opponent attack setting: Primary Attack uses the first attack in skill bar order that can reach the subject,
// Best Hit Chance the one with the highest chance
::BBTest.add("hit-chance overlay: opponent primary attack or best hit chance", function() {
	local s = setupBroNextToEnemy();
	if (s.Bro.getTile().getDistanceTo(s.Enemy.getTile()) != 1)
		yield ::BBTest.placeAt(s.Bro, s.Tile);

	// A late attack in skill bar order with the best hit chance
	local late = ::new("scripts/skills/actives/hand_to_hand");
	late.m.ID = "actives.rf_test_late_attack";	// the enemy already has a hand_to_hand skill
	late.m.Order = 100000;
	late.m.IsUsingHitchance = true;
	late.isUsable = @() true;
	late.isHidden = @() false;	// hidden while a weapon is equipped
	late.getHitchance = @( _target ) 95;
	s.Enemy.getSkills().add(late);

	local setting = ::Reforged.Mod.ModSettings.getSetting("HitchanceOverlay_EnemyAttack");
	local showSetting = ::Reforged.Mod.ModSettings.getSetting("HitchanceDisplay_Shown");
	local oldSetting = setting.getValue(), oldShow = showSetting.getValue();
	showSetting.set("All");
	local results = {};
	foreach (value in ["Primary Attack", "Best Hit Chance"])
	{
		setting.set(value);
		local snapshot = ::Reforged.HitchanceOverlay.compute(makeSubject(s.Bro, "Hover", s.Bro.getTile()));
		local entry = s.Enemy.getID() in snapshot.EntriesByID ? snapshot.EntriesByID[s.Enemy.getID()] : null;
		results[value] <- entry == null || ::MSU.isNull(entry.ToBeHitSkill) ? null : entry.ToBeHitSkill.getID();
	}
	setting.set(oldSetting);
	showSetting.set(oldShow);
	late.removeSelf();
	s.Enemy.getSkills().update();

	// The first attack in skill bar order that can reach the bro
	local primary = null;
	foreach (sk in s.Enemy.getSkills().query(::Const.SkillType.Active, false, true))
	{
		if (sk.isAttack() && sk.isUsingHitchance() && sk.isUsable() && sk.isInRange(s.Bro.getTile()) && sk.onVerifyTarget(s.Enemy.getTile(), s.Bro.getTile()))
		{
			primary = sk.getID();
			break;
		}
	}
	::BBTest.assertEq("actives.rf_test_late_attack", results["Best Hit Chance"], "Best Hit Chance didn't pick the attack with the highest chance");
	if (primary != null && primary != "actives.rf_test_late_attack")
		::BBTest.assertEq(primary, results["Primary Attack"], "Primary Attack didn't pick the first attack in skill bar order");
	else
		::logWarning("[BBTEST] primary part skipped: the enemy has no other attack that reaches the bro");
}, { Phase = ::BBTest.Phase.Tactical });

// Helpers of the tests below. Functions in a test (a generator) can't read its locals, so these live here.

// IDs of the actors whose properties the movement preview of _entity to _dest recalculated for addHitchances
local function getPreviewUpdatedIDs( _entity, _dest )
{
	local overlay = ::Reforged.HitchanceOverlay;
	local snapshot = overlay.createSnapshot(makeSubject(_entity, "Move", _dest));
	local ret = {};
	overlay.runMovementPreview(_entity, _dest, function( _tag ) {
		overlay.addHitchances(_entity, _dest, snapshot, _tag);
		foreach (id, _ in _tag.ActorsToUpdate)
			ret[id] <- true;
	});
	return ret;
}

// Runs a movement preview of _entity to _dest that throws: in the callback, or with _isUpdateFailing in the first
// preview update of _entity. Returns the error.
local function runFailingPreview( _entity, _dest, _isUpdateFailing )
{
	local overlay = ::Reforged.HitchanceOverlay;
	local container = _entity.getSkills();
	local original = container.MV_doPreviewUpdate;
	if (_isUpdateFailing)
	{
		local calls = { N = 0 };
		container.MV_doPreviewUpdate = function( _isPreviewing = true ) {
			calls.N++;
			if (calls.N == 1)
			{
				// as if a skill's onUpdate threw in the middle of the update
				this.getActor().m.MV_IsDoingPreviewUpdate = true;
				this.getActor().m.MV_IsPreviewing = _isPreviewing;
				throw "test error in the preview update";
			}
			return original.call(this, _isPreviewing);
		};
	}

	local ret = null;
	try
	{
		overlay.runMovementPreview(_entity, _dest, function( _tag ) {
			throw "test error in the preview";
		});
	}
	catch (error)
	{
		ret = error;
	}
	container.MV_doPreviewUpdate = original;
	return ret;
}

// Calls onFrame _frames times while compute throws. Returns { Compute, Log }: the number of compute calls and logged errors.
local function countComputeErrors( _frames )
{
	local overlay = ::Reforged.HitchanceOverlay;
	local originalCompute = overlay.compute;
	local originalLog = overlay.logError;
	local ret = { Compute = 0, Log = 0 };
	overlay.compute = function( _subject ) {
		ret.Compute++;
		throw "test error in compute";
	};
	overlay.logError = function( _message ) {
		ret.Log++;
	};
	overlay.__State.LastKey = null;
	try
	{
		for (local i = 0; i < _frames; i++)
			overlay.onFrame();
	}
	catch (error)
	{
		overlay.compute = originalCompute;
		overlay.logError = originalLog;
		throw error;
	}
	overlay.compute = originalCompute;
	overlay.logError = originalLog;
	return ret;
}

// ZoC counts of the faction of _entity on the tiles around its current tile and _dest during the movement preview:
// array of { ID, Expected, Actual }. The entity's ZoC moves from its current tile and its neighbors to _dest and its
// neighbors; tiles around both keep their count.
local function getPreviewZOCCounts( _entity, _dest )
{
	local overlay = ::Reforged.HitchanceOverlay;
	local f = _entity.getFaction();
	local curr = _entity.getTile();
	local tiles = {};
	foreach (center in [curr, _dest])
	{
		tiles[center.ID] <- center;
		foreach (n in ::MSU.Tile.getNeighbors(center))
			tiles[n.ID] <- n;
	}
	local before = {};
	foreach (id, t in tiles)
		before[id] <- t.getZoneOfControlCount(f);

	local isAround = @( _t, _center ) _t.ID == _center.ID || _t.getDistanceTo(_center) == 1;
	local ret = [];
	overlay.runMovementPreview(_entity, _dest, function( _tag ) {
		foreach (id, t in tiles)
		{
			local expected = before[id] + (isAround(t, _dest) ? 1 : 0) - (isAround(t, curr) ? 1 : 0);
			ret.push({ ID = id, Expected = expected, Actual = t.getZoneOfControlCount(f) });
		}
	});
	return ret;
}

::BBTest.add("hit-chance overlay: preview updates opponents the subject can target", function() {
	local s = setupBroNextToEnemy();
	if (s.Bro.getTile().getDistanceTo(s.Enemy.getTile()) != 1)
		yield ::BBTest.placeAt(s.Bro, s.Tile);

	local dest = ::BBTest.findEmptyTileNear(s.Enemy.getTile(), 1);
	::BBTest.assert(dest != null, "no destination tile");

	// Player Only: the opponent's attacks aren't checked, but its defense at the destination still needs its update
	local shownSetting = ::Reforged.Mod.ModSettings.getSetting("HitchanceDisplay_Shown");
	shownSetting.set("Player Only");
	local updated;
	try
	{
		updated = getPreviewUpdatedIDs(s.Bro, dest);
	}
	catch (error)
	{
		shownSetting.set("All");
		throw error;
	}
	shownSetting.set("All");
	::BBTest.assert(s.Enemy.getID() in updated, "the targeted opponent wasn't updated for the preview");
}, { Phase = ::BBTest.Phase.Tactical });

::BBTest.add("hit-chance overlay: preview restored after an error", function() {
	local s = setupBroNextToEnemy();
	if (s.Bro.getTile().getDistanceTo(s.Enemy.getTile()) != 1)
		yield ::BBTest.placeAt(s.Bro, s.Tile);

	local start = s.Bro.getTile();
	local dest = ::BBTest.findEmptyTileNear(s.Enemy.getTile(), 1);
	::BBTest.assert(dest != null, "no destination tile");
	local skillsBefore = s.Bro.getSkills().m.Skills.len();

	foreach (isUpdateFailing in [false, true])
	{
		local what = isUpdateFailing ? "an error in the preview update" : "an error in the preview";
		local error = runFailingPreview(s.Bro, dest, isUpdateFailing);
		::BBTest.assert(error != null, "no error passed on after " + what);
		::BBTest.assertEq(start.ID, s.Bro.getTile().ID, "getTile not restored after " + what);
		::BBTest.assertEq(skillsBefore, s.Bro.getSkills().m.Skills.len(), "terrain effects not restored after " + what);
		::BBTest.assert(!dest.Properties.has("RF_PreviewEntity") && !start.Properties.has("RF_PreviewVacated"), "preview tile properties left after " + what);
		::BBTest.assert(!s.Bro.m.MV_IsDoingPreviewUpdate && !s.Bro.m.MV_IsPreviewing, "preview update flags left after " + what);
	}
}, { Phase = ::BBTest.Phase.Tactical });

::BBTest.add("hit-chance overlay: a failing compute isn't retried every frame", function() {
	local restore = previewMoveNextToEnemy();
	if (restore == null)
	{
		::logWarning("[BBTEST] skipped: no player character active");
		return;
	}
	setMode("Overlay");

	local counts;
	try
	{
		counts = countComputeErrors(5);
	}
	catch (error)
	{
		restore();
		throw error;
	}
	restore();
	::Reforged.HitchanceOverlay.__State.LastKey = null;
	::BBTest.assertEq(1, counts.Compute, "compute retried in later frames");
	::BBTest.assertEq(1, counts.Log, "error not logged once");
	::BBTest.assert(!::Reforged.HitchanceOverlay.isShowingLabels(), "labels shown after a failing compute");
}, { Phase = ::BBTest.Phase.Tactical });

::BBTest.add("hit-chance overlay: attacks on movement need a valid target", function() {
	local s = setupBroNextToEnemy();
	if (s.Bro.getTile().getDistanceTo(s.Enemy.getTile()) != 1)
		yield ::BBTest.placeAt(s.Bro, s.Tile);

	local overlay = ::Reforged.HitchanceOverlay;
	local aoo = s.Enemy.getSkills().getAttackOfOpportunity();
	::BBTest.assert(aoo != null, "the enemy has no attack of opportunity");

	local snapshot = overlay.createSnapshot(makeSubject(s.Bro, "Move", s.Bro.getTile()));
	overlay.addLeaveAttacks(s.Bro, snapshot);
	::BBTest.assert(s.Enemy.getID() in snapshot.EntriesByID, "no attack on leaving the enemy's zone of control");

	// e.g. a height difference too large to attack
	local original = aoo.onVerifyTarget;
	aoo.onVerifyTarget = function( _originTile, _targetTile ) { return false; };
	snapshot = overlay.createSnapshot(makeSubject(s.Bro, "Move", s.Bro.getTile()));
	try
	{
		overlay.addLeaveAttacks(s.Bro, snapshot);
	}
	catch (error)
	{
		aoo.onVerifyTarget = original;
		throw error;
	}
	aoo.onVerifyTarget = original;
	::BBTest.assert(!(s.Enemy.getID() in snapshot.EntriesByID), "attack on movement although the attack can't target the bro");
}, { Phase = ::BBTest.Phase.Tactical });

::BBTest.add("hit-chance overlay: preview moves the zone of control", function() {
	local bro = ::BBTest.getPlayerBros()[0];
	::BBTest.setUnlimited(bro);
	if (!bro.m.IsExertingZoneOfControl || !bro.hasZoneOfControl())
	{
		::logWarning("[BBTEST] skipped: the bro exerts no zone of control");
		return;
	}

	local dest = ::BBTest.findEmptyTileNear(bro.getTile(), 1);
	::BBTest.assert(dest != null, "no empty tile next to the bro");
	foreach (c in getPreviewZOCCounts(bro, dest))
	{
		::BBTest.assertEq(c.Expected, c.Actual, "zone of control count during the preview on tile " + c.ID);
	}
}, { Phase = ::BBTest.Phase.Tactical });

// Runs one onFrame and returns how many times it called compute
local function computesInOneFrame()
{
	local overlay = ::Reforged.HitchanceOverlay;
	local original = overlay.compute;
	local counter = { N = 0 };
	overlay.compute = function( _subject ) {
		counter.N++;
		return original.call(this, _subject);
	};
	try
	{
		overlay.onFrame();
	}
	catch (error)
	{
		overlay.compute = original;
		throw error;
	}
	overlay.compute = original;
	return counter.N;
}

::BBTest.add("hit-chance overlay: recomputes are throttled and paused while frozen", function() {
	local restore = previewMoveNextToEnemy();
	if (restore == null)
	{
		::logWarning("[BBTEST] skipped: no player character active");
		return;
	}
	setMode("Overlay");

	local overlay = ::Reforged.HitchanceOverlay;
	local s = overlay.__State;
	local counts = {};
	try
	{
		s.LastKey = null;
		counts.NewSubject <- computesInOneFrame();
		counts.Unchanged <- computesInOneFrame();
		overlay.setDirty();
		counts.DirtyWithinInterval <- computesInOneFrame();
		s.LastComputeTime -= 2 * overlay.__RecomputeInterval;	// 32-bit floats: exactly one interval may fall short
		counts.DirtyAfterInterval <- computesInOneFrame();
		counts.IsDirtyAfter <- s.IsDirty;
		s.IsFrozen = true;
		overlay.setDirty();
		s.LastComputeTime -= 2 * overlay.__RecomputeInterval;	// 32-bit floats: exactly one interval may fall short
		counts.Frozen <- computesInOneFrame();
	}
	catch (error)
	{
		s.IsFrozen = false;
		restore();
		throw error;
	}
	s.IsFrozen = false;
	restore();

	::BBTest.assertEq(1, counts.NewSubject, "no compute for a new subject");
	::BBTest.assertEq(0, counts.Unchanged, "recomputed without a change");
	::BBTest.assertEq(0, counts.DirtyWithinInterval, "recomputed within the recompute interval");
	::BBTest.assertEq(1, counts.DirtyAfterInterval, "not recomputed when dirty after the interval");
	::BBTest.assert(!counts.IsDirtyAfter, "still dirty after the recompute");
	::BBTest.assertEq(0, counts.Frozen, "recomputed while frozen");
}, { Phase = ::BBTest.Phase.Tactical });
