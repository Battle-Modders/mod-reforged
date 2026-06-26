this.rf_free_dagger_swap <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = true
	},
	function create()
	{
		this.m.ID = "special.rf_free_dagger_swap";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsSerialized = false;
		this.m.IsHidden = true;
	}

	// Make swapping to/from non-hybrid dagger a free action.
	function getItemActionCost( _items )
	{
		if (this.m.IsSpent)
			return;

		foreach (item in _items)
		{
			if (item != null && ::MSU.isKindOf(item, "weapon") && item.isWeaponType(::Const.Items.WeaponType.Dagger, true, true))
			{
				return 0;
			}
		}
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.IsSpent = true;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}
});
