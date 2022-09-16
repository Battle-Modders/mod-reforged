this.perk_rf_swordmaster_juggernaut <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {
		Target = null
	},
	function create()
	{
		this.perk_rf_swordmaster_abstract.create();
		this.m.ID = "perk.rf_swordmaster_juggernaut";
		this.m.Name = ::Const.Strings.PerkName.RF_SwordmasterJuggernaut;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SwordmasterJuggernaut;
		this.m.Icon = "ui/perks/rf_swordmaster_juggernaut.png";
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		local ret = this.perk_rf_swordmaster_abstract.isEnabled();
		if (ret)
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			if (weapon.isItemType(::Const.Items.ItemType.RF_Fencing) || !weapon.isItemType(::Const.Items.ItemType.TwoHanded)) return false;
		}

		return ret;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_swordmaster_charge_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_swordmaster_charge");
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (this.m.Target != null || !_skill.isAttack() || _skill.isAOE() || !this.isEnabled())
		{
			this.m.Target = null;
			return;
		}

		this.m.Target = null;

		local targetTile = _targetEntity.getTile();

		local targets = [];

		for (local i = 0; i < 6; i++)
		{
			if (targetTile.hasNextTile(i))
			{
				local nextTile = targetTile.getNextTile(i);
				if (nextTile.IsOccupiedByActor)
				{
					local entity = nextTile.getEntity();
					if (!entity.isAlliedWith(this.getContainer().getActor())) targets.push(entity);
				}
			}
		}

		this.m.Target = ::MSU.Array.rand(targets);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.Target != null)
		{
			_skill.onUse(this.getContainer().getActor(), this.m.Target.getTile());
			this.m.Target = null;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.Target != null)
		{
			_properties.DamageTotalMult *= 0.5;
		}
	}

	function onCombatStarted()
	{
		this.perk_rf_swordmaster_abstract.onCombatStarted();
		this.m.Target = null;
	}

	function onCombatFinished()
	{
		this.perk_rf_swordmaster_abstract.onCombatFinished();
		this.m.Target = null;
	}
});
