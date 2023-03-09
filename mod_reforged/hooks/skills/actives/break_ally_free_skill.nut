::mods_hookExactClass("skills/actives/break_ally_free_skill", function(o) {
    local create = o.create;
    o.create = function()
    {
        create();
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 10;
    }

    // Rewrite of the vanilla function. We no longer check for a hard-coded list of effects. Instead we look for the first effect that is a "TrappedEffect" and use it for reference
	o.isHidden = function()
    {
		local actor = this.getContainer().getActor();
		if (!::Tactical.isActive()) return this.skill.isHidden();
        if (!actor.isPlacedOnMap()) return this.skill.isHidden();
        local myTile = actor.getTile();

        for (local i = 0; i < 6; i++)
        {
            if (!myTile.hasNextTile(i)) continue;
            local tile = myTile.getNextTile(i);
            if (!tile.IsOccupiedByActor) continue;
            if (!this.isValidTarget(tile.getEntity())) continue;

            // This function also automatically updates the Icons of this skill to match those of the first trapped-effect it finds
            local skill = this.getFirstTrappedEffect(tile.getEntity());
            this.m.Icon = skill.m.BreakAllyFreeIcon;
            this.m.IconDisabled = skill.m.BreakAllyFreeIconDisabled;
            this.m.Overlay = skill.m.BreakAllyFreeOverlay;
            return false;
        }
		return this.skill.isHidden();
    }

	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) return false;
        return this.isValidTarget(_targetTile.getEntity());
    }

    o.onUse = function( _user, _targetTile )
    {
        this.spawnOverlay(_user, _targetTile);
        local target = _targetTile.getEntity();
        local trappedEffect = this.getFirstTrappedEffect(target);
		local breakFree = trappedEffect.getBreakFreeSkill();    // We don't want any BreakFree skill but instead the one added by the trap effect we use as Icon reference
		if (breakFree == null) return false;    // This should never happen unless some trapped effect forgets to add the breakFree skill to its target
        breakFree.setSkillBonus(this.getContainer().getActor().getCurrentProperties().getMeleeSkill());
        breakFree.onUse(target, _targetTile);
        return true;
    }

    // New Helper Functions
	o.isValidTarget <- function( _target )
    {
        if (_target == null) return false;
        local myActor = this.getContainer().getActor();
        if (_target.isAlliedWith(myActor) == false) return false;
        if (::Math.abs(_target.getTile().Level - myActor.getTile().Level) > 1) return false;     // height difference is too great

        return (this.getFirstTrappedEffect(_target) != null);
    }

	o.getFirstTrappedEffect <- function( _target )
    {
        if (_target == null) return null;
        foreach (skill in _target.getSkills().m.Skills)
        {
            if (skill.isTrappedEffect()) return skill;
        }
        return null;
    }
});
