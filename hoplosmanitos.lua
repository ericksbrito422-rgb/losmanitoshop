-- Painel Hop Los Manitos 🐵🐺 (TikTok + Bolinha imagem do jogador arrastável)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local iddojogo = 109983668079237

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui

-- Função para criar painel
local function criarPainel()
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 320, 0, 180)
    Frame.Position = UDim2.new(0.5, -160, 0.5, -90)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.BackgroundTransparency = 0.2
    Frame.BorderSizePixel = 3
    Frame.BorderColor3 = Color3.fromRGB(150, 0, 255)
    Frame.Active = true
    Frame.Draggable = true
    Frame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner", Frame)
    UICorner.CornerRadius = UDim.new(0, 12)

    -- Fade-in
    Frame.Size = UDim2.new(0,0,0,0)
    Frame.Position = UDim2.new(0.5,0,0.5,0)
    Frame:TweenSizeAndPosition(
        UDim2.new(0,320,0,180),
        UDim2.new(0.5,-160,0.5,-90),
        "Out",
        "Quad",
        0.5,
        true
    )

    -- Título
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,0,0,40)
    Title.Position = UDim2.new(0,0,0,10)
    Title.BackgroundTransparency = 1
    Title.Text = "Hop Los Manitos 🐵🐺"
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 24
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.Parent = Frame

    -- TikTok label
    local TikTokLabel = Instance.new("TextLabel")
    TikTokLabel.Size = UDim2.new(1,0,0,20)
    TikTokLabel.Position = UDim2.new(0,0,0,50)
    TikTokLabel.BackgroundTransparency = 1
    TikTokLabel.Text = "TikTok:"
    TikTokLabel.TextColor3 = Color3.fromRGB(180,180,255)
    TikTokLabel.Font = Enum.Font.SourceSans
    TikTokLabel.TextSize = 16
    TikTokLabel.Parent = Frame

    -- Subtítulo
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Size = UDim2.new(1,0,0,25)
    SubTitle.Position = UDim2.new(0,0,0,70)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Text = "@losmanitos777"
    SubTitle.TextColor3 = Color3.fromRGB(180,180,255)
    SubTitle.Font = Enum.Font.SourceSans
    SubTitle.TextSize = 18
    SubTitle.Parent = Frame

    -- Discord link
    local DiscordLink = Instance.new("TextButton")
    DiscordLink.Size = UDim2.new(1,0,0,25)
    DiscordLink.Position = UDim2.new(0,0,0,100)
    DiscordLink.BackgroundTransparency = 1
    DiscordLink.Text = "Discord: https://discord.gg/9zkJZk9H"
    DiscordLink.TextColor3 = Color3.fromRGB(100,200,255)
    DiscordLink.Font = Enum.Font.SourceSans
    DiscordLink.TextSize = 16
    DiscordLink.Parent = Frame

    DiscordLink.MouseEnter:Connect(function()
        DiscordLink.TextColor3 = Color3.fromRGB(150,255,255)
    end)
    DiscordLink.MouseLeave:Connect(function()
        DiscordLink.TextColor3 = Color3.fromRGB(100,200,255)
    end)
    DiscordLink.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard("https://discord.gg/9zkJZk9H")
            game.StarterGui:SetCore("SendNotification", {
                Title = "Discord",
                Text = "Link copiado! Cole no navegador.",
                Duration = 5
            })
        end
    end)

    -- Botão criar
    local function createButton(parent,text,yPos)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.8,0,0,40)
        btn.Position = UDim2.new(0.1,0,0,yPos)
        btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 20
        btn.Parent = parent
        local corner = Instance.new("UICorner",btn)
        corner.CornerRadius = UDim.new(0,8)
        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(150,0,255) end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(50,50,50) end)
        return btn
    end

    local Button1 = createButton(Frame,"Iniciar Hop",130)

    -- Servidores Hop
    local function pegarsvrs()
        local servidores = {}
        local success,response = pcall(function()
            return game:HttpGet("https://games.roblox.com/v1/games/"..iddojogo.."/servers/Public?sortOrder=Asc&limit=100")
        end)
        if success then
            local data = HttpService:JSONDecode(response)
            for _,server in pairs(data.data) do
                if server.playing < server.maxPlayers then
                    table.insert(servidores,server.id)
                end
            end
        end
        return servidores
    end

    local function trocar()
        local servidores = pegarsvrs()
        if #servidores>0 then
            TeleportService:TeleportToPlaceInstance(iddojogo,servidores[math.random(1,#servidores)],LocalPlayer)
            game.StarterGui:SetCore("SendNotification",{Title="Hop",Text="Iniciando hop para outro servidor...",Duration=5})
        else
            game.StarterGui:SetCore("SendNotification",{Title="Hop",Text="Nenhum servidor disponível no momento.",Duration=5})
        end
    end

    Button1.MouseButton1Click:Connect(trocar)

    -- Botão minimizar
    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0,25,0,25)
    MinBtn.Position = UDim2.new(1,-30,0,5)
    MinBtn.BackgroundColor3 = Color3.fromRGB(150,0,255)
    MinBtn.Text = "-"
    MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
    MinBtn.Font = Enum.Font.SourceSansBold
    MinBtn.TextSize = 18
    MinBtn.Parent = Frame
    local corner = Instance.new("UICorner",MinBtn)
    corner.CornerRadius = UDim.new(0,12)

    -- Bolinha minimizada com imagem do jogador
    local MinBolinha = Instance.new("ImageButton")
    MinBolinha.Size = UDim2.new(0,50,0,50)
    MinBolinha.Position = UDim2.new(0,10,0.5,-25)
    MinBolinha.BackgroundTransparency = 0
    MinBolinha.Visible = false
    MinBolinha.Parent = ScreenGui
    local corner2 = Instance.new("UICorner",MinBolinha)
    corner2.CornerRadius = UDim.new(1,0)

    -- Colocando a imagem do jogador
    local success,thumb = pcall(function()
        return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    end)
    if success then
        MinBolinha.Image = thumb
    end

    -- Tornar arrastável
    MinBolinha.Active = true
    MinBolinha.Draggable = true

    -- Minimizar
    MinBtn.MouseButton1Click:Connect(function()
        Frame:TweenSizeAndPosition(UDim2.new(0,0,0,0),UDim2.new(0.5,0,0.5,0),"In","Quad",0.5,true,function()
            Frame.Visible = false
            MinBolinha.Visible = true
        end)
    end)

    -- Restaurar painel
    MinBolinha.MouseButton1Click:Connect(function()
        Frame.Visible = true
        MinBolinha.Visible = false
        Frame.Size = UDim2.new(0,0,0,0)
        Frame.Position = UDim2.new(0.5,0,0.5,0)
        Frame:TweenSizeAndPosition(UDim2.new(0,320,0,180),UDim2.new(0.5,-160,0.5,-90),"Out","Quad",0.5,true)
    end)
end

criarPainel()
