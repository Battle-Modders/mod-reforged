this.rf_from_all_sides_effect <- ::inherit("scripts/skills/skill", {
	m = {
		Malus = 0,
		HitStacks = 0,
		MissStacks = 0,
		MalusForHit = 3,
		MalusForMiss = 1
	},
	function create()
	{
		this.m.ID = "effects.rf_from_all_sides";
		this.m.Name = "From all Sides";
		this.m.Description = "This character is receiving attacks which seem to be coming from all sides - very confusing!";
		this.m.Icon = "ui/perks/rf_from_all_sides.png";
		this.m.IconMini = "rf_from_all_sides_effect_mini";
		this.m.Overlay = "rf_from_all_sides_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getName()
	{
		if (this.m.HitStacks + this.m.MissStacks == 0) return this.m.Name;

		return this.m.Name + " (x" + (this.m.HitStacks + this.m.MissStacks) + ")";
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.extend(
		[
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-" + this.m.Malus + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-" + this.m.Malus + "[/color] Ranged Defense"
			}
		]);

		return tooltip;
	}

	function proc( _hitInfo = null )
	{
		if (_hitInfo == null)
		{
			this.m.MissStacks += 1;
		}
		else
		{
			this.m.HitStacks++;
			if (_hitInfo.BodyPart == ::Const.BodyPart.Head) this.m.HitStacks++;
		}
		this.m.Malus = (this.m.MissStacks * this.m.MalusForMiss) + (this.m.HitStacks * this.m.MalusForHit);
	}

	function onRefresh()
	{
		this.spawnIcon("rf_from_all_sides_effect", this.getContainer().getActor().getTile());
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense -= this.m.Malus;
		_properties.RangedDefense -= this.m.Malus;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}
});
