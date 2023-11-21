// A hidden skill that is used in conjunction with the ai_rf_bodyguard behavior
// to make an entity behave as the dedicated bodyguard of a VIP entity
this.rf_bodyguard <- ::inherit("scripts/skills/skill", {
	m = {
		VIP = null
	},
	function create()
	{
		this.m.ID = "special.rf_bodyguard";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsSerialized = false;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_Bodyguard;
	}

	function setVIP( _entity )
	{
		this.m.VIP = _entity == null ? null : ::MSU.asWeakTableRef(_entity);
	}

	function getVIP()
	{
		return this.m.VIP;
	}

	function onUpdate( _properties )
	{
		if (::MSU.isNull(this.m.VIP) || !this.m.VIP.isAlive())
		{
			this.m.VIP = null;
		}
	}
});
