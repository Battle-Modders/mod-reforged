this.rf_naked <- ::inherit("scripts/skills/skill", {
	m = {
		BraveryMult = 0.5,
		ExcludedBackgrounds = [
			"background.wildman",
			"background.barbarian"
		]
	},
	function create()
	{
		this.m.ID = "special.rf_naked";
		this.m.Name = "Naked";
		this.m.Description = "This character\'s private parts are fully exposed, making it a rather nervous situation to be in.";
		this.m.Icon = "skills/rf_naked.png";
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsHidden = true;
	}

	function isHidden()
	{
		return !this.isEnabled();
	}

	function onUpdate( _properties )
	{
		if (this.isEnabled())
		{
			_properties.BraveryMult *= this.m.BraveryMult;
		}
	}

	function isEnabled()
	{
		local actor = this.getContainer().getActor();
		return ::MSU.isKindOf(actor, "player") && ::MSU.isNull(actor.getBodyItem()) && this.m.ExcludedBackgrounds.find(actor.getBackground().getID()) == null)
	}
});
