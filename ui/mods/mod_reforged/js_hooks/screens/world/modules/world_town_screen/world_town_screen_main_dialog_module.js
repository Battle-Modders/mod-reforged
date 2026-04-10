Reforged.Hooks.WorldTownScreenMainDialogModule_updateContracts = WorldTownScreenMainDialogModule.prototype.updateContracts;
WorldTownScreenMainDialogModule.prototype.updateContracts = function (_data)
{
	// We explicitly remove our custom character portraits before vanilla updates the list.
	this.mDialogContainer.findDialogContentContainer().find('.rf-contract-character').remove();
	Reforged.Hooks.WorldTownScreenMainDialogModule_updateContracts.call(this, _data);
};

Reforged.Hooks.WorldTownScreenMainDialogModule_createContract = WorldTownScreenMainDialogModule.prototype.createContract;
WorldTownScreenMainDialogModule.prototype.createContract = function (_data, _i, _isDisabled, _content)
{
	Reforged.Hooks.WorldTownScreenMainDialogModule_createContract.call(this, _data, _i, _isDisabled, _content);
	var self = this;

	if (_data !== null)
	{
		var contract = _content.find('.is-contract.contract' + _i);
		if (contract.length > 0)
		{
			contract.unbindTooltip();
			contract.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "Contract.Tooltip+" + _data.ID, difficultyIcon: _data.DifficultyIcon });

			// Right click to dismiss contract
			// We allow dismissing even disabled contracts i.e. even while you have an active contract.
			contract.on('mousedown', function (_event)
			{
				if (_event.which === 3)
				{
					self.mParent.RF_notifyBackendContractRightClicked(_data.ID);
				}
			});

			contract.on('contextmenu', function (_event)
			{
				_event.preventDefault();
			});
		}

		if ('CharacterImagePath' in _data && _data.CharacterImagePath !== null)
		{
			// We use the vanilla 'createListBrother' component to set up a standard roster slot.
			// This gives us the standard 7.1rem x 7.8rem footprint and the internal layer structure.
			var characterContainer = _content.createListBrother(_data.ID, 'rf-contract-character is-character contract' + _i + (_isDisabled ? ' is-disabled' : ''));

			// Sync tooltip and positioning
			characterContainer.insertBefore(contract);

			characterContainer.on('click', function () { contract.click(); });
			characterContainer.on('mousedown', function (_event)
			{
				if (_event.which === 3) contract.trigger(_event);
			});
			characterContainer.on('contextmenu', function (_event)
			{
				_event.preventDefault();
			});
			characterContainer.on('mouseover', function () {
				if (!_isDisabled)
					characterContainer.addClass('is-selected');
				contract.trigger('mouseover');
			});
			characterContainer.on('mouseout', function () {
				if (!_isDisabled)
					characterContainer.removeClass('is-selected');
				contract.trigger('mouseout');
			});

			// pair.on('mouseover', function () {
			// 	characterContainer.addClass('is-selected');
			// 	// If we hovered the character, we manually trigger the contract's hover
			// 	// so the vanilla scroll icons and contract bust highlight properly.
			// 	if (this === characterContainer[0]) contract.trigger('mouseover');
			// });

			// pair.on('mouseout', function () {
			// 	characterContainer.removeClass('is-selected');
			// 	if (this === characterContainer[0]) contract.trigger('mouseout');
			// });

			var imageOffsetX = ('ImageOffsetX' in _data ? _data['ImageOffsetX'] : 0);
			var imageOffsetY = ('ImageOffsetY' in _data ? _data['ImageOffsetY'] : 0);
			// Use the vanilla helper with a bit smaller than the standard roster scale of 0.66. This calls
			// centerImageWithinParent(..., false), allowing gear to overflow without shrinking the head.
			characterContainer.assignListBrotherImage(Path.PROCEDURAL + _data.CharacterImagePath, imageOffsetX, imageOffsetY, 0.6);
		}
	}
};
