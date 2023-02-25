// This skill already exists in Vanilla. We rework this skill while keeping the ID the same so only our version will be added.

this.rf_break_free_skill <- this.inherit("scripts/skills/skill", {
	m = {
        // Public
        StagesRemovedPerUse = 1,

        // Private
		SkillBonus = null,  // Hacky vanilla solution to use MeleeSkill from allies when they try to free this actor
        TrappedEffect = null        // Weakref to the effect which caused this skill to be added. Important when multiple Trapped-Effects are present
	},

	function create()
	{
		this.m.ID = "actives.break_free";
		this.m.Name = "Break Free";
		this.m.Description = "Use everything at your disposal to free yourself from what is holding you in place. Hack, slash, cut or gnaw at it if need be!";
		this.m.Icon = "skills/active_15.png";
		this.m.IconDisabled = "skills/active_15_sw.png";
		this.m.Overlay = "active_15";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.BeforeLast;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 10;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
        ret.push({
            id = 4,
            type = "text",
            icon = "ui/icons/melee_skill.png",
            text = "Has a " + ::MSU.Text.colorGreen(this.getChance() + "%") + " chance to succeed, based on Melee Skill. Each failed attempt will increase the chance to succeed for subsequent attempts."
        });
        return ret;
	}

	function setSkillBonus( _d )
	{
		this.m.SkillBonus = _d;
	}

	function getChance()
	{
        if (this.getContainer().hasSkill("effects.goblin_shaman_potion")) return 100;
        local meleeSkill = (this.m.SkillBonus == null) ? this.getContainer().getActor().getCurrentProperties().getMeleeSkill() : this.m.SkillBonus;
		return ::Math.min(100, meleeSkill + this.m.TrappedEffect.m.BonusChance);
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		::Tactical.EventLog.log_newline();

		local chance = this.getChance();
        this.m.SkillBonus = null;   // We reset this variable again because it was only used temporarily during getChance().

		local rolled = ::Math.rand(1, 100);
        local chanceMessage = " (Chance: " + chance + ", Rolled: " + rolled + ")";
		if (rolled > chance)
        {
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_user) + " fails to break free" + chanceMessage);
			this.m.TrappedEffect.m.BonusChance += this.m.TrappedEffect.m.BonusChancePerFail;
			return false;
        }
        this.m.TrappedEffect.decreaseStages(this.m.StagesRemovedPerUse, chanceMessage);
        _user.setDirty(true);
        return true;
	}
});

