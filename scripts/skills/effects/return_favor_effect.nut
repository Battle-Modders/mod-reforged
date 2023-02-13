// No rf_ prefix because this filename and skill ID are used in vanilla code but the effect file doesn't exist in vanilla
this.return_favor_effect <- ::inherit("scripts/skills/skill", {
	m = {
		StunChance = 10,
		DazeChance = 50,
		StaggerChance = 75
	},
	function create()
	{
		// No rf_ prefix because this filename and skill ID are used in vanilla code but the effect file doesn't exist in vanilla
		this.m.ID = "effects.return_favor";
		this.m.Name = "Return Favor";
		this.m.Description = "This character will return any missed melee attacks from adjacent attackers with a jolting bash.";
		this.m.Icon = "skills/rf_return_favor_effect.png";
		this.m.IconMini = "rf_return_favor_effect_mini";
		this.m.Overlay = "rf_return_favor_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Any adjacent attacker who misses a melee attack against this character has a " + ::MSU.Text.colorGreen(this.m.StunChance + "%") + " chance to be Stunned, " + ::MSU.Text.colorGreen(this.m.DazeChance + "%") + " chance to be Dazed and " + ::MSU.Text.colorGreen(this.m.StaggerChance + "%") + " chance to be Staggered"
		});

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && !weapon.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Requires being unarmed or armed with a melee weapon")
			});
		}

		return tooltip;
	}

	function onMissed( _attacker, _skill )
	{
		if (!_skill.isRanged())
		{
			local actor = this.getContainer().getActor();
			local weapon = actor.getMainhandItem();
			if (weapon != null && !weapon.isItemType(::Const.Items.ItemType.MeleeWeapon)) return;

			local distance = _attacker.getTile().getDistanceTo(actor.getTile());
			if (distance == 1 || (weapon != null && weapon.getRangeMax() >= distance))
			{
				local r = ::Math.rand(1, 100);

				if (r <= this.m.StunChance && !_attacker.getCurrentProperties().IsImmuneToStun)
				{
					local effect = ::new("scripts/skills/effects/stunned_effect");
					effect.addTurns(1);
					_attacker.getSkills().add(effect);
					if (!actor.isHiddenToPlayer() && _attacker.getTile().IsVisibleForPlayer)
					{
						::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has stunned " + ::Const.UI.getColorizedEntityName(_attacker) + " for one turn");
					}
				}
				else if (r <= this.m.DazeChance && !_attacker.getCurrentProperties().IsImmuneToDaze)
				{
					_attacker.getSkills().add(::new("scripts/skills/effects/dazed_effect"));
					if (!actor.isHiddenToPlayer() && _attacker.getTile().IsVisibleForPlayer)
					{
						::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has dazed " + ::Const.UI.getColorizedEntityName(_attacker) + " for one turn");
					}
				}
				else if (r <= this.m.StaggerChance)
				{
					_attacker.getSkills().add(::new("scripts/skills/effects/staggered_effect"));
					if (!actor.isHiddenToPlayer() && _attacker.getTile().IsVisibleForPlayer)
					{
						::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has staggered " + ::Const.UI.getColorizedEntityName(_attacker) + " for one turn");
					}
				}
			}
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}
});
