function()
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
    
    function simplehotValue(trigger)
        local finalVal = 0.0
        local multiplier = 1 
        if aura_env.states[trigger].show and aura_env.states[trigger].tooltip1 ~= nil and aura_env.states[trigger].tooltip2 ~= nil  then
            finalVal = aura_env.states[trigger].tooltip1 / aura_env.states[trigger].tooltip2
            multiplier = aura_env.states[trigger].matchCount
        end
        return finalVal * multiplier
    end

        
    function mutliplierWa(trigger) 
        local mutliplier = 1.0
        if aura_env.states[trigger].show and aura_env.states[trigger].tooltip1 ~= nil  then
            mutliplier = 1 + aura_env.states[trigger].tooltip1 / 100
        end
        return mutliplier
    end
    
    local dbg = false 
    local ignite = simplehotValue(1)
    local shadowWordPain = simplehotValue(2)
    local vampiricTouch = simplehotValue(3)
    local devouringPlague = simplehotValue(4)
    local unstableAffliction = simplehotValue(5)
    local corruption = simplehotValue(6)
    local shadowEmbrace = mutliplierWa(7)
    local agony = simplehotValue(8)
    local dreadTouch = mutliplierWa(9)
    local soulRot = simplehotValue(10)
    local haunt = mutliplierWa(11)
    local flameShock = simplehotValue(12)
    local moonfire = simplehotValue(13)
    local sunfire = simplehotValue(14)
    local immolate = simplehotValue(15)

    local total = immolate + moonfire + sunfire + flameShock +  ignite + shadowWordPain + vampiricTouch + devouringPlague + (unstableAffliction + corruption + agony + soulRot) * shadowEmbrace * dreadTouch  * haunt

    if dbg then
        DevTool:AddData(immolate, "immolate")
        DevTool:AddData(sunfire, "sunfire")
        DevTool:AddData(moonfire, "moonfire")
        DevTool:AddData(flameShock, "flameShock")
        DevTool:AddData(ignite, "ignite")
        DevTool:AddData(shadowWordPain, "shadowWordPain")
        DevTool:AddData(vampiricTouch, "vampiricTouch")
        DevTool:AddData(devouringPlague, "devouringPlague")
        DevTool:AddData(unstableAffliction, "unstableAffliction")
        DevTool:AddData(corruption, "corruption")
        DevTool:AddData(shadowEmbrace, "shadowEmbrace")
        DevTool:AddData(agony, "agony")
        DevTool:AddData(dreadTouch, "dreadTouch")
        DevTool:AddData(soulRot, "soulRot")
        DevTool:AddData(haunt, "haunt")
        DevTool:AddData("total",total)
    end

    return numToStr(0 + total)
end





