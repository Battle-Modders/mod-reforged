::Reforged.HooksMod.hook("scripts/skills/effects/dazed_effect", function(q) {
	q.m.TwoTurnColor <- ::createColor("#ff6600");	// Orange

	q.onUpdate = @(__original) { function onUpdate( _properties )
	{
		__original(_properties);
		this.updateSprite();
	}}.onUpdate;

// New Functions
	// Initialize the TurnsLeft with a new value. Will always set the Turns to atleast 1. This function already exists for stunned_effect
	q.setTurns <- { function setTurns( _amount )
	{
		if (::MSU.isNull(this.getContainer()) || ::MSU.isNull(this.getContainer().getActor()))
		{
			this.m.TurnsLeft = ::Math.max(1, _amount);
		}
		else
		{
			this.m.TurnsLeft = ::Math.max(1, _amount + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
			this.updateSprite();
		}
	}}.setTurns;

	q.updateSprite <- { function updateSprite()
	{
		if (this.isGarbage()) return;	// This effect is about to be removed

		local actor = this.getContainer().getActor();
		if (!actor.hasSprite("status_stunned")) return;

		local sprite = actor.getSprite("status_stunned");
		if (this.m.TurnsLeft == 0)
		{
			sprite.Visible = false;
		}
		else
		{
			sprite.setBrush("bust_dazed");
			sprite.Visible = true;
			if (this.m.TurnsLeft == 1)
			{
				sprite.Color = ::createColorWhite();
			}
			else
			{
				sprite.Color = this.m.TwoTurnColor;
			}
		}
		actor.setDirty(true);
	}}.updateSprite;
});
