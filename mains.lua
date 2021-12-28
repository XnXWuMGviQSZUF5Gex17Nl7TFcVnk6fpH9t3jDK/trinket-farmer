---@diagnostic disable: undefined-global, deprecated
repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
power = 5000
dampening = 700
plr = game.Players.LocalPlayer
mouse = plr:GetMouse()
char = plr.Character
par = Instance.new("Part", game.Workspace) --
par.CFrame = char.PrimaryPart.CFrame
par.CanCollide = false
par.Transparency = 1
wel = Instance.new("Weld", par) -- weld to person to bypass anticheat detecting a body mover in ur character because im lazy to look for the anticheat myself :(
wel.Part0 = char.PrimaryPart
wel.Part1 = par
-- noclip
loadstring(game:HttpGet("https://pastebin.com/raw/tUUGAeaH", true))()

for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v.ClassName == "Part" or v.ClassName == "MeshPart" then
        spoof(v, "CanCollide", true)
    end
end

local rs = game:GetService("RunService")
local plr = game:GetService("Players").LocalPlayer
local noclip_conn

-- enable
noclip_conn =
    rs.Stepped:Connect(
    function()
        for i, v in ipairs(plr.Character:GetChildren()) do
            pcall(
                function()
                    v.CanCollide = false
                end
            )
        end
    end
)
--webhook
local function webhook(msg)
    local url = _G.Webhook
    local data = {
    ["content"] = "",
    ["embeds"] = {
        {
            ["title"] = "**ruins trinket farmer**",
            ["description"] = msg,
            ["type"] = "rich",
            ["color"] = tonumber(0x7269da)
        }
    }
    }
    local newdata = game:GetService("HttpService"):JSONEncode(data)

    local headers = {
    ["content-type"] = "application/json"
    }
    request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
end
-- new pickup
game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(child)
    webhook("picked up a **".. child.Name.. "** on the account **".. game.Players.LocalPlayer.Name.. "**")
end)
-- auto trinket pick up
pcall(function()
    local Closest
    local trinket
    
    function getclosestpart()
        local name = game.Players.LocalPlayer.Name
        if game.Workspace.Live:FindFirstChild(name) then
        local PlayerPosition = game.Players.LocalPlayer.Character.PrimaryPart.Position
        for i, v in pairs(game.Workspace.Folder:GetChildren()) do
                if trinket == nil then
                trinket = v
                    else
                    if (PlayerPosition - v.Position).magnitude < (trinket.Position - PlayerPosition).magnitude and not v.Blacklist:FindFirstChild(name, true) then
                                for i2,v2 in pairs(game.Workspace.Thrown:GetChildren()) do
                                     if v2:FindFirstChild("Mesh") then
                                        if v2.Position == v.Position then
                                            trinket = v
                                            Closest = v2
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
    
            local runservice = game:GetService("RunService")
            
            runservice.Heartbeat:Connect(function()
                wait()
                getclosestpart()
                if Closest ~= nil and trinket ~= nil and trinket.Position == Closest.Position then
                    local PlayerPositions = game.Players.LocalPlayer.Character.PrimaryPart.Position
                    local distnc = (trinket.Position - PlayerPositions).magnitude
                    if distnc < 8 then
                        wait()
                        local virtualUser = game:GetService('VirtualUser')
                         virtualUser:CaptureController()
                        virtualUser:ClickButton1(Vector2.new(100, 100))
                        trinket = nil
                    end
                else
                   getclosestpart()
                end
                    end)
    
    local mouse = game.Players.LocalPlayer:GetMouse()
    local target = mouse.Target
    
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old
    old = hookfunction(mt.__index, function(obj, key)
            if obj == mouse and tostring(key) == "Target" and not checkcaller() then
                return trinket
            end
            return old(obj, key)
        end)
    end)
--setup
local burnout = true
_G.On = false
clicked = false
function onKeyPress(inputObject, gameProcessedEvent)
    if inputObject.KeyCode == Enum.KeyCode.B and _G.On == false then
        _G.On = true
        print(_G.On)
    elseif inputObject.KeyCode == Enum.KeyCode.B and _G.On == true then
        _G.On = false
        print(_G.On)
    end
end
-- webhook
--[[
"picked up a **".. pickedup.. "** on the account **".. game.Players.LocalPlayer.Name.. "**"
]]

--serverhop func
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

local function Teleport()
    while wait() do
        pcall(function()
            webhook("trinket farming finished. serverhopping..")
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end
-- player detector 
--[[
local function lol()
    for _, player in pairs(game.Players:GetPlayers()) do
        local studs = (player.Character.PrimaryPart.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).magnitude
        if player.Name ~= game.Players.LocalPlayer.Name then
            if studs <= 100  then
                Teleport()
            end
        end
    end
end
while true do
    wait()
    lol()
end
]]--


-- positions (storing)
--[[{
    -6680.99, -5.58478, -30.3776
    -6659.82, -8.73477, -46.5696
    -6651.32, -8.59997, -78.4454
    -6672.91, -8.68477, -84.2426
    -6681.46, -8.73477, -52.3672
    -6844.1, -6.05336, 114.728

    stands
    -6782.65, -7.15335, 136.175
    -6787.82, -6.05336, 129.809
    -6768.95, -6.05336, 134.867
    -6731.7, -6.05336, 144.847
    -6897.58, 36.4793, 42.4405
    -6913.43, 36.4793, 15.0721
}]]--

local function restart()
    while true do
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6755.34, -9.65836, -199.594)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
            end)
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true
    

        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        Teleport()
    end
end

local function twelveth()
    while true do
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6913.43, 36.4793, 15.0721)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
            end)
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true
    

        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        restart()
    end
end

local function eleventh()
    while true do
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6897.58, 36.4793, 42.4405)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
            end)
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true
    

        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        twelveth()
    end
end

local function tenth()
    while true do
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6731.7, -6.05336, 144.847)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
            end)
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true
    

        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        eleventh()
    end
end

local function nineth()
    while true do
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6768.95, -6.05336, 134.867)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
            end)
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true
    

        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        tenth()
    end
end

local function eighth()
    while true do
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6787.82, -6.05336, 129.809)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
            end)
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true
    
        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        nineth()
    end
end

local function seventh()
    while true do
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6782.65, -7.15335, 136.175)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
            end)
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true
    

        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        eighth()
    end
end

local function sixth()
    while true do
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6844.1, -6.05336, 114.728)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
            end)
        
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true

        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        seventh()
    end
end

local function fifth()
    while true do
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6844.1, -6.05336, 114.728)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
            end)
        
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true

        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        sixth()
    end
end

local function fourth()
    while true do
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6681.46, -8.73477, -52.3672)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
        end)
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true

        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        fifth()
    end
end

local function third()
    while true do
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6672.91, -8.68477, -84.2426)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
            end)
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true

        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        fourth()
    end
end

local function second3()
    while true do
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6680.29, -8.73477, -56.7139)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
            end)
        
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true

        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        third()
    end
end

local function second2()
    while true do
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6650.16, -8.59997, -82.7921)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
            end)
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true

        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        second3()
    end
end

local function second()
        wait()
        local body = Instance.new("BodyPosition", par)
        body.P = power
        body.D = dampening
        body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body.Position = Vector3.new(-6659.82, -8.73477, -46.5696)
    
        char.Humanoid.Sit = true
        par.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function() -- if u dont reach the destination end the burnout
            burnout=false
            wait(5)
            burnout=true
        end)
        local pos = mouse.Hit.p
        repeat wait() par.RotVelocity = Vector3.new(0, 0, 0) local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true

        local body3 = Instance.new("BodyVelocity", par)
        body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        body3.P = math.huge
        body3.Velocity = Vector3.new(0, 0, 0)
        body:Remove()

        wait(1)
        body3:Remove()

        char.Humanoid.Sit = false
        char.PrimaryPart.Anchored = false
        clicked = false
        second2()
end

local function start()
    local body = Instance.new("BodyPosition", par)

    body.P = power
    body.D = dampening
    body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    body.Position = Vector3.new(-6680.99, -5.58478, -30.3776)

    char.Humanoid.Sit = true
    par.Velocity = Vector3.new(0, 0, 0)
    spawn(
        function()
            -- if u dont reach the destination end the burnout
            burnout = false
            wait(5)
            burnout = true
        end
    )
    local pos = mouse.Hit.p
    repeat wait() local mag = (char.PrimaryPart.Position - pos).magnitude until mag <= 7 or burnout == true

    local body3 = Instance.new("BodyVelocity", par)
    body3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    body3.P = math.huge
    body3.Velocity = Vector3.new(0, 0, 0)
    body:Remove()

    wait(1)
    body3:Remove()

    char.Humanoid.Sit = false
    char.PrimaryPart.Anchored = false
    clicked = false
    second()
end

start()
