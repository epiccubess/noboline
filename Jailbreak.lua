local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Noboline l Jailbreak (discord.gg/noboline)", "Ocean")

-- Main
local Main = Window:NewTab("Movement")
local MainSection = Main:NewSection("Movement")
MainSection:NewButton("Speed", "Walkspeed", function()
    _G.WS = "150";
                local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid;
                Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                Humanoid.WalkSpeed = _G.WS;
                end)
                Humanoid.WalkSpeed = _G.WS;
end)
MainSection:NewButton("Jump Power (can get kicked)", "Jump Power", function()   
game:GetService('Players').LocalPlayer.Character.Humanoid.JumpPower = 200
end)
MainSection:NewToggle("Fly", "Uses Gravity to make you fly.", function(state)
    if state then
        game.Workspace.Gravity = 1
    else
        game.Workspace.Gravity = 100
    end
end)
local Visual = Window:NewTab("Visuals")
local VisualSection = Visual:NewSection("Visuals")
VisualSection:NewButton("Esp", "You can see other players!", function()
    local Player = game:GetService("Players").LocalPlayer
    local Camera = game:GetService("Workspace").CurrentCamera
    local Mouse = Player:GetMouse()
    local function Dist(pointA, pointB)
        return math.sqrt(math.pow(pointA.X - pointB.X, 2) + math.pow(pointA.Y - pointB.Y, 2))
    end
    
    local function GetClosest(points, dest)
        local min  = math.huge 
        local closest = nil
        for _,v in pairs(points) do
            local dist = Dist(v, dest)
            if dist < min then
                min = dist
                closest = v
            end
        end
        return closest
    end
    
    local function DrawESP(plr)
        local Box = Drawing.new("Quad")
        Box.Visible = false
        Box.PointA = Vector2.new(0, 0)
        Box.PointB = Vector2.new(0, 0)
        Box.PointC = Vector2.new(0, 0)
        Box.PointD = Vector2.new(0, 0)
        Box.Color = Color3.fromRGB(255, 255, 255)
        Box.Thickness = 2
        Box.Transparency = 1
    
        local function Update()
            local c
            c = game:GetService("RunService").RenderStepped:Connect(function()
                if plr.Character ~= nil and plr.Character:FindFirstChildOfClass("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
                    local pos, vis = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                    if vis then 
                        local points = {}
                        local c = 0
                        for _,v in pairs(plr.Character:GetChildren()) do
                            if v:IsA("BasePart") then
                                c = c + 1
                                local p = Camera:WorldToViewportPoint(v.Position)
                                if v.Name == "HumanoidRootPart" then
                                    p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, 0, -v.Size.Z)).p)
                                elseif v.Name == "Head" then
                                    p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, v.Size.Y/2, v.Size.Z/1.25)).p)
                                elseif string.match(v.Name, "Left") then
                                    p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(-v.Size.X/2, 0, 0)).p)
                                elseif string.match(v.Name, "Right") then
                                    p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(v.Size.X/2, 0, 0)).p)
                                end
                                points[c] = p
                            end
                        end
                        local Left = GetClosest(points, Vector2.new(0, pos.Y))
                        local Right = GetClosest(points, Vector2.new(Camera.ViewportSize.X, pos.Y))
                        local Top = GetClosest(points, Vector2.new(pos.X, 0))
                        local Bottom = GetClosest(points, Vector2.new(pos.X, Camera.ViewportSize.Y))
    
                        if Left ~= nil and Right ~= nil and Top ~= nil and Bottom ~= nil then
                            Box.PointA = Vector2.new(Right.X, Top.Y)
                            Box.PointB = Vector2.new(Left.X, Top.Y)
                            Box.PointC = Vector2.new(Left.X, Bottom.Y)
                            Box.PointD = Vector2.new(Right.X, Bottom.Y)
    
                            Box.Visible = true
                        else 
                            Box.Visible = false
                        end
                    else 
                        Box.Visible = false
                    end
                else
                    Box.Visible = false
                    if game.Players:FindFirstChild(plr.Name) == nil then
                        c:Disconnect()
                    end
                end
            end)
        end
        coroutine.wrap(Update)()
    end
    
    for _,v in pairs(game:GetService("Players"):GetChildren()) do
        if v.Name ~= Player.Name then 
            DrawESP(v)
        end
    end
    
    game:GetService("Players").PlayerAdded:Connect(function(v)
        DrawESP(v)
    end)
end)

local Combat = Window:NewTab("Combat")
local ComatSection = Combat:NewSection("Combat")
CombatSection:NewButton("Velocity", "Reduces knockback taken", function()
    print ("HI")
end)
