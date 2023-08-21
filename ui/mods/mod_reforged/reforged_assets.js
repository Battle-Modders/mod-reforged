
"use strict";

Reforged.Asset = {
	BUTTON_WAIT_ALL_TURNS: 'ui/skin/rf_icon_wait_all.png',
	BUTTON_RETREAT_WIN : 'ui/skin/icon_rf_retreat_win.png',
	MAIN_MENU_LOGO: 'ui/skin/rf_main_menu_logo.png',

	generateScaleCommand: function(_imagePath)
	{
		var scaleX = 1;
		var scaleY = 1;

		if (_imagePath != null)
		{
			_imagePath = _imagePath.replace(Path.ITEMS, "");
			var searchTerm = _imagePath.substring(0, _imagePath.indexOf("/"));

			if (_imagePath != null)
			{
				var count = 0;
				while (_imagePath.search("\\.\\./" + searchTerm + "/") !== -1)		// we need to escape the .. because search() takes a regex
				{
					count++;
					_imagePath = _imagePath.replace("../" + searchTerm + "/", "");
				}

				if (count === 1)
				{
					scaleY = -1;
				}
				else if (count === 2)
				{
					scaleX = -1;
				}
				else if (count === 3)
				{
					scaleX = -1;
					scaleY = -1;
				}
			}
		}

		return "scale(" + scaleX + "," + scaleY + ")"
	}
};
