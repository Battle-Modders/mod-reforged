this.rf_eyes_up_effect <- ::inherit("scripts/skills/skill", {
	m = {
		Stacks = 1
		SkillMalus = 5,
		DefenseMalus = 3,
		MaxStacks = 10
	},
	function create()
	{
		this.m.ID = "effects.rf_eyes_up";
		this.m.Name = "Eyes Up";
		this.m.Description = "A part of this character\'s attention is diverted towards attacks coming from up high.";
		this.m.Icon = "ui/perks/perk_rf_eyes_up.png";
		this.m.IconMini = "perk_rf_eyes_up_mini";
		this.m.Overlay = "rf_eyes_up_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getName()
	{
		return this.m.Stacks == 1 ? this.m.Name : this.m.Name + " (x" + this.m.Stacks + ")";
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		local skillMalus = this.getSkillMalus();

		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::MSU.Text.colorNegative("-" + skillMalus) + " Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::MSU.Text.colorNegative("-" + skillMalus) + " Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::MSU.Text.colorNegative("-" + this.getDefenseMalus()) + " Melee Defense"
			}
		]);

		return tooltip;
	}

	function addStacks( _stacks )
	{
		this.m.Stacks = ::Math.minf(this.m.MaxStacks, this.m.Stacks + _stacks);
	}

	function onRefresh()
	{
		this.addStacks(1);
		this.spawnIcon("rf_eyes_up_effect", this.getContainer().getActor().getTile());
	}

	function getSkillMalus()
	{
		return ::Math.floor(this.m.Stacks * this.m.SkillMalus);
	}

	function getDefenseMalus()
	{
		return ::Math.floor(this.m.Stacks * this.m.DefenseMalus);
	}

	function onUpdate( _properties )
	{
		local skillMalus = this.getSkillMalus();
		_properties.MeleeSkill -= skillMalus;
		_properties.RangedSkill -= skillMalus;
		_properties.MeleeDefense -= this.getDefenseMalus();
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});
