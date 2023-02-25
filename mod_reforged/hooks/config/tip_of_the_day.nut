// Remove several vanilla "tips" that barely classify as such or are pure flavor
for (local index = (::Const.TipOfTheDay.len() - 1); index >= 0; index--)
{
    switch (::Const.TipOfTheDay[index])
    {
        case "As brothers we fight, as brothers we die!":
        case "Learn the 'Rotation' or 'Footwork' perks for additional mobility in battle.":
        case "A life can be worth little in this world.":
        case "Try the Ironman mode to experience Battle Brothers the way it's meant to be played.":     // not advisable while the mod is still riddled with potential bugs
        case "Dying is part of a mercenary's job description.":
        case "Try playing a campaign in veteran mode once you've gained some experience - it's the recommended difficulty.":
        case "Do the job. Survive. Get paid.":
        case "The 'Lone Wolf' perk is not affected by nearby dogs or allies that are not part of your company.":
        case "The 'Fast Adaptation' perk reduces variance of randomness.":
        case "Losing is fun.":
        case "Some people will use you and throw you away.":
            ::Const.TipOfTheDay.remove(index);
    }
}

::Const.TipOfTheDay.extend([
    "You can interact with towns while on a caravan mission.",
    "The Mod Options have a lot of customizations regarding quality of life.",
    "Morale Checks are harder for every adjacent enemy and easier for every adjacent ally.",
    "Click on an active contract to focus on its target on the world map, if it is known to you.",
    "The more mods you add the harder it is to debug the game for the modder.",
    "Tavern rumors will never be about legendary locations you have already discovered"
    // "If you see colorful squares, do NOT save the game or you might end up with a corrupted savefile"    // We wait with adding this until we actually get reports of those happening under reforged
]);
