// Remove several vanilla "tips" that barely classify as such or are pure flavor
for (local index = (::Const.TipOfTheDay.len() - 1); index >= 0; index--)
{
	switch (::Const.TipOfTheDay[index])
	{
		case "As brothers we fight, as brothers we die!":
		case "Learn the 'Rotation' or 'Footwork' perks for additional mobility in battle.":
		case "A life can be worth little in this world.":
		case "Try the Ironman mode to experience Battle Brothers the way it's meant to be played.":	 // not advisable while the mod is still riddled with potential bugs
		case "Dying is part of a mercenary's job description.":
		case "Try playing a campaign in veteran mode once you've gained some experience - it's the recommended difficulty.":
		case "Do the job. Survive. Get paid.":
		case "The 'Lone Wolf' perk is not affected by nearby dogs or allies that are not part of your company.":
		case "The 'Fast Adaptation' perk reduces variance of randomness.":
		case "Losing is fun.":
		case "Some people will use you and throw you away.":
		case "With the \'Beast Slayers\' origin you\'ll have an easier time tracking beasts and get more trophies from any of those you slay.":
		case "With the \'Lone Wolf\' origin you\'ll have a player character in the world. If you die, the campaign ends.":
		case "With the \'Peasant Militia\' origin you can take up to 16 men into battle at once.":
		case "With the \'Cultists\' origin your god will demand sacrifices from you, but also bestow boons upon those loyal to him.":
		case "With the \'Band of Poachers\' origin you\'ll move faster on the worldmap.":
		case "With the \'Trading Caravan\' origin you\'ll get better prices for both buying and selling.":
		case "With the \'Manhunters\' origin you can make prisoners after every battle against humans and force them to fight for you.":
		case "With the \'Gladiators\' origin you start with three powerful characters, but losing all three will end your campaign.":
		case "With the \'Anatomists\' origin, defeating new enemies grants potions that mutate your men and grant them special abilities.":
		case "With the \'Oathtakers\' origin, instead of ambitions you\'ll pick oaths that grant special boons and burdens.":
			::Const.TipOfTheDay.remove(index);
			break;
		case "Flails ignore the defense bonus of shields.":
			::Const.TipOfTheDay[index] = "Reforged: Similar to Flails, Bolas ignore the defense bonus of shields but not of \'Shieldwall\'.";
			break;
	}
}

::Const.TipOfTheDay.extend([
	"Non-player controlled characters will never run out of ammunition for bows, crossbows, and guns.",
	"Reforged: While on a caravan mission, you can enter towns up to 2 tiles away instead of only on the same tile.",
	"The Mod Options have a lot of customizations regarding quality of life.",
	"Morale Checks are harder for every adjacent enemy and easier for every adjacent ally.",
	"Reforged: Click on an active contract to focus on its target on the world map, if it is known to you.",
	"Reforged: Tavern rumors will never be about legendary locations you have already discovered.",
	// "Reforged: Enemies will only drop loot if your faction has dealt at least 50% of the total damage received by that enemy." // This feature is removed due to mod compatibility issues, and should be re-included if we can find a good way.
	"Reforged: Experience from slain enemies is awarded depending on how much damage was dealt to them by your brothers.",
	"If you see colorful squares, do NOT save the game or you might end up with a corrupted save file.",
	"Reforged: Weapons worn by your characters will always drop and be recovered after the battle, even if they break."
]);
