::Reforged.HooksMod.hook("scripts/skills/skill_container", function(q) {
	q.onDamageReceived = @(__original) { function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local damage = _damageArmor + ::Math.min(_damageHitpoints, this.getActor().getHitpoints());

		__original(_attacker, _damageHitpoints, _damageArmor);

		if (_attacker != null && damage > 0)
		{
			// We store the damage done by the attacker. This is used to
			// calculate XP distribution when this actor dies.
			local t = this.getActor().m.RF_DamageReceived;

			if (!(_attacker.getFaction() in t)) t[_attacker.getFaction()] <- { Total = 0.0 };
			if (!(_attacker.getID() in t[_attacker.getFaction()])) t[_attacker.getFaction()][_attacker.getID()] <- 0.0;

			t.Total += damage;
			t[_attacker.getFaction()].Total += damage;
			t[_attacker.getFaction()][_attacker.getID()] += damage;
		}
	}}.onDamageReceived;

	q.update = @(__original) { function update()
	{
		__original();
		if (!this.m.IsUpdating && this.getActor().isAlive())
			this.onSkillsUpdated();
	}}.update;

	q.onSkillsUpdated <- { function onSkillsUpdated()
	{
		this.callSkillsFunctionWhenAlive("onSkillsUpdated", null, false);
	}}.onSkillsUpdated;

	// Hook MSU function to move Warning tooltip entries to the end of tooltips.
	q.onQueryTooltip = @(__original) { function onQueryTooltip( _skill, _tooltip )
	{
		local ret = __original(_skill, _tooltip);
		local warnings = [];
		for (local i = _tooltip.len() - 1; i >= 0; i--)
		{
			local entry = _tooltip[i];
			if ("icon" in entry && (entry.icon == "ui/icons/warning.png" || entry.icon == "ui/tooltips/warning.png"))
			{
				warnings.push(_tooltip.remove(i));
			}
		}
		_tooltip.extend(warnings);
		return ret;
	}}.onQueryTooltip;

	// Modular Vanilla function
	// We add the cost of evading attacks of opportunity to the movement costs preview
	q.onCostsPreview = @(__original) { function onCostsPreview( _costsPreview )
	{
		__original(_costsPreview);
		_costsPreview.fatiguePreview += this.getActor().RF_getZOCEvasionFatigue();
	}}.onCostsPreview;
});
