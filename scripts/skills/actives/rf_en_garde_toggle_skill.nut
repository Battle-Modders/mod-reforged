this.rf_en_garde_toggle_skill <- ::inherit("scripts/skills/skill", {
	m = {
		IsOn = true,
		FatigueRequired = 15,
		ReturnFavorSounds = [
			"sounds/combat/return_favor_01.wav"
		]
	},
	function create()
	{
		this.m.ID = "actives.rf_en_garde_toggle";
		this.m.Name = "Toggle En Garde";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Toggle your [En Garde|Perk+perk_rf_en_garde] perk to be enabled or disabled.");
		this.m.Icon = "skills/rf_en_garde_toggle_on.png";
		this.m.IconDisabled = "skills/rf_en_garde_toggle_sw.png";
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
	}

	function softReset()
	{
		this.skill.softReset();
		this.resetField("FatigueRequired");
	}

	function addResources()
	{
		this.skill.addResources();
		foreach (r in this.m.ReturnFavorSounds)
		{
			::Tactical.addResource(r);
		}
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Currently " + (this.m.IsOn ? ::MSU.Text.colorPositive("enabled") : ::MSU.Text.colorNegative("disabled"))
		});

		if (!this.isEnabled())
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Requires a two-handed sword or a sword with [Riposte|Skill+riposte]"))
			});
		}
		
		return ret;
	}

	function isEnabled()
	{
		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Sword))
		{
			return false;
		}

		return this.getContainer().getActor().getMainhandItem().isItemType(::Const.Items.ItemType.TwoHanded) || this.getContainer().getSkillByID("actives.riposte"))
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.isEnabled();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function pickSkill()
	{
		if (!this.isEnabled()) return null;

		if (this.getContainer().getActor().getFatigueMax() - this.getContainer().getActor().getFatigue() < this.m.FatigueRequired)
		{
			return null;
		}

		local riposte = this.getContainer().getSkillByID("actives.riposte");
		if (riposte != null)
		{
			return riposte;
		}
		else if (this.getContainer().getActor().getMainhandItem().isItemType(::Const.Items.ItemType.TwoHanded))
		{
			local rebuke = ::new("scripts/skills/effects/rf_rebuke_effect");
			rebuke.m.BaseChance += 15;
			rebuke.m.BuildsFatigue = false;
			local onTurnStart = "onTurnStart" in rebuke ? rebuke.onTurnStart : null;
			local parentName = rebuke.SuperName;
			rebuke.onTurnStart <- { function onTurnStart()
			{
				if (onTurnStart != null) onTurnStart();
				else this[parentName].onTurnStart();
				this.removeSelf();
			}}.onTurnStart;
			return rebuke;
		}
	}

	function onTurnEnd()
	{
		if (!this.m.IsOn)
		{
			return;
		}

		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || !actor.hasZoneOfControl() || ::Tactical.State.isAutoRetreat())
		{
			return;
		}

		local skill = this.pickSkill();
		if (skill != null)
		{
			if (skill.getID() == "actives.riposte")
			{
				skill.useForFree(actor.getTile());
			}
			else
			{
				this.getContainer().add(skill);
				if (actor.getTile().IsVisibleForPlayer)
				{
					::Sound.play(this.m.ReturnFavorSounds[::Math.rand(0, this.m.ReturnFavorSounds.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, actor.getPos());
				}
			}
		}
	}

	function onAfterUpdate( _properties )
	{
		// During preview set the fatigue cost so that the player knows if their previewed action
		// will still allow en garde to trigger afterward
		if (this.getContainer().getActor().isPreviewing())
			this.m.FatigueCost = this.m.FatigueRequired;
	}

	function onUse( _user, _targetTile )
	{
		this.setOnOff(!this.m.IsOn);
		return true;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.setOnOff(true);
	}

	function setOnOff( _onOrOff )
	{
		this.m.IsOn = _onOrOff;
		this.m.Icon = _onOrOff ? "skills/rf_en_garde_toggle_on.png" : "skills/rf_en_garde_toggle_off.png";
	}
});
