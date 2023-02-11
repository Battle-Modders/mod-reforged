Reforged.Hooks.MainMenuModule_createDIV = MainMenuModule.prototype.createDIV;
MainMenuModule.prototype.createDIV = function (_parentDiv)
{
	Reforged.Hooks.MainMenuModule_createDIV.call(this, _parentDiv);
	this.mContainer.find('>.header>img').attr('src', Path.GFX + Reforged.Asset.MAIN_MENU_LOGO);
};
