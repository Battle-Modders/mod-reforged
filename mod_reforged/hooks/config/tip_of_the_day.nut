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
		case "Consider putting injured characters in reserve until their wounds have healed.":
		case "Consider building up a reserve roster and rotating your men, so you can more easily deal with losses down the road.":
		case "Having men of different backgrounds in your company may enable you to perform different actions in events.": // Vanilla has another tip which conveys this information more concisely and completely.
		case "You don\'t have to be a hero, you\'re running a business.":
		case "Drag and drop your men in the inventory screen to where you want them to be in your formation.":
		case "Consider forming a shieldwall when surrounded.":
		case "Conserve your stamina when in prolonged engagements.":
		case "Success in Battle Brothers is also about picking the right fights.":
		case "Undead are unaffected by fatigue and morale.":
		case "Crossbows require less skill to fire accurately than bows, but are slower to use.":
		case "Each type of weapon has advantages and disadvantages.":
		case "Clubs and maces can stun or incapacitate targets.":
		case "Try to save some crowns for when things turn sour.":
		case "Longswords and Greatswords can hit multiple targets with one strike.":
		case "Spears are good defensive weapons due to their Spearwall ability.":
		case "Use terrain and chokepoints to your advantage.":
		case "The higher their level, the more your men will demand in wages.":
		case "Skeletons are highly resistant to ranged attacks and fire.":
		case "Heavy armor offers great protection, but also slows down the wearer and makes him tire more quickly.":
		case "Heavy helmets can be hard to breathe in and limit the field of vision.":
		case "Warhammers and Military Picks can make short work of heavy armor.":
		case "The Billhook, Pike and Longaxe can attack over 2 tiles, unlike most other melee weapons.":
		case "A human is no match for an adult orc physically.":
		case "Orcs rely on raw power and physical prowess.":
		case "A goblin is no match for an adult human physically, so they rely on wit and dirty tricks.":
		case "Geists are lost between the physical world and the world beyond, constantly shifting between the two.":
		case "Two-handed axes can hit up to 6 targets with a single round swing.":
		case "Roads are the fastest way to travel over land, but not always the safest.":
		case "Forests can hide many dangers within.":
		case "Always keep a good stock of provisions - lest your men starve and desert you!":
		case "Wiedergangers are the dead walking again.":
		case "Difficult terrain, such as mountains and swamp, has your men use more supplies on the worldmap.":
		case "If you can not win, retreat to fight another day.": // vanilla has another tip that conveys the same message
		case "Try to negotiate better payment for your contracts.":
		case "Try to negotiate payment modalities that guarantee you the most money for contracts.":
		case "Throwing weapons can be deadly on short distances, but their accuracy drops sharply the farther away the target.":
		case "You can find contract offers in the top left of settlement screens.":
		case "Cleavers can inflict bleeding wounds.":
		case "Stunned characters get no attack of opportunity when someone moves inside their zone of control.":
		case "The minimum hit chance for any attack is 5%, and the maximum hit chance for any attack is 95%.":
		case "The natural habitat of direwolves is the forest.":
		case "You can enable faster AI turns in the options menu.":
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
	"Reforged: Enemies will drop loot only if your faction has dealt at least 50% of the total damage received by that enemy, regardless of the killer.",
	"Reforged: Experience from slain enemies is awarded depending on how much damage was dealt to them by your brothers.",
	"Reforged: You can customize the tactical tooltips of your characters and enemies in the Mod Options.",
	"If you see colorful squares, do NOT save the game or you might end up with a corrupted save file.",
	"Reforged: Weapons worn by your characters will always drop and be recovered after the battle, even if they break."
]);
