::mods_hookExactClass("skills/actives/throw_net", function(o) {
	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) return false;
        if (_targetTile.getEntity().getSkills().hasSkill("effects.net")) return false;  // Can't stack multiple nets... for now
		return true;
	}

	local onUse = o.onUse;
    o.onUse = function( _user, _targetTile )
    {
		local targetEntity = _targetTile.getEntity();
        if (targetEntity.getCurrentProperties().IsImmuneToRoot) return onUse(_user, _targetTile);
        local netEffect = this.new("scripts/skills/effects/net_effect");
        if (this.m.IsReinforced)
        {
            netEffect.m.BonusChance -= 15;     // Vanilla effect
            netEffect.m.Decal = "net_destroyed_02";
        }
        targetEntity.getSkills().add(netEffect);
        onUse(_user, _targetTile);  // The original function also tries to add a 'net_effect' but that will fail because the skill doesn't stack.
    }
});
