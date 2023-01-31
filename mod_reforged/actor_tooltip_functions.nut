::Reforged.TacticalTooltip <- {}

// Returns a list of all attributes in tooltip-form which are not displayed as progressbars on the tooltips
// Those are Melee/Ranged Skill/Defense, Resolve and Initiative
::Reforged.TacticalTooltip.getTooltipAttributesSmall <- function( _actor, _startID )
{
    local currentID = _startID;
    local gapLength = 6;
    local attributeList = [];
    // ::Reforged.TacticalTooltip.pushSectionName(attributeList, "Attributes", currentID);
    currentID++;

    local meleeSkillText = 		::Reforged.TacticalTooltip.getAttributeEntry("melee_skill_15px.png", _actor.getCurrentProperties().getMeleeSkill(), _actor.getCurrentProperties().getMeleeSkill() - _actor.getBaseProperties().getMeleeSkill());
    local meleeDefenseText = 	::Reforged.TacticalTooltip.getAttributeEntry("melee_defense_15px.png", _actor.getCurrentProperties().getMeleeDefense(), _actor.getCurrentProperties().getMeleeDefense() - _actor.getBaseProperties().getMeleeDefense());
    local rangedSkillText = 	::Reforged.TacticalTooltip.getAttributeEntry("ranged_skill_15px.png", _actor.getCurrentProperties().getRangedSkill(), _actor.getCurrentProperties().getRangedSkill() - _actor.getBaseProperties().getRangedSkill());
    local rangedDefenseText = 	::Reforged.TacticalTooltip.getAttributeEntry("ranged_defense_15px.png", _actor.getCurrentProperties().getRangedDefense(), _actor.getCurrentProperties().getRangedDefense() - _actor.getBaseProperties().getRangedDefense());
    local resolveText = 		::Reforged.TacticalTooltip.getAttributeEntry("bravery_15px.png", _actor.getCurrentProperties().getBravery(), _actor.getCurrentProperties().getBravery() - _actor.getBaseProperties().getBravery());
    local initiativeText = 		::Reforged.TacticalTooltip.getAttributeEntry("initiative_15px.png", _actor.getInitiative(), _actor.getInitiative() - _actor.getBaseProperties().getInitiative());

    local meleeSkill = "" + _actor.getCurrentProperties().getMeleeSkill();
    local meleeDefense = "" + _actor.getCurrentProperties().getMeleeDefense();
    local firstRow = meleeSkillText + ::Reforged.TacticalTooltip.getSpacebars(gapLength - (meleeSkill.len() * 2)) + meleeDefenseText + ::Reforged.TacticalTooltip.getSpacebars(gapLength - (meleeDefense.len() * 2)) + resolveText;

    attributeList.push({
        id = currentID,
        type = "text",
        text = firstRow
    });
    currentID++;

    local rangedSkill = "" + _actor.getCurrentProperties().getRangedSkill();
    local rangedDefense = "" + _actor.getCurrentProperties().getRangedDefense();
    local secondRow = rangedSkillText + ::Reforged.TacticalTooltip.getSpacebars(gapLength - (rangedSkill.len() * 2)) + rangedDefenseText + ::Reforged.TacticalTooltip.getSpacebars(gapLength - (rangedDefense.len() * 2)) + initiativeText;

    attributeList.push({
        id = currentID,
        type = "text",
        text = secondRow
    });
    currentID++;

    return attributeList;
}

// Returns a list of all effects in tooltip-form
::Reforged.TacticalTooltip.getTooltipEffects <- function( _actor, _startID )
{
    local currentID = _startID;
    local collapseThreshold = ::Reforged.Mod.ModSettings.getSetting("CollapseEffectsWhenX").getValue();
    local effectList = [];

    local statusEffects = _actor.getSkills().query(::Const.SkillType.StatusEffect, false, true);
    if (statusEffects.len() != 0 || ::Reforged.Mod.ModSettings.getSetting("HeaderForEmptyCategories").getValue() == true) ::Reforged.TacticalTooltip.pushSectionName(effectList, "Effects", currentID);
    currentID++;

    if (statusEffects.len() < collapseThreshold)
    {
        foreach( statusEffect in statusEffects )
        {
            local effect = {
                id = currentID,
                type = "text",
                icon = statusEffect.getIcon(),
                text = ::Reforged.TacticalTooltip.getNestedSkillName(statusEffect)
            };
            currentID++;

            effectList.push(effect);
        }
    }
    else
    {
        local entryText = "";
        statusEffects.sort(@(a,b) a.getName() <=> b.getName());
        foreach( statusEffect in statusEffects )
        {
            entryText += ::Reforged.TacticalTooltip.getNestedSkillName(statusEffect, underlineFirstCharacter(statusEffect.getName()));
            entryText += ", ";
        }
        if (entryText.len() != 0) entryText = entryText.slice(0, -2);

        effectList.push({
            id = currentID,
            type = "text",
            text = entryText
        });
        currentID++;
    }

    return effectList;
}

// Returns a list of all perks in tooltip-form
::Reforged.TacticalTooltip.getTooltipPerks <- function( _actor, _startID )
{
    local currentID = _startID;
    local collapseThreshold = ::Reforged.Mod.ModSettings.getSetting("CollapsePerksWhenX").getValue();
    local perkList = [];

    local perks = _actor.getSkills().query(::Const.SkillType.Perk, true, true);
    if (perks.len() != 0 || ::Reforged.Mod.ModSettings.getSetting("HeaderForEmptyCategories").getValue() == true) ::Reforged.TacticalTooltip.pushSectionName(perkList, "Perks", currentID);
    currentID++;

    // Sometimes perks add information through their getName(). That is only relevant for the 'Effects' section and should be discarded under 'Perks'
    perks.sort(@(a,b) a.m.Name <=> b.m.Name);
    if (perks.len() < collapseThreshold)
    {
        foreach( i, perk in perks )
        {
            local perkEntry = {
                id = currentID,
                type = "text",
                icon = perk.getIcon(),
                text = ::Reforged.TacticalTooltip.getNestedPerkName(perk)
            };
            currentID++;

            perkList.push(perkEntry);
        }
    }
    else
    {
        local entryText = "";
        foreach( perk in perks )
        {
            entryText += ::Reforged.TacticalTooltip.getNestedPerkName(perk);
            entryText += ", ";
        }
        if (entryText.len() != 0) entryText = entryText.slice(0, -2);

        perkList.push({
            id = currentID,
            type = "text",
            text = entryText
        });
        currentID++;
    }

    return perkList;
}

// Returns a list of all important equipped items of the character in tooltip-form
::Reforged.TacticalTooltip.getTooltipEquippedItems <- function( _actor, _startID )
{
    local currentID = _startID;
    local itemList = [];

    local mainhandItems = _actor.getItems().getAllItemsAtSlot(::Const.ItemSlot.Mainhand);
    local offhandItems = _actor.getItems().getAllItemsAtSlot(::Const.ItemSlot.Offhand);
    local accessories = _actor.getItems().getAllItemsAtSlot(::Const.ItemSlot.Accessory);

    if (mainhandItems.len() != 0 || offhandItems.len() != 0 || accessories.len() != 0 || ::Reforged.Mod.ModSettings.getSetting("HeaderForEmptyCategories").getValue() == true) ::Reforged.TacticalTooltip.pushSectionName(itemList, "Equipped Items", currentID);
    currentID++;

    foreach(mainhandItem in mainhandItems)
    {
        itemList.push({
            id = currentID,
            type = "text",
            icon = "ui/items/" + mainhandItem.getIcon(),
            text = ::Reforged.Mod.Tooltips.parseString(format("[%s|Item+%s,%s,entity]", mainhandItem.getName(), split(::IO.scriptFilenameByHash(mainhandItem.ClassNameHash), "/").top(), mainhandItem.getInstanceID()))
        });
        currentID++;
    }
    foreach(offhandItem in offhandItems)
    {
        itemList.push({
            id = currentID,
            type = "text",
            icon = "ui/items/" + offhandItem.getIcon(),
            text = ::Reforged.Mod.Tooltips.parseString(format("[%s|Item+%s,%s,entity]", offhandItem.getName(), split(::IO.scriptFilenameByHash(offhandItem.ClassNameHash), "/").top(), offhandItem.getInstanceID()))
        });
        currentID++;
    }
    foreach(accessory in accessories)
    {
        itemList.push({
            id = currentID,
            type = "text",
            icon = "ui/items/" + accessory.getIcon(),
            text = ::Reforged.Mod.Tooltips.parseString(format("[%s|Item+%s,%s,entity]", accessory.getName(), split(::IO.scriptFilenameByHash(accessory.ClassNameHash), "/").top(), accessory.getInstanceID()))
        });
        currentID++;
    }

    return itemList;
}

// Returns a list of all important bag items of the character in tooltip-form
::Reforged.TacticalTooltip.getTooltipBagItems <- function( _actor, _startID )
{
    local currentID = _startID;
    local itemList = [];

    local bagItems = _actor.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag);
    if (bagItems.len() != 0 || ::Reforged.Mod.ModSettings.getSetting("HeaderForEmptyCategories").getValue() == true) ::Reforged.TacticalTooltip.pushSectionName(itemList, "Items in bag", currentID);
    currentID++;

    foreach(bagItem in bagItems)
    {
        itemList.push({
            id = currentID,
            type = "text",
            icon = "ui/items/" + bagItem.getIcon(),
            text = ::Reforged.Mod.Tooltips.parseString(format("[%s|Item+%s,%s,entity]", bagItem.getName(), split(::IO.scriptFilenameByHash(bagItem.ClassNameHash), "/").top(), bagItem.getInstanceID()))
        });
        currentID++;
    }

    return itemList;
}

// Returns a list of all items that are on the ground below the entity in tooltip form
::Reforged.TacticalTooltip.getGroundItems <- function( _actor, _startID )
{
    local currentID = _startID;
    local itemList = [];

    local groundItems = _actor.getTile().Items;
    if (groundItems.len() != 0)
    {
        ::Reforged.TacticalTooltip.pushSectionName(itemList, "Items on ground", currentID);
        currentID++;
        foreach(groundItem in groundItems)
        {
            itemList.push({
                id = currentID,
                type = "text",
                icon = "ui/items/" + groundItem.getIcon(),
                text = ::Reforged.Mod.Tooltips.parseString(format("[%s|Item+%s,%s,ground]", groundItem.getName(), split(::IO.scriptFilenameByHash(groundItem.ClassNameHash), "/").top(), groundItem.getInstanceID()))
            });
            currentID++;
        }
    }

    return itemList;
}

::Reforged.TacticalTooltip.getSpacebars <- function( _amount )
{
    local ret = "";
    for (local i = 0; i < _amount; i++)
    {
        ret += "&nbsp;";
    }
    return ret;
}

::Reforged.TacticalTooltip.getAttributeEntry <- function( _icon, _currentValue, _difference )
{
    local bracketsTextSize = 10;
    local entryText = "[img]gfx/ui/icons/" + _icon + "[/img] " + _currentValue;
    if (_difference != 0) entryText += "[size=" + bracketsTextSize + "] (" + ::MSU.Text.colorizeValue(_difference) + ")[/size]";
    return entryText;
}

::Reforged.TacticalTooltip.underlineFirstCharacter <- function ( _string )
{
    if (_string.len() == 0) return "";
    return "[u]" + _string.slice(0, 1) + "[/u]" + _string.slice(1);
};

::Reforged.TacticalTooltip.pushSectionName <- function ( _list, _title, _startID )
{
    _list.push({
        id = _startID,
        type = "text",
        text = "[u][size=15]" + _title + "[/size][/u]"
    });
};

// These two functions are temporary at this spot. They should be made into more global reforged functions because they will be needed in other places aswell
::Reforged.TacticalTooltip.getNestedPerkName <- function ( _perk, _displayName = null )
{
    if (_displayName == null) _displayName = _perk.m.Name;
    local fileName = split(::IO.scriptFilenameByHash(_perk.ClassNameHash), "/").top();
    local nestedText = ::Reforged.Mod.Tooltips.parseString(format("[%s|%s]", _displayName, "Perk+" + fileName));
    return nestedText;
}

// All other kinds of skills like effects and actives
::Reforged.TacticalTooltip.getNestedSkillName <- function ( _skill, _displayName = null )
{
    if (_displayName == null) _displayName = _skill.getName();
    local fileName = split(::IO.scriptFilenameByHash(_skill.ClassNameHash), "/").top();
    local nestedText = ::Reforged.Mod.Tooltips.parseString(format("[%s|%s]", _displayName, "Skill+" + fileName));
    return nestedText;
}
