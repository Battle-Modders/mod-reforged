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

	function getDaysRemainingText( _numDays )
	{
		if (_numDays > 8)
			return "a long while";
		if (_numDays >= 6)
			return "another week or so";
		if (_numDays >= 4)
			return "several more days";
		if (_numDays >= 2)
			return "a couple more days";
		if (_numDays >= 1)
			return "another day or so";

		return "less than a day";
	}

	function getDaysAgoAsText( _numDays )
	{
		if (_numDays > 8)
			return "a long time ago";
		if (_numDays >= 6)
			return "a week or so ago";
		if (_numDays >= 4)
			return "several days ago";
		if (_numDays >= 2)
			return "a couple days ago";
		if (_numDays == 1)
			return "yesterday";

		return "today";
	}

	// Replaces colorization tags in _string and fills each %s with the next vararg, left to right.
	// Tags: pos(x), neg(x), dmg(x), grn(x), red(x) -> MSU colorPositive/Negative/Damage/Green/Red; x is text and may contain %s.
	// val<flags>(x), mult<flags>(x), multml<flags>(x) -> MSU colorizeValue/Mult/MultWithText; x is a literal number or exactly %s.
	// Flags: s = AddSign, p = AddPercent, i = InvertColor.
	// e.g. colorize("Gain vals(%s) Melee Skill and multml(%s) damage", 10, 0.75)
	__ColorizeRegex = ::regexp(@"(pos|neg|dmg|multml|mult|val)([spi]*)\(([^)]*)\)"),
	__ColorizeNumberRegex = ::regexp(@"^-?\d+(\.\d+)?$"),

	function colorize( _string, ... )
	{
		local ret = "";
		local args = { Values = vargv, Idx = 0, String = _string };
		local pos = 0;

		while (pos < _string.len())
		{
			local tag = this.__ColorizeRegex.capture(_string, pos);
			// A tag must start at a word boundary, e.g. "repos(" is not a tag
			while (tag != null && tag[0].begin > 0 && this.__isWordChar(_string[tag[0].begin - 1]))
			{
				tag = this.__ColorizeRegex.capture(_string, tag[0].begin + 1);
			}

			local placeholder = _string.find("%s", pos);
			if (placeholder != null && (tag == null || placeholder < tag[0].begin))
			{
				ret += _string.slice(pos, placeholder) + this.__colorizeNextArg(args);
				pos = placeholder + 2;
				continue;
			}

			if (tag == null)
			{
				ret += _string.slice(pos);
				break;
			}

			ret += _string.slice(pos, tag[0].begin);
			local name = _string.slice(tag[1].begin, tag[1].end);
			local flags = _string.slice(tag[2].begin, tag[2].end);
			local content = _string.slice(tag[3].begin, tag[3].end);
			pos = tag[0].end;

			if (name == "pos" || name == "neg" || name == "dmg")
			{
				local text = "";
				local i = 0;
				local p;
				while ((p = content.find("%s", i)) != null)
				{
					text += content.slice(i, p) + this.__colorizeNextArg(args);
					i = p + 2;
				}
				text += content.slice(i);

				switch (name)
				{
					case "pos": ret += ::MSU.Text.colorPositive(text); break;
					case "neg": ret += ::MSU.Text.colorNegative(text); break;
					case "dmg": ret += ::MSU.Text.colorDamage(text); break;
					case "grn": ret += ::MSU.Text.colorGreen(text); break;
					case "red": ret += ::MSU.Text.colorRed(text); break;
				}
				continue;
			}

			local value;
			if (content == "%s")
				value = this.__colorizeNextArg(args);
			else if (this.__ColorizeNumberRegex.match(content))
				value = content.find(".") != null ? content.tofloat() : content.tointeger();
			else
				throw format("Reforged.Text.colorize: %s%s(%s) must contain a number or exactly %%s", name, flags, content);

			local kwargs = {};
			if (flags.find("s") != null) kwargs.AddSign <- true;
			if (flags.find("p") != null) kwargs.AddPercent <- true;
			if (flags.find("i") != null) kwargs.InvertColor <- true;

			switch (name)
			{
				case "val": ret += ::MSU.Text.colorizeValue(value, kwargs); break;
				case "mult": ret += ::MSU.Text.colorizeMult(value, kwargs); break;
				case "multml": ret += ::MSU.Text.colorizeMultWithText(value, kwargs); break;
			}
		}

		return ret;
	}

	function __colorizeNextArg( _args )
	{
		if (_args.Idx >= _args.Values.len())
			throw format("Reforged.Text.colorize: not enough arguments for \"%s\"", _args.String);
		return _args.Values[_args.Idx++];
	}

	function __isWordChar( _char )
	{
		return (_char >= 'a' && _char <= 'z') || (_char >= 'A' && _char <= 'Z') || (_char >= '0' && _char <= '9') || _char == '_';
	}
}
