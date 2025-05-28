::Reforged.HooksMod.hook("scripts/skills/actives/fire_handgonne_skill", function(q) {
	q.m.AdditionalAccuracy = 10;
	q.m.AdditionalHitChance = -10;

	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 6 targets"
		});

		local rangedTooltip = this.getRangedTooltip();
		rangedTooltip[rangedTooltip.len() - 1].text += ". This chance is unaffected by objects or characters in the line of fire"

		ret.extend(rangedTooltip);

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has " + ::MSU.Text.colorPositive(ammo) + " shots left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Needs a non-empty powder bag equipped")
			});
		}

		if (!this.getItem().isLoaded())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Must be reloaded before firing again")
			});
		}

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Cannot be used because this character is [engaged|Concept.ZoneOfControl] in melee"))
			});
		}

		return ret;
	}}.getTooltip;

	q.onAnySkillUsed = @() { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}}.onAnySkillUsed;

	// Implementation of Extended AOE due to rf_take_aim_effect
	q.getAffectedTiles = @(__original) { function getAffectedTiles( _targetTile )
	{
		// For targeting beyond 2 tiles keep normal behavior
		if (_targetTile.getDistanceTo(this.getContainer().getActor().getTile()) != 2 || !this.getContainer().hasSkill("effects.rf_take_aim"))
		{
			return __original(_targetTile);
		}

		local ret = [
			_targetTile
		];
		local ownTile = this.getContainer().getActor().getTile();

		// The logic below is the same as vanilla's for adding the tiles except we condense it by using a local function
		// and increase the number of tiles that are added in each direction.

		local function addTiles( _tile, _startDir, _forwardDir, _num )
		{
			local currDir = _startDir;
			for (local i = 0; i < _num && _tile.hasNextTile(currDir); i++)
			{
				_tile = _tile.getNextTile(currDir);
				if (::Math.abs(_tile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(_tile);
				}
				currDir = _forwardDir;
			}
		}

		local dir = ownTile.getDirectionTo(_targetTile);
		addTiles(_targetTile, dir, dir, 2);

		local left = dir - 1 < 0 ? 5 : dir - 1;
		addTiles(_targetTile, left, dir, 3);

		local right = dir + 1 > 5 ? 0 : dir + 1;
		addTiles(_targetTile, right, dir, 3);

		return ret;
	}}.getAffectedTiles;
});
