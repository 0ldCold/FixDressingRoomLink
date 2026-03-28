local function dressingLinkToConfig(str)
    local regex =
    "^%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*,%s*-?%d+%s*$"
    local withoutTrash = str:gsub("/customset v1 ", "")
    if not withoutTrash:match(regex) then
        error("Неправильный формат строки 1")
    end

    local arrNumbers = {}

    for item in withoutTrash:gmatch("[^,]+") do
        local trimmed = item:match("^%s*(.-)%s*$")
        local num = tonumber(trimmed)
        if not num then
            error("Неправильный формат строки 2")
        end
        table.insert(arrNumbers, num)
    end

    if #arrNumbers ~= 17 then
        error("Неправильный формат строки 3")
    end

    return {
        INVENTORY_SLOT_HEAD = arrNumbers[1],
        INVENTORY_SLOT_SHOULDERS = arrNumbers[2],
        INVENTORY_SLOT_SHOULDER_2 = arrNumbers[3],
        INVENTORY_SLOT_BACK = arrNumbers[4],
        INVENTORY_SLOT_CHEST = arrNumbers[5],
        INVENTORY_SLOT_SHIRT = arrNumbers[6],
        INVENTORY_SLOT_TABARD = arrNumbers[7],
        INVENTORY_SLOT_WRISTS = arrNumbers[8],
        INVENTORY_SLOT_HANDS = arrNumbers[9],
        INVENTORY_SLOT_WAIST = arrNumbers[10],
        INVENTORY_SLOT_LEGS = arrNumbers[11],
        INVENTORY_SLOT_FEET = arrNumbers[12],
        INVENTORY_SLOT_MAIN_HAND = arrNumbers[13],
        INVENTORY_SLOT_MAIN_HAND_ENCHANT = arrNumbers[15],
        INVENTORY_SLOT_OFF_HAND = arrNumbers[16],
        INVENTORY_SLOT_OFF_HAND_ENCHANT = arrNumbers[17],
    }
end

local function configToChatLink(config)
    local function hashChatConfig(numbersConfig)
        local e = 38
        local t = 86
        local i = 3

        local function getChatItemHesh(item)
            local acc = ""
            for index = i - 1, 0, -1 do
                local charCode = math.floor(item / (t ^ index)) % t + e
                acc = acc .. string.char(charCode)
            end
            return acc
        end

        local result = {}
        for _, num in ipairs(numbersConfig) do
            table.insert(result, getChatItemHesh(num))
        end
        return table.concat(result, "")
    end

    local function genlink(data)
        return "|cffff80ff|Hcustomset:" .. data .. "|h[|T1598183:13:13:-1:0|tOutfit]|h|r"
    end

    local arrConfig = {
        config.INVENTORY_SLOT_HEAD or 0,
        config.INVENTORY_SLOT_SHOULDERS or 0,
        config.INVENTORY_SLOT_BACK or 0,
        config.INVENTORY_SLOT_CHEST or 0,
        config.INVENTORY_SLOT_SHIRT or 0,
        config.INVENTORY_SLOT_TABARD or 0,
        config.INVENTORY_SLOT_WRISTS or 0,
        config.INVENTORY_SLOT_HANDS or 0,
        config.INVENTORY_SLOT_WAIST or 0,
        config.INVENTORY_SLOT_LEGS or 0,
        config.INVENTORY_SLOT_FEET or 0,
        config.INVENTORY_SLOT_MAIN_HAND or 0,
        config.INVENTORY_SLOT_OFF_HAND or 0,
        config.INVENTORY_SLOT_MAIN_HAND_ENCHANT or 0,
        config.INVENTORY_SLOT_OFF_HAND_ENCHANT or 0,
        0,
        config.INVENTORY_SLOT_SHOULDER_2 or 0,
    }

    print()

    return genlink(hashChatConfig(arrConfig))
end


function convertDressingLinkToChatLink(dressingLink)
    return configToChatLink(dressingLinkToConfig(dressingLink))
end
