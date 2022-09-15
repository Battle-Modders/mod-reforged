this.perk_rf_feral_rage <- ::inherit("scripts/skills/skill", {
	m = {
		RageStacks = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_feral_rage";
		this.m.Name = ::Const.Strings.PerkName.RF_FeralRage;
		this.m.Description = "The smell of blood and death sends you into an uncontrollable rage. Every taste of blood your weapon takes, every kill you make, and every hit you receive emboldens you and increases your lethality. Once in a rage, you must continuously feed it to keep it going.";
		this.m.Icon = "ui/perks/rf_feral_rage.png";
		this.m.IconMini = "rf_feral_rage_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.SoundOnUse = [
			"sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		];
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.RageStacks == 0;
	}

	function getName()
	{
		return this.m.RageStacks > 1 ? this.m.Name + " (x" + this.m.RageStacks + ")" : this.m.Name;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.RageStacks + "[/color] Damage in Melee"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Only receive [color=" + ::Const.UI.Color.PositiveValue + "]" + (100 - ::Math.min(70, 2 * this.m.RageStacks)) + "%[/color] of incoming damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.RageStacks + "[/color] Resolve"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.RageStacks + "[/color] Initiative"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-" + this.m.RageStacks + "[/color] Melee Defense"
			}
		]);

		local str = "";

		if (this.m.RageStacks >= 5)
		{
			tooltip.push({
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]33%[/color] chance to resist physical status effects such as Staggered, " + (this.m.RageStacks < 7 ? "Stunned, " : "") + "Distracted, and Withered"
			});

			str += "[color=" + ::Const.UI.Color.PositiveValue + "]Immune[/color] to being Dazed";
		}
		if (this.m.RageStacks >= 7)
		{
			str += this.m.RageStacks < 10 ? " or Stunned" : ", Stunned, Knocked Back or Grabbed"
		}

		if (str != "")
		{
			tooltip.push({
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = str
			});
		}

		return tooltip;
	}

	function addRage( _r )
	{
		this.m.RageStacks += _r;
		local actor = this.getContainer().getActor();

		if (!actor.isHiddenToPlayer())
		{
			::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Actor, this.getContainer().getActor().getPos(), ::Math.rand(100, 115) * 0.01 * this.getContainer().getActor().getSoundPitch());
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " gains rage!");
		}
	}

	function onUpdate( _properties )
	{
		_properties.DamageReceivedTotalMult *= ::Math.maxf(0.3, 1.0 - 0.02 * this.m.RageStacks);
		_properties.Bravery += this.m.RageStacks;		
		_properties.Initiative += this.m.RageStacks;
		_properties.MeleeDefense -= this.m.RageStacks;
		if (this.m.RageStacks >= 5)
		{
			_properties.IsImmuneToDaze = true;
			_properties.IsResistantToPhysicalStatuses = true;
		}
		if (this.m.RageStacks >= 8)
		{
			_properties.IsImmuneToStun = true;
		}
		if (this.m.RageStacks >= 10)
		{
			_properties.IsImmuneToKnockBackAndGrab = true;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!_skill.isRanged())
		{
			_properties.DamageRegularMin += this.m.RageStacks;
			_properties.DamageRegularMax += this.m.RageStacks;
		}
	}

	function onTurnStart()
	{
		this.m.RageStacks = ::Math.max(0, this.m.RageStacks - 2);
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		this.addRage(1);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_skill.isRanged() && _targetEntity.isAlive() && !_targetEntity.isDying() && _targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile()) == 1)
		{
			local rage = _skill.getBaseValue("ActionPointCost") > 4 ? 2 : 1;
			this.addRage(rage);
		}
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		if (!_skill.isRanged())
		{
			this.addRage(3);
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.RageStacks = 0;
	}
});
