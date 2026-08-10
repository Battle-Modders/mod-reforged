this.rf_beckoned_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		OriginalFaction = 0,
		OriginalAgent = null,
		OriginalSocket = null,
		Master = null,
		MovementAPCostAdditional = 1,
		FlippedBackBeforeCharm = false
	},

	function setMaster( _f )
	{
		this.m.Master = _f;
	}

    function getCharmer()
    {
        return this.m.Master.getContainer().getActor();
    }

	function create()
	{
		this.m.ID = "effects.rf_beckoned";
		this.m.Name = "Beckoned";
        // TODO: different icon for this stage of charmed
		this.m.Icon = "skills/status_effect_85.png";
		this.m.IconMini = "status_effect_85_mini";
		this.m.Overlay = "status_effect_85";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/hexe_charm_chimes_01.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_02.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_03.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_04.wav"
		];
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has been beckoned. He no longer has any control over his actions and will slowly move towards his master. Wears off in [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] turn(s) or until he reaches his master and become charmed.\n\nThe higher a character\'s resolve, the higher the chance to resist being beckoned.";
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

        ret.push({
			id = 9,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = "This character is uncontrollable and moves towards his master, on reaching his destination he will be charmed."
		});

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative(this.m.MovementAPCostAdditional) + " additional [Action Points|Concept.ActionPoints] per tile moved")
		});

        ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = "Ignores zone of control and moves through enemies."
		});

		return ret;
	}

	function addTurns( _t )
	{
		this.m.TurnsLeft += _t;
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(1, 1 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		local actor = this.getContainer().getActor();

        // Stagger
        this.Tactical.TurnSequenceBar.pushEntityBack(actor.getID());

        // Change to special agent for ai controlled units too
        this.m.OriginalAgent = actor.getAIAgent();
        actor.setAIAgent(this.new("scripts/ai/tactical/agents/rf_beckoned_player_agent"));
        actor.getAIAgent().setActor(actor);

        // Swap to special faction
		this.m.OriginalFaction = actor.getFaction();
		local beckoned_faction = ::World.FactionManager.getFactionOfType(::Const.FactionType.RF_Beckoned);
		actor.setFaction(beckoned_faction);
		this.logDebug(actor.getName() + " temporarily changed to faction " + beckoned_faction.getName() + " with id " + beckoned_faction.getID() +  " from faction " + this.m.OriginalFaction )
		this.m.OriginalSocket = actor.getSprite("socket").getBrush().Name;
		actor.getSprite("socket").setBrush("bust_base_beasts");
		actor.setDirty(true);

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill * 1.0, actor.getPos());
		}

		local effect = {
			Delay = 0,
			Quantity = 50,
			LifeTimeQuantity = 50,
			SpawnRate = 1000,
			Brushes = [
				"effect_heart_01"
			],
			Stages = [
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 1.0,
					ColorMin = this.createColor("fff3e50f"),
					ColorMax = this.createColor("ffffff5f"),
					ScaleMin = 0.5,
					ScaleMax = 0.5,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = this.createVec(-0.5, 0.0),
					DirectionMax = this.createVec(0.5, 1.0),
					SpawnOffsetMin = this.createVec(-30, -70),
					SpawnOffsetMax = this.createVec(30, 30),
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("fff3e500"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.1,
					ScaleMax = 0.1,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = this.createVec(-0.5, 0.0),
					DirectionMax = this.createVec(0.5, 1.0),
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		};
		this.Tactical.spawnParticleEffect(false, effect.Brushes, actor.getTile(), effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByDyingAllies = false;
		_properties.IsAffectedByLosingHitpoints = false;
		_properties.MovementAPCostAdditional += this.m.MovementAPCostAdditional;

        // Charm when 1 tile with master
		if (this.m.Master == null)
			return;

		local actor = this.getContainer().getActor();
        local charmer = this.getCharmer();
		if (actor.isPlacedOnMap() && charmer.isPlacedOnMap())
		{
			local myTile = actor.getTile();
			local charmerTile = charmer.getTile();
            if (charmerTile.getDistanceTo(myTile) == 1)
            {
				this.m.FlippedBackBeforeCharm = true;
				// flip back agent to use charmed player agent
				if (this.m.OriginalAgent != null && !this.m.FlippedBackBeforeCharm)
				{
					actor.setAIAgent(this.m.OriginalAgent);
				}
				// no saves
				local charmed = this.new("scripts/skills/effects/charmed_effect");
				charmed.setMasterFaction(charmer.getFaction() == this.Const.Faction.Player ? this.Const.Faction.PlayerAnimals : charmer.getFaction());
				charmed.setMaster(charmer.getSkills().getSkillByID("actives.charm"));
				actor.getSkills().add(charmed);
            }
		}

		// Sprite
		if (this.m.TurnsLeft != 0)
			{
				if (actor.hasSprite("status_beckoned") && !this.getContainer().hasSkill("effects.stunned"))
				{
					actor.getSprite("status_beckoned").Visible = true;
				}

				actor.setDirty(true);
			}
			else
			{
				if (actor.hasSprite("status_beckoned"))
				{
					actor.getSprite("status_beckoned").Visible = false;
				}

				actor.setDirty(true);
			}
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		// only flip back when not charmed
		if (!actor.getSkills().hasSkill("effects.charmed"))
		{		
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill * 1.0, actor.getPos());
			}

			if (this.m.OriginalAgent != null)
			{
				actor.setAIAgent(this.m.OriginalAgent);
			}

			actor.setFaction(this.m.OriginalFaction);
			actor.getSprite("socket").setBrush(this.m.OriginalSocket);
		}
		actor.setDirty(true);
		if (actor.hasSprite("status_beckoned"))
			{
				actor.getSprite("status_beckoned").Visible = false;
			}

		if (this.m.Master != null)
		{
			this.m.Master.removeSlave(actor.getID());
			this.m.Master = null;
		}
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onTurnStart()
	{
		if (this.m.Master != null)
		{
			if (!this.m.Master.isAlive())
			{
				this.removeSelf();
			}
		}
	}

});

