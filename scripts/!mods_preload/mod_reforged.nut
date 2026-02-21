::Reforged <- {
	Version = "0.7.23",
	ID = "mod_reforged",
	Name = "Reforged Mod",
	GitHubURL = "https://github.com/Battle-Modders/mod-reforged",
	ItemTable = {},
	QueueBucket = {
		Late = [],
		VeryLate = [], // For experimental modules only
		AfterHooks = [],
		FirstWorldInit = []
	}
};

local requiredMods = [
	"vanilla >= 1.5.1-6",
	"mod_modular_vanilla >= 0.6.1",
	"mod_msu >= 1.7.2",
	"mod_nested_tooltips >= 0.3.0",
	"mod_modern_hooks >= 0.4.10"
	"dlc_lindwurm",
	"dlc_unhold",
	"dlc_wildmen",
	"dlc_desert",
	"dlc_paladins",
	"mod_dynamic_perks >= 0.5.0"
	"mod_dynamic_spawns >= 0.4.0",
	"mod_item_tables >= 0.1.3",
	"mod_upd",
	"mod_stack_based_skills >= 0.5.1"
];

::Reforged.HooksMod <- ::Hooks.register(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);
::Reforged.HooksMod.require(requiredMods);
::include("mod_reforged/mod_conflicts");

local queueLoadOrder = [];
foreach (requirement in requiredMods)
{
	local idx = requirement.find(" ");
	queueLoadOrder.push(">" + (idx == null ? requirement : requirement.slice(0, idx)));
}

// TODO: Establish a cleaner way to organize "Early" bucket hooks on a per-file basis
::Reforged.HooksMod.queue(queueLoadOrder, function() {
	::Reforged.HooksMod.hook("scripts/entity/world/combat_manager", function(q) {
		// Overwrite vanilla function to add the following changes:
		//	- Deal spillover damage from an attack to other opponents. This makes the battles more representative of unit Strength.
		q.tickCombat = @() { function tickCombat( _combat )
		{
			local attackOccured = false;

			for (local i = 0; i < _combat.Combatants.len(); i++)
			{
				local combatant = _combat.Combatants[i];

				if (::MSU.isNull(combatant.Party))
					continue;

				// In vanilla this is an array of indices (_f) but we use an array of the elements instead.
				local potentialOpponentFactions = _combat.Factions.filter(@(_f, _parties) _parties.len() != 0 && combatant.Party.getFaction() != _f && !::World.FactionManager.isAllied(combatant.Party.getFaction(), _f));
				if (potentialOpponentFactions.len() == 0)
					continue;

				// This is the total damage this combatant did in this tick. Same calculation as vanilla to roll damage per attack.
				local damage = ::Math.max(1, ::Math.rand(1, combatant.Strength) * ::Const.World.CombatSettings.CombatStrengthMult);

				// Deal all of the damage to opponents. If any opponent dies, we choose a new opponent and deal the spillover damage to it.
				while (damage > 0)
				{
					local opponentParties = [];
					foreach (parties in potentialOpponentFactions)
					{
						if (parties.len() != 0)
						{
							opponentParties.extend(parties.filter(@(_, _p) !::MSU.isNull(_p) && _p.getTroops().len() != 0));
						}
					}

					// Stop if no opponent party with troops was found in any opponent factions.
					if (opponentParties.len() == 0)
						break;

					local opponentParty = ::MSU.Array.rand(opponentParties);

					local opponentIndex = ::Math.rand(0, opponentParty.getTroops().len() - 1);
					local opponent = opponentParty.getTroops()[opponentIndex];
					attackOccured = true;

					// Deal up to the Strength of the opponent in damage, and subtract it from our total damage in this attack.
					local damageDealt = ::Math.min(damage, opponent.Strength);
					damage -= damageDealt;
					opponent.Strength -= damageDealt;

					// This block is the same as in vanilla.
					if (opponent.Strength <= 0)
					{
						++_combat.Stats.Dead;
						opponentParty.getTroops().remove(opponentIndex);
						opponentIndex = _combat.Combatants.find(opponent);
						_combat.Combatants.remove(opponentIndex);

						if (opponentIndex < i)
						{
							i--;
						}

						if (opponentParty.getTroops().len() == 0)
						{
							_combat.Stats.Loot.extend(opponentParty.getInventory());
							local partyIndex = _combat.Factions[opponentParty.getFaction()].find(opponentParty);
							opponentParty.setCombatID(0);
							_combat.Factions[opponentParty.getFaction()].remove(partyIndex);
							opponentParty.onCombatLost();
						}
					}
				}
			}

			if (!attackOccured)
			{
				_combat.IsResolved = true;
			}
		}}.tickCombat;
	});

	::Reforged.HooksMod.hook("scripts/items/shields/shield", function(q) {
		// Hook the vanilla function so that ShieldExpert does not reduce damage to shields.
		// We do this in Early bucket so that subsequent hooks on this function are not affected
		q.applyShieldDamage = @(__original) { function applyShieldDamage( _damage, _playHitSound = true )
		{
			// We double the damage because ShieldExpert reduces it by half
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
				_damage *= 2;

			__original(_damage, _playHitSound);
		}}.applyShieldDamage;
	});
}, ::Hooks.QueueBucket.Early);

::Reforged.HooksMod.queue(queueLoadOrder, function() {
	::Reforged.Mod <- ::MSU.Class.Mod(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);

	::Reforged.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, ::Reforged.GitHubURL);
	::Reforged.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);
	::Reforged.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.NexusMods, "https://www.nexusmods.com/battlebrothers/mods/765");

	::Reforged.checkConflictWithFilename();
	delete ::Reforged.checkConflictWithFilename;

	::Reforged.Mod.Debug.setFlag("ai", false);
	::Reforged.Mod.Debug.setFlag("onAnySkillExecutedFully", true);
	::Reforged.Mod.Debug.setFlag("AIAgentFixes", false);

	::include("mod_reforged/hooks/misc.nut");
	::include("mod_reforged/ui/load.nut");

	local function requireSettingValue( _setting, _value )
	{
		if (_setting.set(true)) _setting.lock(format("Required by %s (%s)", ::Reforged.Name, ::Reforged.ID));
		else ::MSU.QueueErrors.add(format("%s (%s) requires the MSU setting \'%s\' to be \'%s\'", ::Reforged.Name, ::Reforged.ID, _setting.getID(), _value + ""));
	}

	requireSettingValue(::getModSetting("mod_msu", "ExpandedSkillTooltips"), true);
	requireSettingValue(::getModSetting("mod_msu", "ExpandedItemTooltips"), true);

	foreach (file in ::IO.enumerateFiles("mod_reforged/msu_systems"))
	{
		::include(file);
	}

	::include("mod_reforged/hooks/config/strings.nut");

	foreach (file in ::IO.enumerateFiles("mod_reforged/hooks/config"))
	{
		::include(file);
	}

	foreach (file in ::IO.enumerateFiles("mod_reforged"))
	{
		::include(file);
	}
});

::Reforged.HooksMod.queue(queueLoadOrder, function() {
	foreach (func in ::Reforged.QueueBucket.Late)
	{
		func();
	}
}, ::Hooks.QueueBucket.Late);

::Reforged.HooksMod.queue(queueLoadOrder, function() {
	foreach (func in ::Reforged.QueueBucket.VeryLate)
	{
		func();
	}
}, ::Hooks.QueueBucket.VeryLate);

::Reforged.HooksMod.queue(queueLoadOrder, function() {
	foreach (file in ::IO.enumerateFiles("mod_reforged_AfterHooks"))
	{
		::include(file);
	}
	foreach (func in ::Reforged.QueueBucket.AfterHooks)
	{
		func();
	}
	// Dev Console sets AI.ParallelizationMode to false in older versions.
	// We enable it so that users who have older Dev Console in their data folder don't suffer.
	if (::Hooks.hasMod("mod_dev_console"))
	{
		::Const.AI.ParallelizationMode = true;
	}

}, ::Hooks.QueueBucket.AfterHooks);

::Reforged.HooksMod.queue(queueLoadOrder, function() {
	foreach (func in ::Reforged.QueueBucket.FirstWorldInit)
	{
		func();
	}
	delete ::Reforged.QueueBucket;
	delete ::Reforged.InheritHelper;
}, ::Hooks.QueueBucket.FirstWorldInit);
