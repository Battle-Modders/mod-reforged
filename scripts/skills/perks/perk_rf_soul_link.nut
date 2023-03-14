this.perk_rf_soul_link <- ::inherit("scripts/skills/skill", {
	m = {
		TransferedPart = 0.4,	// This percentage of incoming damage is prevented
		TransferedMult = 1.0,	// This part of the prevented damage is inflicted to the nearby linked target

		TransferInfo = null
	},
	function create()
	{
		this.m.ID = "perk.rf_soul_link";
		this.m.Name = "Soul Link";
		this.m.Description = "This character can link their soul with adjacent lesser allies. A portion of all incoming damage to Hitpoints is transfered to a random adjacent ally. Does not work with allies that also have Soul Link.";
		this.m.KilledString = "Died from Soul Link";
		this.m.Icon = "ui/perks/rf_soul_link.png";
		this.m.IconMini = "perk_rf_soul_link_mini";
		this.m.Overlay = "perk_rf_soul_link";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/hexe_hex_damage_01.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_02.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_03.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_04.wav"
		];
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.IsHidden = true;
	}

	function isHidden()
	{
		return !this.hasLink();
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/health.png",
			text = ::MSU.Text.colorGreen((this.m.TransferedPart * 100) + "%") + " of Hitpoint damage taken is redirected"
		});

		return tooltip;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints == 0) return;
		if (!this.hasLink()) return;

		local transferedDamageMult = (1.0 / (1.0 - this.m.TransferedPart)) - 1.0;
		this.m.TransferInfo = {
			Attacker = ::MSU.asWeakTableRef(_attacker),
			Damage = ::Math.ceil(transferedDamageMult * _damageHitpoints * this.m.TransferedMult)
		}
	}

	function onAfterDamageReceived()	// Transferred damage should display after the initial damage in the log
	{
		if (this.m.TransferInfo == null) return;
		this.transferDamage(this.m.TransferInfo.Attacker, this.m.TransferInfo.Damage);
		this.m.TransferInfo = null;
	}

	function onDeath( _fatalityType )	// Transferred damage should display after the death in the log
	{
		if (this.m.TransferInfo == null) return;
		this.transferDamage(this.m.TransferInfo.Attacker, this.m.TransferInfo.Damage);
		this.m.TransferInfo = null;
	}

	function onUpdate( _properties )
	{
		if (this.hasLink()) _properties.DamageReceivedTotalMult *= (1.0 - this.m.TransferedPart);
	}

	function hasLink()
	{
		if (this.getLink() == null) return false;
		return true;
	}

	function getLink()
	{
		local candidates = [];
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		for (local i = 0; i < 6; i++)
		{
			if (myTile.hasNextTile(i) == false) continue;

			local nextTile = myTile.getNextTile(i);
			if (!nextTile.IsOccupiedByActor) continue;

			local nextEntity = nextTile.getEntity();
			if (!nextEntity.isAlliedWith(actor)) continue;
			if (nextEntity.getSkills().hasSkill(this.m.ID)) continue;

			candidates.push(nextEntity);
		}
		if (candidates.len() == 0) return null;

		return candidates[::Math.rand(0, candidates.len() - 1)];
	}

	function transferDamage( _attacker, _damage )
	{
		local target = this.getLink();
		if (this.m.SoundOnUse.len() != 0)
		{
			::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect, target.getPos());
		}

		local hitInfo = clone ::Const.Tactical.HitInfo;
		hitInfo.DamageRegular = _damage;
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = ::Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		target.onDamageReceived(_attacker, this, hitInfo);	// Forwarding the attacker skill instead of 'this' would be nice but we don't have access to that one
	}
});
