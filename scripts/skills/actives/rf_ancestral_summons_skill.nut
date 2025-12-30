this.rf_ancestral_summons_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Barrows = [],
		// Weighted Container that is set up during at combat start based on  party composition.
		PossibleSpawns = null
	},
	function create()
	{
		this.m.ID = "actives.rf_ancestral_summons";
		this.m.Name = "Ancestral Summons";
		this.m.Description = "Call upon a buried Barrowkin to rise and join you in battle.";
		this.m.Icon = "skills/rf_ancestral_summons_skill.png";
		this.m.IconDisabled = "skills/rf_ancestral_summons_skill_sw.png";
		this.m.Overlay = "rf_ancestral_summons_skill";
		this.m.SoundOnHit = [
			"sounds/enemies/rf_ancestral_summons_skill_01.wav",
			"sounds/enemies/rf_ancestral_summons_skill_02.wav",
			"sounds/enemies/rf_ancestral_summons_skill_03.wav"
		];
		this.m.SoundVolume = 1.2;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 99;
		this.m.MaxLevelDifference = 4;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_AncestralSummons;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({id = 10,	type = "text",	icon = "ui/icons/special.png",	text = "Can target any barrows on the map"});
		ret.push({id = 11,	type = "text",	icon = "ui/icons/warning.png",	text = "Cannot be used on the same barrow twice"});
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile) || _targetTile.IsEmpty)
		{
			return false;
		}

		local target = _targetTile.getEntity();
		if (!::isKindOf(target, "rf_barrows") || target.isSpent())
		{
			return false;
		}

		return ::MSU.Tile.getNeighbors(_targetTile).filter(@(_, _t) _t.IsEmpty && _t.Level == _targetTile.Level).len() != 0;
	}

	function onUse( _user, _targetTile )
	{
		local adjacentTiles = ::MSU.Tile.getNeighbors(_targetTile).filter(@(_, _t) _t.IsEmpty && _t.Level == _targetTile.Level);
		if (adjacentTiles.len() == 0)
			return false;

		if (_targetTile.IsVisibleForPlayer)
		{
			if (::Const.Tactical.RaiseUndeadParticles.len() != 0)
			{
				for( local i = 0; i < ::Const.Tactical.RaiseUndeadParticles.len(); i = ++i )
				{
					::Tactical.spawnParticleEffect(true, ::Const.Tactical.RaiseUndeadParticles[i].Brushes, _targetTile, ::Const.Tactical.RaiseUndeadParticles[i].Delay, ::Const.Tactical.RaiseUndeadParticles[i].Quantity, ::Const.Tactical.RaiseUndeadParticles[i].LifeTimeQuantity, ::Const.Tactical.RaiseUndeadParticles[i].SpawnRate, ::Const.Tactical.RaiseUndeadParticles[i].Stages);
				}
			}

			if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses " + this.getName());

				if (this.m.SoundOnHit.len() != 0)
				{
					::Sound.play(::MSU.Array.rand(this.m.SoundOnHit), ::Const.Sound.Volume.Skill * 1.2, _user.getPos());
				}
			}
		}

		_targetTile.getEntity().setSpent(true);

		this.spawnUndead(_user, ::MSU.Array.rand(adjacentTiles));
		return true;
	}

	function spawnUndead( _user, _tile )
	{
		local script = this.m.PossibleSpawns.roll();

		// Halve the weight of the rolled spawn type so that
		// subsequent spawns are less likely to be this type.
		this.m.PossibleSpawns.setWeight(script, this.m.PossibleSpawns.getWeight(script) * 0.5);

		local e = ::Tactical.spawnEntity(script, _tile.Coords.X, _tile.Coords.Y);
		if (e != null)
		{
			e.setFaction(_user.getFaction());
			e.assignRandomEquipment();
			e.riseFromGround();
			e.playSound(::Const.Sound.ActorEvent.Resurrect, ::Const.Sound.Volume.Actor * e.m.SoundVolume[::Const.Sound.ActorEvent.Resurrect] * e.m.SoundVolumeOverall);
		}
	}

	function onActorSpawned( _actor )
	{
		if (::MSU.isEqual(_actor, this.getContainer().getActor()))
		{
			this.m.Barrows.clear();

			local mapSize = ::Tactical.getMapSize();
			local width = mapSize.X - 1;
			local height = mapSize.Y - 1;

			for (local x = 1; x < width; x++)
			{
				for (local y = 1; y < height; y++)
				{
					local tile = ::Tactical.getTileSquare(x, y);
					if (!tile.IsEmpty && ::isKindOf(tile.getEntity(), "rf_barrows"))
					{
						this.m.Barrows.push(tile.getEntity());
					}
				}
			}

			this.setupPossibleSpawns();
		}
	}

	function setupPossibleSpawns()
	{
		this.m.PossibleSpawns = ::MSU.Class.WeightedContainer();

		local count = 0;
		local maxXP = 0;
		local maxXPScript;

		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction()))
		{
			if (!::isKindOf(ally, "rf_draugr") || ally.ClassName == "rf_draugr_shaman")
			{
				continue;
			}

			this.m.PossibleSpawns.add("scripts/entity/tactical/enemies/" + ally.ClassName);
			local xp = ally.getXPValue();
			if (xp > maxXP)
			{
				count++;
				maxXP = xp;
				maxXPScript = ::IO.scriptFilenameByHash(ally.ClassNameHash);
			}
		}

		// Remove the highest tier as a possible spawn
		if (count > 1)
		{
			this.m.PossibleSpawns.remove(maxXPScript);
		}

		// Failsafe to have some possible spawns if no allies were found.
		if (this.m.PossibleSpawns.len() == 0)
		{
			this.m.PossibleSpawns.addMany(1, [
				"scripts/entity/tactical/enemies/rf_draugr_thrall",
				"scripts/entity/tactical/enemies/rf_draugr_warrior",
				"scripts/entity/tactical/enemies/rf_draugr_huskarl",
			]);
		}
	}

	function getBarrows()
	{
		return this.m.Barrows;
	}
});
