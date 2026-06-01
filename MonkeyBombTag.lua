local all = {}
all["Library"] = loadstring(game["HttpGet"](game, 'https://raw.githubusercontent.com/NoobHubV1/NoobHubV1/main/Wizard%20Lib.lua'))()
all["Window"] = all["Library"]["NewWindow"](all["Library"], "Monkey Bomb Tag")
all["antiTag"] = false
all["Section"] = all["Window"]["NewSection"](all["Window"], "Main")
all["CollectBanana"] = nil
all["Connecting"] = nil
all["Connecting2"] = nil
all["Connecting3"] = nil
all["Connecting4"] = nil
all["Connecting5"] = nil
all["Connecting6"] = nil
all["Stop"] = nil
all["string"] = getgenv()
all["SavedPos"] = nil
all["Method"] = "Touch"
all["InfJump"] = nil
all["SafeS"] = function(self, service) return game["GetService"](game, service) end
all["RS"] = all["SafeS"](all, "RunService")["RenderStepped"]
all["Section2"] = all["Window"]["NewSection"](all["Window"], "Other")
all["Section3"] = all["Window"]["NewSection"](all["Window"], "Created by NoobHubV6")
all["Fire"] = function(self, part)
    if all["string"]["firetouchinterest"] then
        all["string"]["firetouchinterest"](all["SafeS"](all, "Players")["LocalPlayer"]["Character"]["Hitbox"], part, 0)
        all["string"]["firetouchinterest"](all["SafeS"](all, "Players")["LocalPlayer"]["Character"]["Hitbox"], part, 1)
    end
end
all["UnConnect"] = function(self, connect) if connect then connect["Disconnect"](connect); connect = nil end end
all["TP"] = function(self, cf) all["SafeS"](all, "Players")["LocalPlayer"]["Character"]["HumanoidRootPart"]["CFrame"] = cf end
all["PlayerTP"] = function(self, player)
if not all["Stop"] then
all["Stop"] = true
all["SavedPos"] = all["SafeS"](all, "Players")["LocalPlayer"]["Character"]["HumanoidRootPart"]["CFrame"]
all["Cooldown2"] = all["string"]["os"]["clock"]()
repeat all["RS"]["Wait"](all["RS"])
all["TP"](all, player["FindFirstChild"](player, "Hitbox")["CFrame"])
until all["SafeS"](all, "Workspace")["GetAttribute"](all["SafeS"](all, "Workspace"), "HoldingBomb") ~= all["SafeS"](all, "Players")["LocalPlayer"]["Name"] or (all["string"]["os"]["clock"]() - all["Cooldown2"]) >= 3
all["Stop"] = false
for i = 1, 6 do all["string"]["task"]["wait"]()
all["TP"](all, all["SavedPos"])
end
end
end
all["PlayerTP2"] = function(self, player)
if not all["Stop"] then
all["Stop"] = true
all["SavedPos"] = all["SafeS"](all, "Players")["LocalPlayer"]["Character"]["HumanoidRootPart"]["CFrame"]
all["Cooldown"] = all["string"]["os"]["clock"]()
repeat all["RS"]["Wait"](all["RS"])
all["TP"](all, player["FindFirstChild"](player, "Hitbox")["CFrame"])
until all["SafeS"](all, "Workspace")["GetAttribute"](all["SafeS"](all, "Workspace"), "HoldingBomb") == all["SafeS"](all, "Players")["LocalPlayer"]["Name"] or (all["string"]["os"]["clock"]() - all["Cooldown"]) >= 3
all["Stop"] = false
for i = 1, 6 do all["string"]["task"]["wait"]()
all["TP"](all, all["SavedPos"])
end
end
end
all["Section"]["CreateDropdown"](all["Section"], "Bomb Method", {"Teleport","Touch"}, 2, function(select)
all["Method"] = select
end)
all["Section"]["CreateToggle"](all["Section"], "Anti Bomb", function(state)
     all["antiTag"] = state
     if all["antiTag"] then
            all["Connecting5"] = all["SafeS"](all, "Workspace")["GetAttributeChangedSignal"](all["SafeS"](all, "Workspace"), "BombTime")["Connect"](all["SafeS"](all, "Workspace")["GetAttributeChangedSignal"](all["SafeS"](all, "Workspace"), "BombTime"), function()
                   all["antiBomb"] = all["SafeS"](all, "Workspace")["Runners"]["FindFirstChildOfClass"](all["SafeS"](all, "Workspace")["Runners"], "Model")
                   if all["antiBomb"] and all["SafeS"](all, "Workspace")["GetAttribute"](all["SafeS"](all, "Workspace"), "HoldingBomb") == all["SafeS"](all, "Players")["LocalPlayer"]["Name"] and all["SafeS"](all, "Workspace")["GetAttribute"](all["SafeS"](all, "Workspace"), "BombTime") <= 1 and all["SafeS"](all, "Players")["LocalPlayer"]["GetAttribute"](all["SafeS"](all, "Players")["LocalPlayer"], "PlayedMatch") then
                         if all["Method"] == "Touch" then
                                all["Fire"](all, all["antiBomb"]["FindFirstChild"](all["antiBomb"], "Hitbox"))
                         elseif all["Method"] == "Teleport" then
                                all["PlayerTP"](all, all["antiBomb"])
                         end
                   end
            end)
     else
            all["UnConnect"](all, all["Connecting5"])
     end
end)
all["Section"]["CreateButton"](all["Section"], "Anti Bomb Now", function()
       all["notTag"] = all["SafeS"](all, "Workspace")["Runners"]["FindFirstChildOfClass"](all["SafeS"](all, "Workspace")["Runners"], "Model")
       if all["notTag"] and all["SafeS"](all, "Workspace")["GetAttribute"](all["SafeS"](all, "Workspace"), "HoldingBomb") == all["SafeS"](all, "Players")["LocalPlayer"]["Name"] and all["SafeS"](all, "Players")["LocalPlayer"]["GetAttribute"](all["SafeS"](all, "Players")["LocalPlayer"], "PlayedMatch") then
               if all["Method"] == "Touch" then
                      all["Fire"](all, all["notTag"]["FindFirstChild"](all["notTag"], "Hitbox"))
               elseif all["Method"] == "Teleport" then
                      all["PlayerTP"](all, all["notTag"])
               end
       end
end)
all["Section"]["CreateToggle"](all["Section"], "Auto Steal Bomb", function(state)
     all["autoSteal"] = state
     if all["autoSteal"] then
            all["Connecting6"] = all["SafeS"](all, "Workspace")["GetAttributeChangedSignal"](all["SafeS"](all, "Workspace"), "BombTime")["Connect"](all["SafeS"](all, "Workspace")["GetAttributeChangedSignal"](all["SafeS"](all, "Workspace"), "BombTime"), function()
                   all["bomb"] = all["SafeS"](all, "Workspace")["Bomb"]["FindFirstChildOfClass"](all["SafeS"](all, "Workspace")["Bomb"], "Model")
                   if all["bomb"] and all["SafeS"](all, "Workspace")["GetAttribute"](all["SafeS"](all, "Workspace"), "BombTime") <= 3 and all["SafeS"](all, "Workspace")["GetAttribute"](all["SafeS"](all, "Workspace"), "BombTime") >= 1 and all["SafeS"](all, "Workspace")["GetAttribute"](all["SafeS"](all, "Workspace"), "HoldingBomb") ~= all["SafeS"](all, "Players")["LocalPlayer"]["Name"] and all["SafeS"](all, "Players")["LocalPlayer"]["GetAttribute"](all["SafeS"](all, "Players")["LocalPlayer"], "PlayedMatch") then
                          if all["Method"] == "Touch" then
                                 all["Fire"](all, all["bomb"]["FindFirstChild"](all["bomb"], "Hitbox"))
                          elseif all["Method"] == "Teleport" then
                                 all["PlayerTP2"](all, all["bomb"])
                          end
                   end
            end)
     else
            all["UnConnect"](all, all["Connecting6"])
     end
end)

all["Section"]["CreateButton"](all["Section"], "Steal Now", function()
     all["tag"] = all["SafeS"](all, "Workspace")["Bomb"]["FindFirstChildOfClass"](all["SafeS"](all, "Workspace")["Bomb"], "Model")
     if all["tag"] and all["SafeS"](all, "Workspace")["GetAttribute"](all["SafeS"](all, "Workspace"), "HoldingBomb") ~= all["SafeS"](all, "Players")["LocalPlayer"]["Name"] and all["SafeS"](all, "Players")["LocalPlayer"]["GetAttribute"](all["SafeS"](all, "Players")["LocalPlayer"], "PlayedMatch") then
            if all["Method"] == "Touch" then
                   all["Fire"](all, all["tag"]["FindFirstChild"](all["tag"], "Hitbox"))
            elseif all["Method"] == "Teleport" then
                   all["PlayerTP2"](all, all["tag"])
            end
     end
end)

all["Section2"]["CreateToggle"](all["Section"], "Collect Banana", function(state)
     all["CollectBanana"] = state
     if all["CollectBanana"] then
            all["Connecting"] = all["SafeS"](all, "Workspace")["Bananas"]["ChildAdded"]["Connect"](all["SafeS"](all, "Workspace")["Bananas"]["ChildAdded"], function(p)
                   if p["Name"] == "Banana" and p["IsA"](p, "MeshPart") then
                          all["Fire"](all, p)
                   end
            end)
            for i,v in ipairs(all["SafeS"](all, "Workspace")["Bananas"]["GetChildren"](all["SafeS"](all, "Workspace")["Bananas"])) do
                   if v["Name"] == "Banana" and v["IsA"](v, "MeshPart") then
                          all["Fire"](all, v)
                   end
            end
     else
            all["UnConnect"](all, all["Connecting"])
     end
end)
all["Section2"]["CreateToggle"](all["Section2"], "Ragdoll", function(state)
all["Ragdoll"] = state
if all["Ragdoll"] then
all["Connecting2"] = all["RS"]["Connect"](all["RS"], function()
all["SafeS"](all, "Players")["LocalPlayer"]["Character"]["IsRagdoll"]["Value"] = true
end)
else
all["UnConnect"](all, all["Connecting2"])
all["SafeS"](all, "Players")["LocalPlayer"]["Character"]["IsRagdoll"]["Value"] = false
end
end)
all["Section2"]["CreateToggle"](all["Section3"], "Inf Jump", function(state)
all["InfJump"] = state
if all["InfJump"] then
all["Connecting4"] = all["SafeS"](all, "UserInputService")["JumpRequest"]["Connect"](all["SafeS"](all, "UserInputService")["JumpRequest"], function()
all["SafeS"](all, "Players")["LocalPlayer"]["Character"]["Humanoid"]["ChangeState"](all["SafeS"](all, "Players")["LocalPlayer"]["Character"]["Humanoid"], "Jumping") end)
else
all["UnConnect"](all, all["Connecting4"])
end
end)
