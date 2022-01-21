-- Add to in-game tooltips at mouse over (Like atlas loot)
GameTooltip:HookScript("OnTooltipSetItem", function(tooltip, ...)
    addToolTip(tooltip)
end)

-- Add to in-game tooltips on click (Like chat links)
ItemRefTooltip:HookScript("OnTooltipSetItem", function(tooltip, ...)
    addToolTip(tooltip)
end)




function addToolTip(tooltip)
    local itemName, itemLink = tooltip:GetItem()
    
    if itemLink then
      priority, note = searchForItemPrioAndNote(itemLink:match("item:(%d+):")) -- Using the in-game item link find the Item ID in the string and search through the table to find a match.
    end
  
    if priority then
        if priority ~= "" and priority ~= "NoteOnly" then
            priority = string.format("%s", priority)
            priority = classColour(priority)
            tooltip:AddLine("# Best in Slot Vaillants : \n"..priority, .9,.8,.5) -- "Priority:" = Pink, anything else is default white
    
            if note ~= "" then
                note = string.format("%s", note)
                note = classColour(note)
                tooltip:AddLine("|cFFE6007ENote|r : "..note, 1, 1, 1) -- "Note:" = Pink, anything else is default white
            end
        elseif priority == "NoteOnly" then
            if note ~= "" then
                note = string.format("%s", note)
                note = classColour(note)
                tooltip:AddLine("|cFFE6007ENote|r : "..note, 1, 1, 1) -- "Note:" = Pink, anything else is default white
            end
        end
    end
end

-- Add class colours to each string returned from the loot tables
function classColour(class)

    -- Default Wow Classic class colours
    class = class:gsub("Druide", "|cFFFF7C0ADruid|r")
    class = class:gsub("Chasseur", "|cFFAAD372Hunter|r")
    class = class:gsub("Mage", "|cFF3FC7EBMage|r")
    class = class:gsub("Paladin", "|cFFF48CBAPala|r")
    class = class:gsub("Prêtre", "|cFFFFFFFFPriest|r")
    class = class:gsub("Voleur", "|cFFFFF468Rogue|r")
    class = class:gsub("Chaman", "|cFF0070DDShaman|r")
    class = class:gsub("Démo", "|cFF8788EEWarlock|r")
    class = class:gsub("Guerrier", "|cFFC69B6DWar|r")

    -- Custom Phase 
    class = class:gsub("P1", "|cFF00FFFFP1|r") -- Cyan
    class = class:gsub("P2", "|cFF6050DCP2|r") -- Bleu majorelle
    class = class:gsub("P3", "|cFFF0C300P3|r") -- Ambre
    class = class:gsub("P4", "|cFFCC5500P4|r") -- Orange brulée
    class = class:gsub("P5", "|cFFFF6B6BP5|r") -- rouge
     -- Custom Spé
    class = class:gsub("Holy", "|cFF66ff00Holy|r") -- Vert
    class = class:gsub("Heal", "|cFF66ff00Heal|r") -- Vert
    class = class:gsub("Resto", "|cFF66ff00Resto|r") -- Vert
    class = class:gsub("SP", "|cFF9d00ffSP|r") -- Violet 1
    class = class:gsub("Tank", "|cFFE6007ETank|r") -- rouge 2




    return class
end

-- look for class priority & note from the relevant loot table
function searchForItemPrioAndNote(itemId)
    for index, value in next, Run_loot_table do
        if value["itemId"] == itemId then
            return value["classPriority"], value["note"]
        end
    end
    
    
end
