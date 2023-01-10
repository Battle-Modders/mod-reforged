this.perk_rf_kingfisher <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		Chance = 0,
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "perk.rf_kingfisher";
		this.m.Name = ::Const.Strings.PerkName.RF_Kingfisher;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Kingfisher;
		this.m.Icon = "ui/perks/rf_kingfisher.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		return this.getContainer().hasSkill("actives.throw_net");
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		this.m.Chance = 0;
		if (this.m.IsSpent || _targetEntity.getSkills().hasSkill("effects.net") || _targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile()) > 1 || !this.isEnabled())
			return;

		this.m.Chance = _skill.getHitchance(_targetEntity);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive())
			return;

		if (::Math.rand(1, 100) <= this.m.Chance)
		{
			this.setSpent(true);

			local self = this;
			_targetEntity.getSkills().add(::MSU.new("scripts/skills/effects/net_effect", function(o) {
				o.m.KingfisherPerk <- ::MSU.asWeakTableRef(self);
				o.onRemoved <- function()
				{
					if (!::MSU.isNull(this.m.KingfisherPerk))
					{
						this.m.KingfisherPerk.setSpent(false);
					}
				}
				o.onDeath <- function( _fatalityType )
				{
					this.onRemoved();
				}
			}));

			_targetEntity.getSkills().add(::MSU.new("scripts/skills/actives/break_free_skill", function(o) {
				o.m.Icon = "skills/active_74.png";
				o.m.IconDisabled = "skills/active_74_sw.png";
				o.m.Overlay = "active_74";
				o.setChanceBonus(999);
				o.m.SoundOnUse = [
					"sounds/combat/break_free_net_01.wav",
					"sounds/combat/break_free_net_02.wav",
					"sounds/combat/break_free_net_03.wav"
				];
			}));

			local effect = ::Tactical.spawnSpriteEffect(this.m.IsReinforced ? "bust_net_02" : "bust_net", this.createColor("#ffffff"), _targetEntity.getTile(), 0, 10, 1.0, _targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
			local flip = !_targetEntity.isAlliedWithPlayer();
			effect.setHorizontalFlipping(flip);
			::Time.scheduleEvent(::TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), {
				TargetEntity = _targetEntity,
				IsReinforced = this.m.IsReinforced
			});
		}
	}

	function getItemActionCost( _items )
	{
		// Make it impossible to swap the offhand item
		if (this.m.IsSpent && item.getSlotType() == ::Const.ItemSlot.Offhand)
		{
			return 99;
		}
	}

	function setSpent( _isSpent )
	{
		this.m.IsSpent = _isSpent;
		local throwNetSkill = this.getContainer().getSkillByID("actives.throw_net");
		if (throwNetSkill != null)
		{
			throwNetSkill.m.IsHidden = _isSpent;
		}
	}

	function onNetSpawn( _data )
	{
		local rooted = _data.TargetEntity.getSprite("status_rooted");
		rooted.setBrush(_data.IsReinforced ? "bust_net_02" : "bust_net");
		rooted.Visible = true;
		local rooted_back = _data.TargetEntity.getSprite("status_rooted_back");
		rooted_back.setBrush(_data.IsReinforced ? "bust_net_back_02" : "bust_net_back");
		rooted_back.Visible = true;
		_data.TargetEntity.setDirty(true);
	}
});
