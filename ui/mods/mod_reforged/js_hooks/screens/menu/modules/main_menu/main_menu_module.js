Screens.MainMenuScreen.getModule("MainMenuModule").mContainer.find("img").attr('src', Path.GFX + Reforged.Asset.MAIN_MENU_LOGO).css('top', "-7.8rem").css('left', "-6rem");

Reforged.Hooks.MainMenuModule_createDIV = MainMenuModule.prototype.createDIV;
MainMenuModule.prototype.createDIV = function (_parentDiv)
{
	Reforged.Hooks.MainMenuModule_createDIV.call(this, _parentDiv);
	this.mContainer.find("img").attr('src', Path.GFX + Reforged.Asset.MAIN_MENU_LOGO).css('top', "-3.8rem").css('left', "-6rem");
}
