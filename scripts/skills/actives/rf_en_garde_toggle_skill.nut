this.rf_en_garde_toggle_skill <- ::inherit("scripts/skills/skill", {
	m = {
		IsOn = true,
		HasMoved = false,
		FatigueRequired = 15
	},
	function create()
	{
		this.m.ID = "actives.rf_en_garde_toggle";
		this.m.Name = "Toggle En Garde";
		this.m.Description = "Toggle your En Garde perk to be enabled or disabled."
		this.m.Icon = "skills/rf_en_garde_toggle_on.png";
		this.m.IconDisabled = "skills/rf_en_garde_toggle_bw.png";
		this.m.ReturnFavorSounds <- [
			"sounds/combat/return_favor_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = false;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "En Garde is currently " + (this.m.IsOn ? "[color=" + ::Const.UI.Color.PositiveValue + "]Enabled[/color]" : "[color=" + ::Const.UI.Color.NegativeValue + "]Disabled[/color]")
		});
		
		return tooltip;
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

		return true;
	}

	function isHidden()
	{
		return !this.getContainer().getActor().isPlacedOnMap() || !this.isEnabled();
	}

	function onTurnStart()
	{
		this.m.HasMoved = false;
	}

	function onMovementFinished( _tile )
	{
		local meisterhau = this.getContainer().getSkillByID("actives.rf_swordmaster_stance_meisterhau");
		if (meisterhau == null || !meisterhau.m.IsOn)
		{
			this.m.HasMoved = true;
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function pickSkill()
	{
		if (!this.isEnabled()) return null;

		if (this.getContainer().getActor().getFatigueMax() - this.getContainer().getActor().getFatigue() < this.m.FatigueRequired) return null;

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
			rebuke.onTurnStart <- function()
			{
				if (onTurnStart != null) onTurnStart();
				else this[parentName].onTurnStart();
				this.removeSelf();
			}
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
			if (this.m.HasMoved)
			{
				actor.setFatigue(::Math.min(actor.getFatigueMax(), actor.getFatigue() + this.m.FatigueRequired));
			}
		}
	}

	function onAfterUpdatePreview( _properties, _previewedSkill, _previewedMovement )
	{
		this.m.FatigueCost = 15;
	}

	function onUse( _user, _targetTile )
	{
		this.m.IsOn = !this.m.IsOn;
		this.m.Icon = this.m.IsOn ? "skills/rf_en_garde_toggle_on.png" : "skills/rf_en_garde_toggle_off.png";
		return true;
	}
});
