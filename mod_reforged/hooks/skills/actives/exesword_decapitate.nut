::Reforged.HooksMod.hook("scripts/skills/actives/exesword_decapitate", function(q) {
	q.m.MeleeSkillAdd <- -15;
	q.create = @(__original) { function create()
	{
		__original();
		// Execute name and icon are cooler
		this.m.Name = "Execute";
		this.m.Description = "A wide, heavy swing aimed at the head to decapitate the target on the spot. Does more damage to the head. Killing the target will always decapitate it, if at all possible.";
		this.m.Icon = "skills/active_239.png";
		this.m.IconDisabled = "skills/active_239_sw.png";
		this.m.Overlay = "active_239";
		this.m.DirectDamageMult = 0.25;
		this.m.FatigueCost = 25;
		this.m.SoundOnUse = [
			"sounds/combat/overhead_strike_01.wav",
			"sounds/combat/overhead_strike_02.wav",
			"sounds/combat/overhead_strike_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/execute_hit_01.wav",
			"sounds/combat/execute_hit_02.wav",
			"sounds/combat/execute_hit_03.wav"
		];
	}}.create;

	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getDefaultTooltip();

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has up to [color=" + this.Const.UI.Color.PositiveValue + "]+100%" + "[/color] chance to hit the head depending on how wounded the target already is"
		});

		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Inflicts additional [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] damage to [Hitpoints|Concept.Hitpoints] on a hit to the head")
			}
		]);

		if (this.m.MeleeSkillAdd != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString("Has " + ::MSU.Text.colorizeValue(this.m.MeleeSkillAdd, {AddSign = true, AddPercent = true}) + " chance to hit against target not [$ $|Skill+dazed_effect], [$ $|Skill+stunned_effect], [$ $|Skill+sleeping_effect], [$ $|Skill+net_effect], [$ $|Skill+web_effect], or [$ $|Skill+rooted_effect]")
			});
		}

		return ret;
	}}.getTooltip;
    
	q.onAfterUpdate = @() { function onAfterUpdate( _properties )
	{
        // Use cleaver instead of sword
		if (_properties.IsSpecializedInCleavers)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
		}
	}}.onAfterUpdate;
    
	q.onAnySkillUsed = @() { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{	
		if (_targetEntity == null)
		{
			return;
		}

		if (_skill == this)
		{
			_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.5;
			_properties.HitChance[this.Const.BodyPart.Head] += 1.0 - _targetEntity.getHitpoints() / (_targetEntity.getHitpointsMax() * 1.0);
            _properties.MeleeSkill += this.m.MeleeSkillAdd;
            if (_targetEntity.getSkills().hasSkill("effects.dazed") || _targetEntity.getSkills().hasSkill("effects.sleeping") || _targetEntity.getSkills().hasSkill("effects.stunned") || _targetEntity.getSkills().hasSkill("effects.net") || _targetEntity.getSkills().hasSkill("effects.web") || _targetEntity.getSkills().hasSkill("effects.rooted"))
            {
                _properties.MeleeSkill -= this.m.MeleeSkillAdd;
            }
		}
	}}.onAnySkillUsed;
});
