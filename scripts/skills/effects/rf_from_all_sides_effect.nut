this.rf_from_all_sides_effect <- ::inherit("scripts/skills/skill", {
	m = {
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
		local malus = this.getMalus();

		tooltip.extend(
		[
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-" + malus + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-" + malus + "[/color] Ranged Defense"
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
			this.m.HitStacks += _hitInfo.BodyPart == ::Const.BodyPart.Head ? 2 : 1;
		}
	}

	function onRefresh()
	{
		this.spawnIcon("rf_from_all_sides_effect", this.getContainer().getActor().getTile());
		this.getContainer().update();
	}

	function getMalus()
	{
		return this.m.HitStacks * this.m.MalusForHit + this.m.MissStacks * this.m.MalusForMiss;
	}

	function onUpdate( _properties )
	{
		local malus = this.getMalus();
		_properties.MeleeDefense -= malus;
		_properties.RangedDefense -= malus;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}
});
