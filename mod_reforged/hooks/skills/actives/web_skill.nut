::mods_hookExactClass("skills/actives/web_skill", function(o) {
	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) return false;
        if (_targetTile.getEntity().getSkills().hasSkill("effects.web")) return false;  // Can't stack multiple webs... for now
		return true;
	}
});
