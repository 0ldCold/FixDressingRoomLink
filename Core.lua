MyAddon = LibStub("AceAddon-3.0"):NewAddon("FixDressingRoomLinkAddon", "AceConsole-3.0")

-- MyAddon:Print("Hello, world! OnInitialize")

function MyAddon:OnInitialize()
    self:RegisterChatCommand("customset", "FoundLink")
end

function MyAddon:FoundLink(input)
    local fullCommand = "/customset " .. input;
    local success, result = pcall(convertDressingLinkToChatLink, fullCommand)
    if success then
        print(result)
    else
        MyAddon:Print(result)
    end
end
