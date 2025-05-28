::Reforged.HooksMod.hook("scripts/entity/tactical/humans/militia_guest_ranged", function(q) {
	q.onInit = @() { function onInit()
	{
		this.player.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.MilitiaRanged);
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Talents.resize(::Const.Attributes.COUNT, 0);
		this.m.Attributes.resize(::Const.Attributes.COUNT, [
			0
		]);
		this.m.Name = ::Const.Strings.CharacterNames[::Math.rand(0, ::Const.Strings.CharacterNames.len() - 1)];
		this.m.Title = "the Militiaman";
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.getSprite("accessory_special").setBrush("bust_militia_band_01");

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_strength_in_numbers"));
	}}.onInit;

	q.assignRandomEquipment = @(__original) { function assignRandomEquipment()
	{
		__original();

		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	}}.assignRandomEquipment;
});
