// This file is a copy of fixes.nut from AutoPilot New mod by Hackflow (https://github.com/Suor/battle-brothers-mods/tree/master/autopilot)
// included into Reforged thanks to the BSD license.
if (!::Hooks.hasMod("mod_autopilot_new"))
{
	// copy of ::std.Actor from Hackflow's stdlib mod.
	// Code is adjusted for dependencies. Original code is commented out.
	local Actor = {
		function isAlive( _actor ) {
			// return !Util.isNull(_actor) && _actor.isAlive() && !_actor.isDying();
			return !::MSU.isNull(_actor) && _actor.isAlive() && !_actor.isDying();
		}
		function isValidTarget(_actor) {
			// Not using "this." to make it passable to map/filter/whatever
			// return ::std.Actor.isAlive(_actor) && _actor.isPlacedOnMap();
			return !::MSU.isNull(_actor) && _actor.isAlive() && !_actor.isDying() && _actor.isPlacedOnMap();
		}
	};

	local mod = ::Reforged.HooksMod;

	/*
					===== NOTE =====
	The following code is copied AS IS from AutoPilot New without any style or code adjustments.
	It shouLd be updated if and when the original fixes code gets updated.
	*/

	// Fix crash with skill loosing container,
	// happens when actor looses a skill while evaluating possible targets,
	// i.e. weapon breaks as a result of previous attack delayed calc.
	mod.hookTree("scripts/skills/skill", function (q) {
		q.onVerifyTarget = @(__original) function (_originTile, _targetTile) {
			if (this.m.Container == null ||  this.m.Container.isNull()) return false;
			return __original(_originTile, _targetTile);
		}
		// Wrap MSU broken weapon bug, i.e. skill loosing container between onEvaluate and onExecute
		q.use = @(__original) function (_targetTile, _forFree = false) {
			if (this.m.Container == null ||  this.m.Container.isNull()) return false;
			return __original(_targetTile, _forFree);
		}
	})

	// Fix crash after ranged actor killing somebody or enemy dying while ranged actor is thinking
	mod.hook("scripts/ai/tactical/behaviors/ai_engage_ranged", function (q) {
		local function cleanup(_b) {
			_b.m.ValidTargets = _b.m.ValidTargets.filter(@(_, t) Actor.isAlive(t.Actor));
			_b.m.PotentialDanger = _b.m.PotentialDanger.filter(@(_, a) Actor.isAlive(a));
		}

		// The problem with this is while we go through tiles a target might become invalid,
		// usually after a ranged bro shoots someone and we are evaluating his next shot
		q.selectBestTargetTile = @(__original) function (_entity, _maxRange, _considerLineOfFire, _visibleTileNeeded) {
			local ret;
			local gen = __original(_entity, _maxRange, _considerLineOfFire, _visibleTileNeeded);

			while (true) {
				cleanup(this);
				ret = resume gen;
				// Proxy "results"
				if (ret != null) return ret;
				yield ret;
			}
		}
	})

	// Fix melee target or entity breaking (dying, going out of map) between onEvaluate and onExecute
	mod.hook("scripts/ai/tactical/behaviors/ai_engage_melee", function (q) {
		q.onExecute = @(__original) function (_entity) {
			if (!Actor.isAlive(_entity)
				|| this.m.TargetActor != null && !Actor.isValidTarget(this.m.TargetActor)) return true;
			return __original(_entity);
		}
	})

	mod.hook("scripts/ai/tactical/behavior", function (q) {
		// Sometimes _tile might be 0 ???
		q.querySpearwallValueForTile = @(__original) function (_entity, _tile) {
			if (!_tile) return 0.0;
			return __original(_entity, _tile);
		}
		// Note the reverse params order
		q.hasNegativeTileEffect = @(__original) function (_tile, _entity) {
			if (!_tile) return 0.0;
			return __original(_tile, _entity);
		}

		// For player actors whether somebody is ranged or not is decided by his vision,
		// so a throwing guy in a big hat at night suddenly becomes not ranged for AI.
		// This makes 2-tile bros start to hide behind such guy :)
		q.isRangedUnit = @(__original) function (_entity) {
			if (typeof _entity == "instance" && _entity.isNull()) return false;
			if ("_autopilot" in _entity.m) {
				return _entity.m._autopilot.ranged || _entity.hasRangedWeapon();
			}
			return __original(_entity);
		}
	})

	// ai_attack_knockout.getBestTarget() tries to call .getExpectedDamage` on attack of oppotunity of
	// the _entity, if there is none combat hangs up
	mod.hook("scripts/ai/tactical/behaviors/ai_attack_knock_out", function (q) {
		q.getBestTarget = @(__original) function (_entity, _skill, _targets) {
			local skills = _entity.getSkills();
			local attackSkill = skills.getAttackOfOpportunity();
			if (attackSkill != null) return __original(_entity, _skill, _targets);

			local function mock_getAttackOfOpportunity() {
				return {
					function getActionPointCost() {return 4}
					function getExpectedDamage(target) {
						return {ArmorDamage = 0, DirectDamage = 0, HitpointDamage = 0, TotalDamage = 0}
					}
				}
			}
			local mock = {
				function getSkills() {
					return {
						getAttackOfOpportunity = mock_getAttackOfOpportunity
					}.setdelegate(skills)
				}
			}.setdelegate(_entity.get());

			return __original(mock, _skill, _targets);
		}
	})


	// The great delayed melee kill fix.
	// Same problem as with ranged kill, but the fix is more complicated - we wrap all the known
	// opponents and allies into special WeakTableRef descendant, which will save the day when
	// some code will try to access bad actor.
	mod.hook("scripts/ai/tactical/strategy", function (q) {
		q.onOpponentSighted = @(__original) function (_entity) {
			__original(ActorRef(_entity));
		}
	})
	mod.hook("scripts/ai/tactical/agent", function (q) {
		q.compileKnownAllies = @(__original) function () {
			__original();
			this.m.KnownAllies = this.m.KnownAllies.map(@(e) ::ActorRef(e));
		}
	})

	// local debugSkills = [
	//     "actives.xxitem_leftsaa_skill"
	//     "actives.cascade"
	// ]

	mod.hook("scripts/ai/tactical/behavior", function (q) {
		// q.selectSkill = @(__original) function (_potentialSkills) {
		//     local entity = this.getAgent().getActor();
		//     foreach (sid in debugSkills) {
		//         if (_potentialSkills.find(sid) == null) continue;

		//         local skill = entity.getSkills().getSkillByID(sid);
		//         if (skill != null && skill.isUsable() && skill.isAffordable()) return skill;
		//     }
		//     return __original(_potentialSkills);
		// }
		q.queryTargetValue = @(__original) function (_entity, _target, _skill = null) {
			if (!Actor.isValidTarget(_target)) return 0;
			return __original(_entity, _target, _skill);
		}
		q.queryActorTurnsNearTarget = @(__original) function (_actor, _target, _entity) {
			if (!Actor.isValidTarget(_actor) || !Actor.isValidTarget(_entity)) return {
				Turns = 9000.0
				TurnsWithAttack = 9000.0
				InZonesOfControl = false
				InZonesOfOccupation = false
			}
			return __original(_actor, _target, _entity)
		}
	})

	// local r_LastId = 0;
	local function getBound(_actor, _index) {
		local result = _actor[_index];
		if (typeof result == "function") result = result.bindenv(_actor);
		return result;
	}
	::ActorRef <- class extends WeakTableRef {
		r_Suffix = "<not-set>";

		constructor(_obj) {
			if (typeof _obj == "instance" && _obj instanceof ::WeakTableRef) {
				_obj = _obj.get()
			}
			if (_obj != null && typeof _obj != "table") throw "Passed something unexpected here";
			if (_obj != null) {
				this.WeakTable = _obj.weakref();
				// if (!("r_Id" in _obj)) _obj.r_Id <- ++r_LastId;
				this.r_Suffix = " of " + _obj.getName();// + " " + _obj.r_Id;
			}
		}

		function _get(_index) {
			if (_index in this) return this[_index];
			else if (this.WeakTable == null) {
				if (_index in ::ActorFake) {
					::logWarning("autopilot: null ActorRef, saving " + _index + this.r_Suffix);
					return getBound(::ActorFake, _index);
				}
				::logWarning("autopilot: null ActorRef, crashing " + _index + this.r_Suffix);
				throw "null ActorRef, index = " + _index + this.r_Suffix;
			}
			else {
				if (_index == "getTile" && !this.WeakTable.isPlacedOnMap()) {
					::logWarning("autopilot: bad ActorRef, saving " + _index + this.r_Suffix);
					return getBound(::ActorFake, _index);
				}
				return getBound(this.WeakTable, _index);
			}
		}
	}
	::ActorFake <- {
		function getTile() {return ::Tactical.getTileSquare(0, 0)}
		function isAlive() {return false}
		function isDying() {return true}
		function isPlacedOnMap() {return false}
		function getAlliedFactions() {return []}
		function getMoraleState() {return ::Const.MoraleState.Fleeing}
		function getAIAgent() {
			return {
				function getEngagementsDeclared(_entity) {return 0}
			}
		}
	}
}
