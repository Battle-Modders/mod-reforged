this.rf_from_all_sides_effect <- ::inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		MalusPerStack = 5
	},
	function create()
	{
		this.m.ID = "effects.rf_from_all_sides";
		this.m.Name = "From all Sides";
		this.m.Description = "This character is receiving attacks which seem to be coming from all sides - very confusing!";
		this.m.Icon = "ui/perks/perk_rf_from_all_sides.png";
		this.m.IconMini = "rf_from_all_sides_effect_mini";
		this.m.Overlay = "rf_from_all_sides_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getName()
	{
		return this.m.Stacks == 1 ? this.m.Name : this.m.Name + " (x" + (this.m.Stacks) + ")";
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local malus = this.getMalus();

		ret.extend(
		[
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("-" + malus) + " [Melee Defense|Concept.MeleeDefense]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("-" + malus) + " [Ranged Defense|Concept.RangeDefense]")
			}
		]);

		return ret;
	}

	function proc( _hitInfo = null )
	{
		this.m.Stacks += _hitInfo.BodyPart == ::Const.BodyPart.Head ? 2 : 1;
	}

	function onRefresh()
	{
		this.spawnIcon("rf_from_all_sides_effect", this.getContainer().getActor().getTile());
		this.getContainer().update();
	}

	function getMalus()
	{
		return this.m.Stacks * this.m.MalusPerStack;
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
