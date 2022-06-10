local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
--Ui
local UI = Material.Load({
    Title = "OneSh0t",
    Style = 3,
    SizeX = 300,
    SizeY = 80,
    Theme = "Light",
})

local Main = UI.New({
    Title = "Main"
})
--Setup
local Players = game:GetService("Players")
local Client = Players.LocalPlayer.Name
local Player = Players.LocalPlayer
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false

--Tp
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

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

--OneSh0t
Main.Toggle({
    Text = 'OneSh0t',
    Callback = function(Value)
      if Value then
        killaura = true
      else
        killaura = false
      end
      while killaura do
        for Index, Value in next, workspace.Mobs:GetChildren() do
            if workspace.Mobs:FindFirstChild(Value.Name) and workspace.Mobs[Value.Name]:FindFirstChild('Head') then
              if (Value['Head'].Position - workspace[Client]['Head'].Position).magnitude < 100  then 
                game:GetService("ReplicatedStorage").ChangeWeld:FireServer("One-Handed Held", "RightLowerArm")
                game:GetService("ReplicatedStorage").DamageMob:FireServer(workspace.Mobs[Value.Name].Humanoid, false, workspace[Client].Sword.Middle)
                workspace.Mobs[Value.Name].Head:Destroy()
              end
          end
      end
      Wait(.25)  
  end
    end,
    killaura = false
  })

  -- Staff Detection // Re-join On kick
  Players.PlayerAdded:Connect(function(Plr)
    if Plr:GetRankInGroup(5683480) > 1 then 
                    Teleport()
                end
            end)

while wait() do
    for Index, Value in next, Players:GetPlayers() do 
        if Value ~= Player and Value:GetRankInGroup(5683480) > 1 then 
            Teleport()
        end
    end
end