::Reforged.HooksMod.hook("scripts/skills/traits/lucky_trait", function(q) {
	q.m.ChanceToAvoidDamage <- 5;

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			if (entry.id == 10 && entry.text.find("any attacker require two") != null)
			{
				entry.text = "Has a " + ::MSU.Text.colorizePercentage(this.m.ChanceToAvoidDamage, {AddSign = false}) + " chance to avoid all damage from any source."
			}
		}
		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		local oldRerollDefenseChance = _properties.RerollDefenseChance;
		__original(_properties);
		_properties.RerollDefenseChance = oldRerollDefenseChance;
	}

	q.onBeforeDamageReceived = @(__original) function( _attacker, _skill, _hitInfo, _properties )
	{
		__original(_attacker, _skill, _hitInfo, _properties);

		if (::Math.rand(1, 100) <= this.m.ChanceToAvoidDamage)
		{
			_properties.DamageReceivedTotalMult = 0.0;

			this.spawnIcon("rf_lucky_trait", this.getContainer().getActor().getTile());

			local logText = ::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " was lucky and takes " + ::MSU.Text.colorGreen("no damage");
			if (_attacker != null) logText += " from " + ::Const.UI.getColorizedEntityName(_attacker);
			::Tactical.EventLog.logEx(logText);
		}
	}
});
