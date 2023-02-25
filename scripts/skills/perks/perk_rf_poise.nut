this.perk_rf_poise <- ::inherit("scripts/skills/skill", {
	m = {
		WeightThreshold = 35,
		HitpointDamageMultiplier = 0.70,
		ArmorDamageMultiplier = 0.85
	},

	function create()
	{
		this.m.ID = "perk.rf_poise";
		this.m.Name = ::Const.Strings.PerkName.RF_Poise;
		this.m.Description = "This character moves lithely, turning incoming attacks into somewhat glancing hits.";
		this.m.Icon = "ui/perks/rf_poise.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.getContainer().hasSkill("perk.nimble") || (::Math.floor(this.getHitpointsMult() * 100) >= 100 && ::Math.floor(this.getArmorMult() * 100) >= 100);
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local hpMult = ::Math.round(this.getHitpointsMult() * 100);
		if (hpMult < 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Damage to hitpoints from attacks is reduced by " + ::MSU.colorGreen((100-hpMult) + "%")
			});
		}
		local armorMult = ::Math.round(this.getArmorMult() * 100);
		if (armorMult < 100)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "Damage to armor from attacks is reduced by " + ::MSU.colorGreen((100-armorMult) + "%")
			});
		}

		if (hpMult >= 100 && armorMult >= 100)
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorRed("This character\'s body and head armor are too heavy to gain any benefit from poise")
			});
		}

		local actor = this.getContainer().getActor();
		local maxHPString = ::Math.floor(actor.getHitpointsMax() / (hpMult * 0.01));
		local currHPString = ::Math.floor(actor.getHitpoints() / (hpMult * 0.01));

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::MSU.Text.colorGreen("Effective Hitpoints: ") + currHPString + " / " + maxHPString
		});

		return tooltip;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		if (this.getContainer().hasSkill("perk.nimble")) return;

		_properties.DamageReceivedRegularMult *= this.getHitpointsMult();
		_properties.DamageReceivedArmorMult *= this.getArmorMult();

	}

	function getHitpointsMult()
	{
		local rawWeight = this.getContainer().getActor().getCurrentProperties().getRawWeight([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
		rawWeight = ::Math.max(0, rawWeight - this.m.WeightThreshold);
		return ::Math.minf(1.0, this.m.HitpointDamageMultiplier + ::Math.pow(rawWeight, 1.23) * 0.01);
	}

	function getArmorMult()
	{
		local rawWeight = this.getContainer().getActor().getCurrentProperties().getRawWeight([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
		rawWeight = ::Math.max(0, rawWeight - this.m.WeightThreshold);
		return ::Math.minf(1.0, this.m.ArmorDamageMultiplier + ::Math.pow(rawWeight, 1.23) * 0.01);
	}
});
