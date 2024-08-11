::Reforged.HooksMod.hook("scripts/skills/perks/perk_anticipation", function(q) {
	// Config
	q.m.BaseChance = 0;
	q.m.ChancePerTile <- 10;
	q.m.MaxChance = 70;
	q.m.MinDamageReceivedTotalMult = 0.7;

	// Private
	// These two fields are used to ensure that the damage reduction is the same in all instances of damage from a single attack from an attacker
	q.m.SkillCount <- 0;
	q.m.LastAttacker <- null;
	// This is used to keep track of the current damage reduction so that it can be later displayed in the combat log
	q.m.TempDamageReceivedTotalMult <- 1.0;

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Use your fast senses to anticipate attacks against you, taking reduced damage.";
		this.m.IconMini = "rf_anticipation_mini";

		this.addType(::Const.SkillType.StatusEffect);	// We now want this effect to show up on entities
	}

	q.isHidden <- function()
	{
		return this.getChance() == 0;
	}

	q.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();

		local chance = this.getChance();
		local mult = this.getDamageReceivedTotalMult();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = ::MSU.Text.colorPositive(chance + "%") + " chance to receive " + ::MSU.Text.colorizeMult(mult, {InvertColor = true}) + " reduced damage from attacks"
		});

		if (this.m.ChancePerTile != 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "The chance is [increased|Concept.StackAdditively] by " + ::MSU.Text.colorizeValue(this.m.ChancePerTile, {AddSign = true, AddPercent = true}) " + for every tile between the attacker and you"
			});
		}

		return ret;
	}

	q.onBeforeDamageReceived <- function( _attacker, _skill, _hitinfo, _properties )
	{
		// Do not recalculate the damage received mult during damage instances from a single attack
		if (this.m.SkillCount == ::Const.SkillCounter && ::MSU.isEqual(_attacker, this.m.LastAttacker))
			return;

		this.m.TempDamageReceivedTotalMult = 1.0;

		if (_skill == null || !_skill.isAttack() || ::Math.rand(1, 100) > this.getChance(_attacker))
		{
			return;
		}

		this.m.SkillCount = ::Const.SkillCounter;
		this.m.LastAttacker = _attacker == null ? null : ::MSU.asWeakTableRef(_attacker);

		this.m.TempDamageReceivedTotalMult = this.getDamageReceivedTotalMult();
		_properties.DamageReceivedTotalMult *= this.m.TempDamageReceivedTotalMult;
	}

	q.onDamageReceived <- function( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.TempDamageReceivedTotalMult == 1.0)
			return;

		// _attacker can be null e.g. when receiving damage from mortar
		::Tactical.EventLog.logEx(format("%s anticipated %s, reducing damage received by %s", ::Const.UI.getColorizedEntityName(this.getContainer().getActor()), _attacker == null ? "an attack" : "the attack of " + ::Const.UI.getColorizedEntityName(_attacker), ::MSU.Text.colorPositive(this.m.TempDamageReduction + "%")));
	}

	q.getDamageReceivedTotalMult <- function( _attacker = null )
	{
		return ::Math.maxf(this.m.MinDamageReceivedTotalMult, 1.0 - this.getContainer().getActor().getCurrentProperties().getRangedDefense() * 0.01);
	}

	function getChance( _attacker = null )
	{
		local actor = this.getContainer().getActor();
		local ret = this.m.BaseChance + actor.getRangedDefense();

		if (_attacker != null && _attacker.isPlacedOnMap() && actor.isPlacedOnMap())
		{
			ret += this.m.ChancePerTile;
		}

		return ::Math.max(0, ::Math.min(this.m.MaxChance, ret));
	}
});
