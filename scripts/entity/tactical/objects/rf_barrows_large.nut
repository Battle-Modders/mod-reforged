this.rf_barrows_large <- ::inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "Barrow";
	}

	function getDescription()
	{
		return "Presumably the last resting place of someone who died long ago.";
	}

	function onInit()
	{
		local variant = ::MSU.Class.WeightedContainer([
			[1, "01"],
			[0.25, "02"], // sword in ground
			[1, "03"],
			[1, "04"]
		]).roll();

		local tile = this.getTile();
		local isOnSnow = tile.Subtype == ::Const.Tactical.TerrainSubtype.Snow || tile.Subtype == ::Const.Tactical.TerrainSubtype.LightSnow;

		local body = this.addSprite("body");
		body.setBrush("rf_barrows_large_" + variant + (isOnSnow ? "_snow" : ""));
		body.setHorizontalFlipping(::Math.rand(0, 1) == 1);
		this.setBlockSight(true);
	}
});
