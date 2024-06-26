function()
    -- 1. Ignite 
    -- 2. Shadow word pain
    -- 3. Vampire touch
    -- 4. Devouring plague

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

    local ignite = simplehotValue(1)
    local shadowWordPain = simplehotValue(2)
    local vampiricTouch = simplehotValue(3)
    local devouringPlague = simplehotValue(4)
    local total = ignite + shadowWordPain + vampiricTouch + devouringPlague
    return numToStr(total)
end





