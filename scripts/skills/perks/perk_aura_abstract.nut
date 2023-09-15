this.perk_aura_abstract <- ::inherit("scripts/skills/skill", {
	m = {
		AuraEffectScript = "",
		AuraEffectID = "",
		AuraRange = 4,
		AppliesToSelf = false
	},
	function create()
	{
		this.m.ID = "perk.aura_abstract";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return !this.isEnabled();
	}

	function getAuraRange()
	{
		return this.m.AuraRange;
	}

	function onMovementFinished( _tile )
	{
		local actor = this.getContainer().getActor();
		foreach (faction in ::Tactical.Entities.getAllInstances())
		{
			foreach (receiver in faction)
			{
				if (this.validateAuraReceiver(receiver) && (this.m.AppliesToSelf || actor.getID() != receiver.getID()))
					receiver.getSkills().update();
			}
		}
	}

	function onSpawnEntity( _entity )
	{
		// I spawned
		if (_entity.getID() == this.getContainer().getActor().getID())
		{
			foreach (receiver in ::Tactical.Entities.getAllInstancesAsArray())
			{
				if (!this.validateAuraReceiver(receiver) || (!this.m.AppliesToSelf && receiver.getID() == _entity.getID()))
					continue;

				local effect = receiver.getSkills().getSkillByID(this.m.AuraEffectID);
				if (effect == null)
				{
					effect = ::new(this.m.AuraEffectScript);
					receiver.getSkills().add(effect);
				}
				effect.registerAuraProvider(this.getContainer().getActor());
			}
		}
		// someone else spawned
		else if (this.validateAuraReceiver(_entity))
		{
			local effect = ::new(this.m.AuraEffectScript);
			_entity.getSkills().add(effect);
			effect.registerAuraProvider(this.getContainer().getActor());
		}
	}

	function onDeath( _fatalityType )
	{
		this.unregisterFromAllReceivers();
	}

	function onRemoved()
	{
		this.unregisterFromAllReceivers();
	}

	function unregisterFromAllReceivers()
	{
		foreach (faction in ::Tactical.Entities.getAllInstances())
		{
			foreach (receiver in faction)
			{
				local effect = receiver.getSkills().getSkillByID(this.m.AuraEffectID);
				if (effect != null) effect.unregisterAuraProvider(this.getContainer().getActor());
			}
		}
	}

	// Add conditions to filter which kinds of entities receive aura effect e.g. check faction, allied status etc.
	function validateAuraReceiver( _entity )
	{
		return true;
	}

	function isEnabled()
	{
		return true;
	}
});
