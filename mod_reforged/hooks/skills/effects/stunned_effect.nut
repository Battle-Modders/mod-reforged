::Reforged.HooksMod.hook("scripts/skills/effects/stunned_effect", function(q) {
	q.m.TwoTurnColor <- ::createColor("#ff6600");	// Orange

	q.create = @(__original) { function create()
	{
		__original();
		this.m.Order += 100;	// So this skill acts after Dazed and overwrites the graphical changes made by those
	}}.create;

	q.onUpdate = @(__original) { function onUpdate( _properties )
	{
		__original(_properties);
		this.updateSprite();
	}}.onUpdate;

	q.setTurns = @(__original) { function setTurns( _turns )
	{
		__original(_turns);
		this.updateSprite();
	}}.setTurns;

// New Functions
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
	}}.updateSprite;
});
