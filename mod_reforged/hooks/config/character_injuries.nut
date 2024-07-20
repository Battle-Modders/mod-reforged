{	// Regular Injury Types
	::Const.Injury.BluntHead.extend([
		{
			ID = "injury.rf_black_eye",
			Threshold = 0.25,
			Script = "injury/rf_black_eye_injury"
		},
		{
			ID = "injury.rf_dislocated_jaw",
			Threshold = 0.25,
			Script = "injury/rf_dislocated_jaw_injury"
		}
	]);

	::Const.Injury.BurningBody.extend([
		{
			ID = "injury.rf_heat_stroke",
			Threshold = 0.25,
			Script = "injury/rf_heat_stroke_injury"
		}
	]);
}

{	// Super-Categories
	::Const.Injury.All.extend([
		{
			ID = "injury.rf_black_eye",
			Threshold = 0.25,
			Script = "injury/rf_black_eye_injury"
		},
		{
			ID = "injury.rf_dislocated_jaw",
			Threshold = 0.25,
			Script = "injury/rf_dislocated_jaw_injury"
		},
		{
			ID = "injury.rf_heat_stroke",
			Threshold = 0.25,
			Script = "injury/rf_heat_stroke_injury"
		}
	]);

	::Const.Injury.BluntAndPiercingHead.extend([
		{
			ID = "injury.rf_black_eye",
			Threshold = 0.25,
			Script = "injury/rf_black_eye_injury"
		},
		{
			ID = "injury.rf_dislocated_jaw",
			Threshold = 0.25,
			Script = "injury/rf_dislocated_jaw_injury"
		}
	]);

	::Const.Injury.Burning.extend([
		{
			ID = "injury.rf_heat_stroke",
			Threshold = 0.25,
			Script = "injury/rf_heat_stroke_injury"
		}
	]);

	::Const.Injury.BurningAndPiercingBody.extend([
		{
			ID = "injury.rf_heat_stroke",
			Threshold = 0.25,
			Script = "injury/rf_heat_stroke_injury"
		}
	]);
}

{	// Event Categories
	::Const.Injury.Brawl.extend([
		{
			ID = "injury.rf_black_eye",
			Threshold = 0.25,
			Script = "injury/rf_black_eye_injury"
		},
		{
			ID = "injury.rf_dislocated_jaw",
			Threshold = 0.25,
			Script = "injury/rf_dislocated_jaw_injury"
		}
	]);

	::Const.Injury.Knockout.extend([
		{
			ID = "injury.rf_black_eye",
			Threshold = 0.25,
			Script = "injury/rf_black_eye_injury"
		},
		{
			ID = "injury.rf_dislocated_jaw",
			Threshold = 0.25,
			Script = "injury/rf_dislocated_jaw_injury"
		}
	]);

	::Const.Injury.Accident1.extend([	// Contains many regular injuries, including broken nose but exluding the 0,5+ head injuries
		{
			ID = "injury.rf_black_eye",
			Threshold = 0.25,
			Script = "injury/rf_black_eye_injury"
		},
		{
			ID = "injury.rf_dislocated_jaw",
			Threshold = 0.25,
			Script = "injury/rf_dislocated_jaw_injury"
		}
	]);

	::Const.Injury.Accident3.extend([	// Focussed on regular head-only blunt damage related injuries
		{
			ID = "injury.rf_black_eye",
			Threshold = 0.25,
			Script = "injury/rf_black_eye_injury"
		},
		{
			ID = "injury.rf_dislocated_jaw",
			Threshold = 0.25,
			Script = "injury/rf_dislocated_jaw_injury"
		}
	]);
}

