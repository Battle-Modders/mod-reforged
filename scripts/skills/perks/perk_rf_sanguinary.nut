this.perk_rf_sanguinary <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Cleaver,
		RequiredDamageType = ::Const.Damage.DamageType.Cutting,
		IsSpent = true,
		UsesRemaining = 0,
		MaxUses = 2,
		RestoredActionPoints = 3
	},
	function create()
	{
		this.m.ID = "perk.rf_sanguinary";
		this.m.Name = ::Const.Strings.PerkName.RF_Sanguinary;
		this.m.Description = "Gruesome kills revitalize you!";
		this.m.Icon = "ui/perks/perk_rf_sanguinary.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return this.m.UsesRemaining == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local attackString = this.m.RequiredDamageType == null ? "" : " " + ::Const.Damage.getDamageTypeName(this.m.RequiredDamageType);
		local weaponString = this.m.RequiredWeaponType == null ? "" : " from a " + ::Const.Items.getWeaponTypeName(this.m.RequiredWeaponType);
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString(format("The next %i%s attack(s) during your [turn|Concept.Turn]%s will recover %s [Action Points|Concept.ActionPoints] if they cause a fatality", this.m.UsesRemaining, attackString, weaponString, ::MSU.Text.colorPositive(this.m.RestoredActionPoints)))
		});
		return ret;
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		if (this.m.IsSpent || this.m.UsesRemaining == 0 || _fatalityType == ::Const.FatalityType.None || _killer == null || _killer.getID() != this.getContainer().getActor().getID() || !_killer.isPlacedOnMap() || !::Tactical.TurnSequenceBar.isActiveEntity(_killer))
			return;

		if (_skill == null || !this.isSkillValid(_skill))
			return;

		_killer.setActionPoints(::Math.min(_killer.getActionPointsMax(), _killer.getActionPoints() + this.m.RestoredActionPoints));
		_killer.setDirty(true);
		this.spawnIcon("perk_rf_sanguinary", _killer.getTile());
		this.m.IsSpent = true; // Ensures that it cannot trigger more than once per attack (e.g. even if you kill multiple opponents in an AOE attack)
		this.m.UsesRemaining = ::Math.max(0, this.m.UsesRemaining - 1);
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.IsSpent = false;
	}

	function onTurnStart()
	{
		this.m.UsesRemaining = this.m.MaxUses;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished()
		this.m.UsesRemaining = 0;
	}

	function isSkillValid( _skill )
	{
		if (_skill.isRanged() || !_skill.isAttack() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(::Const.Damage.DamageType.Cutting)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
