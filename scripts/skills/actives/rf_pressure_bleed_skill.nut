this.rf_pressure_bleed_skill <- ::inherit("scripts/skills/skill", {
    m = {
        IsSpent = false
    },

	function create()
	{
		this.m.ID = "actives.rf_pressure_bleed";
		this.m.Name = "Pressure the Bleeding";
		this.m.Description = "Apply pressure on your wound to try to stop the bleeding."
		this.m.Icon = "skills/rf_pressure_bleed_skill.png";
		this.m.IconDisabled = "skills/rf_pressure_bleed_skill_sw.png";
		this.m.Overlay = "rf_pressure_bleed_skill";
		this.m.SoundOnUse = [
			"sounds/combat/first_aid_01.wav",
			"sounds/combat/first_aid_02.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 10;
		this.m.IsHidden = true;
		// Maybe give this to enemies too? Currently only players have this skill
	}

    function isHidden()
    {
        if (this.isBleeding()) return false;
        return this.skill.isHidden();
    }

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Ignore the damage from the strongest bleeding effect this turn."
		});

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	function isUsable()
	{
		if (this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions())) return false;
		return !this.m.IsSpent && this.isBleeding() && this.skill.isUsable();
	}

	function onUse( _user, _targetTile )
	{
		this.m.IsSpent = true;
        local bleed = this.getStrongestBleed();

		// Dynamic Hook
        local oldApplyDamage = bleed.applyDamage;
        bleed.applyDamage = function()
        {
			// Switcheroo
            local player = this.getContainer().getActor();
            local oldOnDamageReceived = player[player.SuperName].onDamageReceived;	// This is a 'player.nut' but only its parent defines an onDamageReceived function
            player[player.SuperName].onDamageReceived = function (a, b, c) {};    // We temporary disable the way that those bleed effects deal their damage with
            oldApplyDamage();
            player[player.SuperName].onDamageReceived = oldOnDamageReceived;
            bleed.applyDamage = oldApplyDamage;  // We correct this dynamic hook within this function call
        }

		return true;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

    // New Functions
    function isBleeding()
    {
        local skills = this.getContainer();
		if (skills.hasSkill("effects.bleeding")) return true;
		if (skills.hasSkill("injury.cut_throat") && skills.getSkillByID("injury.cut_throat").isFresh()) return true;
		if (skills.hasSkill("injury.cut_artery") && skills.getSkillByID("injury.cut_artery").isFresh()) return true;
		if (skills.hasSkill("injury.grazed_neck") && skills.getSkillByID("injury.grazed_neck").isFresh()) return true;
        return false;
    }

    function getStrongestBleed()
    {
        local strongestBleed = null;
        local strongestAmount = 0;
        foreach (effect in this.getContainer().m.Skills)
        {
            local bleedDamage = this.getBleedDamage(effect)
            if (bleedDamage > strongestAmount)
            {
                strongestBleed = effect;
                strongestAmount = bleedDamage;
            }
        }
        return strongestBleed;
    }

    function getBleedDamage( _effect )
    {
		if (_effect.getID() == "injury.cut_throat") return 6;
		if (_effect.getID() == "injury.cut_artery") return 3;
		if (_effect.getID() == "injury.grazed_neck") return 1;
		if (_effect.getID() == "effects.bleeding") return _effect.getDamage();
        return 0;
    }
});
