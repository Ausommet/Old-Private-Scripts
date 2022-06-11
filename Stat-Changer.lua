local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local UI = Material.Load({
    Title = "「Stat-Changer」 | By Ausommet",
    Style = 3,
    SizeX = 300,
    SizeY = 185,
    Theme = "Jester",
    ColorOverrides = {
        MainFrame = Color3.fromRGB(9,49,69),
		Minimise = Color3.fromRGB(255,106,0),
		MinimiseAccent = Color3.fromRGB(147,59,0),
		Maximise = Color3.fromRGB(25,255,0),
		MaximiseAccent = Color3.fromRGB(0,255,110),
		NavBar = Color3.fromRGB(60,100,120),
		NavBarAccent = Color3.fromRGB(9,49,69),
		NavBarInvert = Color3.fromRGB(255,255,255),
		TitleBar = Color3.fromRGB(60,100,120),
		TitleBarAccent = Color3.fromRGB(255,255,255),
		Overlay = Color3.fromRGB(255,255,255),
		Banner = Color3.fromRGB(9,49,69),
		BannerAccent = Color3.fromRGB(255,255,255),
		Content = Color3.fromRGB(255,255,255),
		Button = Color3.fromRGB(9,49,69), 
		ButtonAccent = Color3.fromRGB(255,255,255),
		ChipSet = Color3.fromRGB(255,255,255),
		ChipSetAccent = Color3.fromRGB(9,49,69),
		DataTable = Color3.fromRGB(255,255,255),
		DataTableAccent = Color3.fromRGB(9,49,69),
		Slider = Color3.fromRGB(9,49,69),   
		SliderAccent = Color3.fromRGB(255,255,255),
		Toggle = Color3.fromRGB(255,255,255),
		ToggleAccent = Color3.fromRGB(9,49,69),
		Dropdown = Color3.fromRGB(9,49,69),
		DropdownAccent = Color3.fromRGB(255,255,255),
		ColorPicker = Color3.fromRGB(9,49,69),
		ColorPickerAccent = Color3.fromRGB(255,255,255),
		TextField = Color3.fromRGB(255,255,255),
		TextFieldAccent = Color3.fromRGB(255,255,255),
    }
})

local main = UI.New({
    Title = "Main"
})

main.Dropdown({
    Text = "Select Stat to change",
    Callback = function(value)
        a = value
    end,
    Options = {"Vitality", "Strength", "Agility", "Defense", "Luck"}
})

main.TextField({
    Text = "Set Value",
    Callback = function(value)
        b = value
    end,
})


main.Button({
    Text = "Change Stat",
    Callback = function()
        print(game:GetService("ReplicatedStorage").StatsEvent:FireServer(a, tonumber(b)))
    end
})

main.Button({
    Text = "God-Mode Respawn",
    Callback = function()
        game.workspace.GameLoader.CharLoadEvent:FireServer()
    end
})