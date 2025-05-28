::Reforged.HooksMod.hook("scripts/items/weapons/oriental/two_handed_saif", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 5;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.RF_Southern;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost += 2;
			o.m.Icon = "skills/active_210.png";
			o.m.IconDisabled = "skills/active_210_sw.png";
			o.m.Overlay = "active_210";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/decapitate", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}}.onEquip;
});
