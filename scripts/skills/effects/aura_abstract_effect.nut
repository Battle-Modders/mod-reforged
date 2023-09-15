this.aura_abstract_effect <- ::inherit("scripts/skills/skill", {
	m = {
		AuraScript = "",
		AuraID = "",
		AuraProviders = [],
		CurrProvider = null
	},
	function create()
	{
		this.m.ID = "effects.aura_abstract";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.IconMini = "";
		this.m.Overlay = "";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function isHidden()
	{
		return this.m.CurrProvider == null;
	}

	function getAuraProvider()
	{
		return this.m.CurrProvider;
	}

	function onAdded()
	{
		this.getContainer().registerAuraEffect(this);
	}

	function onRemoved()
	{
		this.getContainer().unregisterAuraEffect(this);
	}

	function registerAuraProvider( _entity )
	{
		foreach (provider in this.m.AuraProviders)
		{
			if (provider.getID() == _entity.getID()) return;
		}

		this.m.AuraProviders.push(::MSU.asWeakTableRef(_entity));

		if (::MSU.isNull(this.m.CurrProvider)) this.updateCurrProvider();
	}

	function unregisterAuraProvider( _entity )
	{
		foreach (i, provider in this.m.AuraProviders)
		{
			if (provider.getID() == _entity.getID())
			{
				this.m.AuraProviders.remove(i);
				break;
			}
		}

		if (!::MSU.isNull(this.m.CurrProvider) && this.m.CurrProvider.getID() == _entity.getID())
			this.updateCurrProvider();
	}

	function updateCurrProvider()
	{
		this.m.CurrProvider = null;

		foreach (provider in this.m.AuraProviders)
		{
			if (!provider.isPlacedOnMap()) continue;

			local aura = provider.getSkills().getSkillByID(this.m.AuraID);
			if (aura.isEnabled() && provider.getTile().getDistanceTo(this.getContainer().getActor().getTile()) <= aura.getAuraRange())
			{
				this.m.CurrProvider = ::MSU.asWeakTableRef(provider);
				break;
			}
		}
	}
});
