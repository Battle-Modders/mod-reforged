this.swindler_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
        SwindleTraits = [
            "trait.athletic",
            "trait.bright",
            "trait.determined",
            "trait.dexterous",
            "trait.fearless",
            "trait.iron_jaw",
            "trait.iron_lungs",
            "trait.loyal",
            "trait.lucky",
            "trait.optimist",
            "trait.quick",
            "trait.strong",
            "trait.sure_footing",
            "trait.tough",
            "trait.lucky"
        ],
        FakedTrait = "",
        ExperienceModifier = -5,

        WasSetup = false
    },

	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.swindler";
		this.m.Name = "Swindler";
		this.m.Icon = "ui/traits/trait_icon_35.png";    // Disloyal Icon as a placeholder. It's fitting but we don't want duplicates
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.Trait;    // By adding any random additional Type we prevent this trait from ever showing up under Tryout. This is a hacky but easy fix
		this.m.Description = "This character prefers fabricating stories instead of actually becoming good in something.";
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.dumb",
            "trait.bright"
		];

		this.m.PerkTreeMultipliers = {
			"pg.rf_talented": 0.75
		};
		this.m.IsHidden = false;
	}

    function addTitle()
    {
        // We do this here because this function is always called after all traits are added during the 'function setStartValuesEx'
        // That way we make sure we don't swindle into a trait that is already present on this character
        this.setupSwindle();
        return this.character_trait.addTitle();
    }

    function revealSwindle()
    {
        local fakedTrait = this.getContainer().getActor().getSkills().getSkillByID(this.m.FakedTrait);
		this.m.Icon = fakedTrait.m.Icon;    // We just steal the icon of the pretended trait for now
        local descriptionPrefix = "\"Did I say " + fakedTrait.m.Name + "? I meant...\" \n";
        this.m.Description = descriptionPrefix + this.m.Description;

		this.m.IsHidden = false;

        // Remove the faked trait
        this.getContainer().getActor().getSkills().removeByID(this.m.FakedTrait);
        this.m.FakedTrait = "";
    }

    function setupSwindle()
    {
        this.m.WasSetup = true;

        // Choose and add a random pretend-perk
        local chosenTrait = ::Math.rand(0, this.m.SwindleTraits.len() - 1);
        local currentTraits = this.getContainer().getActor().getSkills().query(::Const.SkillType.Trait, true, false);
        for(local i = chosenTrait; ; )
        {
            i++;    // We don't want to start with 'chosenTrait' so we can use 'chosenTrait' as an exit-condition
            if (i == this.m.SwindleTraits.len()) i = 0;     // So we can go full circle around that array

            local validTrait = true;
            foreach( trait in currentTraits )
            {
                if (("isExcluded" in trait) == false) continue;     // Some skills are marked as "Traits" but do not have this function. Bad Coding?
                if (trait.getID() == this.m.SwindleTraits[chosenTrait] || trait.isExcluded(this.m.SwindleTraits[chosenTrait]))
                {
                    validTrait = false;
                    break;
                }
            }
            if (validTrait) break;
            if (i == chosenTrait) return;   // This will only happen if the character already has every SwindleTrait or their traits exclude all SwindleTraits. SO basically never
        }

        foreach (trait in ::Const.CharacterTraits)
        {
            if (trait[0] == this.m.SwindleTraits[chosenTrait])
            {
                this.getContainer().getActor().getSkills().add(::new(trait[1]));
                break;
            }
        }

        this.m.FakedTrait = this.m.SwindleTraits[chosenTrait];
		this.m.IsHidden = true;     // We don't want this trait to show up during try-out
    }

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = ::MSU.Text.colorizeValue(this.m.ExperienceModifier, {AddPercent = true}) + " Experience Gain"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.XPGainMult *= (1.0 + (this.m.ExperienceModifier / 100.0));

        if (this.getContainer().getActor().getFaction() == ::Const.Faction.Player) this.m.WasSetup = true;
        if (this.m.WasSetup == false) this.setupSwindle();
	}
// BRPNYQJFKU
});

