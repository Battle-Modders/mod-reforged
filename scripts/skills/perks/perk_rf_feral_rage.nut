this.perk_rf_feral_rage <- ::inherit("scripts/skills/skill", {
	m = {
		RageStacks = 0,
		RageStacksPerTurn = -1,
		PerStackBraveryModifier = 2,
		PerStackInitiativeModifier = 2,
		PerStackMeleeDefenseModifier = -1,
		PerStackDamageMult = 0.03,
		PerStackDamageReductionMult = 0.03,
		MaxDamageReductionMult = 0.3
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
				text = ::MSU.Text.colorizeMult(this.m.RageStacks * this.m.PerStackDamageMult) + " increased melee damage"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::MSU.Text.colorizeMult(::Math.maxf(this.m.MaxDamageReductionMult, 1.0 - this.m.RageStacks * this.m.PerStackDamageReductionMult), {InvertColor = true}) + " reduced damage received"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.RageStacks * this.m.PerStackBraveryModifier) + " [Resolve|Concept.Bravery]")
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.RageStacks * this.m.PerStackInitiativeModifier) + " [Initiative|Concept.Initiative]")
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.RageStacks * this.m.PerStackMeleeDefenseModifier) + " [Melee Defense|Concept.MeleeDefense]")
			}
		]);

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
		_properties.DamageReceivedTotalMult *= ::Math.maxf(this.m.MaxDamageReductionMult, 1.0 - this.m.PerStackDamageReductionMult * this.m.RageStacks);
		_properties.Bravery += this.m.RageStacks * this.m.PerStackBraveryModifier;
		_properties.Initiative += this.m.RageStacks * this.m.PerStackInitiativeModifier;
		_properties.MeleeDefense += this.m.RageStacks * this.m.PerStackMeleeDefenseModifier;
		_properties.MeleeDamageMult *= 1.0 + this.m.RageStacks * this.m.PerStackDamageMult;
	}

	function onTurnStart()
	{
		this.m.RageStacks = ::Math.max(0, this.m.RageStacks + this.m.RageStacksPerTurn);
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		this.addRage(2);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_skill.isRanged() && _targetEntity.isAlive() && !_targetEntity.isDying() && _targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile()) == 1)
		{
			this.addRage(2);
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
