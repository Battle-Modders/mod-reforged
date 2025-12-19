this.rf_draugr_location_enter_event <- ::inherit("scripts/events/event", {
	m = {
		LocationID = null
	},
	function create()
	{
		this.m.ID = "event.location.rf_draugr_location_enter";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			// Event text set during the `start` function
			Text = "[img]gfx/ui/events/rf_draugr_01.png[/img]",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Prepare the attack.",
					function getResult( _event )
					{
						::World.Events.showCombatDialog(true, true, true);
						return 0;
					}
				},
				{
					Text = "Fall back for now.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				local variant = ::Math.rand(1, 2);
				switch (_event.m.LocationID)
				{
					case "location.rf_draugr_barrows":
						switch (variant)
						{
							case 1:
								this.Text += "The land rises into low, rounded mounds of stone and frozen earth, each marked by crude standing slabs worn smooth by wind and time. The air here is unnaturally still, the cold sharper than it should be, and your men grow quiet without being told. Whatever was buried in these barrows was meant to stay undisturbed.\n\nThen you hear it. A chant, slow and measured, carried across the stones like a funeral dirge without end. At the center of the mounds stands a lone figure, unmoving, his voice grinding on as if he has never known fatigue. As the chant continues, the earth itself begins to answer, barrow after barrow cracking open as pale shapes claw their way free.\n\nWeapons are drawn as the dead rise, some little more than frozen thralls, others clad in ancient mail that still bears the marks of careful burial. Their voices rasp as they move, not quite speech, not quite breath, and the sound sets teeth on edge. The chanting does not falter, nor does the chanter acknowledge your presence.\n\n%randombrother% mutters that these graves were stocked with offerings. Coin, arms, perhaps relics meant to honor the dead, and that such places are rarely poor. You know he\'s right, but as the chant presses down on your thoughts and the dead gather in number, it\'s clear that any riches here will be paid for in blood.";
								break;

							case 2:
								this.Text += "The barrows come into view like old scars upon the land, their stones stacked with care that speaks of reverence rather than haste. Frost clings to everything, and even the wind seems reluctant to pass through the place. Your men slow their pace, glancing from mound to mound, as though expecting something to rise at any moment.\n\nA voice answers their unease. It comes from among the stones, low and droning, repeating words worn thin by centuries of use. A solitary figure stands watch over the graves, his form stiff and rimed with ice, chanting without pause or inflection. With each verse, the ground trembles, and hands break through the soil, followed by helms, mail, and dead eyes that fix upon the living.\n\nThe risen Barrowkin move with purpose, drawn together by the chant, their presence pressing down on the spirit. No man feels the urge to shout or boast here. Only the need to brace, to endure. The chanter\'s voice binds them, steady and unyielding, as if this was always how the barrows were meant to answer intruders.\n\n%randombrother% whispers that these mounds must hold more than bones, that no people would guard empty graves for this long. You weigh the promise of buried wealth against the certainty that once blades are drawn, the chant will only grow louder, and the dead more numerous.";
								break;
						}
						break;


					case "location.rf_draugr_crypt":
						switch (variant)
						{
							case 1:
								this.Text += "The barrows give way to stonework as you approach the crypt, its entrance cut deep into the earth and sealed with slabs etched in symbols worn nearly smooth. This was no common grave. The air around it is colder still, heavy with the weight of time and remembrance, and your men fall quiet as if instinct demands it.\n\nFrom within comes the chant, steady and unbroken, echoing through stone corridors meant to carry it, rising and falling in a cadence that feels practiced beyond memory. The voice sends a dreadful chill down your spine, gnawing at any courage you thought you might have had. Momentarily, the ground around the crypt stirs, and the dead answer, rising from their cold slumber.\n\nThen you feel it: a presence deeper within. This place was built for one who mattered, a forgotten hero whose name once carried weight enough to warrant stone walls and sealed doors. %randombrother% mutters that men are not laid in crypts like this unless they earned it in blood and battle. If the stories are even half true, the place will be full of of arms and treasure worth killing for. The question is, are they worth dying for?";
								break;

							case 2:
								this.Text += "The crypt rises from the frost like a clenched fist of stone, its entrance marked by carvings of warriors long since stripped of name and meaning. Snow lies undisturbed before it, but the stillness feels forced, held in place by something watching from within. Your breath fogs as the cold deepens, seeping through mail and fur alike.\n\nA chant echoes from the dark beyond the doorway, its rhythm measured and patient, as if time itself bends around it. The voice carries through soil and stone as the earth answers. Barrowkin rise, clad in armor that speaks of deliberate honor rather than mass burial.\n\nSomewhere behind those walls, you sense a heavier tread waiting. This crypt was raised to hold a hero, a figure venerated enough to be sealed away with weapons and relics meant to follow them into whatever came after. The dead outside do not wander. They hold ground, as though guarding the moment yet to come.\n\n%randombrother% says this place reeks of old glory and old mistakes, and that crypts like these are never empty-handed. You know he\'s thinking of famed steel and grave-goods untouched by living hands, but first you\'ll have to silence the chant that keeps raising the dead.";
								break;
						}
						break;


					case "location.rf_draugr_fane":
						switch (variant)
						{
							case 1:
								this.Text += "The fane is carved into the mountain itself, its stone face worked into pillars and lintels that once marked a hall of gathering. Wind howls through the entrance, carrying with it a chill that feels older than the snow beneath your boots. This place was not built to hide the dead, but to house them in state.\n\nWithin, a chant echoes from vaulted stone, deep and resonant, as though the mountain answers it in kind. A lone chanter stands at the threshold, his voice rising and falling in a cadence that feels ceremonial rather than watchful. At his call, the dead emerge, stepping forth from shadowed halls and sealed chambers.\n\nThese Barrowkin bear the marks of rank and lineage. Their armor is decorated, their weapons wrought with care, and they move with the certainty of those who were once followed into battle. The chant binds them together while pressing down on your men like the weight of an unseen crowd, smothering any spark of bravado before it can take hold.\n\n%randombrother% speaks low, naming this place a hall of ancestors, the kind raised for kings, champions, and those buried with their kin and their warbands alike. There will be riches here beyond counting, he says, but they were never meant for the living. To take them, you will have to break the rite that keeps the dead enthroned and face whatever champions wait deep within."
								break;

							case 2:
								this.Text += "The mountain\'s face has been shaped into something that resembles a hall rather than a tomb, its entrance wide and deliberate. Stone pillars rise like frozen sentinels, their carvings dulled by centuries of wind and ice. This is no ordinary burial hall, it is a place built to endure the grinding of time.\n\nA chant fills the fane, echoing from deep within, layered and heavy, as though repeated by voices long since stilled. The chanter stands unmoving, his vigil uninterrupted by your approach, and with every measured verse more of the dead take their places. They do not rise in disorder; they assemble.\n\nYou feel eyes upon you from the dark beyond the pillars. Somewhere in the depths lie those for whom this hall was raised. Kings, heroes of ages past, buried with their families, their guards, and the relics of their rule. The dead outside hold their ground, as if awaiting the moment their betters are called to rise.\n\n%randombrother% mutters that fanes like this are spoken of in old tales, where clans gathered to honor their rulers even after death. If the stories hold true, then famed arms and ancient wealth lie within, but so do the dead who were trusted to wield them forever."
								break;
						}
						break;
				}
			}
		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
		if (::World.State.getLastLocation() != null)
		{
			this.m.LocationID = ::World.State.getLastLocation().getTypeID();
		}
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.LocationID = null;
	}
});

