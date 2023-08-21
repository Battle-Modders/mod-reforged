Reforged.Hooks.jQuery_assignListItemImage = $.fn.assignListItemImage;
$.fn.assignListItemImage = function(_imagePath)
{
	var scaleString = Reforged.Asset.generateScaleCommand(_imagePath);

	Reforged.Hooks.jQuery_assignListItemImage.call(this, _imagePath);

	var imageLayer = this.find('.image-layer:first');
	var image = imageLayer.find('img:first');
	image.css("transform", scaleString);
};
