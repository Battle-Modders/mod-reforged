this.rf_barrows <- ::inherit("scripts/entity/tactical/entity", {
	m = {
		IsSpent = false
	},
	function getName()
	{
		return "Barrow";
	}

	function getDescription()
	{
		return "Presumably the last resting place of someone who died long ago.";
	}

	function getTooltip()
	{
		local ret = this.entity.getTooltip();
		ret.push({ id = 10,	type = "text",	icon = "ui/icons/special.png",	text = this.isSpent() ? "Contains a corpse" : "Empty" });
		return ret;
	}

	function setSpent( _s )
	{
		this.m.IsSpent = _s;
	}

	function isSpent()
	{
		return this.m.IsSpent;
	}

	function onInit()
	{
		local variants = [
			"01"
			"02"
			"03"
			"04"
		];
		local tile = this.getTile();
		local isOnSnow = tile.Subtype == ::Const.Tactical.TerrainSubtype.Snow || tile.Subtype == ::Const.Tactical.TerrainSubtype.LightSnow;

		local body = this.addSprite("body");
		body.setBrush("rf_barrows_" + variants[this.Math.rand(0, variants.len() - 1)] + (isOnSnow ? "_snow" : ""));
		body.setHorizontalFlipping(this.Math.rand(0, 1) == 1);
	}
});
