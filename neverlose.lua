local Library = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- UI Theme
local Theme = {
    Background = Color3.fromRGB(15, 15, 15),
    Accent = Color3.fromRGB(116, 184, 22),
    Secondary = Color3.fromRGB(25, 25, 25),
    Text = Color3.fromRGB(255, 255, 255),
    Border = Color3.fromRGB(35, 35, 35),
    DarkAccent = Color3.fromRGB(86, 154, 12)
}

function Library:CreateWindow(title)
    local NeverLoseUI = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TabContainer = Instance.new("Frame")
    local ContentContainer = Instance.new("Frame")
    
    NeverLoseUI.Name = "NeverLoseUI"
    NeverLoseUI.Parent = CoreGui
    
    Main.Name = "Main"
    Main.Parent = NeverLoseUI
    Main.BackgroundColor3 = Theme.Background
    Main.BorderColor3 = Theme.Border
    Main.Position = UDim2.new(0.2, 0, 0.2, 0)
    Main.Size = UDim2.new(0, 650, 0, 500)
    Main.Active = true
    Main.Draggable = true
    
    TopBar.Name = "TopBar"
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = Theme.Secondary
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 35)
    
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Font = Enum.Font.Gotham
    Title.Text = title
    Title.TextColor3 = Theme.Text
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Main
    TabContainer.BackgroundColor3 = Theme.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 0, 0, 35)
    TabContainer.Size = UDim2.new(0, 150, 1, -35)
    
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = Main
    ContentContainer.BackgroundColor3 = Theme.Background
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Position = UDim2.new(0, 150, 0, 35)
    ContentContainer.Size = UDim2.new(1, -150, 1, -35)
    
    local Window = {}
    local Tabs = {}
    
    function Window:CreateTab(name)
        local TabButton = Instance.new("TextButton")
        local TabContent = Instance.new("ScrollingFrame")
        local UIListLayout = Instance.new("UIListLayout")
        
        TabButton.Name = name
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Theme.Secondary
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = name
        TabButton.TextColor3 = Theme.Text
        TabButton.TextSize = 14
        TabButton.AutoButtonColor = false
        
        TabContent.Name = name.."Content"
        TabContent.Parent = ContentContainer
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.ScrollBarThickness = 2
        TabContent.Visible = false
        TabContent.ScrollingDirection = Enum.ScrollingDirection.Y
        TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        
        UIListLayout.Parent = TabContent
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 5)
        
        local Tab = {}
        
        function Tab:CreateToggle(name, callback)
            local Toggle = Instance.new("Frame")
            local Title = Instance.new("TextLabel")
            local Button = Instance.new("TextButton")
            local enabled = false
            
            Toggle.Name = "Toggle"
            Toggle.Parent = TabContent
            Toggle.BackgroundColor3 = Theme.Secondary
            Toggle.BorderSizePixel = 0
            Toggle.Size = UDim2.new(1, -20, 0, 35)
            Toggle.Position = UDim2.new(0, 10, 0, 0)
            
            Title.Name = "Title"
            Title.Parent = Toggle
            Title.BackgroundTransparency = 1
            Title.Position = UDim2.new(0, 10, 0, 0)
            Title.Size = UDim2.new(1, -50, 1, 0)
            Title.Font = Enum.Font.Gotham
            Title.Text = name
            Title.TextColor3 = Theme.Text
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left
            
            Button.Name = "Button"
            Button.Parent = Toggle
            Button.AnchorPoint = Vector2.new(1, 0.5)
            Button.Position = UDim2.new(1, -10, 0.5, 0)
            Button.Size = UDim2.new(0, 40, 0, 20)
            Button.BackgroundColor3 = Theme.DarkAccent
            Button.BorderSizePixel = 0
            Button.Text = ""
            Button.AutoButtonColor = false
            
            Button.MouseButton1Click:Connect(function()
                enabled = not enabled
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = enabled and Theme.Accent or Theme.DarkAccent
                }):Play()
                if callback then callback(enabled) end
            end)
            
            return Toggle
        end
        
        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Tabs) do
                tab.Content.Visible = false
                tab.Button.BackgroundColor3 = Theme.Secondary
            end
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Theme.Accent
        end)
        
        if #Tabs == 0 then
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Theme.Accent
        end
        
        table.insert(Tabs, {Content = TabContent, Button = TabButton})
        
        return Tab
    end
    
    return Window
end

return Library
