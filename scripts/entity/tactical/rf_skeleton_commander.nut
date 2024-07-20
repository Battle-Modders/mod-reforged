this.rf_skeleton_commander <- ::inherit("scripts/entity/tactical/skeleton", {
	m = {},
	function create()
	{
		this.skeleton.create();
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_skeleton_commander_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		local addSprite = this.addSprite;
		this.addSprite = function( _sprite )
		{
			if (_sprite == "armor")
			{
				local ret = addSprite(_sprite);
				this.addSprite("rf_cape");
				return ret;
			}
			return addSprite(_sprite);
		}
		this.skeleton.onInit();
		this.addSprite = addSprite;
	}

	function onFactionChanged()
	{
		this.skeleton.onFactionChanged();
		this.getSprite("rf_cape").setHorizontalFlipping(!this.isAlliedWithPlayer());
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		this.skeleton.onDeath(_killer, _skill, _tile, _fatalityType);
		if (_tile != null)
		{
			local decal = _tile.spawnDetail("rf_ancient_cape_dead", ::Const.Tactical.DetailFlag.Corpse, this.m.IsCorpseFlipped, false, ::Const.Combat.HumanCorpseOffset);
			decal.Scale = 0.9;
		}
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		local ret = this.skeleton.onDamageReceived(_attacker, _skill, _hitInfo);
		if (this.isAlive() && this.isPlacedOnMap())
		{
			local armor = this.getBodyItem();
			if (armor != null && armor.getCondition() / armor.getConditionMax() <= ::Const.Combat.ShowDamagedArmorThreshold)
			{
				this.getSprite("rf_cape").setBrush("rf_ancient_cape_damaged");
			}
		}
		return ret;
	}
});
