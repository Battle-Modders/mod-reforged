::mods_hookExactClass("skills/perks/perk_anticipation", function(o) {
	// Public
	o.m.UsesMax <- 2;
	o.m.DamageReductionPerTile <- 10.0;
	o.m.DamageReductionBase <- 0.0;

	// Private
	o.m.UsesRemaining <- 2;

	// Temp
	o.m.TempDamageReduction <- 0.0;
	o.m.IsAboutToConsumeUse <- false;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IconMini = "rf_anticipation_mini";

		this.addType(::Const.SkillType.StatusEffect);	// We now want this effect to show up on entities
	}

	o.isHidden <- function()
	{
		return (this.isEnabled() == false);
	}

	o.onCombatStarted <- function()
	{
		this.m.UsesRemaining = this.m.UsesMax;
	}

	o.onCombatFinished <- function()
	{
		this.m.UsesRemaining = this.m.UsesMax;	// So that for the purposes of the tooltip everything looks good
	}

	o.getDescription <- function()
	{
		return ("Take reduced damage from the first " + ::MSU.Text.colorGreen(this.m.UsesMax) + " attacks you receive each battle. This reduction is dependant on your current Ranged Defense and the distance between the attacker and you");
	}

	o.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();

		local damageReduction = this.calculateDamageReduction();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::MSU.Text.colorRed(damageReduction + "%") + " reduced damage received from all attacks"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::MSU.Text.colorRed(this.m.DamageReductionPerTile + "%") + " additional reduced damage received from all attacks for every tile distance between the attacker and you"
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::MSU.Text.colorGreen(this.m.UsesRemaining) + " uses remaining"
			}
		]);

		return ret;
	}

	o.onBeforeDamageReceived <- function( _attacker, _skill, _hitinfo, _properties )
	{
		if (!this.isEnabled() || _skill == null || !_skill.isAttack())		// _skill can be null, for example when burning damage is applied
		{
			this.m.IsAboutToConsumeUse = false;
			return;
		}

		this.m.TempDamageReduction = this.calculateDamageReduction(_attacker);	// We save this so that we can later display it in the combat log
		local damageReceivedMultiplier = (1.0 - (this.m.TempDamageReduction / 100.0));
		_properties.DamageReceivedTotalMult *= damageReceivedMultiplier;

		this.m.IsAboutToConsumeUse = true;	// We need this variable because in "onDamageReceived" we have no information whether that was caused by an "attack"
	}

	o.onDamageReceived <- function( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.IsAboutToConsumeUse == false) return;	// We only consume one use for each registrated attack. Something like the vanilla three headed flail might otherwise use up all of this perks charges
		this.m.IsAboutToConsumeUse = false;

		local actor = this.getContainer().getActor();
		this.m.UsesRemaining = ::Math.max(0, this.m.UsesRemaining - 1);
		::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " anticipated the attack of " + ::Const.UI.getColorizedEntityName(_attacker) + ", reducing its damage by " + ::MSU.Text.colorGreen(this.m.TempDamageReduction + "%"));
	}


	// private functions
	o.isEnabled <- function()
	{
		return (this.m.UsesRemaining > 0);
	}

	// returns a value between 0 and 100 indicitation the damage reduction in %
	o.calculateDamageReduction <- function( _attacker = null )
	{
		local distanceToAttacker = 0;
		if (_attacker != null) distanceToAttacker = _attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile());

		local damageReduction = this.m.DamageReductionBase;
		damageReduction += ::Math.max(0, this.getContainer().getActor().getCurrentProperties().getRangedDefense());
		damageReduction += distanceToAttacker * this.m.DamageReductionPerTile;
		return ::Math.max(0, ::Math.min(100.0, damageReduction));
	}
});
