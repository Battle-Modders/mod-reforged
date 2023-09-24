::Reforged.HooksMod.hook("scripts/skills/effects/stunned_effect", function(q) {
	q.m.TwoTurnColor <- ::createColor("#ff6600");	// Orange

	q.create = @(__original) function()
	{
		__original();
		this.m.Order += 100;	// So this skill acts after Dazed and overwrites the graphical changes made by those
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		this.updateSprite();
	}

	q.setTurns = @(__original) function( _turns )
	{
		__original(_turns);
		this.updateSprite();
	}

// New Functions
	q.updateSprite <- function()
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
			sprite.setBrush(::Const.Combat.StunnedBrush);
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
	}
});
