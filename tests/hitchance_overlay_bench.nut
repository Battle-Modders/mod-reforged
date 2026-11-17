// Benchmark of ::Reforged.HitchanceOverlay in a large battle. Registered only when the runner's filter contains
// "bench" (python -I bb_test.py --mod <mod_reforged> --filter bench), as it starts its own large combat.
// Besides the timings (BENCH rows, compared with --save-bench baselines) it logs a FINGERPRINT of every result,
// which tuning must leave unchanged; the POSITIONS row shows that two runs measured the same scene.
if (::BBTest.Config.Filter.find("bench") == null)
	return;

local function join( _array )
{
	local ret = "";
	foreach (i, s in _array)
		ret += (i == 0 ? "" : " ") + s;
	return ret;
}

local function fingerprint( _snapshot )
{
	local skillID = @( _ref ) ::MSU.isNull(_ref) ? "-" : _ref.get().getID();
	local attack = @( _a ) _a == null ? "-" : _a.Hitchance + "/" + skillID(_a.Skill);
	local rows = [];
	foreach (entry in _snapshot.Entries)
	{
		local tile = ::Tactical.getEntityByID(entry.ID).getTile();
		rows.push(format("%i,%i:%s/%s|%s/%s|%s|%s", tile.SquareCoords.X, tile.SquareCoords.Y,
			entry.ToHit + "", skillID(entry.ToHitSkill), entry.ToBeHit + "", skillID(entry.ToBeHitSkill), attack(entry.LeaveAttack), attack(entry.ArriveAttack)));
	}
	rows.sort();
	return join(rows);
}

::BBTest.add("hitchance overlay bench: large battle", function() {
	local overlay = ::Reforged.HitchanceOverlay;
	::Reforged.Mod.ModSettings.getSetting("HitchanceDisplay_Mode").set("Overlay");
	::Reforged.Mod.ModSettings.getSetting("HitchanceDisplay_Shown").set("All");
	local enemyAttack = ::Reforged.Mod.ModSettings.getSetting("HitchanceOverlay_EnemyAttack");
	local oldEnemyAttack = enemyAttack.getValue();

	// Status effects with mini icons on every opponent
	local enemies = ::BBTest.getEnemies();
	foreach (e in enemies)
	{
		foreach (eff in ["adrenaline_effect", "dodge_effect", "iron_will_effect", "night_vision_effect", "double_strike_effect"])
			e.getSkills().add(::new("scripts/skills/effects/" + eff));
		e.getSkills().update();
	}

	// The bro closest to the opponents and a destination tile next to the opponent closest to him
	local bro = null, target = null;
	foreach (b in ::BBTest.getPlayerBros())
	{
		foreach (e in enemies)
		{
			if (bro == null || b.getTile().getDistanceTo(e.getTile()) < bro.getTile().getDistanceTo(target.getTile()))
			{
				bro = b;
				target = e;
			}
		}
	}
	::BBTest.setUnlimited(bro);
	if (bro.getTile().getDistanceTo(target.getTile()) != 1)
		yield ::BBTest.placeAt(bro, ::BBTest.findEmptyTileNear(target.getTile(), 1));
	// No AI may act while measuring: the scene must stay the same (POSITIONS shows whether it did before)
	::Tactical.State.setPause(true);
	local dest = ::BBTest.findEmptyTileNear(target.getTile(), 1);
	local attack = null;
	foreach (s in bro.getSkills().getAllSkillsOfType(::Const.SkillType.Active))
	{
		if (s.isAttack() && s.isUsingHitchance() && s.isInRange(target.getTile()))
		{
			attack = s;
			break;
		}
	}

	local positions = [];
	foreach (a in ::Tactical.Entities.getAllInstancesAsArray())
		positions.push(a.getTile().SquareCoords.X + "," + a.getTile().SquareCoords.Y);
	positions.sort();
	::BBTest.log(format("POSITIONS units %i, opponents %i, bro %i,%i, dest %i,%i: %s", positions.len(), enemies.len(),
		bro.getTile().SquareCoords.X, bro.getTile().SquareCoords.Y, dest.SquareCoords.X, dest.SquareCoords.Y, join(positions)));

	local ctx = { o = overlay, b = bro, d = dest, s = attack };
	ctx.hover <- { Entity = bro, Mode = "Hover", IsPreview = false, Tile = bro.getTile(), Skill = null };
	ctx.skill <- { Entity = bro, Mode = "Skill", IsPreview = false, Tile = bro.getTile(), Skill = attack };
	ctx.move <- { Entity = bro, Mode = "Move", IsPreview = true, Tile = dest, Skill = null };

	foreach (mode in ["Primary Attack", "Best Hit Chance"])
	{
		enemyAttack.set(mode);
		local tag = mode == "Primary Attack" ? "primary" : "best";
		foreach (kind in ["hover", "skill", "move"])
		{
			::BBTest.log(format("FINGERPRINT %s %s: %s", kind, tag, fingerprint(overlay.compute(ctx[kind]))));
			ctx.kind <- kind;
			::BBTest.bench(format("hitchance overlay: compute %s (%s, %i opponents)", kind, tag, enemies.len()), function() {
				this.o.compute(this[this.kind]);
			}.bindenv(ctx), 20);
		}
	}
	enemyAttack.set(oldEnemyAttack);

	overlay.__State.Snapshot = overlay.compute(ctx.move);
	ctx.c <- overlay.getCameraState();
	::BBTest.bench("hitchance overlay: getLabelsUIData", function() { this.o.getLabelsUIData(this.c); }.bindenv(ctx), 50);
	::BBTest.bench("hitchance overlay: getLabelPositions", function() { this.o.getLabelPositions(this.c); }.bindenv(ctx), 50);
	overlay.__State.Snapshot = null;

	::Tactical.State.setPause(false);
}, { Phase = ::BBTest.Phase.Tactical, Battle = { Enemies = { Units = [
	{ Troop = "BanditRaider", Num = 10 }, { Troop = "BanditMarksman", Num = 6 }, { Troop = "OrcWarrior", Num = 6 },
	{ Troop = "OrcYoung", Num = 6 }, { Troop = "Direwolf", Num = 4 }, { Troop = "GoblinAmbusher", Num = 4 },
	{ Troop = "Footman", Num = 4 }, { Troop = "Arbalester", Num = 4 }
] } } });
