::Reforged.Text <- {
	// Converts a given integer into a text which represents that number
	// e.g. 1: one, 51: fifty one, 1251: one thousand two hundred and fifty one
	// Supports language up to "million". Does not convert higher numbers to "billion" etc.
	// i.e. billion will be written as thousand million.
	function getNumberAsText( _number )
	{
		if (_number == 0)
			return "zero";

		local ret = "";
		local n = _number;
		if (n < 0)
		{
			ret = "negative ";
			n = -n;
		}

		local units = ["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"];
		local tens = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"];

		// Helper function to process groups of three digits (up to 999)
		local getPart = function( _n )
		{
			local str = "";
			if (_n >= 100)
			{
				str += units[_n / 100] + " hundred";
				_n = _n % 100;
				if (_n > 0)
					str += " and ";
			}

			if (_n >= 20)
			{
				str += tens[_n / 10];
				if (_n % 10 > 0)
					str += " " + units[_n % 10];
			}
			else if (_n > 0)
			{
				str += units[_n];
			}
			return str;
		};

		if (n >= 1000000)
		{
			ret += getPart(n / 1000000) + " million";
			n = n % 1000000;
			if (n > 0)
				ret += (n < 100 ? " and " : " ");
		}

		if (n >= 1000)
		{
			ret += getPart(n / 1000) + " thousand";
			n = n % 1000;
			if (n > 0)
				ret += (n < 100 ? " and " : " ");
		}

		if (n > 0)
		{
			ret += getPart(n);
		}

		return ret;
	}

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
		if (daysAndHalf <= 1.0)
			return "a day"

		if (daysAndHalf == daysAndHalf.tointeger())
			return daysAndHalf + " days";

		return this.getNumberAsText(daysAndHalf.tointeger()) + " and a half days";
	}
}
