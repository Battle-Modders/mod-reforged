this.perk_rf_hybridization <- ::inherit("scripts/skills/skill", {
	m = {
		RangedSkillToMeleeMult = 0.1,
		MeleeSkillToRangedMult = 0.2
	},
	function create()
	{
		this.m.ID = "perk.rf_hybridization";
		this.m.Name = ::Const.Strings.PerkName.RF_Hybridization;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Hybridization;
		this.m.Icon = "ui/perks/rf_hybridization.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getMeleeBonus();
		_properties.MeleeSkill += bonus;
		_properties.MeleeDefense += bonus;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && this.isSkillValid(_skill))
		{
			_properties.RangedSkill += this.getRangedBonus();
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (this.isSkillValid(_skill))
		{
			_tooltip.push({
				id = 15,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("Has %s chance to hit due to [%s|Skill+%s]", ::MSU.Text.colorizePercentage(this.getRangedBonus()), this.getName(), split(::IO.scriptFilenameByHash(this.ClassName), "/").top()))
			});
		}
	}

	function getMeleeBonus()
	{
		return ::Math.floor(this.getContainer().getActor().getBaseProperties().getRangedSkill() * this.m.RangedSkillToMeleeMult);
	}

	function getRangedBonus()
	{
		return ::Math.floor(this.getContainer().getActor().getCurrentProperties().getMeleeSkill() * this.m.MeleeSkillToRangedMult);
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isRanged() || _skill.isAttack())
			return false;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Throwing);
	}
});

