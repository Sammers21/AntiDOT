function(a, e, n, s)
    
    -- 1. Ignite 
    -- 2. Shadow word pain
    -- 3. Vampire touch
    -- 4. Devouring plague
    -- 5. Unstable affliction
    -- 6. Corruption
    -- 7. Shadow Embrace
    -- 8. Agony
    -- 9. Dread Touch
    -- 10. Soul Rot
    -- 11. Haunt
    -- 12. Flame Shock
    -- 13. Moonfire
    -- 14. Sunfire
    -- 15. Immolate
    
    -- DevTool:AddData(a, "a")
    -- DevTool:AddData(e, "e")
    -- DevTool:AddData(n, "n")
    -- DevTool:AddData(s, "s")
    
    function numToStr(num)
        local letter = {
            [0] = "",
            [1] = "K",
            [2] = "M",
            --etc
        }
        local n = num
        local numGroups = 0
        local n2 = n
        while n2 >= 1000 do
            n2 = n2 / 1000
            numGroups = numGroups + 1
        end
        return string.format("%.1f%s", n/1000^numGroups, letter[numGroups])
    end
    
    function getUnit(auras)
        for k, v in pairs(auras) do
            if v.unit ~= nil then
                return v.unit
            end
        end
        return nil
    end
    function rebuildToMap(auras)
        local map = {}
        for k, v in pairs(auras) do
            map[v.name] = k
        end
        return map
    end
    
    function simplehotValue(spell, spellMap)
        if spell == nil then
            return 0
        end
        local spellV = spellMap[spell]
        if spellV == nil then
            return 0
        end
        if spellV.tooltip1 == nil or spellV.tooltip2 == nil then
            return 0
        end
        return spellV.tooltip1 / spellV.tooltip2
    end
    
    function mutliplierWa(spell, spellMap)
        if spell == nil then
            return 1
        end
        local spellV = spellMap[spell]
        if spellV == nil then
            return 1
        end
        return 1 + spellV.tooltip1 / 100
    end
    
    if not a[""] then a[""] = {
            DotDPS = 0,
            DotDPSPercent = 0,
            DotDPSStr = "",
            changed = true,
            show = true,
        }
    end
    
    if e == "TRIGGER" then    
        local unit = getUnit(s)
        if unit == nil then
            return false
        end
        local spells = rebuildToMap(s)
        local ignite = simplehotValue(spells["Ignite"], s)
        local shadowWordPain = simplehotValue(spells["Shadow Word: Pain"], s)
        local vampiricTouch = simplehotValue(spells["Vampiric Touch"], s)
        local devouringPlague = simplehotValue(spells["Devouring Plague"], s)
        local unstableAffliction = simplehotValue(spells["Unstable Affliction"], s)
        local corruption = simplehotValue(spells["Corruption"], s)
        local shadowEmbrace = mutliplierWa(spells["Shadow Embrace"], s)
        local agony = simplehotValue(spells["Agony"], s)
        local dreadTouch = mutliplierWa(spells["Dread Touch"], s)
        local soulRot = simplehotValue(spells["Soul Rot"], s)
        local haunt = mutliplierWa(spells["Haunt"], s)
        local flameShock = simplehotValue(spells["Flame Shock"], s)
        local moonfire = simplehotValue(spells["Moonfire"], s)
        local sunfire = simplehotValue(spells["Sunfire"], s)
        local immolate = simplehotValue(spells["Immolate"], s)
        local total = immolate + moonfire + sunfire + flameShock +  ignite + shadowWordPain + vampiricTouch + devouringPlague + (unstableAffliction + corruption + agony + soulRot) * shadowEmbrace * dreadTouch  * haunt  
        local maxHP = UnitHealthMax(unit)
        local totalPercent = total / maxHP * 100
        a[""] = {
            DotDPS = total,
            DotDPSPercent = totalPercent,
            DotDPSStr = numToStr(total),
            changed = true,
            show = true,
        }
        return true
    end
    
end

