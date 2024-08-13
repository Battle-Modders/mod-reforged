::Reforged.HooksMod.hook("scripts/skills/perks/perk_anticipation", function(q) {
	// Public
	q.m.UsesMax <- 2;
	q.m.DamageReductionPerTile <- 10.0;
	q.m.DamageReductionBase <- 0.0;

	// Private
	q.m.UsesRemaining <- 2;

	// Temp
	q.m.TempDamageReduction <- 0.0;		// This is used to keep track of the current damage reduction so that it can be later displayed in the combat log
	q.m.IsAboutToConsumeUse <- false;

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Use your fast senses to anticipate attacks against you, taking reduced damage from the first few attacks each battle.";
		this.m.IconMini = "rf_anticipation_mini";

		this.addType(::Const.SkillType.StatusEffect);	// We now want this effect to show up on entities
	}

	q.isHidden <- function()
	{
		return (this.isEnabled() == false);
	}

	q.onCombatStarted <- function()
	{
		this.m.UsesRemaining = this.m.UsesMax;
	}

	q.onCombatFinished <- function()
	{
		this.m.UsesRemaining = this.m.UsesMax;	// So that for the purposes of the tooltip everything looks good
	}

	q.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();

		local damageReduction = this.calculateDamageReduction();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::MSU.Text.colorNegative(damageReduction + "%") + " reduced damage received from all attacks"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::MSU.Text.colorNegative(this.m.DamageReductionPerTile + "%") + " additional reduced damage received from all attacks for every tile between the attacker and you"
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::MSU.Text.colorPositive(this.m.UsesRemaining) + " uses remaining"
			}
		]);

		return ret;
	}

	q.onBeforeDamageReceived <- function( _attacker, _skill, _hitinfo, _properties )
	{
		if (!this.isEnabled() || _skill == null || !_skill.isAttack())		// _skill can be null, for example when burning damage is applied
		{
			this.m.IsAboutToConsumeUse = false;
			return;
		}

		this.m.TempDamageReduction = this.calculateDamageReduction(_attacker);	// We save this so that we can later display it in the combat log
		_properties.DamageReceivedTotalMult *= (1.0 - (this.m.TempDamageReduction / 100.0));

		this.m.IsAboutToConsumeUse = true;	// We need this variable because in "onDamageReceived" we have no information whether that was caused by an "attack"
	}

	q.onDamageReceived <- function( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.IsAboutToConsumeUse == false) return;	// We only consume one use for each registered attack. But a single attack that deals damage multiple times will therefor have the damage of all instances reduced
		this.m.IsAboutToConsumeUse = false;

		this.m.UsesRemaining = ::Math.max(0, this.m.UsesRemaining - 1);

		if (_attacker == null)	// This can for example happen when this character receives a mortar attack.
		{
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " anticipated an attack, reducing damage received by " + ::MSU.Text.colorPositive(this.m.TempDamageReduction + "%"));
		}
		else
		{
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " anticipated the attack of " + ::Const.UI.getColorizedEntityName(_attacker) + ", reducing damage received by " + ::MSU.Text.colorPositive(this.m.TempDamageReduction + "%"));
		}
	}

	// private functions
	q.isEnabled <- function()
	{
		return (this.m.UsesRemaining > 0);
	}

	// returns a value between 0 and 100 indicitation the damage reduction in %
	q.calculateDamageReduction <- function( _attacker = null )
	{
		local damageReduction = this.m.DamageReductionBase;
		damageReduction += ::Math.max(0, this.getContainer().getActor().getCurrentProperties().getRangedDefense());

		if (_attacker != null && _attacker.isPlacedOnMap() && this.getContainer().getActor().isPlacedOnMap())
		{
			// -1 because adjacent entities count as a distance of 1 but we want only the number of tiles between the entities
			damageReduction += this.m.DamageReductionPerTile * (_attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) - 1);
		}

		return ::Math.max(0, ::Math.min(100.0, damageReduction));
	}
});
