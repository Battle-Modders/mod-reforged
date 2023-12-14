::Reforged <- {
	Version = "0.5.0-alpha.17",
	ID = "mod_reforged",
	Name = "Reforged Mod",
	GitHubURL = "https://github.com/Battle-Modders/mod-reforged",
	ItemTable = {},
	QueueBucket = {
		Late = [],
		AfterHooks = [],
		FirstWorldInit = []
	}
};

local requiredMods = [
	"mod_msu >= 1.3.0-reforged.12",
	"mod_modern_hooks >= 0.4.10"
	"dlc_lindwurm",
	"dlc_unhold",
	"dlc_wildmen",
	"dlc_desert",
	"dlc_paladins",
	"mod_dynamic_perks >= 0.2.4"
	"mod_dynamic_spawns >= 0.3.3",
	"mod_item_tables >= 0.1.1",
	"mod_upd",
	"mod_stack_based_skills >= 0.5.0"
];

requiredMods.push("mod_poise_system >= 0.1.1");

::Reforged.HooksMod <- ::Hooks.register(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);
::Reforged.HooksMod.require(requiredMods);
::Reforged.HooksMod.conflictWith(
	"mod_legends"
);

requiredMods.pop();	// Poise System must load after Reforged, even though it's a requirement for reforged

local queueLoadOrder = [];
foreach (requirement in requiredMods)
{
	local idx = requirement.find(" ");
	queueLoadOrder.push(">" + (idx == null ? requirement : requirement.slice(0, idx)));
}

// TODO: Establish a cleaner way to organize "Early" bucket hooks on a per-file basis
::Reforged.HooksMod.queue(queueLoadOrder, function() {
	::Reforged.HooksMod.hookTree("scripts/entity/tactical/actor", function(q) {
		q.onDeath = @(__original) function( _killer, _skill, _tile, _fatalityType )
		{
			local playerRelevantDamage = 0.0;
			if (::Const.Faction.Player in this.m.RF_DamageReceived)
				playerRelevantDamage += this.m.RF_DamageReceived[::Const.Faction.Player].Total;
			if (::Const.Faction.PlayerAnimals in this.m.RF_DamageReceived)
				playerRelevantDamage +=  this.m.RF_DamageReceived[::Const.Faction.PlayerAnimals].Total;

			// If player + player animals did at least 50% of total damage to this actor, we set the _killer to null to ensure that the loot properly drops from this actor.
			// This is because vanilla drops loot if _killer is null or belongs to Player or PlayerAnimals faction.
			// Warning: This will break any mod that hooks the original onDeath and expects _killer to represent the actual killer
			if (playerRelevantDamage / this.m.RF_DamageReceived.Total >= 0.5)
			{
				_killer = null;
			}
			// Otherwise set the killer to the dying entity itself, so loot doesn't spawn for the player
			else if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
			{
				_killer = this;
			}

			__original(_killer, _skill, _tile, _fatalityType);
		}
	});

	::Reforged.HooksMod.hook("scripts/items/shields/shield", function(q) {
		// Hook the vanilla function so that ShieldExpert does not reduce damage to shields.
		// We do this in Early bucket so that subsequent hooks on this function are not affected
		q.applyShieldDamage = @(__original) function( _damage, _playHitSound = true )
		{
			// We double the damage because ShieldExpert reduces it by half
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
				_damage *= 2;

			__original(_damage, _playHitSound);
		}
	});
}, ::Hooks.QueueBucket.Early);

::Reforged.HooksMod.queue(queueLoadOrder, function() {
	::Reforged.Mod <- ::MSU.Class.Mod(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);	

	::Reforged.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, ::Reforged.GitHubURL);
	::Reforged.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

	::Reforged.Mod.Debug.setFlag("ai", false);

	::include("mod_reforged/hooks/msu.nut");
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

	::MSU.AI.addBehavior("RF_AttackLunge", "RF.AttackLunge", ::Const.AI.Behavior.Order.Darkflight, ::Const.AI.Behavior.Score.Attack);
	::MSU.AI.addBehavior("RF_CoverAlly", "RF.CoverAlly", ::Const.AI.Behavior.Order.Adrenaline, 60);
	::MSU.AI.addBehavior("RF_FollowUp", "RF.FollowUp", ::Const.AI.Behavior.Order.AttackDefault, 1);
	::MSU.AI.addBehavior("RF_HoldSteady", "RF.HoldSteady", ::Const.AI.Behavior.Order.BoostMorale, ::Const.AI.Behavior.Score.BoostMorale);
	::MSU.AI.addBehavior("RF_Onslaught", "RF.Onslaught", ::Const.AI.Behavior.Order.BoostMorale, ::Const.AI.Behavior.Score.BoostMorale);
	::MSU.AI.addBehavior("RF_KataStep", "RF.KataStep", ::Const.AI.Behavior.Order.Disengage, ::Const.AI.Behavior.Score.Disengage);
	::MSU.AI.addBehavior("RF_Blitzkrieg", "RF.Blitzkrieg", ::Const.AI.Behavior.Order.Rally, ::Const.AI.Behavior.Score.Rally);
	::MSU.AI.addBehavior("RF_SanguineCurse", "RF.SanguineCurse", ::Const.AI.Behavior.Order.Hex, ::Const.AI.Behavior.Score.Hex);
	::MSU.AI.addBehavior("RF_Bodyguard", "RF.Bodyguard", ::Const.AI.Behavior.Order.Protect, ::Const.AI.Behavior.Score.Protect);
	::MSU.AI.addBehavior("RF_Command", "RF.Command", ::Const.AI.Behavior.Order.PossessUndead, ::Const.AI.Behavior.Score.PossessUndead);

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
	foreach (func in ::Reforged.QueueBucket.AfterHooks)
	{
		func();
	}
}, ::Hooks.QueueBucket.AfterHooks);

::Reforged.HooksMod.queue(queueLoadOrder, function() {
	foreach (func in ::Reforged.QueueBucket.FirstWorldInit)
	{
		func();
	}
	delete ::Reforged.QueueBucket;
}, ::Hooks.QueueBucket.FirstWorldInit);
