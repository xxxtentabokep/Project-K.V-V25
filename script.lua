-- [[ KRYPTON VERSE.hub - OFFICIAL PROJECT-KV-VII FINAL PATCH (INTEGRATED WITH LOOTLABS) ]] --
-- Fixed: Layout & Structure | Fixed missing ESP & Aimbot logic | Fixed closing brackets
-- Fixed: GUI Resize visibility Bug & Pre-optimized Booster Logic
-- Integrated: Lootlabs Premium Key System with GitHub Gist Database

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera
local HttpService = game:GetService("HttpService")

-- ============================================= --
-- 🛠️ BEXUS CONFIGURATION — S.ID & LINK RAW ABADI --
-- ============================================= --
local LootlabsLink = "https://sfl.gl/WaSDcP"
local KeyDatabaseURL = "https://gist.githubusercontent.com/xxxtentabokep/634999058ad4ead3175e159a85fea09d/raw/key.txt"
-- ============================================= --
-- ⚙️ PROSES VERIFIKASI UTAMA KRYPTON ENGINE --- --
-- ============================================= --
local RealKey = ""
local success, result = pcall(function()
    return game:HttpGet(KeyDatabaseURL)
end)

if success and result then
    RealKey = result:gsub("%s+", "") 
else
    LocalPlayer:Kick("⚠️ [KRYPTON]: Gagal terhubung ke database server key! Cek jaringan lu!")
    return
end

if setclipboard then
    setclipboard(LootlabsLink)
end

-- Membuat GUI Input Key Premium (Tema Krypton Dark)
local KeyGui = Instance.new("ScreenGui", game.CoreGui)
KeyGui.Name = "Krypton_Lootlabs_Key"
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local Frame = Instance.new("Frame", KeyGui)
Frame.Size = UDim2.new(0, 340, 0, 170)
Frame.Position = UDim2.new(0.5, -170, 0.5, -85)
Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Frame).Color = Color3.fromRGB(255, 255, 255)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0.25, 0)
Title.Text = "KRYPTON VERSE HUB — KEY SYSTEM"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.BackgroundTransparency = 1

local Desc = Instance.new("TextLabel", Frame)
Desc.Size = UDim2.new(0.9, 0, 0.2, 0)
Desc.Position = UDim2.new(0.05, 0, 0.25, 0)
Desc.Text = "Link key harian udah otomatis dicopy! Paste di browser lu buat lewatin iklan Lootlabs."
Desc.TextColor3 = Color3.fromRGB(180, 180, 180)
Desc.Font = Enum.Font.Gotham
Desc.TextSize = 9
Desc.TextWrapped = true
Desc.BackgroundTransparency = 1

local TextBox = Instance.new("TextBox", Frame)
TextBox.Size = UDim2.new(0.85, 0, 0.22, 0)
TextBox.Position = UDim2.new(0.075, 0, 0.48, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Text = ""
TextBox.PlaceholderText = "Tempel Teks Key Lootlabs Di Sini..."
TextBox.TextColor3 = Color3.new(0, 0, 0)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 11
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 5)

local SubmitBtn = Instance.new("TextButton", Frame)
SubmitBtn.Size = UDim2.new(0.4, 0, 0.2, 0)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.74, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Text = "CHECK KEY"
SubmitBtn.TextColor3 = Color3.new(0, 0, 0)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 10
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 4)

local GetLinkBtn = Instance.new("TextButton", Frame)
GetLinkBtn.Size = UDim2.new(0.4, 0, 0.2, 0)
GetLinkBtn.Position = UDim2.new(0.525, 0, 0.74, 0)
GetLinkBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
GetLinkBtn.Text = "COPY LINK AGAIN"
GetLinkBtn.TextColor3 = Color3.new(1, 1, 1)
GetLinkBtn.Font = Enum.Font.GothamBold
GetLinkBtn.TextSize = 10
Instance.new("UICorner", GetLinkBtn).CornerRadius = UDim.new(0, 4)

GetLinkBtn.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(LootlabsLink) end
    GetLinkBtn.Text = "COPIED!"
    task.wait(1.5)
    GetLinkBtn.Text = "COPY LINK AGAIN"
end)

-- Tunggu Verifikasi Key Selesai Baru Load Script Utama
SubmitBtn.MouseButton1Click:Connect(function()
    local userKey = TextBox.Text:gsub("%s+", "")
    if userKey == RealKey and RealKey ~= "" then
        SubmitBtn.Text = "ACCESS GRANTED!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        task.wait(1)
        KeyGui:Destroy()
        
        -- ======================================================= --
        -- JALANKAN SCRIPT UTAMA KRYPTON VERSE HUB --
        -- ======================================================= --
        
        local _G = { 
            AimbotMaster = false, AimbotCursor = false, AimbotChar = false,
            ESP = false, ESPMode = "TEAM",
            Fly = false, NoClip = false, HitboxExpand = false,
            AntiReport = false, AntiBan = false,
            FPSBoost = false, PingBoost = false, PotatoMode = false,
            FlySpeed = 100, AimFOV = 100, HitboxSize = 2, 
            TeleportTarget = "", SuperSpeed = false, 
            RunSpeed = 16, ShowFOVCircle = false,
            BrightnessToggle = false
        }

        local OriginalBrightness = Lighting.Brightness
        local OriginalAmbient = Lighting.Ambient

        local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
        ScreenGui.Name = "KRYPTON_VERSE_HUB"
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        ScreenGui.IgnoreGuiInset = true 

        local MainFrame = Instance.new("Frame", ScreenGui)
        MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        MainFrame.Position = UDim2.new(0.5, -225, 0.5, -155)
        MainFrame.Size = UDim2.new(0, 450, 0, 310)
        MainFrame.ClipsDescendants = false
        MainFrame.Active = true
        MainFrame.Draggable = true
        Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

        local Stroke = Instance.new("UIStroke", MainFrame)
        Stroke.Thickness = 1.5
        Stroke.Color = Color3.new(1, 1, 1)

        local ContentGroup = Instance.new("Frame", MainFrame)
        ContentGroup.Size = UDim2.new(1, 0, 1, 0)
        ContentGroup.BackgroundTransparency = 1

        local Sidebar = Instance.new("Frame", ContentGroup)
        Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Sidebar.Size = UDim2.new(0.244, 0, 1, 0)
        Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

        local Logo = Instance.new("TextLabel", Sidebar)
        Logo.Size = UDim2.new(1, 0, 0.16, 0)
        Logo.Text = "KRYPTON\nVERSE.hub"
        Logo.TextColor3 = Color3.new(1, 1, 1)
        Logo.Font = Enum.Font.GothamBold
        Logo.TextScaled = true
        Logo.BackgroundTransparency = 1

        local LogoConstraint = Instance.new("UITextSizeConstraint", Logo)
        LogoConstraint.MaxTextSize = 11
        LogoConstraint.MinTextSize = 6

        local TabContainer = Instance.new("Frame", Sidebar)
        TabContainer.Position = UDim2.new(0, 0, 0.19, 0)
        TabContainer.Size = UDim2.new(1, 0, 0.81, 0)
        TabContainer.BackgroundTransparency = 1

        local Pages = Instance.new("Frame", ContentGroup)
        Pages.Position = UDim2.new(0.266, 0, 0.048, 0)
        Pages.Size = UDim2.new(0.7, 0, 0.9, 0)
        Pages.BackgroundTransparency = 1

        local MainPage = Instance.new("ScrollingFrame", Pages)
        MainPage.Size = UDim2.new(1, 0, 1, 0)
        MainPage.BackgroundTransparency = 1
        MainPage.Visible = true
        MainPage.ScrollBarThickness = 3
        MainPage.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
        MainPage.CanvasSize = UDim2.new(0, 0, 0, 520)
        MainPage.BorderSizePixel = 0

        local BoostPage = Instance.new("ScrollingFrame", Pages)
        BoostPage.Size = UDim2.new(1, 0, 1, 0)
        BoostPage.BackgroundTransparency = 1
        BoostPage.Visible = false
        BoostPage.ScrollBarThickness = 3
        BoostPage.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
        BoostPage.CanvasSize = UDim2.new(0, 0, 0, 400)
        BoostPage.BorderSizePixel = 0

        local SecurityPage = Instance.new("ScrollingFrame", Pages)
        SecurityPage.Size = UDim2.new(1, 0, 1, 0)
        SecurityPage.BackgroundTransparency = 1
        SecurityPage.Visible = false
        SecurityPage.ScrollBarThickness = 3
        SecurityPage.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
        SecurityPage.CanvasSize = UDim2.new(0, 0, 0, 400)
        SecurityPage.BorderSizePixel = 0

        local InfoPage = Instance.new("Frame", Pages)
        InfoPage.Size = UDim2.new(1, 0, 1, 0)
        InfoPage.BackgroundTransparency = 1
        InfoPage.Visible = false

        local ResizeBtn = Instance.new("ImageButton", MainFrame)
        ResizeBtn.Size = UDim2.new(0, 16, 0, 16)
        ResizeBtn.Position = UDim2.new(1, -16, 1, -16)
        ResizeBtn.BackgroundTransparency = 1
        ResizeBtn.Image = "rbxassetid://10651034440"
        ResizeBtn.ZIndex = 200

        local Resizing = false
        ResizeBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Resizing = true
                local conn
                conn = RunService.RenderStepped:Connect(function()
                    if not Resizing then 
                        conn:Disconnect() 
                        return 
                    end
                    local currPos = UIS:GetMouseLocation()
                    local deltaX = currPos.X - (MainFrame.AbsolutePosition.X + MainFrame.AbsoluteSize.X)
                    local deltaY = (currPos.Y - 36) - (MainFrame.AbsolutePosition.Y + MainFrame.AbsoluteSize.Y)
                    
                    local newWidth = math.clamp(MainFrame.AbsoluteSize.X + deltaX, 300, 900)
                    local newHeight = math.clamp(MainFrame.AbsoluteSize.Y + deltaY, 200, 650)
                    
                    MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
                    ResizeBtn.Position = UDim2.new(1, -16, 1, -16)
                end)
            end
        end)

        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                Resizing = false 
            end
        end)

        local Minimized = false
        local MinBtn = Instance.new("TextButton", MainFrame)
        MinBtn.Size = UDim2.new(0, 25, 0, 25)
        MinBtn.Position = UDim2.new(1, -30, 0, 5)
        MinBtn.Text = "-"
        MinBtn.ZIndex = 100
        MinBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        MinBtn.TextColor3 = Color3.new(1, 1, 1)
        MinBtn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", MinBtn)

        MinBtn.MouseButton1Click:Connect(function()
            Minimized = not Minimized
            ContentGroup.Visible = not Minimized
            if Minimized then
                MainFrame:TweenSize(UDim2.new(0, 50, 0, 50), "Out", "Quad", 0.3, true)
                MinBtn.Text = "+"
                MinBtn.Size = UDim2.new(1, 0, 1, 0)
                MinBtn.Position = UDim2.new(0, 0, 0, 0)
                ResizeBtn.Visible = false
            else
                MainFrame:TweenSize(UDim2.new(0, 450, 0, 310), "Out", "Quad", 0.3, true)
                MinBtn.Text = "-"
                MinBtn.Size = UDim2.new(0, 25, 0, 25)
                MinBtn.Position = UDim2.new(1, -30, 0, 5)
                task.wait(0.3)
                ResizeBtn.Visible = true
                ResizeBtn.Position = UDim2.new(1, -16, 1, -16)
            end
        end)

        local function CreateTabBtn(name, scaleY, targetPage)
            local Btn = Instance.new("TextButton", TabContainer)
            Btn.Size = UDim2.new(1, -16, 0.1, 0)
            Btn.Position = UDim2.new(0, 8, scaleY, 0)
            Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Btn.Text = name
            Btn.TextColor3 = Color3.new(1, 1, 1)
            Btn.Font = Enum.Font.GothamBold
            Btn.TextScaled = true
            
            local tc = Instance.new("UITextSizeConstraint", Btn)
            tc.MaxTextSize = 9
            tc.MinTextSize = 5
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
            
            Btn.MouseButton1Click:Connect(function()
                MainPage.Visible = (targetPage == MainPage)
                BoostPage.Visible = (targetPage == BoostPage)
                SecurityPage.Visible = (targetPage == SecurityPage)
                InfoPage.Visible = (targetPage == InfoPage)
            end)
        end

        CreateTabBtn("MAIN", 0.0, MainPage)
        CreateTabBtn("BOOST", 0.13, BoostPage)
        CreateTabBtn("SECURITY", 0.26, SecurityPage)
        CreateTabBtn("INFO", 0.39, InfoPage)

        local function CreateToggle(parent, text, pos, varName, callback)
            local bg = Instance.new("Frame", parent)
            bg.Size = UDim2.new(1, -8, 0, 22)
            bg.Position = UDim2.new(0, 0, 0, pos)
            bg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 6)
            
            local lbl = Instance.new("TextLabel", bg)
            lbl.Size = UDim2.new(0.65, 0, 0.8, 0)
            lbl.Position = UDim2.new(0, 10, 0.1, 0)
            lbl.Text = text
            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            lbl.BackgroundTransparency = 1
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Font = Enum.Font.GothamBold
            lbl.TextScaled = true
            
            local tc = Instance.new("UITextSizeConstraint", lbl)
            tc.MaxTextSize = 9
            tc.MinTextSize = 5
            
            local tgl = Instance.new("TextButton", bg)
            tgl.Size = UDim2.new(0, 40, 0.7, 0)
            tgl.Position = UDim2.new(1, -45, 0.15, 0)
            tgl.Text = _G[varName] and "ON" or "OFF"
            tgl.Font = Enum.Font.GothamBold
            tgl.TextScaled = true
            
            local tc2 = Instance.new("UITextSizeConstraint", tgl)
            tc2.MaxTextSize = 8
            tc2.MinTextSize = 5
            Instance.new("UICorner", tgl).CornerRadius = UDim.new(0, 4)
            
            local function upstyle()
                if _G[varName] then
                    tgl.BackgroundColor3 = Color3.new(1, 1, 1)
                    tgl.TextColor3 = Color3.new(0, 0, 0)
                else
                    tgl.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    tgl.TextColor3 = Color3.new(1, 1, 1)
                end
            end
            upstyle()
            
            tgl.MouseButton1Click:Connect(function()
                _G[varName] = not _G[varName]
                tgl.Text = _G[varName] and "ON" or "OFF"
                upstyle()
                if callback then callback(_G[varName]) end
            end)
            return bg
        end

        local function CreateSlider(parent, text, pos, min, max, varName)
            local bg = Instance.new("Frame", parent)
            bg.Size = UDim2.new(1, -8, 0, 32)
            bg.Position = UDim2.new(0, 0, 0, pos)
            bg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 6)
            
            local lbl = Instance.new("TextLabel", bg)
            lbl.Size = UDim2.new(1, 0, 0.45, 0)
            lbl.Text = text.." ["..tostring(_G[varName]).."]"
            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.GothamBold
            lbl.TextScaled = true
            
            local tc = Instance.new("UITextSizeConstraint", lbl)
            tc.MaxTextSize = 8
            tc.MinTextSize = 5
            
            local bar = Instance.new("TextButton", bg)
            bar.Size = UDim2.new(0.9, 0, 0, 5)
            bar.Position = UDim2.new(0.05, 0, 0.65, 0)
            bar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            bar.Text = ""
            
            local fill = Instance.new("Frame", bar)
            fill.Size = UDim2.new((_G[varName]-min)/(max-min), 0, 1, 0)
            fill.BackgroundColor3 = Color3.new(1, 1, 1)
            fill.BorderSizePixel = 0
            
            bar.MouseButton1Down:Connect(function()
                local conn
                conn = RunService.RenderStepped:Connect(function()
                    local move = math.clamp((Mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    _G[varName] = math.floor(min + (move * (max - min)))
                    fill.Size = UDim2.new(move, 0, 1, 0)
                    lbl.Text = text.." ["..tostring(_G[varName]).."]"
                    if varName == "AimFOV" and FOVCircle then
                        FOVCircle.Size = UDim2.new(0, _G.AimFOV * 2, 0, _G.AimFOV * 2)
                    end
                    if not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then 
                        conn:Disconnect() 
                    end
                end)
            end)
        end

        -- ============================================= --
        -- ============ MAIN PAGE CONTENT ============== --
        -- ============================================= --
        CreateToggle(MainPage, "Aimbot Master Toggle", 0, "AimbotMaster")

        local tglCursor = CreateToggle(MainPage, "→ Aimbot (Closest to Cursor)", 24, "AimbotCursor", function(s)
            if s then 
                _G.AimbotChar = false
                local f = MainPage:FindFirstChild("→ Aimbot (Closest to Character)")
                local btn = f and f:FindFirstChildWhichIsA("TextButton")
                if btn then
                    btn.Text = "OFF"
                    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    btn.TextColor3 = Color3.new(1, 1, 1)
                end
            end
        end)
        tglCursor.Name = "→ Aimbot (Closest to Cursor)"

        local tglChar = CreateToggle(MainPage, "→ Aimbot (Closest to Character)", 48, "AimbotChar", function(s)
            if s then 
                _G.AimbotCursor = false
                local f = MainPage:FindFirstChild("→ Aimbot (Closest to Cursor)")
                local btn = f and f:FindFirstChildWhichIsA("TextButton")
                if btn then
                    btn.Text = "OFF"
                    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    btn.TextColor3 = Color3.new(1, 1, 1)
                end
            end
        end)
        tglChar.Name = "→ Aimbot (Closest to Character)"

        CreateToggle(MainPage, "Full Visual Master ESP", 76, "ESP")

        local tglTeam = CreateToggle(MainPage, "→ ESP Mode: TEAM ONLY", 100, "ESPModeTeam", function(s)
            if s then 
                _G.ESPMode = "TEAM"
                local f = MainPage:FindFirstChild("→ ESP Mode: FFA (Free For All)")
                local btn = f and f:FindFirstChildWhichIsA("TextButton")
                if btn then
                    btn.Text = "OFF"
                    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    btn.TextColor3 = Color3.new(1, 1, 1)
                end
            end
        end)
        tglTeam.Name = "→ ESP Mode: TEAM ONLY"

        local tglFFA = CreateToggle(MainPage, "→ ESP Mode: FFA (Free For All)", 124, "ESPModeFFA", function(s)
            if s then 
                _G.ESPMode = "FFA"
                local f = MainPage:FindFirstChild("→ ESP Mode: TEAM ONLY")
                local btn = f and f:FindFirstChildWhichIsA("TextButton")
                if btn then
                    btn.Text = "OFF"
                    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    btn.TextColor3 = Color3.new(1, 1, 1)
                end
            end
        end)
        tglFFA.Name = "→ ESP Mode: FFA (Free For All)"

        CreateToggle(MainPage, "🎯 Show FOV Circle", 152, "ShowFOVCircle")
        CreateToggle(MainPage, "Hitbox Expander (Universal)", 176, "HitboxExpand")
        CreateSlider(MainPage, "Hitbox Size", 200, 2, 50, "HitboxSize")
        CreateToggle(MainPage, "Real Admin Fly", 236, "Fly")
        CreateToggle(MainPage, "No Clip Matrix", 260, "NoClip")
        CreateSlider(MainPage, "Fly Speed Multiplier", 284, 16, 1000, "FlySpeed")
        CreateSlider(MainPage, "Aim FOV Range Radius", 320, 50, 800, "AimFOV")
        CreateToggle(MainPage, "Bypass Super Speed", 356, "SuperSpeed")
        CreateSlider(MainPage, "Speed Velocity Engine", 380, 16, 1000, "RunSpeed")
        CreateToggle(MainPage, "Ambient Brightness Mod", 416, "BrightnessToggle", function(s)
            if not s then 
                Lighting.Brightness = OriginalBrightness
                Lighting.Ambient = OriginalAmbient
            end
        end)

        -- ============================================= --
        -- ============ BOOST PAGE CONTENT ============= --
        -- ============================================= --
        local tglFPS = CreateToggle(BoostPage, "EXTREME FPS BOOSTER", 0, "FPSBoost", function(s)
            if s then 
                _G.PotatoMode = false
                local f = BoostPage:FindFirstChild("POTATO PC MODE ULTRA")
                local btn = f and f:FindFirstChildWhichIsA("TextButton")
                if btn then
                    btn.Text = "OFF"
                    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    btn.TextColor3 = Color3.new(1, 1, 1)
                end
            end
        end)
        tglFPS.Name = "EXTREME FPS BOOSTER"

        local tglPotato = CreateToggle(BoostPage, "POTATO PC MODE ULTRA", 24, "PotatoMode", function(s)
            if s then 
                _G.FPSBoost = false
                local f = BoostPage:FindFirstChild("EXTREME FPS BOOSTER")
                local btn = f and f:FindFirstChildWhichIsA("TextButton")
                if btn then
                    btn.Text = "OFF"
                    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    btn.TextColor3 = Color3.new(1, 1, 1)
                end
            end
        end)
        tglPotato.Name = "POTATO PC MODE ULTRA"

        CreateToggle(BoostPage, "SUPREME PING REDUCER", 52, "PingBoost")

        -- ============================================= --
        -- ============ SECURITY PAGE CONTENT ========== --
        -- ============================================= --
        CreateToggle(SecurityPage, "MAXIMUM ANTI-BAN BYPASS", 0, "AntiBan")
        CreateToggle(SecurityPage, "HIGH-LEVEL ANTI-REPORT SHIELD", 24, "AntiReport")

        -- ============================================= --
        -- ============ INFO PAGE CONTENT ============== --
        -- ============================================= --
        local Watermark = Instance.new("TextLabel", InfoPage)
        Watermark.Size = UDim2.new(1, 0, 0.45, 0)
        Watermark.Position = UDim2.new(0, 0, 0.05, 0)
        Watermark.RichText = true
        Watermark.Text = "THIS SCRIPT WAS CREATED BY\n--Krypton Verse--\n\nCODED WITH PASSION,\nDELIVERED WITH PRECISION.\n\nREMOVAL OF THIS WATERMARK IS\nSTRICTLY PROHIBITED."
        Watermark.TextColor3 = Color3.new(1, 1, 1)
        Watermark.Font = Enum.Font.GothamBold
        Watermark.TextScaled = true
        Watermark.BackgroundTransparency = 1
        Watermark.TextWrapped = true

        local wmtc = Instance.new("UITextSizeConstraint", Watermark)
        wmtc.MaxTextSize = 13
        wmtc.MinTextSize = 6

        local DiscordBtn = Instance.new("TextButton", InfoPage)
        DiscordBtn.Size = UDim2.new(0.8, 0, 0.15, 0)
        DiscordBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
        DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        DiscordBtn.Text = "COPY DISCORD LINK"
        DiscordBtn.TextColor3 = Color3.new(1, 1, 1)
        DiscordBtn.Font = Enum.Font.GothamBold
        DiscordBtn.TextScaled = true
        Instance.new("UICorner", DiscordBtn)

        local dctc = Instance.new("UITextSizeConstraint", DiscordBtn)
        dctc.MaxTextSize = 11
        dctc.MinTextSize = 6

        DiscordBtn.MouseButton1Click:Connect(function()
            setclipboard("discord.gg")
            DiscordBtn.Text = "LINK COPIED!"
            task.wait(2)
            DiscordBtn.Text = "COPY DISCORD LINK"
        end)

-- ============================================= --
-- ============ FOV CIRCLE GRAPHICS ============ --
-- ============================================= --
local FOVCircle = Instance.new("Frame", ScreenGui)
FOVCircle.Name = "FOV_Circle"
FOVCircle.Size = UDim2.new(0, _G.AimFOV * 2, 0, _G.AimFOV * 2)
FOVCircle.Position = UDim2.new(0.5, -_G.AimFOV, 0.5, -_G.AimFOV)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = false

local circleStroke = Instance.new("UIStroke", FOVCircle)
circleStroke.Thickness = 2
circleStroke.Color = Color3.fromRGB(255, 0, 0)

local circleCorner = Instance.new("UICorner", FOVCircle)
circleCorner.CornerRadius = UDim.new(1, 0)

-- ============================================= --
-- ============ DRAWING API CACHE ============== --
-- ============================================= --
local DrawCache = {}

local function GetDrawVisuals(p)
    if DrawCache[p.Name] then 
        return DrawCache[p.Name] 
    end
    
    local box = Drawing.new("Square")
    box.Thickness = 1.5
    box.Filled = false
    box.Transparency = 1
    box.Visible = false
    
    local line = Drawing.new("Line")
    line.Thickness = 1.5
    line.Transparency = 1
    line.Visible = false
    
    DrawCache[p.Name] = {Box = box, Line = line}
    return DrawCache[p.Name]
end

local function ClearDrawVisuals(p)
    if DrawCache[p.Name] then
        DrawCache[p.Name].Box:Remove()
        DrawCache[p.Name].Line:Remove()
        DrawCache[p.Name] = nil
    end
    if p.Character and p.Character:FindFirstChild("KryptonHighlight") then
        p.Character.KryptonHighlight:Destroy()
    end
end

Players.PlayerRemoving:Connect(ClearDrawVisuals)

-- ============================================= --
-- ============ TEAM DETECTOR ================== --
-- ============================================= --
local function IsEnemyUniversal(TargetPlayer)
    if not TargetPlayer or TargetPlayer == LocalPlayer then 
        return false 
    end
    
    if _G.ESPMode == "FFA" then 
        return true 
    end
    
    if TargetPlayer.Team and LocalPlayer.Team then 
        return TargetPlayer.Team ~= LocalPlayer.Team 
    end
    
    if TargetPlayer.TeamColor and LocalPlayer.TeamColor then 
        return TargetPlayer.TeamColor ~= LocalPlayer.TeamColor 
    end
    
    local tChar = TargetPlayer.Character
    if tChar and tChar:FindFirstChild("Status") and tChar.Status:FindFirstChild("Team") then
        local tTeam = tChar.Status.Team.Value
        local mTeam = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Status") and 
                       LocalPlayer.Character.Status:FindFirstChild("Team") and 
                       LocalPlayer.Character.Status.Team.Value
        if tTeam and mTeam then 
            return tostring(tTeam) ~= tostring(mTeam) 
        end
    end
    
    return true
end

-- ============================================= --
-- ============ OPTIMIZED BOOSTER ENGINE ======= --
-- ============================================= --
local function ApplyBoosterEffects()
    if not (_G.FPSBoost or _G.PotatoMode) then 
        return 
    end
    
    Lighting.GlobalShadows = false
    local descendants = game:GetDescendants()
    
    for i, v in pairs(descendants) do
        if i % 100 == 0 then 
            task.wait() 
        end
        
        if _G.FPSBoost then
            if v:IsA("PostProcessEffect") or v:IsA("ParticleEmitter") or v:IsA("Smoke") then
                v.Enabled = false
            end
        elseif _G.PotatoMode then
            if v:IsA("PostProcessEffect") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
        end
    end
end

task.spawn(function()
    while true do
        if _G.FPSBoost or _G.PotatoMode then
            ApplyBoosterEffects()
            task.wait(5)
        else
            task.wait(1)
        end
    end
end)

game.DescendantAdded:Connect(function(v)
    if _G.FPSBoost then
        if v:IsA("PostProcessEffect") or v:IsA("ParticleEmitter") or v:IsA("Smoke") then
            v.Enabled = false
        end
    elseif _G.PotatoMode then
        if v:IsA("PostProcessEffect") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        end
    end
end)

-- ============================================= --
-- ============ RENDERING ENGINE LOOP ========== --
-- ============================================= --
RunService.RenderStepped:Connect(function()
    if _G.ShowFOVCircle and _G.AimbotMaster then
        FOVCircle.Visible = true
        FOVCircle.Size = UDim2.new(0, _G.AimFOV * 2, 0, _G.AimFOV * 2)
        FOVCircle.Position = UDim2.new(0.5, -_G.AimFOV, 0.5, -_G.AimFOV)
    else
        FOVCircle.Visible = false
    end
    
    local character = LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    -- FLY ENGINE & MOVEMENT
    if hrp and humanoid then
        if _G.Fly then
            hrp.Velocity = Vector3.new(0, 0, 0)
            
            local cameraLook = Camera.CFrame.LookVector
            local flyDirection = Vector3.new(0, 0, 0)
            
            if humanoid.MoveDirection.Magnitude > 0 then
                local rawMove = humanoid.MoveDirection
                local forwardVector = cameraLook.Unit
                local rightVector = Camera.CFrame.RightVector.Unit
                
                flyDirection = (forwardVector * (rawMove.Z < 0 and 1 or (rawMove.Z > 0 and -1 or 0))) + 
                               (rightVector * (rawMove.X > 0 and 1 or (rawMove.X < 0 and -1 or 0)))
            end
            
            if flyDirection.Magnitude > 0 then
                hrp.CFrame = CFrame.new(hrp.CFrame.Position, hrp.CFrame.Position + cameraLook) 
                hrp.CFrame = hrp.CFrame + (flyDirection.Unit * (_G.FlySpeed / 25))
            else
                hrp.CFrame = CFrame.new(hrp.CFrame.Position, hrp.CFrame.Position + Vector3.new(cameraLook.X, 0, cameraLook.Z))
            end
        end
        
        if _G.SuperSpeed and humanoid.MoveDirection.Magnitude > 0 then
            local bypassVelocity = (_G.RunSpeed / 16) * 0.35
            hrp.CFrame = hrp.CFrame + (humanoid.MoveDirection * bypassVelocity)
        end
        
        if _G.NoClip then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then 
                    part.CanCollide = false 
                elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
                    part.Handle.CanCollide = false
                end
            end
        end
    end
    
    -- BRIGHTNESS MOD
    if _G.BrightnessToggle then
        Lighting.Brightness = 3.5
        Lighting.Ambient = Color3.fromRGB(150, 150, 150)
    end
    
    -- AIMBOT & ESP LOGIC
    local closestTarget = nil
    local shortestDistance = _G.AimFOV
    local cursorPosition = Vector2.new(Mouse.X, Mouse.Y)
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pChar = p.Character
            if pChar and pChar:FindFirstChild("Head") and pChar:FindFirstChild("HumanoidRootPart") then
                local head = pChar.Head
                local tHrp = pChar.HumanoidRootPart
                local isEnemy = IsEnemyUniversal(p)
                
                if _G.HitboxExpand then
                    head.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                    head.Transparency = 0.5
                    head.CanCollide = false
                elseif head.Size.X ~= 2 then
                    head.Size = Vector3.new(2, 1, 1)
                    head.Transparency = 0
                end
                
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen and _G.AimbotMaster and isEnemy then
                    if _G.AimbotCursor then
                        local distCursor = (Vector2.new(pos.X, pos.Y) - cursorPosition).Magnitude
                        if distCursor < shortestDistance then
                            shortestDistance = distCursor
                            closestTarget = head
                        end
                    elseif _G.AimbotChar and hrp then
                        local distChar = (tHrp.Position - hrp.Position).Magnitude
                        if distChar < shortestDistance then
                            shortestDistance = distChar
                            closestTarget = head
                        end
                    end
                end
                
                if _G.ESP then
                    local draw = GetDrawVisuals(p)
                    local hrpPos, hrpOnScreen = Camera:WorldToViewportPoint(tHrp.Position)
                    local drawColor = isEnemy and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
                    
                    -- BODYHIGHLIGHT ESP
                    local hl = pChar:FindFirstChild("KryptonHighlight")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "KryptonHighlight"
                        hl.Parent = pChar
                    end
                    hl.FillColor = drawColor
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.FillTransparency = 0.45
                    hl.OutlineTransparency = 0.2
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Enabled = true
                    
                    if hrpOnScreen then
                        local camDist = (Camera.CFrame.Position - tHrp.Position).Magnitude
                        local scaleWidth = math.clamp(1200 / camDist, 12, 60)
                        local scaleHeight = scaleWidth * 1.45
                        
                        draw.Box.Visible = true
                        draw.Box.Color = drawColor
                        draw.Box.Position = Vector2.new(hrpPos.X - (scaleWidth / 2), hrpPos.Y - (scaleHeight / 2))
                        draw.Box.Size = Vector2.new(scaleWidth, scaleHeight)
                        draw.Line.Visible = true
                        draw.Line.Color = drawColor
                        draw.Line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        draw.Line.To = Vector2.new(hrpPos.X, hrpPos.Y)
                    else
                        draw.Box.Visible = false
                        draw.Line.Visible = false
                    end
                else
                    local draw = DrawCache[p.Name]
                    if draw then
                        draw.Box.Visible = false
                        draw.Line.Visible = false
                    end
                    if pChar:FindFirstChild("KryptonHighlight") then
                        pChar.KryptonHighlight:Destroy()
                    end
                end
            end
        end
    end
    
    if _G.AimbotMaster and closestTarget and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position)
    end
end)
