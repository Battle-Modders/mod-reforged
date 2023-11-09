Reforged.Hooks.CharacterScreenLeftPanelHeaderModule_updateControls = CharacterScreenLeftPanelHeaderModule.prototype.updateControls;
CharacterScreenLeftPanelHeaderModule.prototype.updateControls = function (_id, _data)
{
	Reforged.Hooks.CharacterScreenLeftPanelHeaderModule_updateControls.call(this, _id, _data);

    if (_data === null || typeof(_data) !== 'object') return;
	if (!(CharacterScreenIdentifier.Entity.Character.ParagonLevel in _data)) return;

    if (_data[CharacterScreenIdentifier.Entity.Character.Level] >= _data[CharacterScreenIdentifier.Entity.Character.ParagonLevel])
	{
		this.mXPProgressbar.addClass('xp-paragon');
	}
	else
	{
		this.mXPProgressbar.removeClass('xp-paragon');
	}
}
