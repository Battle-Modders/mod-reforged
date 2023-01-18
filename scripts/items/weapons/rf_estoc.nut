this.rf_estoc <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_estoc";
		this.m.Name = "Estoc";
		this.m.Description = "A long two-handed thrusting blade perfect for lunging strikes.";
		this.m.IconLarge = "weapons/melee/rf_estoc_01.png";
		this.m.Icon = "weapons/melee/rf_estoc_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_rf_estoc_01";
		this.m.Value = 2400;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.2;
		this.m.Reach = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/rf_sword_thrust", function(o) {
			o.m.FatigueCost += 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/lunge", function(o) {
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/riposte", function(o) {
		}));
	}

	local onUpdateProperties = ::mods_getMember(o, "onUpdateProperties");
			o.onUpdateProperties <- function( _properties )
			{
				onUpdateProperties(_properties);
				_properties.HitChance[::Const.BodyPart.Head] += -25;
			}

	local getTooltip = ::mods_getMember(o, "getTooltip");
			o.getTooltip <- function()
			{
				local tooltip = getTooltip();
				tooltip.insert(tooltip.len() - 1,
					{
						id = 9,
						type = "text",
						icon = "ui/icons/chance_to_hit_head.png",
						text = "Chance to hit head [color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color]"
					}
				);

				return tooltip;
			}
});
