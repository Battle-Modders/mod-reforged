::Reforged.Text <- {
	function getDayHourString( _seconds )
	{
		local days = ::Math.floor(_seconds / ::World.getTime().SecondsPerDay);
		local hours = ::Math.floor(_seconds / ::World.getTime().SecondsPerHour) % 24;
		local dayHourString = "";
		switch (days)
		{
			case 0:
				break;	// empty string
			case 1:
				dayHourString = "1 day and ";
				break;
			default:
				dayHourString = days + " days and ";
		}
		dayHourString += (hours == 0) ? "" : hours + " hours";
		return dayHourString;
	}

	function getDaysAndHalf( _seconds )
	{
		local doubleDays = ::Math.round(2.0 * (_seconds / ::World.getTime().SecondsPerDay));
		local daysAndHalf = (doubleDays / 2.0);
		if (daysAndHalf <= 1.0) return "a day"
		return "" + daysAndHalf + " days";
	}
}
