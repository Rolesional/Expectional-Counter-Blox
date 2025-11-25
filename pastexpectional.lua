--// shit version of it but it doesnt lag so that's the point nigger.
--// he's using a base64 encoding for this :sob: :sob:
--// chez if you're here luv u bro :heart:
	local cheatLoadingStartTick = os.clock()

	local tick = tick
	local env = getgenv()
	if env.Hack then return end

	--ANCHOR Game loading waiting
	if not game:IsLoaded() then
		game.Loaded:Wait()
	end
	if game.ReplicatedFirst:FindFirstChild("Session") then
		game.ReplicatedFirst.Session:Destroy()
	end
	if game.Players.localPlayer.PlayerScripts:FindFirstChild("scapter") then
		game.Players.localPlayer.PlayerScripts.scapter:Destroy()
	end
	-- mooooooom i bypassed my first anti cheat


	-- Identifiy our executor
	local executor = syn and "Synapse" or nil
	local platform = "Windows"
	if not executor then
		executor, platform = identifyexecutor()
	end

	--ANCHOR Uilib (hi invaded)
	local Library
	do
		-- Ui lib thing or smth December 12th 2021

		-- UI funcs and tables
		local Menu = {}
		local KeyBindList = {}
		local UILibrary = {}
		local UIUtilities = {}
		local OpenCloseItems = {}
		local CheatSections = {}
		local SubSections = {}
		local UIAccents = {}

		local Signal = loadstring(game:HttpGet("https://raw.githubusercontent.com/Quenty/NevermoreEngine/version2/Modules/Shared/Events/Signal.lua"))()

		function UILibrary:Start(Parameters)
			local UIStyle = Parameters
			local ClipboardColor
			-- Important Bullshit
			local RunService = game:GetService("RunService")
			local UserInputService = game:GetService("UserInputService")
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local TextService = game:GetService("TextService") 
			local HttpService = game:GetService("HttpService")
			local TweenService = game:GetService("TweenService")
			local Players = game:GetService("Players")
			local Plr = Players.localPlayer
			local Mouse = Plr:GetMouse()
			local fading = false

			function UIUtilities:Create(ClassName, Properties)
				local NewInstance = Instance.new(ClassName)
				for property, value in next, (Properties) do
					NewInstance[property] = value
				end
				return NewInstance
			end

			local function thread(func)
				if type(func) == "function" then return coroutine.resume(coroutine.create(func)) end
			end

			local valid_chars = {}

			local function set_valid(x, y)
				for i = string.byte(x), string.byte(y) do
					table.insert(valid_chars, string.char(i))
				end
			end

			set_valid('a', 'z')
			set_valid('A', 'Z')
			set_valid('0', '9')

			function UIUtilities:random_string(length)
				local s = {}
				for i = 1, length do s[i] = valid_chars[math.random(1, #valid_chars)] end
				return table.concat(s)
			end

			function UIUtilities:Tween(...)
				TweenService:Create(...):Play()
			end

			local function RGBtoHSV(Color)
				local color = Color3.new(Color.R, Color.G, Color.B)
				local h, s, v = color:ToHSV()
				return h, s, v
			end

			local function realWait(n)
				return task.wait(n)
			end
			
			local Core = UIUtilities:Create("ScreenGui", {
				Name = UIUtilities:random_string(math.random(16, 64)),
				DisplayOrder = 6942069,
			})

			Core.Parent = game.CoreGui

			local function AutoApplyBorder(Parented, Suffix, StartZIndex, c1, c2, forgetIt)
				local BorderContainer = UIUtilities:Create("Folder", {
					Name = "Border" .. Suffix,
					Parent = Parented
				})
				local v1 = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = c1,
					BorderSizePixel = 0,
					Name = "v1" .. Suffix,
					Parent = BorderContainer,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, 2, 1, 2),
					ZIndex = StartZIndex - 1
				})
				local v2 = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = c2,
					BorderSizePixel = 0,
					Name = "v2" .. Suffix,
					Parent = v1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, 2, 1, 2),
					ZIndex = v1.ZIndex - 1
				})
				if forgetIt then
					table.insert(OpenCloseItems, v1)
					table.insert(OpenCloseItems, v2)
				end
				return BorderContainer, v1, v2
			end

			local function AutoApplyAccent(Parented, Suffix, StartZIndex, forgetIt)
				local Accent = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = UIStyle.UIcolors.FullWhite,
					BorderSizePixel = 1,
					BorderColor3 = UIStyle.UIcolors.ColorJ,
					Name = "UI",
					Parent = Parented,
					Position = UDim2.new(0.5, 0, 0, -1),
					Size = UDim2.new(1, 0, 0, 2),
					ZIndex = StartZIndex
				})
				if forgetIt then
					table.insert(OpenCloseItems, Accent)
				end
				local Hue, Sat, Val = RGBtoHSV(UIStyle.UIcolors.Accent)
				local color = UIStyle.UIcolors.Accent
				local AccentStyling = UIUtilities:Create("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromHSV(Hue, Sat, Val)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(math.clamp(color.R * 255 - 40, 0, 255), math.clamp(color.G * 255 - 40, 0, 255), math.clamp(color.B * 255 - 40, 0, 255)))
					}),
					Rotation = 90,
					Parent = Accent
				})
				table.insert(UIAccents, AccentStyling)
				return Accent, AccentStyling
			end
			
			local isColorThingOpen
			local isColorThingOpen2
			local isDropDownOpen

			UILibrary.tooltip = {}
			do
				local FakeBackGround = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = UIStyle.UIcolors.FullWhite,
					BackgroundTransparency = 1,
					BorderColor3 = UIStyle.UIcolors.FullWhite,
					BorderMode = Enum.BorderMode.Outline,
					BorderSizePixel = 0,
					Name = "Event",
					Parent = Core, 
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(0, 0, 0, 0),
					ZIndex = 29
				})
				local EventLogContainer = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = UIStyle.UIcolors.FullWhite,
					BackgroundTransparency = 1,
					BorderColor3 = UIStyle.UIcolors.FullWhite,
					BorderMode = Enum.BorderMode.Outline,
					BorderSizePixel = 0,
					Name = "Event",
					Parent = FakeBackGround,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 1, -4),
					ZIndex = 29
				})
				local fuckingFolder, fuckingThing, fuckingOtherThing = AutoApplyBorder(EventLogContainer, "a", 29, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
				local BackGroundStyling = UIUtilities:Create("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
						ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
					}),
					Rotation = 90,
					Parent = EventLogContainer
				})
				local BackGroundAccent = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = UIStyle.UIcolors.FullWhite,
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					Name = "UI",
					Parent = EventLogContainer,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(0, 2, 1, 0),
					ZIndex = 30
				})
				local Hue, Sat, Val = RGBtoHSV(UIStyle.UIcolors.Accent)
				local BackGroundAccentStyling = UIUtilities:Create("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromHSV(Hue, Sat, Val - 0.1)),
						ColorSequenceKeypoint.new(1, Color3.new(UIStyle.UIcolors.Accent.R, UIStyle.UIcolors.Accent.G, UIStyle.UIcolors.Accent.B))
					}),
					Rotation = 180,
					Parent = BackGroundAccent
				})
				local BackGroundText = UIUtilities:Create("TextLabel", {
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = 1, 
					Position = UDim2.new(1, 0, 0, 0),
					Parent = EventLogContainer,
					Size = UDim2.new(1, -6, 1, 0),
					ZIndex = 31,
					Font = UIStyle.HeaderFont.Font,
					LineHeight = 1.1,
					Text = "idiot",
					TextColor3 = UIStyle.UIcolors.FullWhite,
					TextSize = UIStyle.HeaderFont.WatermarkTxtSize,
					TextTransparency = 1,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center
				})
				local currentTrans = 1
				local hoverTime = 0
				local bounds = Vector2.new(0, 0)
				local objectPos = Vector2.new(0, 0)
				local loop; loop = RunService.Heartbeat:Connect(function(deltaTime)
					local hovering = Mouse.X > objectPos.X and Mouse.X < objectPos.X + bounds.X and Mouse.Y > objectPos.Y and Mouse.Y < objectPos.Y + bounds.Y and not (isColorThingOpen or isColorThingOpen2 or isDropDownOpen)

					if hovering then
						if hoverTime > 2 then
							currentTrans = math.max(0, currentTrans - deltaTime * 4)
						else
							hoverTime = hoverTime + deltaTime
							currentTrans = 1
						end
					else
						hoverTime = 0
						currentTrans = math.min(1, currentTrans + deltaTime * 8)
					end

					EventLogContainer.BackgroundTransparency = currentTrans
					BackGroundAccent.BackgroundTransparency = currentTrans
					BackGroundText.TextTransparency = currentTrans
					fuckingThing.BackgroundTransparency = currentTrans
					fuckingOtherThing.BackgroundTransparency = currentTrans

					if currentTrans >= 1 then
						return
					end

					BackGroundAccentStyling.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromHSV(Hue, Sat, Val - 0.1)),
						ColorSequenceKeypoint.new(1, Color3.new(UIStyle.UIcolors.Accent.R, UIStyle.UIcolors.Accent.G, UIStyle.UIcolors.Accent.B))
					})
				end)

				function UILibrary.CallToolTip(msg, showAt, pos, showInside)
					objectPos = showAt
					bounds = showInside

					local Message = msg
					local maxWidth = 30
					local text = Message
					local msgsize = TextService:GetTextSize(Message, UIStyle.HeaderFont.WatermarkTxtSize, UIStyle.HeaderFont.Font, Vector2.new(9999999999999999999999999999999, 0))
					do -- WARNING !! ALAN CODE AHEAD!!
						local split = text:split("")
						local lastspaceidx = 0 -- the text idx that the last space is
						local charinline = 0
						for i, v in next, (split) do
							charinline = charinline + 1
							if v == " " then
								lastspaceidx = i
							end
							if charinline >= maxWidth then
								split[lastspaceidx] = "\n" -- insert a thing
								charinline = 0
							end
						end
						text = ""
						for i, v in next, (split) do
							text = text .. v
						end
					end
					-- ok most of the gayness is over
					local split = text:split("\n")
					local textlinelength = {}
					local verticalLength = 8
					for i, v in next, (split) do
						local d = TextService:GetTextSize(v, UIStyle.HeaderFont.WatermarkTxtSize, UIStyle.HeaderFont.Font, Vector2.new(9999999999999999999999999999999, 0))
						textlinelength[i] = d.x
						verticalLength = verticalLength + d.y
					end
					table.sort(textlinelength, function(a, b) return a > b end)
					local longestthing = textlinelength[1]

					FakeBackGround.Size = UDim2.new(0, longestthing + 12, 0, verticalLength)
					FakeBackGround.Position = UDim2.new(0, pos.x, 0, pos.y)
					BackGroundText.Text = text
				end
			end

			local function CreateColorThing(Parameters)
				local fakeFlagsShit = {}
				local dropKickFlag

				Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance] = {}
				Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"] = Parameters.StartColor
				Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance].Save = function()
					local garbageshit = {}
					for anim, data in next, fakeFlagsShit do
						garbageshit[anim] = {}
						for name, values in next, data do
							garbageshit[anim][name] = {}
							if fakeFlagsShit[anim][name]["Value"] then
								garbageshit[anim][name]["Value"] = fakeFlagsShit[anim][name]["Value"]
							elseif fakeFlagsShit[anim][name]["Color"] then
								garbageshit[anim][name]["Color"] = {r = fakeFlagsShit[anim][name]["Color"].r, g = fakeFlagsShit[anim][name]["Color"].g, b = fakeFlagsShit[anim][name]["Color"].b}
								if Parameters.StartTrans and fakeFlagsShit[anim][name]["Transparency"] then
									garbageshit[anim][name]["Transparency"] = fakeFlagsShit[anim][name]["Transparency"]
								end
							end
						end
					end
					return {
						["Color"] = {r = Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"].r, g = Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"].g, b = Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"].b},
						["Transparency"] = Parameters.StartTrans and Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] or nil,
						["Animation Selection"] = {["Value"] = dropKickFlag["Value"]},
						["Animations"] =  garbageshit,
					}
				end
				local TransparencySlider = false
				if Parameters.StartTrans then
					TransparencySlider = true
					Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] = Parameters.StartTrans
				end
				Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance].Changed = Signal.new()	
				local ColorProxy = Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]

				local ColorH, ColorS, ColorV = RGBtoHSV(Parameters.StartColor)
				local ColorP = UIUtilities:Create("ImageButton", {
					Name = "ColorP" .. Parameters.Stance,
					Parent = Parameters.Parented,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Parameters.StartColor,
					BorderColor3 = Color3.fromRGB(255, 0, 0),
					BorderSizePixel = 2,
					BackgroundTransparency = Parameters.StartTrans or 0,
					BorderMode = Enum.BorderMode.Inset,
					Position = UDim2.new(1, Parameters.Pos, 0.5, 0),
					Size = UDim2.new(0, 24, 0, 10),
					ZIndex = 28
				})
				local actualtrans
				if Parameters.StartTrans then
					actualtrans = UIUtilities:Create("NumberValue", {
						Parent = ColorP,
						Value = Parameters.StartTrans,
						Name = "actual"
					})
				end
				local Alpha = UIUtilities:Create("ImageButton", {
					Name = "Alpha",
					Parent = ColorP,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = UIStyle.UIcolors.ColorC,
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, 4, 1, 4),
					ScaleType = "Tile",
					ZIndex = 27,
					Image = "rbxassetid://3887014957"
				})
				AutoApplyBorder(Alpha, "COLORPBACK", 27, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH, true)
				local inDented = 20
				local YBounds = 190
				if not Parameters.StartTrans then
					YBounds = YBounds - 16
				end
				local MasterFrame = UIUtilities:Create("Frame", {
					Name = "Picker",
					Parent = ColorP,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = Color3.fromRGB(27, 27, 27),
					Position = UDim2.new(0, -5, 0, -1),
					Size = UDim2.new(0, -300, 0, YBounds + inDented),
					BackgroundTransparency = 1,
					Visible = false,
					ZIndex = 30,
				})
				AutoApplyAccent(MasterFrame, "", 34)
				AutoApplyBorder(MasterFrame, "COLORBACK", 25, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)

				local Frame = UIUtilities:Create("Frame", {
					Name = "Picker",
					Parent = MasterFrame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = Color3.fromRGB(27, 27, 27),
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Visible = true,
					ZIndex = 30,
				})

				local otherFrame = UIUtilities:Create("Frame", {
					Name = "Picker2",
					Parent = MasterFrame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = Color3.fromRGB(27, 27, 27),
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Visible = false,
					Transparency = 0,
					ZIndex = 30,
				})

				local imHungover = {
					Rainbow = {
						{ 
							type = "slider",
							name = "Speed",
							max = 1000,
							min = 1,
							suffix = "%"
						}
					},
					Linear = {
						{
							type = "color",
							name = "Keyframe 1"
						},
						{
							type = "color",
							name = "Keyframe 2"
						},
						{
							type = "slider",
							name = "Speed",
							max = 1000,
							min = 1,
							suffix = "%"
						}
					},
					Oscillating = {
						{
							type = "color",
							name = "Keyframe 1"
						},
						{
							type = "color",
							name = "Keyframe 2"
						},
						{
							type = "slider",
							name = "Speed",
							max = 1000,
							min = 1,
							suffix = "%"
						}
					},
					Sawtooth = {
						{
							type = "color",
							name = "Keyframe 1"
						},
						{
							type = "color",
							name = "Keyframe 2"
						},
						{
							type = "slider",
							name = "Speed",
							max = 1000,
							min = 1,
							suffix = "%"
						}
					},
					Strobe = {
						{
							type = "color",
							name = "Keyframe 1"
						},
						{
							type = "color",
							name = "Keyframe 2"
						},
						{
							type = "slider",
							name = "Speed",
							max = 1000,
							min = 1,
							suffix = "%"
						}
					}
				}

				for fix, hangover in next, imHungover do
					local faggot = UIUtilities:Create("Frame", {
						AnchorPoint = Vector2.new(0.5, 0),
						Name = fix,
						Parent = otherFrame,
						BackgroundColor3 = Color3.fromRGB(0, 0, 0),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0, 72),
						Size = UDim2.new(1, 0, 1, -72),
						ZIndex = 20 + 22,
						Visible = false
					})
					local i_hate_this = UIUtilities:Create("UIListLayout", {
						Padding = UDim.new(0, 8),
						Parent = faggot,
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Top
					})
					fakeFlagsShit[fix] = {}

					local whoresFucked = 0

					for bullshit, data in next, hangover do
						local fakeFlagNigger
						if data.type == "color" then
							local whoreCoonNig = UIUtilities:Create("Frame", {
								BackgroundTransparency = 1,
								Name = "nigga",
								Parent = faggot,
								Size = UDim2.new(1, 0, 0, 8),
								Visible = true,
								ZIndex = 19
							})

							local TextGarbage = UIUtilities:Create("TextLabel", {
								AnchorPoint = Vector2.new(1, 0),
								BackgroundTransparency = 1,
								Parent = whoreCoonNig,
								Position = UDim2.new(1, 0, 0, 0),
								Size = UDim2.new(1, -10, 1, 0),
								ZIndex = 20 + 28,
								Text = data.name,
								TextColor3 = UIStyle.UIcolors.FullWhite,
								Font = UIStyle.TextFont.Font,
								LineHeight = 1.05,
								TextSize = UIStyle.TextFont.TxtSize,
								TextStrokeColor3 = Color3.new(),
								TextStrokeTransparency = 0.5,
								TextXAlignment = Enum.TextXAlignment.Left,
								TextYAlignment = Enum.TextYAlignment.Center
							})

							local garbageParameters = table.clone(Parameters)

							garbageParameters.Pos = -1 * (((1 - 1) * 24) + (10 * 1 - 1))
							garbageParameters.Stance = whoresFucked
							whoresFucked = whoresFucked + 1
							garbageParameters.ObjectName = data.name

							fakeFlagNigger = {}
							fakeFlagNigger["Color"] = garbageParameters.StartColor
							local TransparencySlider = false
							if garbageParameters.StartTrans then
								TransparencySlider = true
								fakeFlagNigger["Transparency"] = garbageParameters.StartTrans
							end
							fakeFlagNigger.Changed = Signal.new()	

							local ColorProxy = fakeFlagNigger

							local ColorH, ColorS, ColorV = RGBtoHSV(garbageParameters.StartColor)
							local ColorP = UIUtilities:Create("ImageButton", {
								Name = "ColorP" .. garbageParameters.Stance,
								Parent = whoreCoonNig,
								AnchorPoint = Vector2.new(1, 0.5),
								BackgroundColor3 = garbageParameters.StartColor,
								BorderColor3 = Color3.fromRGB(255, 0, 0),
								BorderSizePixel = 2,
								BackgroundTransparency = garbageParameters.StartTrans or 0,
								BorderMode = Enum.BorderMode.Inset,
								Position = UDim2.new(1, garbageParameters.Pos, 0.5, 0),
								Size = UDim2.new(0, 24, 0, 10),
								ZIndex = 22 + 28
							})
							local actualtrans
							if garbageParameters.StartTrans then
								actualtrans = UIUtilities:Create("NumberValue", {
									Parent = ColorP,
									Value = garbageParameters.StartTrans,
									Name = "actual"
								})
							end
							local Alpha = UIUtilities:Create("ImageButton", {
								Name = "Alpha",
								Parent = ColorP,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BorderColor3 = UIStyle.UIcolors.ColorC,
								BorderSizePixel = 0,
								BackgroundTransparency = 1,
								Position = UDim2.new(0.5, 0, 0.5, 0),
								Size = UDim2.new(1, 4, 1, 4),
								ScaleType = "Tile",
								ZIndex = 22 + 27,
								Image = "rbxassetid://3887014957"
							})
							AutoApplyBorder(Alpha, "COLORPBACK", 22 + 27, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
							local inDented = 20
							local YBounds = 190
							if not garbageParameters.StartTrans then
								YBounds = YBounds - 16
							end
							local MasterFrame = UIUtilities:Create("Frame", {
								Name = "Picker",
								Parent = ColorP,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BorderColor3 = Color3.fromRGB(27, 27, 27),
								Position = UDim2.new(0, -5, 0, -1),
								Size = UDim2.new(0, -300, 0, YBounds + inDented),
								BackgroundTransparency = 1,
								Visible = false,
								ZIndex = 22 + 30,
							})
							AutoApplyAccent(MasterFrame, "", 22 + 34)
							AutoApplyBorder(MasterFrame, "COLORBACK", 22 + 25, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)

							local Frame = UIUtilities:Create("Frame", {
								Name = "Picker",
								Parent = MasterFrame,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BorderColor3 = Color3.fromRGB(27, 27, 27),
								Position = UDim2.new(0, 0, 0, 0),
								Size = UDim2.new(1, 0, 1, 0),
								Visible = true,
								ZIndex = 22 + 30,
							})
							local Colorpick = UIUtilities:Create("ImageButton", {
								Name = "Colorpick",
								Parent = Frame,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BorderColor3 = UIStyle.UIcolors.ColorA,
								ClipsDescendants = false,
								BorderSizePixel = 0,
								Position = UDim2.new(0, 8, 0, 10 + inDented),
								Size = UDim2.new(0, 156, 0, 156),
								AutoButtonColor = false,
								Image = "rbxassetid://4155801252",
								ImageColor3 = Color3.fromRGB(255, 0, 0),
								ZIndex = 22 + 33
							})
							AutoApplyBorder(Colorpick, "Picker", 22 + 33, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
							local ColorDrag = UIUtilities:Create("Frame", {
								Name = "ColorDrag",
								Parent = Colorpick,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BorderColor3 = Color3.fromRGB(27, 27, 27),
								Size = UDim2.new(0, 4, 0, 4),
								ZIndex = 22 + 33
							})

							local backThing = UIUtilities:Create("Frame", {
								Name = "thingy",
								Parent = Frame,
								BackgroundColor3 = UIStyle.UIcolors.ColorE,
								BorderColor3 = Color3.fromRGB(27, 27, 27),
								Position = UDim2.new(0, 0, 0, 0),
								Size = UDim2.new(1, 0, 1, 0),
								BackgroundTransparency = 1,
								Visible = true,
								ZIndex = 32,
							})
							local realThing = UIUtilities:Create("Frame", {
								Name = "Picker",
								Parent = backThing,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = UIStyle.UIcolors.ColorA,
								BorderColor3 = Color3.fromRGB(27, 27, 27),
								BorderSizePixel = 0,
								Position = UDim2.new(0.5, 1 * (-1), 0.5, 1),
								Size = UDim2.new(1, -2, 1, -2),
								BackgroundTransparency = 1,
								Visible = true,
								Active = true,
								ZIndex = 22 + 33,
							})
							local theText = UIUtilities:Create("TextLabel", {
								Name = "theText",
								Parent = realThing,
								AnchorPoint = Vector2.new(0, 0),
								Size = UDim2.new(1, 0, 1, 0),
								Text = garbageParameters.ObjectName,
								BackgroundTransparency = 1,
								TextColor3 = UIStyle.UIcolors.FullWhite,
								Font = UIStyle.TextFont.Font,
								LineHeight = 1.1,	
								ZIndex = 22 + 34,
								Position = UDim2.new(0, 8, 0, 4),
								TextSize = UIStyle.TextFont.TxtSize,
								TextXAlignment = Enum.TextXAlignment.Left,
								TextYAlignment = Enum.TextYAlignment.Top,
								TextStrokeColor3 = Color3.new(),
								TextStrokeTransparency = 0.5,
							})

							local Huepick = UIUtilities:Create("ImageButton", {
								Name = "Huepick",
								Parent = Frame,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BorderColor3 = UIStyle.UIcolors.ColorA,
								ClipsDescendants = false,
								BorderSizePixel = 0,
								Position = UDim2.new(0, 172, 0, 10 + inDented),
								Size = UDim2.new(0, 14, 0, 156),
								AutoButtonColor = false,
								Image = "rbxassetid://3641079629",
								ImageColor3 = Color3.fromRGB(255, 0, 0),
								ImageTransparency = 1,
								BackgroundTransparency = 0,
								ZIndex = 22 + 33
							})
							AutoApplyBorder(Huepick, "Picker", 22 + 33, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
							local Huedrag = UIUtilities:Create("Frame", {
								Name = "Huedrag",
								Parent = Huepick,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BorderColor3 = UIStyle.UIcolors.ColorA,
								Size = UDim2.new(1, 0, 0, 2),
								ZIndex = 22 + 33
							})

							local HueFrameGradient = UIUtilities:Create("UIGradient", {
								Rotation = 90,
								Name = "HueFrameGradient",
								Parent = Huepick,
								Color = ColorSequence.new {
									ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
									ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 0, 255)),
									ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 0, 255)),
									ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
									ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 255, 0)),
									ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 255, 0)),
									ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
								},	
							})

							local Transpick, Transcolor, Transdrag

							if TransparencySlider then
								Transpick = UIUtilities:Create("ImageButton", {
									Name = "Transpick",
									Parent = Frame,
									BackgroundColor3 = Color3.fromRGB(255, 255, 255),
									BorderColor3 = UIStyle.UIcolors.ColorA,
									Position = UDim2.new(0, 8, 0, 172 + inDented),
									Size = UDim2.new(0, 156, 0, 12),
									AutoButtonColor = false,
									Image = "rbxassetid://3887014957",
									ScaleType = Enum.ScaleType.Tile,
									TileSize = UDim2.new(0, 10, 0, 10),
									ZIndex = 22 + 33
								})
								AutoApplyBorder(Transpick, "Picker", 22 + 33, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
								Transcolor = UIUtilities:Create("ImageLabel", {
									Name = "Transcolor",
									Parent = Transpick,
									BackgroundColor3 = Color3.fromRGB(255, 255, 255),
									BackgroundTransparency = 1,
									Size = UDim2.new(1, 0, 1, 0),
									Image = "rbxassetid://3887017050",
									ImageColor3 = ColorP.BackgroundColor3,
									ZIndex = 22 + 33,
								})
								Transdrag = UIUtilities:Create("Frame", {
									Name = "Transdrag",
									Parent = Transcolor,
									BackgroundColor3 = Color3.fromRGB(255, 255, 255),
									BorderColor3 = UIStyle.UIcolors.ColorA,
									Position = UDim2.new(0, -1, 0, 0),
									Size = UDim2.new(0, 2, 1, 0),
									ZIndex = 22 + 33
								})
							end

							local OldColorText = UIUtilities:Create("TextLabel", {
								Name = "OldColorText",
								Parent = Frame,
								Size = UDim2.new(0, 16, 0, 14),
								Text = "Old Color",
								BackgroundTransparency = 1,
								TextColor3 = UIStyle.UIcolors.FullWhite,
								Font = UIStyle.TextFont.Font,
								LineHeight = 1.1,
								ZIndex = 22 + 34,
								Position = UDim2.new(0, 212, 0, 78 + inDented),
								TextSize = UIStyle.TextFont.TxtSize,
								TextStrokeColor3 = Color3.new(),
								TextStrokeTransparency = 0.5,
							})
							local OldColor = UIUtilities:Create("Frame", {
								Name = "OldColor",
								Parent = Frame,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BorderColor3 = UIStyle.UIcolors.ColorC,
								BorderSizePixel = 0,
								Position = UDim2.new(0, 196, 0, 94 + inDented),
								Size = UDim2.new(0, 92, 0, 48),
								ZIndex = 22 + 35,
							})
							local OldAlpha = UIUtilities:Create("ImageButton", {
								Name = "OldAlpha",
								Parent = Frame,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BorderColor3 = UIStyle.UIcolors.ColorC,
								BorderSizePixel = 0,
								Position = UDim2.new(0, 196, 0, 94 + inDented),
								BackgroundTransparency = 1,
								Size = UDim2.new(0, 92, 0, 48),
								ScaleType = "Tile",
								ZIndex = 22 + 34,
								Image = "rbxassetid://3887014957"
							})

							AutoApplyBorder(OldAlpha, "OldAlpha", 22 + 34, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)

							local NewColorText = UIUtilities:Create("TextLabel", {
								Name = "NewColorText",
								Parent = Frame,
								Size = UDim2.new(0, 16, 0, 14),
								Text = "New Color",
								BackgroundTransparency = 1,
								TextColor3 = UIStyle.UIcolors.FullWhite,
								Font = UIStyle.TextFont.Font,
								LineHeight = 1.1,
								ZIndex = 22 + 34,
								Position = UDim2.new(0, 212, 0, 6 + inDented),
								TextSize = UIStyle.TextFont.TxtSize,
								TextStrokeColor3 = Color3.new(),
								TextStrokeTransparency = 0.5,
							})
							local NewColor = UIUtilities:Create("Frame", {
								Name = "NewColor",
								Parent = Frame,
								BackgroundColor3 = garbageParameters.StartColor,
								BackgroundTransparency = garbageParameters.StartTrans,
								BorderColor3 = UIStyle.UIcolors.ColorC,
								BorderSizePixel = 0,
								Position = UDim2.new(0, 196, 0, 22 + inDented),
								Size = UDim2.new(0, 92, 0, 48),
								ZIndex = 22 + 35,
							})
							local NewAlpha = UIUtilities:Create("ImageButton", {
								Name = "NewAlpha",
								Parent = Frame,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BorderColor3 = UIStyle.UIcolors.ColorC,
								BorderSizePixel = 0,
								Position = UDim2.new(0, 196, 0, 22 + inDented),
								BackgroundTransparency = 1,
								Size = UDim2.new(0, 92, 0, 48),
								ScaleType = "Tile",
								ZIndex = 22 + 34,
								Image = "rbxassetid://3887014957"
							})
							AutoApplyBorder(NewAlpha, "NewAlpha", 22 + 34, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
							local YOffset = -24
							if garbageParameters.StartTrans then
								YOffset = -22
							end
							local ApplyButton = UIUtilities:Create("TextButton", {
								Name = "Apply",
								AutoButtonColor = false,
								Parent = Frame,
								Size = UDim2.new(0, 52, 0, 16),
								Text = "[ Apply ]",
								BackgroundTransparency = 1,
								TextColor3 = UIStyle.UIcolors.FullWhite,
								Font = UIStyle.TextFont.Font,
								LineHeight = 1.1,
								ZIndex = 22 + 34,
								Position = UDim2.new(0, 196, 0, YBounds + YOffset + inDented),
								TextSize = UIStyle.TextFont.TxtSize,
								TextStrokeColor3 = Color3.new(),
								TextStrokeTransparency = 0.5,
							})

							local okFrameBackGroundGradient = UIUtilities:Create("UIGradient",{
								Color = ColorSequence.new({
									ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
									ColorSequenceKeypoint.new(0.06, UIStyle.UIcolors.ColorA),
									ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
								}),
								Rotation = 90,
								Parent = Frame
							})

							local CopyNewColor = UIUtilities:Create("TextButton", {
								Name = "CopyNewColor",
								Parent = NewColor,
								AutoButtonColor = false,
								Size = UDim2.new(1, 0, 0.5, 0),
								Text = "Copy",
								BackgroundTransparency = 1,
								TextColor3 = UIStyle.UIcolors.FullWhite,
								Font = UIStyle.TextFont.Font,
								Visible = false,
								LineHeight = 1.1,
								ZIndex = 22 + 35,
								Position = UDim2.new(0, 0, 0, 0),
								TextSize = UIStyle.TextFont.TxtSize,
								TextStrokeColor3 = Color3.new(),
								TextXAlignment = Enum.TextXAlignment.Center,
								TextYAlignment = Enum.TextYAlignment.Center,
								TextStrokeTransparency = 0.5,
							})

							local PasteNewColor = UIUtilities:Create("TextButton", {
								Name = "PasteNewColor",
								Parent = NewColor,
								AnchorPoint = Vector2.new(0, 1),
								AutoButtonColor = false,
								Size = UDim2.new(1, 0, 0.5, 0),
								Text = "Paste",
								BackgroundTransparency = 1,
								Visible = false,
								TextColor3 = UIStyle.UIcolors.FullWhite,
								Font = UIStyle.TextFont.Font,
								LineHeight = 1.1,
								ZIndex = 22 + 35,
								Position = UDim2.new(0, 0, 1, 0),
								TextSize = UIStyle.TextFont.TxtSize,
								TextStrokeColor3 = Color3.new(),
								TextXAlignment = Enum.TextXAlignment.Center,
								TextYAlignment = Enum.TextYAlignment.Center,
								TextStrokeTransparency = 0.5,
							})

							local CopyOldColor = UIUtilities:Create("TextButton", {
								Name = "PasteOldColor",
								Parent = OldColor,
								Size = UDim2.new(1, 0, 1, 0),
								AutoButtonColor = false,
								Text = "Copy",
								BackgroundTransparency = 1,
								TextColor3 = UIStyle.UIcolors.FullWhite,
								Visible = false,
								Font = UIStyle.TextFont.Font,
								LineHeight = 1.1,
								ZIndex = 22 + 35,
								Position = UDim2.new(0, 0, 0, 0),
								TextSize = UIStyle.TextFont.TxtSize,
								TextStrokeColor3 = Color3.new(),
								TextXAlignment = Enum.TextXAlignment.Center,
								TextYAlignment = Enum.TextYAlignment.Center,
								TextStrokeTransparency = 0.5,
							})

							local abc = false
							local inCP = false
							ColorP.MouseEnter:Connect(function()
								abc = true
							end)
							ColorP.MouseLeave:Connect(function()
								abc = false
							end)
							MasterFrame.MouseEnter:Connect(function()
								inCP = true
							end)
							MasterFrame.MouseLeave:Connect(function()
								inCP = false
							end)

							NewColor.MouseEnter:Connect(function()
								CopyNewColor.Visible = true
								PasteNewColor.Visible = true
							end)

							NewColor.MouseLeave:Connect(function()
								CopyNewColor.Visible = false
								PasteNewColor.Visible = false
							end)

							OldColor.MouseEnter:Connect(function()
								CopyOldColor.Visible = true
							end)

							OldColor.MouseLeave:Connect(function()
								CopyOldColor.Visible = false
							end)

							local function UpdatePickers(Color)
								ColorH, ColorS, ColorV = RGBtoHSV(Color)

								ColorH = math.clamp(ColorH, 0, 1)
								ColorS = math.clamp(ColorS, 0, 1)
								ColorV = math.clamp(ColorV, 0, 1)

								ColorDrag.Position = UDim2.new(1 - ColorS, 0, 1 - ColorV, 0)
								Colorpick.ImageColor3 = Color3.fromHSV(ColorH, 1, 1)
								Huedrag.Position = UDim2.new(0, 0, 1-ColorH, -1)
								if Transcolor then
									Transcolor.ImageColor3 = Color
								end
							end

							UpdatePickers(ColorP.BackgroundColor3)

							ColorP.MouseButton1Down:Connect(function()
								if isColorThingOpen2 and isColorThingOpen2 ~= MasterFrame then
									return
								end
								MasterFrame.Visible = not MasterFrame.Visible
								if MasterFrame.Visible == false then
									isColorThingOpen2 = nil
								else
									isColorThingOpen2 = MasterFrame
								end
								UpdatePickers(ColorP.BackgroundColor3)
								if MasterFrame.Visible then
									OldColor.BackgroundTransparency = ColorP.BackgroundTransparency
									OldColor.BackgroundColor3 = ColorP.BackgroundColor3
								end
							end)

							PasteNewColor.MouseButton1Down:Connect(function()
								if ClipboardColor then
									NewColor.BackgroundColor3 = ClipboardColor
									UpdatePickers(NewColor.BackgroundColor3)
								end
							end)

							CopyOldColor.MouseButton1Down:Connect(function()
								ClipboardColor = OldColor.BackgroundColor3
							end)

							CopyNewColor.MouseButton1Down:Connect(function()
								ClipboardColor = NewColor.BackgroundColor3
							end)

							UserInputService.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
									if not dragging and not abc and not inCP then
										MasterFrame.Visible = false
										isColorThingOpen2 = nil
									end
								end
							end)

							local function updateColor()
								local ColorX = (math.clamp(Mouse.X - Colorpick.AbsolutePosition.X, 0, Colorpick.AbsoluteSize.X)/Colorpick.AbsoluteSize.X)
								local ColorY = (math.clamp(Mouse.Y - Colorpick.AbsolutePosition.Y, 0, Colorpick.AbsoluteSize.Y)/Colorpick.AbsoluteSize.Y)
								ColorDrag.Position = UDim2.new(ColorX, 0, ColorY, 0)
								ColorS = 1-ColorX
								ColorV = 1-ColorY
								Colorpick.ImageColor3 = Color3.fromHSV(ColorH, 1, 1)
								NewColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
								if Transcolor then
									Transcolor.ImageColor3 = NewColor.BackgroundColor3
								end
							end

							local function updateHue()
								local y = math.clamp(Mouse.Y - Huepick.AbsolutePosition.Y, 0, Huepick.AbsoluteSize.Y)
								Huedrag.Position = UDim2.new(0, 0, 0, y)
								hue = y/Huepick.AbsoluteSize.Y
								ColorH = 1-hue
								Colorpick.ImageColor3 = Color3.fromHSV(ColorH, 1, 1)
								NewColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
								if Transcolor then
									Transcolor.ImageColor3 = NewColor.BackgroundColor3
								end
							end
							local function updateTrans()
								if Transcolor then
									local x = math.clamp(Mouse.X - Transpick.AbsolutePosition.X, 0, Transpick.AbsoluteSize.X)
									NewColor.BackgroundTransparency = x/Transpick.AbsoluteSize.X
									Transdrag.Position = UDim2.new(0, x, 0, 0)
									Transcolor.ImageColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
								end
							end
							if Transcolor then
								Transpick.MouseButton1Down:Connect(function()
									updateTrans()
									moveconnection = Mouse.Move:Connect(function()
										updateTrans()
									end)
									releaseconnection = UserInputService.InputEnded:Connect(function(mouse)
										if mouse.UserInputType == Enum.UserInputType.MouseButton1 then
											updateTrans()
											moveconnection:Disconnect()
											releaseconnection:Disconnect()
										end
									end)
								end)
							end
							Colorpick.MouseButton1Down:Connect(function()
								updateColor()
								moveconnection = Mouse.Move:Connect(function()
									updateColor()
								end)
								releaseconnection = UserInputService.InputEnded:Connect(function(mouse)
									if mouse.UserInputType == Enum.UserInputType.MouseButton1 then
										updateColor()
										moveconnection:Disconnect()
										releaseconnection:Disconnect()
									end
								end) 
							end)

							ApplyButton.MouseButton1Down:Connect(function()
								ColorP.BackgroundColor3 = NewColor.BackgroundColor3
								ColorP.BackgroundTransparency = NewColor.BackgroundTransparency
								MasterFrame.Visible = false
								isColorThingOpen = nil
							end)

							Huepick.MouseButton1Down:Connect(function()
								updateHue()
								moveconnection = Mouse.Move:Connect(function()
									updateHue()
								end)
								releaseconnection = game:GetService("UserInputService").InputEnded:Connect(function(mouse)
									if mouse.UserInputType == Enum.UserInputType.MouseButton1 then
										updateHue()
										moveconnection:Disconnect()
										releaseconnection:Disconnect()
									end
								end)
							end)
							ColorP.BorderColor3 = Color3.fromRGB(math.clamp((ColorP.BackgroundColor3.R * 255) - 40, 40, 255), math.clamp((ColorP.BackgroundColor3.G * 255) - 40, 40, 255), math.clamp((ColorP.BackgroundColor3.B * 255) - 40, 40, 255))
							ColorP:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
								local Hue, Sat, Val = RGBtoHSV(ColorP.BackgroundColor3)
								fakeFlagNigger["Color"] = ColorP.BackgroundColor3
								fakeFlagNigger.Changed:Fire(ColorP.BackgroundColor3, ColorP.BackgroundTransparency)
								local Color = ColorP.BackgroundColor3
								ColorP.BorderColor3 = Color3.fromRGB(math.clamp((Color.R * 255) - 40, 40, 255), math.clamp((Color.G * 255) - 40, 40, 255), math.clamp((Color.B * 255) - 40, 40, 255))
							end)
							if Parameters.StartTrans then
								ColorP:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
									if fading == false then
										fakeFlagNigger["Transparency"] = ColorP.BackgroundTransparency
										fakeFlagNigger.Changed:Fire(ColorP.BackgroundColor3, ColorP.BackgroundTransparency)
										actualtrans.Value = ColorP.BackgroundTransparency
									end
								end)
							end

							fakeFlagNigger = setmetatable({}, {
								__index = function(self, i)
									if ColorProxy[i] == nil then
										if i == "Transparency" then
											return ColorP.BackgroundTransparency
										elseif i == "Color" then
											return ColorP.BackgroundColor3
										end
									else
										return ColorProxy[i]
									end	
								end,
								__newindex = function(self, i, v)
									if i == "Color" then
										if type(v) == "table" then
											local af = Color3.new(v.r, v.g, v.b)
											v = af
										end
										ColorP.BackgroundColor3 = v
									elseif i == "Transparency" then
										ColorP.BackgroundTransparency = v
									end
									ColorProxy[i] = v
								end
							})						
						elseif data.type == "slider" then

							local garbageParameters = {
								Name = data.name,
								MinimumNumber = data.min,
								MaximumNumber = data.max,
								Suffix = data.suffix
							}

							fakeFlagNigger = {}
							fakeFlagNigger.Changed = Signal.new()
							local Proxy = fakeFlagNigger
							if not garbageParameters.Suffix then
								garbageParameters.Suffix = ""
							end
							local Slider = UIUtilities:Create("Frame", {
								Name = garbageParameters.Name,
								Parent = faggot,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								ZIndex = 20 + 22,
								Position = UDim2.new(0, 0, 0, 0),
								Size = UDim2.new(1, 0, 0, 20)
							})
							local TextLabel = UIUtilities:Create("TextButton", {
								Parent = Slider,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								Position = UDim2.new(0, 8, 0, -4),
								Size = UDim2.new(1, 0, 0, 15),
								Font = UIStyle.TextFont.Font,
								ZIndex = 20 + 22,
								Text = garbageParameters.Name,
								TextColor3 = UIStyle.UIcolors.FullWhite,
								TextStrokeColor3 = Color3.new(),
								LineHeight = 1.2,
								TextStrokeTransparency = 0.5,
								TextSize = UIStyle.TextFont.TxtSize,
								TextXAlignment = Enum.TextXAlignment.Left
							})
							local AddText = UIUtilities:Create("TextButton", {
								Parent = Slider,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								Position = UDim2.new(1, -32, 0, -4),
								Size = UDim2.new(0, 8, 0, 15),
								Font = UIStyle.TextFont.Font,
								ZIndex = 20 + 22,
								Visible = false,
								Text = "+",
								TextColor3 = UIStyle.UIcolors.FullWhite,
								TextStrokeColor3 = Color3.new(),
								TextStrokeTransparency = 0.5,
								TextSize = UIStyle.TextFont.TxtSize,
								TextXAlignment = Enum.TextXAlignment.Center
							})
							local SubtractText = UIUtilities:Create("TextButton", {
								Parent = Slider,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								Position = UDim2.new(1, -22, 0, -4),
								Size = UDim2.new(0, 8, 0, 15),
								Font = UIStyle.TextFont.Font,
								ZIndex = 20 + 22,
								Visible = false,
								Text = "-",
								TextColor3 = UIStyle.UIcolors.FullWhite,
								TextStrokeColor3 = Color3.new(),
								TextStrokeTransparency = 0.5,
								TextSize = UIStyle.TextFont.TxtSize,
								TextXAlignment = Enum.TextXAlignment.Center
							})

							local Button = UIUtilities:Create("TextButton", {
								AnchorPoint = Vector2.new(0.5, 0),
								Name = "Button",
								Parent = Slider,
								BackgroundTransparency = 1,
								BackgroundColor3 = UIStyle.UIcolors.ColorD,
								BorderSizePixel = 0,
								Position = UDim2.new(0.5, 0, 0, 12),
								Size = UDim2.new(1, -18, 0, 8),
								AutoButtonColor = false,
								ZIndex = 20 + 21,
								Text = ""
							})
							local ButtonStyle = UIUtilities:Create("Frame", {
								AnchorPoint = Vector2.new(0.5, 0.5),
								Name = "Button",
								Parent = Button,
								BackgroundTransparency = 0,
								BackgroundColor3 = UIStyle.UIcolors.ColorD,
								BorderSizePixel = 0,
								Position = UDim2.new(0.5, 0, 0.5, 0),
								Size = UDim2.new(1, 0, 1, 0),
								ZIndex = 20 + 22
							})
							local ButtonStyleStyling = UIUtilities:Create("UIGradient", {
								Color = ColorSequence.new({
									ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
									ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
								}),
								Rotation = 90,
								Parent = ButtonStyle
							})

							AutoApplyBorder(ButtonStyle, garbageParameters.Name, 20 + 22, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
							local Frame = UIUtilities:Create("Frame", {
								Parent = Button,
								BackgroundColor3 = UIStyle.UIcolors.Accent,
								BorderSizePixel = 0,
								ZIndex = 20 + 22,
								Size = UDim2.new(0, 0, 1, 0)
							})
							table.insert(UIAccents, Frame)
							local FrameStyling = UIUtilities:Create("UIGradient", {
								Color = ColorSequence.new({
									ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
									ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
								}),
								Rotation = 90,
								Parent = Frame
							})

							local Value = UIUtilities:Create("TextLabel", {
								AnchorPoint = Vector2.new(0.5, 0.5),
								Name = "Value",
								Parent = ButtonStyle,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								Position = UDim2.new(0.5, 0, 0.5, 0),
								Size = UDim2.new(1, 0, 0, 2),
								LineHeight = 1.1,
								Font = UIStyle.TextFont.Font,
								Text = garbageParameters.MinimumText or garbageParameters.MinimumNumber .. garbageParameters.Suffix,
								ZIndex = 20 + 24,
								TextColor3 = UIStyle.UIcolors.FullWhite,
								TextStrokeColor3 = Color3.new(),
								TextStrokeTransparency = 0.5,
								TextSize = UIStyle.TextFont.TxtSize,
								TextXAlignment = Enum.TextXAlignment.Center
							})

							local NumberValue = UIUtilities:Create("NumberValue", {
								Value = garbageParameters.MinimumNumber,
								Parent = Slider,
								Name = garbageParameters.Name
							})
							fakeFlagNigger["Value"] = NumberValue.Value
							local mouse = Mouse
							local val
							local Absolute = Button.AbsoluteSize.X
							local Moving = false

							Button.MouseButton1Down:Connect(function()
								Absolute = Button.AbsoluteSize.X
								if moveconnection then
									moveconnection:Disconnect()
								end
								if releaseconnection then
									releaseconnection:Disconnect() -- fixing the issue where if ur mouse goes off screen while dragging itll cancel it on click
								end
								Moving = true
								Frame.Size = UDim2.new(0, math.clamp(mouse.X - Frame.AbsolutePosition.X, 0, Absolute), 1, 0)
								val = math.floor(0.5 + (((garbageParameters.MaximumNumber - garbageParameters.MinimumNumber) / Absolute) * Frame.AbsoluteSize.X) + garbageParameters.MinimumNumber) or 0
								NumberValue.Value = val
								moveconnection = mouse.Move:Connect(function()
									Frame.Size = UDim2.new(0, math.clamp(mouse.X - Frame.AbsolutePosition.X, 0, Absolute), 1, 0)
									val = math.floor(0.5 + (((garbageParameters.MaximumNumber - garbageParameters.MinimumNumber) / Absolute) * Frame.AbsoluteSize.X) + garbageParameters.MinimumNumber)
									NumberValue.Value = val
								end)
								releaseconnection = UserInputService.InputEnded:Connect(function(Mouse)
									if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
										Frame.Size = UDim2.new(0, math.clamp(mouse.X - Frame.AbsolutePosition.X, 0, Absolute), 1, 0)
										val = (((garbageParameters.MaximumNumber - garbageParameters.MinimumNumber) / Absolute) * Frame.AbsoluteSize.X) + garbageParameters.MinimumNumber
										moveconnection:Disconnect()
										releaseconnection:Disconnect()
										Moving = false
									end
								end)
							end)
							NumberValue.Changed:Connect(function()
								Absolute = Button.AbsoluteSize.X
								NumberValue.Value = math.clamp(NumberValue.Value, garbageParameters.MinimumNumber, garbageParameters.MaximumNumber)
								if not Moving then
									local Portion = 0.5
									if garbageParameters.MinimumNumber > 0 then
										Portion = ((NumberValue.Value - garbageParameters.MinimumNumber)) / (garbageParameters.MaximumNumber - garbageParameters.MinimumNumber)
									else
										Portion = (NumberValue.Value - garbageParameters.MinimumNumber) / (garbageParameters.MaximumNumber - garbageParameters.MinimumNumber)
									end
									Frame.Size = UDim2.new(Portion, 0, 1, 0) -- itll go back to offset when someone tries moving it
									val = math.floor(0.5 + (((garbageParameters.MaximumNumber - garbageParameters.MinimumNumber) / Absolute) * Frame.AbsoluteSize.X) + garbageParameters.MinimumNumber) or 0
								end
								if NumberValue.Value == garbageParameters.MaximumNumber and garbageParameters.MaximumText ~= nil then
									Value.Text = garbageParameters.MaximumText
								elseif NumberValue.Value == garbageParameters.MinimumNumber and garbageParameters.MinimumText ~= nil then
									Value.Text = garbageParameters.MinimumText
								else
									Value.Text = val .. garbageParameters.Suffix  
								end
								fakeFlagNigger["Value"] = NumberValue.Value
								if garbageParameters.Callback then
									garbageParameters.Callback(NumberValue.Value)
								end
								fakeFlagNigger.Changed:Fire(NumberValue.Value)
							end)
							Slider.MouseEnter:Connect(function()
								AddText.Visible = true
								SubtractText.Visible = true
							end)
							Slider.MouseLeave:Connect(function()
								AddText.Visible = false
								SubtractText.Visible = false
							end)
							AddText.MouseEnter:Connect(function()
								AddText.TextColor3 = UIStyle.UIcolors.Accent
							end)
							AddText.MouseLeave:Connect(function()
								AddText.TextColor3 = UIStyle.UIcolors.FullWhite
							end)
							SubtractText.MouseEnter:Connect(function()
								SubtractText.TextColor3 = UIStyle.UIcolors.Accent
							end)
							SubtractText.MouseLeave:Connect(function()
								SubtractText.TextColor3 = UIStyle.UIcolors.FullWhite
							end)
							AddText.MouseButton1Down:Connect(function()
								NumberValue.Value = NumberValue.Value + 1
							end)
							SubtractText.MouseButton1Down:Connect(function()
								NumberValue.Value = NumberValue.Value - 1
							end)
							fakeFlagNigger = setmetatable({}, {
								__index = function(self, i)
									return Proxy[i]
								end,
								__newindex = function(self, i, v)
									if i == "Value" then
										NumberValue.Value = v
									end
									Proxy[i] = v
								end
							})
						end
						fakeFlagsShit[fix][data.name] = fakeFlagNigger
					end
				end

				local reUpdate = function() end

				do
					local zindexBoost = 20
					local fakeFlag = {}
					local Proxy = fakeFlag
					fakeFlag["Dropdown"] = {}
					fakeFlag["Dropdown"].Changed = Signal.new()
					local Parameters = {
						Name = "Animation Type",
						Values = {
							"None",
							"Rainbow",
							"Linear",
							"Oscillating",
							"Strobe",
							"Sawtooth"
						}
					}

					local Contained = UIUtilities:Create("Frame", {
						AnchorPoint = Vector2.new(0.5, 0),
						Name = Parameters.Name,
						Parent = otherFrame,
						BackgroundColor3 = Color3.fromRGB(0, 0, 0),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0, inDented + 8),
						Size = UDim2.new(1, 0, 0, 32),
						ZIndex = zindexBoost + 22,
					})
					local ValueContainer = UIUtilities:Create("Frame", {
						AnchorPoint = Vector2.new(0.5, 0),
						Name = "ValueContainer",
						Parent = Contained,
						BackgroundTransparency = 1,
						Position = UDim2.new(0.5, 0, 1, 4),
						Size = UDim2.new(1, -18, 0, 16),
						Visible = false,
						ZIndex = zindexBoost + 23,
					})
					local FakeSelection = UIUtilities:Create("TextButton", {
						Active = true,
						AnchorPoint = Vector2.new(0.5, 1),
						Name = "FAKE",
						Parent = Contained,
						BackgroundColor3 = Color3.fromRGB(44, 44, 44),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(39, 39, 39),
						BorderSizePixel = 3,
						Position = UDim2.new(0.5, 0, 1, 0),
						Selectable = true,
						Size = UDim2.new(1, -18, 0, 20),
						ZIndex = zindexBoost + 24,
						Font = UIStyle.TextFont.Font,
						ClipsDescendants = false,
						LineHeight = 1.1,
						Text = "",
						TextColor3 = UIStyle.UIcolors.FullWhite,
						TextSize = UIStyle.TextFont.TxtSize,
						TextStrokeColor3 = Color3.new(),
						TextStrokeTransparency = 0.5,
						TextXAlignment = Enum.TextXAlignment.Left,
					})
					local Selection = UIUtilities:Create("TextButton", {
						Active = true,
						AnchorPoint = Vector2.new(0.5, 1),
						Name = "Selection",
						Parent = Contained,
						BackgroundColor3 = Color3.fromRGB(44, 44, 44),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(39, 39, 39),
						BorderSizePixel = 3,
						Position = UDim2.new(0.5, 0, 1, 0),
						Selectable = true,
						Size = UDim2.new(1, -18, 0, 20),
						ZIndex = zindexBoost + 24,
						Font = UIStyle.TextFont.Font,
						ClipsDescendants = true,
						LineHeight = 1.1,
						Text = Parameters.Values[1],
						TextColor3 = UIStyle.UIcolors.FullWhite,
						TextSize = UIStyle.TextFont.TxtSize,
						TextStrokeColor3 = Color3.new(),
						TextStrokeTransparency = 0.5,
						TextXAlignment = Enum.TextXAlignment.Left,
					})
					local DropDownTypeText = UIUtilities:Create("TextButton", {
						AnchorPoint = Vector2.new(0.5, 1),
						Name = "TypeOf",
						Parent = Contained,
						BackgroundColor3 = Color3.fromRGB(44, 44, 44),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(39, 39, 39),
						BorderSizePixel = 3,
						Position = UDim2.new(0.5, 0, 1, 0),
						Size = UDim2.new(1, -32, 0, 18),
						ZIndex = zindexBoost + 23,
						Font = UIStyle.TextFont.Font,
						LineHeight = 1.1,
						Text = "-",
						TextColor3 = UIStyle.UIcolors.FullWhite,
						TextSize = UIStyle.TextFont.TxtSize,
						TextStrokeColor3 = Color3.new(),
						TextStrokeTransparency = 0.5,
						TextXAlignment = Enum.TextXAlignment.Right,
					})
					if Parameters.MultiChoice then 
						DropDownTypeText.Text = "..."
					end
					local Padding = UIUtilities:Create("UIPadding", {
						Parent = Selection,
						PaddingLeft = UDim.new(0, 12)
					}) 
					local Padding2 = UIUtilities:Create("UIPadding", {
						Parent = FakeSelection,
						PaddingLeft = UDim.new(0, 12)
					}) 
					local SelectionStyling = UIUtilities:Create("Frame", {
						BackgroundColor3 = UIStyle.UIcolors.FullWhite,
						Parent = FakeSelection,
						BorderSizePixel = 0,
						Position = UDim2.new(0, -12, 0, 0),
						Size = UDim2.new(1, 12, 1, 0),
						ZIndex = zindexBoost + 23,
					})
					local SelectionStylingGradient = UIUtilities:Create("UIGradient", {
						Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
							ColorSequenceKeypoint.new(0.84, UIStyle.UIcolors.ColorA),
							ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
						}),
						Rotation = 90,
						Parent = SelectionStyling
					})
					AutoApplyBorder(SelectionStyling, "SelectionStyling", 22 + zindexBoost, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
					local NameTag = UIUtilities:Create("TextLabel", {
						Name = "NAMETAG",
						Parent = Contained,
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 8, 0, 0),
						Size = UDim2.new(1, -12, 1, -24),
						Font = UIStyle.TextFont.Font,
						Text = Parameters.Name,
						TextColor3 = UIStyle.UIcolors.FullWhite,
						TextSize = UIStyle.TextFont.TxtSize,
						TextStrokeColor3 = Color3.new(),
						TextStrokeTransparency = 0.5,
						TextXAlignment = Enum.TextXAlignment.Left,
						ZIndex = zindexBoost + 22
					})
					local Organizer = UIUtilities:Create("UIListLayout", {
						Padding = UDim.new(0, 0),
						Parent = ValueContainer,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
					})
					for iC, vC in next, (Parameters.Values) do
						local Button = UIUtilities:Create("TextButton", {
							AnchorPoint = Vector2.new(0.5, 0),
							Name = "Button",
							Parent = ValueContainer,
							AutoButtonColor = false,
							BackgroundColor3 = UIStyle.UIcolors.ColorI,
							BorderColor3 = UIStyle.UIcolors.ColorB,
							BorderSizePixel = 0,
							BackgroundTransparency = 0,
							Position = UDim2.new(0.5, 0, 0, 0),
							Size = UDim2.new(1, 0, 0, 18),
							ZIndex = zindexBoost + 32,
							Font = UIStyle.TextFont.Font,
							TextStrokeColor3 = Color3.new(),
							TextStrokeTransparency = 0,
							Text = vC,
							TextColor3 = UIStyle.UIcolors.FullWhite,
							TextSize = UIStyle.TextFont.TxtSize
						})
						local valsthing = UIUtilities:Create("BoolValue", {
							Parent = Button,
							Value = false,
							Name = "Selection"
						})
						if iC == 1 and Parameters.MultiChoice then
							Button.TextColor3 = UIStyle.UIcolors.Accent
							valsthing.Value = true
						end
						local ButtonStyling = UIUtilities:Create("Frame", {
							AnchorPoint = Vector2.new(0.5, 0.5),
							Parent = Button,
							BackgroundColor3 = UIStyle.UIcolors.ColorA,
							BorderSizePixel = 1,
							BorderColor3 = UIStyle.UIcolors.ColorB,
							Position = UDim2.new(0.5, 0, 0.5, 0),
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = zindexBoost + 31
						})
						AutoApplyBorder(ButtonStyling, vC, 31 + zindexBoost, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
					end
					local closeconnection
					local inDropDown = false
					local mouseent, mouseext
					local function trigger()
						ValueContainer.Size = UDim2.new(1, -18, 0, #Parameters.Values * 18)
						ValueContainer.Visible = not ValueContainer.Visible
						if ValueContainer.Visible then
							if not Parameters.MultiChoice then
								for _, Button in next, (ValueContainer:GetChildren()) do
									if Button:IsA("TextButton") then
										if Button.Text == Selection.Text then
											Button.TextColor3 = UIStyle.UIcolors.Accent
										else
											Button.TextColor3 = UIStyle.UIcolors.FullWhite
										end	
									end
								end
							else
								for _, Button in next, (ValueContainer:GetChildren()) do
									if Button:IsA("TextButton") then
										if table.find(fakeFlag["Value"], Button.Text) ~= nil then
											Button.TextColor3 = UIStyle.UIcolors.Accent
										else
											Button.TextColor3 = UIStyle.UIcolors.FullWhite
										end	
									end
								end
							end
							task.wait()
							mouseent = ValueContainer.MouseEnter:Connect(function()
								inDropDown = true
							end)
							mouseext = ValueContainer.MouseLeave:Connect(function()
								inDropDown = false
							end)
							closeconnection = UserInputService.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
									if not inDropDown then
										ValueContainer.Visible = false
										closeconnection:Disconnect()
										mouseent:Disconnect()
										mouseext:Disconnect()
									end
								end
							end)
						else
							if closeconnection then
								closeconnection:Disconnect()
							end
							if mouseent then
								mouseent:Disconnect()
							end
							if mouseext then
								mouseext:Disconnect()
							end
						end
					end
					Selection.MouseButton1Down:Connect(trigger)
					local function initialize()
						if Parameters.MultiChoice then	
							fakeFlag["Value"] = {Parameters.Values[1]}

							local function update()
								local chosentext = {}
								Selection.Text = ""

								for cf, c in next, (ValueContainer:GetChildren()) do
									if c:IsA("TextButton") then
										if c:FindFirstChild("Selection") and c.Selection.Value == true then
											table.insert(chosentext, c.Text)
										end
									end
								end

								for e = 1, #chosentext do
									if e == #chosentext then
										Selection.Text = Selection.Text .. chosentext[e]
									else
										Selection.Text = Selection.Text .. chosentext[e] .. ", "
									end
								end
							end

							for _, button in next, (ValueContainer:GetChildren()) do
								if button:IsA("TextButton") then
									button.MouseButton1Down:Connect(function()
										button.TextColor3 = UIStyle.UIcolors.Accent
										button.Selection.Value = not button.Selection.Value
										if button:FindFirstChild("Selection") and button.Selection.Value == true then
											button.TextColor3 = UIStyle.UIcolors.FullWhite
										end
										update()
									end)
								end
							end

						else
							fakeFlag["Value"] = Parameters.Values[1]
							for _, ButtonA in next, (ValueContainer:GetChildren()) do
								if ButtonA:IsA("TextButton") then
									ButtonA.MouseButton1Down:Connect(function()
										Selection.Text = ButtonA.Text
										trigger()
									end)
								end
							end
						end
					end
					initialize()
					Selection:GetPropertyChangedSignal("Text"):Connect(function()
						if Parameters.MultiChoice then
							if ValueContainer.Visible == false then
								local selectedvalues = (Selection.Text):split(", ")
								for _, button in next, (ValueContainer:GetChildren()) do
									if button:IsA("TextButton") then
										if table.find(selectedvalues, button.Text) then
											button.TextColor3 = UIStyle.UIcolors.Accent
										else
											button.TextColor3 = Color3.fromRGB(255, 255, 255)
										end
									end
								end
								fakeFlag["Value"] = selectedvalues
							else
								local selection = {}
								for cf, c in next, (ValueContainer:GetChildren()) do
									if c:IsA("TextButton") then
										if c:FindFirstChild("Selection") and c.Selection.Value == true then
											table.insert(selection, c.Text)
										end
									end
								end
								if selection[1] == nil then
									Selection.Text = "None"
								end
								fakeFlag["Value"] = selection
							end
						else
							fakeFlag["Value"] = Selection.Text
						end
						if Parameters.Callback then
							Parameters.Callback(fakeFlag["Value"])
						end
						fakeFlag["Dropdown"].Changed:Fire(fakeFlag["Value"])
					end)
					fakeFlag.UpdateValues = function(NewValues)
						if Parameters.MultiChoice then
							fakeFlag["Value"] = {}
						else
							fakeFlag["Value"] = ""
						end
						for i, v in next, (ValueContainer:GetChildren()) do
							if v ~= Organizer then
								v:Destroy()
							end
						end
						for iC, vC in next, (NewValues) do
							local Button = UIUtilities:Create("TextButton", {
								AnchorPoint = Vector2.new(0.5, 0),
								Name = "Button",
								Parent = ValueContainer,
								AutoButtonColor = false,
								BackgroundColor3 = UIStyle.UIcolors.ColorI,
								BorderColor3 = UIStyle.UIcolors.ColorB,
								BorderSizePixel = 0,
								BackgroundTransparency = 0,
								Position = UDim2.new(0.5, 0, 0, 0),
								Size = UDim2.new(1, 0, 0, 18),
								ZIndex = zindexBoost + 32,
								Font = UIStyle.TextFont.Font,
								TextStrokeColor3 = Color3.new(),
								TextStrokeTransparency = 0,
								Text = vC,
								TextColor3 = UIStyle.UIcolors.FullWhite,
								TextSize = UIStyle.TextFont.TxtSize
							})
							if iC == 1 and Parameters.MultiChoice then
								Button.TextColor3 = UIStyle.UIcolors.Accent
							end
							local ButtonStyling = UIUtilities:Create("Frame", {
								AnchorPoint = Vector2.new(0.5, 0.5),
								Parent = Button,
								BackgroundColor3 = UIStyle.UIcolors.ColorA,
								BorderSizePixel = 1,
								BorderColor3 = UIStyle.UIcolors.ColorB,
								Position = UDim2.new(0.5, 0, 0.5, 0),
								Size = UDim2.new(1, 0, 1, 0),
								ZIndex = zindexBoost + 31
							})
							AutoApplyBorder(ButtonStyling, vC, 31 + zindexBoost, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
						end
						Parameters.Values = NewValues
						Selection.Text = NewValues[1]
						initialize()
					end
					fakeFlag = setmetatable({}, {
						__index = function(self, i)
							return Proxy[i]
						end,
						__newindex = function(self, i, v)
							Proxy[i] = v
							if i == "Value" then
								if not Parameters.MultiChoice then
									Selection.Text = v
								else
									for _, button in next, (ValueContainer:GetChildren()) do
										if button:IsA("TextButton") then
											if table.find(v, button.Text) then
												button.Selection.Value = true
												button.TextColor3 = UIStyle.UIcolors.Accent
											else
												button.TextColor3 = Color3.fromRGB(255, 255, 255)
												button.Selection.Value = false
											end
										end
									end
								end
							end
						end
					})

					fakeFlag["Dropdown"].Changed:Connect(function(value)
						for i, v in next, otherFrame:GetChildren() do
							for i2, v2 in next, imHungover do
								if v.Name == i2 then
									if v.Name == value then
										v.Visible = true
									else
										v.Visible = false
									end
								end
							end
						end
						reUpdate(value)
					end)

					dropKickFlag = fakeFlag
				end

				local okFrameBackGroundGradient = UIUtilities:Create("UIGradient",{
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
						ColorSequenceKeypoint.new(0.06, UIStyle.UIcolors.ColorA),
						ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
					}),
					Rotation = 90,
					Parent = otherFrame
				})

				local TabHolder = UIUtilities:Create("Frame", {
					Name = "Picker",
					Parent = MasterFrame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = Color3.fromRGB(27, 27, 27),
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 0, inDented),
					Visible = true,
					ZIndex = 31,
				})

				AutoApplyBorder(TabHolder, "COLORBACK", 31, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
				local TabFrameBackGroundGradient = UIUtilities:Create("UIGradient",{
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
						ColorSequenceKeypoint.new(0.06, UIStyle.UIcolors.ColorA),
						ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
					}),
					Rotation = 90,
					Parent = TabHolder
				})

				local toggleablethingos = {}

				for i, v in next, {"Color", "Animation"} do
					local textLeng = TextService:GetTextSize(v, UIStyle.TextFont.TxtSize, UIStyle.TextFont.Font, Vector2.new(900, 900)).X
					local backThing = UIUtilities:Create("Frame", {
						Name = "thingy",
						Parent = TabHolder,
						BackgroundColor3 = UIStyle.UIcolors.ColorE,
						BorderColor3 = Color3.fromRGB(27, 27, 27),
						Position = UDim2.new(0, 0, 0, 0),
						Size = UDim2.new(0, textLeng + 10, 1, 0),
						BackgroundTransparency = 1,
						Visible = true,
						ZIndex = 32,
					})
					local realThing = UIUtilities:Create("Frame", {
						Name = "Picker",
						Parent = backThing,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = UIStyle.UIcolors.ColorA,
						BorderColor3 = Color3.fromRGB(27, 27, 27),
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, i * (-1), 0.5, 1),
						Size = UDim2.new(1, -2, 1, -2),
						BackgroundTransparency = 0,
						Visible = true,
						Active = true,
						ZIndex = 33,
					})
					local theText = UIUtilities:Create("TextLabel", {
						Name = "theText",
						Parent = realThing,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.new(1, 0, 1, 0),
						Text = v,
						BackgroundTransparency = 1,
						TextColor3 = UIStyle.UIcolors.FullWhite,
						Font = UIStyle.TextFont.Font,
						LineHeight = 1.1,	
						ZIndex = 34,
						Position = UDim2.new(0.5, 0, 0.5, 0),
						TextSize = UIStyle.TextFont.TxtSize,
						TextStrokeColor3 = Color3.new(),
						TextStrokeTransparency = 0.5,
					})

					toggleablethingos[1 + #toggleablethingos] = {
						backThing,
						realThing,
						theText
					}

					realThing.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							for i2, v2 in next, toggleablethingos do
								v2[2].BackgroundColor3 = UIStyle.UIcolors.ColorA
							end
							realThing.BackgroundColor3 = UIStyle.UIcolors.ColorG
						end
					end)
				end

				for i2, v2 in next, toggleablethingos do
					v2[2].BackgroundColor3 = UIStyle.UIcolors.ColorA
				end
				toggleablethingos[1][2].BackgroundColor3 = UIStyle.UIcolors.ColorG

				toggleablethingos[1][2].InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Frame.Visible = true
						otherFrame.Visible = false
					end
				end)

				toggleablethingos[2][2].InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Frame.Visible = false
						otherFrame.Visible = true
					end
				end)

				local TabsOrganiser = UIUtilities:Create("UIListLayout", {
					Parent = TabHolder,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Top
				})

				local FrameBackGroundGradient = UIUtilities:Create("UIGradient",{
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
						ColorSequenceKeypoint.new(0.06, UIStyle.UIcolors.ColorA),
						ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
					}),
					Rotation = 90,
					Parent = Frame
				})
				local Colorpick = UIUtilities:Create("ImageButton", {
					Name = "Colorpick",
					Parent = Frame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = UIStyle.UIcolors.ColorA,
					ClipsDescendants = false,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 8, 0, 10 + inDented),
					Size = UDim2.new(0, 156, 0, 156),
					AutoButtonColor = false,
					Image = "rbxassetid://4155801252",
					ImageColor3 = Color3.fromRGB(255, 0, 0),
					ZIndex = 33
				})
				AutoApplyBorder(Colorpick, "Picker", 33, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
				local ColorDrag = UIUtilities:Create("Frame", {
					Name = "ColorDrag",
					Parent = Colorpick,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = Color3.fromRGB(27, 27, 27),
					Size = UDim2.new(0, 4, 0, 4),
					ZIndex = 33
				})

				local Huepick = UIUtilities:Create("ImageButton", {
					Name = "Huepick",
					Parent = Frame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = UIStyle.UIcolors.ColorA,
					ClipsDescendants = false,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 172, 0, 10 + inDented),
					Size = UDim2.new(0, 14, 0, 156),
					AutoButtonColor = false,
					Image = "rbxassetid://3641079629",
					ImageColor3 = Color3.fromRGB(255, 0, 0),
					ImageTransparency = 1,
					BackgroundTransparency = 0,
					ZIndex = 33
				})
				AutoApplyBorder(Huepick, "Picker", 33, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
				local Huedrag = UIUtilities:Create("Frame", {
					Name = "Huedrag",
					Parent = Huepick,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = UIStyle.UIcolors.ColorA,
					Size = UDim2.new(1, 0, 0, 2),
					ZIndex = 33
				})

				local HueFrameGradient = UIUtilities:Create("UIGradient", {
					Rotation = 90,
					Name = "HueFrameGradient",
					Parent = Huepick,
					Color = ColorSequence.new {
						ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
						ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 0, 255)),
						ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 0, 255)),
						ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
						ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 255, 0)),
						ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 255, 0)),
						ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
					},	
				})

				local Transpick, Transcolor, Transdrag

				if TransparencySlider then
					Transpick = UIUtilities:Create("ImageButton", {
						Name = "Transpick",
						Parent = Frame,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BorderColor3 = UIStyle.UIcolors.ColorA,
						Position = UDim2.new(0, 8, 0, 172 + inDented),
						Size = UDim2.new(0, 156, 0, 12),
						AutoButtonColor = false,
						Image = "rbxassetid://3887014957",
						ScaleType = Enum.ScaleType.Tile,
						TileSize = UDim2.new(0, 10, 0, 10),
						ZIndex = 33
					})
					AutoApplyBorder(Transpick, "Picker", 33, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
					Transcolor = UIUtilities:Create("ImageLabel", {
						Name = "Transcolor",
						Parent = Transpick,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 1, 0),
						Image = "rbxassetid://3887017050",
						ImageColor3 = ColorP.BackgroundColor3,
						ZIndex = 33,
					})
					Transdrag = UIUtilities:Create("Frame", {
						Name = "Transdrag",
						Parent = Transcolor,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BorderColor3 = UIStyle.UIcolors.ColorA,
						Position = UDim2.new(0, -1, 0, 0),
						Size = UDim2.new(0, 2, 1, 0),
						ZIndex = 33
					})
				end

				local OldColorText = UIUtilities:Create("TextLabel", {
					Name = "OldColorText",
					Parent = Frame,
					Size = UDim2.new(0, 16, 0, 14),
					Text = "Old Color",
					BackgroundTransparency = 1,
					TextColor3 = UIStyle.UIcolors.FullWhite,
					Font = UIStyle.TextFont.Font,
					LineHeight = 1.1,
					ZIndex = 34,
					Position = UDim2.new(0, 212, 0, 78 + inDented),
					TextSize = UIStyle.TextFont.TxtSize,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
				})
				local OldColor = UIUtilities:Create("Frame", {
					Name = "OldColor",
					Parent = Frame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = UIStyle.UIcolors.ColorC,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 196, 0, 94 + inDented),
					Size = UDim2.new(0, 92, 0, 48),
					ZIndex = 35,
				})
				local OldAlpha = UIUtilities:Create("ImageButton", {
					Name = "OldAlpha",
					Parent = Frame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = UIStyle.UIcolors.ColorC,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 196, 0, 94 + inDented),
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 92, 0, 48),
					ScaleType = "Tile",
					ZIndex = 34,
					Image = "rbxassetid://3887014957"
				})

				AutoApplyBorder(OldAlpha, "OldAlpha", 34, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)

				local NewColorText = UIUtilities:Create("TextLabel", {
					Name = "NewColorText",
					Parent = Frame,
					Size = UDim2.new(0, 16, 0, 14),
					Text = "New Color",
					BackgroundTransparency = 1,
					TextColor3 = UIStyle.UIcolors.FullWhite,
					Font = UIStyle.TextFont.Font,
					LineHeight = 1.1,
					ZIndex = 34,
					Position = UDim2.new(0, 212, 0, 6 + inDented),
					TextSize = UIStyle.TextFont.TxtSize,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
				})
				local NewColor = UIUtilities:Create("Frame", {
					Name = "NewColor",
					Parent = Frame,
					BackgroundColor3 = Parameters.StartColor,
					BackgroundTransparency = Parameters.StartTrans,
					BorderColor3 = UIStyle.UIcolors.ColorC,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 196, 0, 22 + inDented),
					Size = UDim2.new(0, 92, 0, 48),
					ZIndex = 35,
				})
				local NewAlpha = UIUtilities:Create("ImageButton", {
					Name = "NewAlpha",
					Parent = Frame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderColor3 = UIStyle.UIcolors.ColorC,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 196, 0, 22 + inDented),
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 92, 0, 48),
					ScaleType = "Tile",
					ZIndex = 34,
					Image = "rbxassetid://3887014957"
				})
				AutoApplyBorder(NewAlpha, "NewAlpha", 34, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
				local YOffset = -24
				if Parameters.StartTrans then
					YOffset = -22
				end
				local ApplyButton = UIUtilities:Create("TextButton", {
					Name = "Apply",
					AutoButtonColor = false,
					Parent = Frame,
					Size = UDim2.new(0, 52, 0, 16),
					Text = "[ Apply ]",
					BackgroundTransparency = 1,
					TextColor3 = UIStyle.UIcolors.FullWhite,
					Font = UIStyle.TextFont.Font,
					LineHeight = 1.1,
					ZIndex = 34,
					Position = UDim2.new(0, 196, 0, YBounds + YOffset + inDented),
					TextSize = UIStyle.TextFont.TxtSize,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
				})

				local CopyNewColor = UIUtilities:Create("TextButton", {
					Name = "CopyNewColor",
					Parent = NewColor,
					AutoButtonColor = false,
					Size = UDim2.new(1, 0, 0.5, 0),
					Text = "Copy",
					BackgroundTransparency = 1,
					TextColor3 = UIStyle.UIcolors.FullWhite,
					Font = UIStyle.TextFont.Font,
					Visible = false,
					LineHeight = 1.1,
					ZIndex = 35,
					Position = UDim2.new(0, 0, 0, 0),
					TextSize = UIStyle.TextFont.TxtSize,
					TextStrokeColor3 = Color3.new(),
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextStrokeTransparency = 0.5,
				})

				local PasteNewColor = UIUtilities:Create("TextButton", {
					Name = "PasteNewColor",
					Parent = NewColor,
					AnchorPoint = Vector2.new(0, 1),
					AutoButtonColor = false,
					Size = UDim2.new(1, 0, 0.5, 0),
					Text = "Paste",
					BackgroundTransparency = 1,
					Visible = false,
					TextColor3 = UIStyle.UIcolors.FullWhite,
					Font = UIStyle.TextFont.Font,
					LineHeight = 1.1,
					ZIndex = 35,
					Position = UDim2.new(0, 0, 1, 0),
					TextSize = UIStyle.TextFont.TxtSize,
					TextStrokeColor3 = Color3.new(),
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextStrokeTransparency = 0.5,
				})

				local CopyOldColor = UIUtilities:Create("TextButton", {
					Name = "PasteOldColor",
					Parent = OldColor,
					Size = UDim2.new(1, 0, 1, 0),
					AutoButtonColor = false,
					Text = "Copy",
					BackgroundTransparency = 1,
					TextColor3 = UIStyle.UIcolors.FullWhite,
					Visible = false,
					Font = UIStyle.TextFont.Font,
					LineHeight = 1.1,
					ZIndex = 35,
					Position = UDim2.new(0, 0, 0, 0),
					TextSize = UIStyle.TextFont.TxtSize,
					TextStrokeColor3 = Color3.new(),
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextStrokeTransparency = 0.5,
				})

				local abc = false
				local inCP = false
				ColorP.MouseEnter:Connect(function()
					abc = true
				end)
				ColorP.MouseLeave:Connect(function()
					abc = false
				end)
				MasterFrame.MouseEnter:Connect(function()
					inCP = true
				end)
				MasterFrame.MouseLeave:Connect(function()
					inCP = false
				end)

				NewColor.MouseEnter:Connect(function()
					CopyNewColor.Visible = true
					PasteNewColor.Visible = true
				end)

				NewColor.MouseLeave:Connect(function()
					CopyNewColor.Visible = false
					PasteNewColor.Visible = false
				end)

				OldColor.MouseEnter:Connect(function()
					CopyOldColor.Visible = true
				end)

				OldColor.MouseLeave:Connect(function()
					CopyOldColor.Visible = false
				end)

				local function UpdatePickers(Color)
					ColorH, ColorS, ColorV = RGBtoHSV(Color)

					ColorH = math.clamp(ColorH, 0, 1)
					ColorS = math.clamp(ColorS, 0, 1)
					ColorV = math.clamp(ColorV, 0, 1)

					ColorDrag.Position = UDim2.new(1 - ColorS, 0, 1 - ColorV, 0)
					Colorpick.ImageColor3 = Color3.fromHSV(ColorH, 1, 1)
					Huedrag.Position = UDim2.new(0, 0, 1-ColorH, -1)
					if Transcolor then
						Transcolor.ImageColor3 = Color
					end
				end

				UpdatePickers(ColorP.BackgroundColor3)

				ColorP.MouseButton1Down:Connect(function()
					if isColorThingOpen and isColorThingOpen ~= MasterFrame then
						return
					end
					MasterFrame.Visible = not MasterFrame.Visible
					if MasterFrame.Visible == false then
						isColorThingOpen = nil
					else
						isColorThingOpen = MasterFrame
					end
					UpdatePickers(ColorP.BackgroundColor3)
					if MasterFrame.Visible then
						OldColor.BackgroundTransparency = ColorP.BackgroundTransparency
						OldColor.BackgroundColor3 = ColorP.BackgroundColor3
					end
				end)

				PasteNewColor.MouseButton1Down:Connect(function()
					if ClipboardColor then
						NewColor.BackgroundColor3 = ClipboardColor
						UpdatePickers(NewColor.BackgroundColor3)
					end
				end)

				CopyOldColor.MouseButton1Down:Connect(function()
					ClipboardColor = OldColor.BackgroundColor3
				end)

				CopyNewColor.MouseButton1Down:Connect(function()
					ClipboardColor = NewColor.BackgroundColor3
				end)

				local function updateColor()
					local ColorX = (math.clamp(Mouse.X - Colorpick.AbsolutePosition.X, 0, Colorpick.AbsoluteSize.X)/Colorpick.AbsoluteSize.X)
					local ColorY = (math.clamp(Mouse.Y - Colorpick.AbsolutePosition.Y, 0, Colorpick.AbsoluteSize.Y)/Colorpick.AbsoluteSize.Y)
					ColorDrag.Position = UDim2.new(ColorX, 0, ColorY, 0)
					ColorS = 1-ColorX
					ColorV = 1-ColorY
					Colorpick.ImageColor3 = Color3.fromHSV(ColorH, 1, 1)
					NewColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
					if Transcolor then
						Transcolor.ImageColor3 = NewColor.BackgroundColor3
					end
				end

				local function updateHue()
					local y = math.clamp(Mouse.Y - Huepick.AbsolutePosition.Y, 0, Huepick.AbsoluteSize.Y)
					Huedrag.Position = UDim2.new(0, 0, 0, y)
					hue = y/Huepick.AbsoluteSize.Y
					ColorH = 1-hue
					Colorpick.ImageColor3 = Color3.fromHSV(ColorH, 1, 1)
					NewColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
					if Transcolor then
						Transcolor.ImageColor3 = NewColor.BackgroundColor3
					end
				end
				local function updateTrans()
					if Transcolor then
						local x = math.clamp(Mouse.X - Transpick.AbsolutePosition.X, 0, Transpick.AbsoluteSize.X)
						NewColor.BackgroundTransparency = x/Transpick.AbsoluteSize.X
						Transdrag.Position = UDim2.new(0, x, 0, 0)
						Transcolor.ImageColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
					end
				end
				if Transcolor then
					Transpick.MouseButton1Down:Connect(function()
						updateTrans()
						moveconnection = Mouse.Move:Connect(function()
							updateTrans()
						end)
						releaseconnection = UserInputService.InputEnded:Connect(function(mouse)
							if mouse.UserInputType == Enum.UserInputType.MouseButton1 then
								updateTrans()
								moveconnection:Disconnect()
								releaseconnection:Disconnect()
							end
						end)
					end)
				end
				Colorpick.MouseButton1Down:Connect(function()
					updateColor()
					moveconnection = Mouse.Move:Connect(function()
						updateColor()
					end)
					releaseconnection = UserInputService.InputEnded:Connect(function(mouse)
						if mouse.UserInputType == Enum.UserInputType.MouseButton1 then
							updateColor()
							moveconnection:Disconnect()
							releaseconnection:Disconnect()
						end
					end) 
				end)

				ApplyButton.MouseButton1Down:Connect(function()
					ColorP.BackgroundColor3 = NewColor.BackgroundColor3
					ColorP.BackgroundTransparency = NewColor.BackgroundTransparency
					MasterFrame.Visible = false
					isColorThingOpen = nil
				end)

				Huepick.MouseButton1Down:Connect(function()
					updateHue()
					moveconnection = Mouse.Move:Connect(function()
						updateHue()
					end)
					releaseconnection = game:GetService("UserInputService").InputEnded:Connect(function(mouse)
						if mouse.UserInputType == Enum.UserInputType.MouseButton1 then
							updateHue()
							moveconnection:Disconnect()
							releaseconnection:Disconnect()
						end
					end)
				end)
				ColorP.BorderColor3 = Color3.fromRGB(math.clamp((ColorP.BackgroundColor3.R * 255) - 40, 40, 255), math.clamp((ColorP.BackgroundColor3.G * 255) - 40, 40, 255), math.clamp((ColorP.BackgroundColor3.B * 255) - 40, 40, 255))
				ColorP:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
					local Hue, Sat, Val = RGBtoHSV(ColorP.BackgroundColor3)
					Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"] = ColorP.BackgroundColor3
					Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance].Changed:Fire(ColorP.BackgroundColor3, ColorP.BackgroundTransparency)
					local Color = ColorP.BackgroundColor3
					ColorP.BorderColor3 = Color3.fromRGB(math.clamp((Color.R * 255) - 40, 40, 255), math.clamp((Color.G * 255) - 40, 40, 255), math.clamp((Color.B * 255) - 40, 40, 255))
				end)
				if Parameters.StartTrans then
					ColorP:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
						if fading == false then
							Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] = ColorP.BackgroundTransparency
							Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance].Changed:Fire(ColorP.BackgroundColor3, ColorP.BackgroundTransparency)
							actualtrans.Value = ColorP.BackgroundTransparency
						end
					end)
				end
				table.insert(OpenCloseItems, Alpha)
				table.insert(OpenCloseItems, ColorP)

				Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Animations"] = fakeFlagsShit
				Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Animation Selection"] = dropKickFlag

				Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance] = setmetatable({}, {
					__index = function(self, i)
						return ColorProxy[i]
					end,
					__newindex = function(self, i, v)
						if i == "Color" then
							if type(v) == "table" then
								v = Color3.new(v.r, v.g, v.b)
							end
							ColorP.BackgroundColor3 = v
						elseif i == "Transparency" then
							ColorP.BackgroundTransparency = v
						elseif i == "Animations" then
							for anim, data in next, v do
								for name, values in next, data do
									if v[anim][name]["Value"] then
										fakeFlagsShit[anim][name]["Value"] = v["Value"]
									elseif v[anim][name]["Color"] then
										fakeFlagsShit[anim][name]["Color"] = Color3.new(v[anim][name]["Color"].r, v[anim][name]["Color"].g, v[anim][name]["Color"].b)
										if v[anim][name]["Transparency"] then
											fakeFlagsShit[anim][name]["Transparency"] = v[anim][name]["Transparency"]
										end
									end
								end
							end
						end
						ColorProxy[i] = v
					end
				})

				local animationLoop
				reUpdate = function(anim)
					if animationLoop then
						animationLoop:Disconnect()
					end
					if anim == "Rainbow" then
						animationLoop = RunService.Stepped:Connect(function()
							local oldhue, oldsat, oldval = Color3.toHSV(Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"])
							Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"] = (Color3.fromHSV((tick() * (fakeFlagsShit["Rainbow"]["Speed"]["Value"] / 100) - math.floor(tick() * (fakeFlagsShit["Rainbow"]["Speed"]["Value"] / 100))), oldsat, oldval))
						end)
					elseif anim == "Linear" then
						animationLoop = RunService.Stepped:Connect(function()
							local percentage = (tick() * (fakeFlagsShit["Linear"]["Speed"]["Value"] / 100) - math.floor(tick() * (fakeFlagsShit["Linear"]["Speed"]["Value"] / 100)))
							if percentage > 0.5 then
								percentage = percentage - 0.5
								percentage = percentage * 2
								Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"] = fakeFlagsShit["Linear"]["Keyframe 2"]["Color"]:Lerp(fakeFlagsShit["Linear"]["Keyframe 1"]["Color"], percentage)
								if Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] then
									local a = fakeFlagsShit["Linear"]["Keyframe 2"]["Transparency"]
									local b = fakeFlagsShit["Linear"]["Keyframe 1"]["Transparency"]
									local c = percentage
									Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] = (a + (b - a)*c)
								end
							else
								percentage = percentage * 2
								Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"] = (fakeFlagsShit["Linear"]["Keyframe 1"]["Color"]:Lerp(fakeFlagsShit["Linear"]["Keyframe 2"]["Color"], percentage))
								if Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] then
									local a = fakeFlagsShit["Linear"]["Keyframe 1"]["Transparency"]
									local b = fakeFlagsShit["Linear"]["Keyframe 2"]["Transparency"]
									local c = percentage
									Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] = (a + (b - a)*c)
								end
							end
						end)
					elseif anim == "Oscillating" then
						animationLoop = RunService.Stepped:Connect(function()
							local percentage = (tick() * (fakeFlagsShit["Oscillating"]["Speed"]["Value"] / 100) - math.floor(tick() * (fakeFlagsShit["Oscillating"]["Speed"]["Value"] / 100)))
							if percentage > 0.5 then
								percentage = percentage - 0.5
								Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"] = (fakeFlagsShit["Oscillating"]["Keyframe 2"]["Color"]:Lerp(fakeFlagsShit["Oscillating"]["Keyframe 1"]["Color"], math.sin(percentage * math.pi)))
								if Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] then
									local a = fakeFlagsShit["Oscillating"]["Keyframe 2"]["Transparency"]
									local b = fakeFlagsShit["Oscillating"]["Keyframe 1"]["Transparency"]
									local c = math.sin(percentage * math.pi)
									Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] = (a + (b - a)*c)
								end
							else
								Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"] = (fakeFlagsShit["Oscillating"]["Keyframe 1"]["Color"]:Lerp(fakeFlagsShit["Oscillating"]["Keyframe 2"]["Color"], math.sin(percentage * math.pi)))
								if Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] then
									local a = fakeFlagsShit["Oscillating"]["Keyframe 1"]["Transparency"]
									local b = fakeFlagsShit["Oscillating"]["Keyframe 2"]["Transparency"]
									local c = math.sin(percentage * math.pi)

									Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] = (a + (b - a)*c)
								end
							end
						end)
					elseif anim == "Strobe" then
						animationLoop = RunService.Stepped:Connect(function()
							local percentage = (tick() * (fakeFlagsShit["Strobe"]["Speed"]["Value"] / 100) - math.floor(tick() * (fakeFlagsShit["Strobe"]["Speed"]["Value"] / 100)))
							if percentage > 0.5 then
								Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"] = fakeFlagsShit["Strobe"]["Keyframe 2"]["Color"]
								if Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] then
									Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] = (fakeFlagsShit["Strobe"]["Keyframe 2"]["Transparency"])
								end
							else
								Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"] = fakeFlagsShit["Strobe"]["Keyframe 1"]["Color"]
								if Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] then
									Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] = (fakeFlagsShit["Strobe"]["Keyframe 1"]["Transparency"])
								end
							end
						end)
					elseif anim == "Sawtooth" then
						animationLoop = RunService.Stepped:Connect(function()
							local percentage = (tick() * (fakeFlagsShit["Sawtooth"]["Speed"]["Value"] / 100) - math.floor(tick() * (fakeFlagsShit["Sawtooth"]["Speed"]["Value"] / 100)))
							Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Color"] = (fakeFlagsShit["Sawtooth"]["Keyframe 1"]["Color"]:Lerp(fakeFlagsShit["Sawtooth"]["Keyframe 2"]["Color"], percentage))
							if Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] then
								local a = fakeFlagsShit["Sawtooth"]["Keyframe 1"]["Transparency"]
								local b = fakeFlagsShit["Sawtooth"]["Keyframe 2"]["Transparency"]
								local c = percentage
								Menu[Parameters.Tab][Parameters.Section][Parameters.ObjectName]["Color " .. Parameters.Stance]["Transparency"] = (a + (b - a)*c)
							end
						end)
					end
				end
			end

			local function CreateKeyBindThing(Parented, Default, Tab, Section, ObjectName)
				local Options = {"Hold", "Toggle", "Hold Off", "Always"}
				Menu[Tab][Section][ObjectName]["Bind"] = {}
				Menu[Tab][Section][ObjectName]["Bind"]["Activation Type"] = Options[1]
				Menu[Tab][Section][ObjectName]["Bind"]["Key"] = Default
				Menu[Tab][Section][ObjectName]["Bind"]["Active"] = false
				Menu[Tab][Section][ObjectName]["Bind"].Changed = Signal.new()
				local BindsProxy = Menu[Tab][Section][ObjectName]["Bind"]

				UILibrary:AddKeyBindList(Section .. ": " .. ObjectName)
				local corresponding = KeyBindList[Section .. ": " .. ObjectName] 
				corresponding.Text = ObjectName .. ": Disabled"
				local Bind = UIUtilities:Create("TextButton", {
					AnchorPoint = Vector2.new(0, 0.5),
					Name = "Bind",	
					BackgroundColor3 = UIStyle.UIcolors.ColorE,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(1, -44, 0.5, 0),
					Parent = Parented,
					Size = UDim2.new(0, 36, 1, 4),
					ZIndex = 26,
					Text = Default,
					TextColor3 = UIStyle.UIcolors.FullWhite,
					Font = UIStyle.TextFont.Font,
					LineHeight = 1.1,
					TextSize = UIStyle.TextFont.TxtSize,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center
				})
				local FakeBind = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					Name = "Fake",	
					BackgroundColor3 = UIStyle.UIcolors.ColorE,
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Parent = Bind,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 25,
				})
				table.insert(OpenCloseItems, FakeBind)
				local Val = UIUtilities:Create("StringValue", {
					Name = "RealKey",
					Parent = Bind,
					Value = "None"
				})
				local a, b, c = AutoApplyBorder(Bind, "Bind", 24, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH, true)
				local ActivationMethod = UIUtilities:Create("StringValue", {
					Name = "BindType",
					Parent = Bind,
					Value = "Always"
				})
				local Dropdown = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0, 0),
					Parent = Bind,
					Name = "Type",
					BackgroundColor3 = UIStyle.UIcolors.ColorI,
					Visible = false,
					ZIndex = 31,
					Size = UDim2.new(0, 68, 0, 6 + TextService:GetTextSize(Options[1], UIStyle.TextFont.TxtSize, UIStyle.TextFont.Font, Vector2.new(900, 900)).Y * 4),
					Position = UDim2.new(0, 0, 1, 4),
					BorderSizePixel = 0,
				})
				AutoApplyBorder(Dropdown, "Options Outline", 31, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
				local inDropDown = false
				Dropdown.MouseEnter:Connect(function()
					inDropDown = true
				end)
				Dropdown.MouseLeave:Connect(function()
					inDropDown = false
				end)
				local Connection
				local UpdateConnection
				Bind.MouseButton2Click:Connect(function()
					for i, v in next, (Dropdown:GetChildren()) do
						if v:IsA("TextButton") then
							if v.Text == Menu[Tab][Section][ObjectName]["Bind"]["Activation Type"] then
								v.TextColor3 = UIStyle.UIcolors.Accent
							else
								v.TextColor3 = UIStyle.UIcolors.FullWhite
							end
						end
					end
					Dropdown.Visible = true
					for i, v in next, (Dropdown:GetChildren()) do
						if v:IsA("TextButton") then
							if v.Text == Menu[Tab][Section][ObjectName]["Bind"]["Activation Type"] then
								v.TextColor3 = UIStyle.UIcolors.Accent
							else
								v.TextColor3 = UIStyle.UIcolors.FullWhite
							end
						end
					end
					Connection = UserInputService.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
							if not inDropDown then
								Dropdown.Visible = false
								Connection:Disconnect()
							end
						end
					end)
				end)
				for i, v in next, (Options) do
					local Button = UIUtilities:Create("TextButton", {
						Name = v,	
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 2, 0, (i - 1) * (TextService:GetTextSize(Options[1], UIStyle.TextFont.TxtSize, UIStyle.TextFont.Font, Vector2.new(900, 900)).Y + 2)),
						Parent = Dropdown,
						Size = UDim2.new(1, 0, 0, 18),
						ZIndex = 31,
						Text = v,
						TextColor3 = UIStyle.UIcolors.FullWhite,
						Font = UIStyle.TextFont.Font,
						LineHeight = 1,
						TextSize = UIStyle.TextFont.TxtSize,
						TextStrokeColor3 = Color3.new(),
						TextStrokeTransparency = 0,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Center
					})
					Button.MouseButton1Down:Connect(function()
						Menu[Tab][Section][ObjectName]["Bind"]["Activation Type"] = Button.Text
						ActivationMethod.Value = Menu[Tab][Section][ObjectName]["Bind"]["Activation Type"]
						Dropdown.Visible = false
					end)
				end		
				table.insert(OpenCloseItems, Bind)

				local thing = ObjectName
				if thing == "Enabled" then
					thing = Section
				end
				corresponding.Text = thing .. " - Disabled"
				local function Updater()
					if Connection then
						Connection:Disconnect()
					end
					if AuxUpdateConnection then
						AuxUpdateConnection:Disconnect()
					end
					if UpdateConnection then
						UpdateConnection:Disconnect()
					end
					if Menu[Tab][Section][ObjectName]["Bind"]["Activation Type"] ~= Options[2] then
						UpdateConnection = RunService.Heartbeat:Connect(function()
							if Menu[Tab][Section][ObjectName]["Toggle"]["Enabled"] then
								if Menu[Tab][Section][ObjectName]["Bind"]["Activation Type"] == Options[4] then	
									Menu[Tab][Section][ObjectName]["Bind"]["Active"] = true
									Menu[Tab][Section][ObjectName]["Bind"].Changed:Fire(true)
									corresponding.Text = Section .. " - " .. ObjectName
								end
								if Menu[Tab][Section][ObjectName]["Bind"]["Activation Type"] == Options[1] then
									if Bind.Text ~= "None" and UserInputService:IsKeyDown(tostring(Menu[Tab][Section][ObjectName]["Bind"]["Key"]):sub(14)) then
										Menu[Tab][Section][ObjectName]["Bind"]["Active"] = true
										Menu[Tab][Section][ObjectName]["Bind"].Changed:Fire(true)
										corresponding.Text = Section .. " - " .. ObjectName
									else
										Menu[Tab][Section][ObjectName]["Bind"]["Active"] = false
										Menu[Tab][Section][ObjectName]["Bind"].Changed:Fire(false)
										corresponding.Text = thing .. " - Disabled"
									end
								end
								if Menu[Tab][Section][ObjectName]["Bind"]["Activation Type"] == Options[3] then
									if Bind.Text ~= "None" and UserInputService:IsKeyDown(tostring(Menu[Tab][Section][ObjectName]["Bind"]["Key"]):sub(14)) then
										corresponding.Text = thing .. " - Disabled"
										Menu[Tab][Section][ObjectName]["Bind"]["Active"] = false
										Menu[Tab][Section][ObjectName]["Bind"].Changed:Fire(false)
									else
										Menu[Tab][Section][ObjectName]["Bind"]["Active"] = true
										Menu[Tab][Section][ObjectName]["Bind"].Changed:Fire(true)
										corresponding.Text = Section .. " - " .. ObjectName
									end
								end
							else
								corresponding.Text = thing .. " - Disabled"
							end
						end)
					else
						UpdateConnection = UserInputService.InputBegan:Connect(function(Input, gameProcessed)
							if Menu[Tab][Section][ObjectName]["Bind"]["Key"] == "None" then return end
							if Input.UserInputType == Enum.UserInputType.Keyboard then
								local keyPressed = Input.KeyCode
								if Bind.Text ~= "None" and tostring(keyPressed) == tostring(Menu[Tab][Section][ObjectName]["Bind"]["Key"]) then
									if Parameters.Callback ~= nil then
										Parameters.Callback(Menu[Tab][Section][ObjectName]["Toggle"]["Enabled"], Menu[Tab][Section][ObjectName]["Bind"]["Active"])
									end
									Menu[Tab][Section][ObjectName]["Bind"]["Active"] = not Menu[Tab][Section][ObjectName]["Bind"]["Active"]
									Menu[Tab][Section][ObjectName]["Bind"].Changed:Fire(Menu[Tab][Section][ObjectName]["Bind"]["Active"])
									if Menu[Tab][Section][ObjectName]["Bind"]["Active"] then
										corresponding.Text = Section .. " - " .. ObjectName
									else
										corresponding.Text =  thing .. " - Disabled"
									end
								end
							end
						end)
					end
				end

				Updater()
				ActivationMethod.Changed:Connect(function()
					Menu[Tab][Section][ObjectName]["Bind"]["Activation Type"] = ActivationMethod.Value
					Updater()
				end)

				local recording = false

				UserInputService.InputBegan:Connect(function(Input, gameProcessed)
					if recording == true and Input.UserInputType == Enum.UserInputType.Keyboard then
						if Input.KeyCode.Value == 27 then 
							Val.Value = "None"
							Menu[Tab][Section][ObjectName]["Bind"]["Key"] = "None"
							Bind.Text = "None"
						else
							local key = tostring(Input.KeyCode)
							Val.Value = key:sub(14)
							Menu[Tab][Section][ObjectName]["Bind"]["Key"] = Input.KeyCode
							Bind.Text = string.sub(string.upper(Val.Value), 1, 4)
						end
						recording = false
						b.BackgroundColor3 = UIStyle.UIcolors.ColorG
					end
				end)

				Val.Changed:Connect(function()
					if not recording then
						local key = Val.Value
						if key == "" or key == "None" then
							Menu[Tab][Section][ObjectName]["Bind"]["Key"] = "None"
							Bind.Text = "None"
						else
							Menu[Tab][Section][ObjectName]["Bind"]["Key"] = Enum.KeyCode[key]
							Bind.Text = string.upper(string.sub(key, 1, 4))
						end
					end
				end)
				local function onButtonActivated()
					b.BackgroundColor3 = UIStyle.UIcolors.Accent
					Bind.Text = "None"
					recording = true
				end
				Bind.MouseButton1Down:Connect(onButtonActivated)

				Menu[Tab][Section][ObjectName]["Bind"] = setmetatable({}, {
					__index = function(self, i)
						return BindsProxy[i]
					end,
					__newindex = function(self, i, v)
						if i == "Key" and not recording then
							Val.Value = tostring(v):sub(14)
						elseif i == "Activation Type" then
							ActivationMethod.Value = v
						end
						BindsProxy[i] = v
					end
				})
				Menu[Tab][Section][ObjectName]["Bind"]["Activation Type"] = "Always"
			end

			local MessageLogs = UIUtilities:Create("Frame", {
				AnchorPoint = Vector2.new(0, 0),
				BackgroundTransparency = 1,
				Parent = Core,
				Position = UDim2.new(0, 12, 0, -2),
				Size = UDim2.new(0, 317, 0, 532)
			})

			local MessageLogsListOrganizer = UIUtilities:Create("UIListLayout", {
				Parent = MessageLogs,
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Top
			})

			UILibrary.Watermark = UIUtilities:Create("Frame", {
				AnchorPoint = Vector2.new(0, 1),
				BackgroundColor3 = UIStyle.UIcolors.FullWhite,
				BackgroundTransparency = 0,
				BorderColor3 = UIStyle.UIcolors.FullWhite,
				Visible = false,
				BorderMode = Enum.BorderMode.Outline,
				BorderSizePixel = 0,
				Name = "Watermark",
				Parent = Core, 
				Position = UDim2.new(0, 12, 0, -10),
				Size = UDim2.new(0, 428, 0, 24),
				ZIndex = 1
			})

			local WatermarkStyling = UIUtilities:Create("UIGradient", {
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
					ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
				}),
				Rotation = 90,
				Parent = UILibrary.Watermark
			})
			local WatermarkAccent = UIUtilities:Create("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = UIStyle.UIcolors.FullWhite,
				BorderSizePixel = 0,
				Name = "UI",
				Parent = UILibrary.Watermark,
				Position = UDim2.new(0.5, 0, 0, 1),
				Size = UDim2.new(0, 0, 0, 2),
				ZIndex = 2
			})

			local WatermarkAccentStyling = UIUtilities:Create("UIGradient", {
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new(UIStyle.UIcolors.Accent.R - (15/255), UIStyle.UIcolors.Accent.G - (15/255), UIStyle.UIcolors.Accent.B - (15/255))),
					ColorSequenceKeypoint.new(1, Color3.new(UIStyle.UIcolors.Accent.R, UIStyle.UIcolors.Accent.G, UIStyle.UIcolors.Accent.B))
				}),
				Rotation = 0,
				Parent = WatermarkAccent
			})

			table.insert(UIAccents, WatermarkAccentStyling)

			local WatermarkText = UIUtilities:Create("TextLabel", {
				AnchorPoint = Vector2.new(0, 0),
				BackgroundTransparency = 1, 
				Position = UDim2.new(0, 0, 0, 0),
				Parent = UILibrary.Watermark,
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 2,
				Font = UIStyle.HeaderFont.Font,
				LineHeight = 1,
				Text = "",
				TextColor3 = UIStyle.UIcolors.FullWhite,
				TextSize = UIStyle.HeaderFont.WatermarkTxtSize,
				TextStrokeColor3 = Color3.new(),
				TextStrokeTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
			})

			UILibrary.Watermark.MouseEnter:Connect(function()
				UIUtilities:Tween(UILibrary.Watermark, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false })
				UIUtilities:Tween(WatermarkAccent, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false })
				UIUtilities:Tween(WatermarkText, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { TextTransparency = 1, Active = false })
			end)

			UILibrary.Watermark.MouseLeave:Connect(function()
				UIUtilities:Tween(UILibrary.Watermark, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true })
				UIUtilities:Tween(WatermarkAccent, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true })
				UIUtilities:Tween(WatermarkText, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { TextTransparency = 0, Active = true })
			end)

			local months = {"Jan.","Feb.","Mar.","Apr.","May","Jun.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec."}
			local daysinmonth = {31,28,31,30,31,30,31,31,30,31,30,31}

			local function getDate()
				local time = os.time()
				local year = math.floor(time/60/60/24/365.25+1970)
				local day = math.ceil(time/60/60/24%365.25)
				local month
				for i=1, #daysinmonth do
					if day > daysinmonth[i] then
						day = day - daysinmonth[i]
					else
						month = i
						break
					end
				end
				return month, day, year
			end

			function UILibrary:EventLog(Message, Time) -- laziness below
				--thread(function()
					local MoveTime = 1
					local FadeTime = 0.25
					local TweenStyling = Enum.EasingStyle.Quint
					local TweenDir = Enum.EasingDirection.Out
					
					local maxWidth = 60
					local text = Message
					local msgsize = TextService:GetTextSize(Message, UIStyle.HeaderFont.WatermarkTxtSize, UIStyle.HeaderFont.Font, Vector2.new(9999999999999999999999999999999, 0))
					do -- WARNING !! ALAN CODE AHEAD!!
						local split = text:split("")
						local lastspaceidx = 0 -- the text idx that the last space is
						local charinline = 0
						for i, v in next, (split) do
							charinline = charinline + 1
							if v == " " then
								lastspaceidx = i
							end
							if charinline >= maxWidth then
								split[lastspaceidx] = "\n" -- insert a thing
								charinline = 0
							end
						end
						text = ""
						for i, v in next, (split) do
							text = text .. v
						end
					end
					-- ok most of the gayness is over
					local split = text:split("\n")
					local textlinelength = {}
					local verticalLength = 8
					for i, v in next, (split) do
						local d = TextService:GetTextSize(v, UIStyle.HeaderFont.WatermarkTxtSize, UIStyle.HeaderFont.Font, Vector2.new(9999999999999999999999999999999, 0))
						textlinelength[i] = d.x
						verticalLength = verticalLength + d.y
					end
					table.sort(textlinelength, function(a, b) return a > b end)
					local longestthing = textlinelength[1]
					local FakeBackGround = UIUtilities:Create("Frame", {
						AnchorPoint = Vector2.new(0, 0),
						BackgroundColor3 = UIStyle.UIcolors.FullWhite,
						BackgroundTransparency = 1,
						BorderColor3 = UIStyle.UIcolors.FullWhite,
						BorderMode = Enum.BorderMode.Outline,
						BorderSizePixel = 0,
						Name = "Event",
						Parent = MessageLogs, 
						Position = UDim2.new(0, 0, 0, 0),
						Size = UDim2.new(0, longestthing + 12, 0, verticalLength),
						ZIndex = 1
					})
					local EventLogContainer = UIUtilities:Create("Frame", {
						AnchorPoint = Vector2.new(0, 0),
						BackgroundColor3 = UIStyle.UIcolors.FullWhite,
						BackgroundTransparency = 1,
						BorderColor3 = UIStyle.UIcolors.FullWhite,
						BorderMode = Enum.BorderMode.Outline,
						BorderSizePixel = 0,
						Name = "Event",
						Parent = FakeBackGround,
						Position = UDim2.new(0, -msgsize.X + 32, 0, 0),
						Size = UDim2.new(1, 0, 1, -4),
						ZIndex = 1
					})
					local BackGroundStyling = UIUtilities:Create("UIGradient", {
						Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
							ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
						}),
						Rotation = 90,
						Parent = EventLogContainer
					})
					local BackGroundAccent = UIUtilities:Create("Frame", {
						AnchorPoint = Vector2.new(0, 0),
						BackgroundColor3 = UIStyle.UIcolors.FullWhite,
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						Name = "UI",
						Parent = EventLogContainer,
						Position = UDim2.new(0, 0, 0, 0),
						Size = UDim2.new(0, 2, 1, 0),
						ZIndex = 2
					})
					local Hue, Sat, Val = RGBtoHSV(UIStyle.UIcolors.Accent)
					local BackGroundAccentStyling = UIUtilities:Create("UIGradient", {
						Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromHSV(Hue, Sat, Val - 0.1)),
							ColorSequenceKeypoint.new(1, Color3.new(UIStyle.UIcolors.Accent.R, UIStyle.UIcolors.Accent.G, UIStyle.UIcolors.Accent.B))
						}),
						Rotation = 180,
						Parent = BackGroundAccent
					})
					local BackGroundText = UIUtilities:Create("TextLabel", {
						AnchorPoint = Vector2.new(1, 0),
						BackgroundTransparency = 1, 
						Position = UDim2.new(1, 0, 0, 0),
						Parent = EventLogContainer,
						Size = UDim2.new(1, -6, 1, 0),
						ZIndex = 2,
						Font = UIStyle.HeaderFont.Font,
						LineHeight = 1.1,
						Text = text,
						TextColor3 = UIStyle.UIcolors.FullWhite,
						TextSize = UIStyle.HeaderFont.WatermarkTxtSize,
						TextTransparency = 1,
						TextStrokeColor3 = Color3.new(),
						TextStrokeTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Center
					})
					coroutine.wrap(function()
						UIUtilities:Tween(
							EventLogContainer,
							TweenInfo.new(FadeTime, TweenStyling, TweenDir),
							{BackgroundTransparency = 0}
						)
						UIUtilities:Tween(
							BackGroundAccent,
							TweenInfo.new(FadeTime, TweenStyling, TweenDir),
							{BackgroundTransparency = 0}
						)
						UIUtilities:Tween(
							BackGroundText,
							TweenInfo.new(FadeTime, TweenStyling, TweenDir),
							{TextTransparency = 0}
						)
						EventLogContainer:TweenPosition(
							UDim2.new(0, 0, 0, 0),
							TweenDir,
							TweenStyling,
							MoveTime
						)
						realWait(MoveTime)
						realWait(Time)
						MoveTime = 1
						FadeTime = 0.75
						TweenDir = Enum.EasingDirection.In
						UIUtilities:Tween(
							EventLogContainer,
							TweenInfo.new(FadeTime, TweenStyling, TweenDir),
							{BackgroundTransparency = 1}
						)
						UIUtilities:Tween(
							BackGroundAccent,
							TweenInfo.new(FadeTime, TweenStyling, TweenDir),
							{BackgroundTransparency = 1}
						)
						UIUtilities:Tween(
							BackGroundText,
							TweenInfo.new(FadeTime, TweenStyling, TweenDir),
							{TextTransparency = 1}
						)
						EventLogContainer:TweenPosition(
							UDim2.new(0, -msgsize.X + 48, 0, 0),
							TweenDir,
							TweenStyling,
							MoveTime
						)
						realWait(FadeTime)
						FakeBackGround:Destroy()
					end)()
				--end)
			end

			local SpectatorList = UIUtilities:Create("Frame", {
				AnchorPoint = Vector2.new(1, 0),
				BackgroundTransparency = 1,
				Parent = Core,
				Position = UDim2.new(1, -8, 0.2, 0),
				Size = UDim2.new(0, 317, 0, 532)
			})

			local SpectatorListOrganizer = UIUtilities:Create("UIListLayout", {
				Parent = SpectatorList,
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Top
			})

			UILibrary.KeyBindContainer = UIUtilities:Create("Frame", {
				AnchorPoint = Vector2.new(0, 0),
				BackgroundTransparency = 1,
				Parent = Core,
				Visible = false,
				Position = UDim2.new(0, 8, 0.45, 0),
				Size = UDim2.new(0, 256, 0, 532)
			})
			local KeyBindContainerOrganizer = UIUtilities:Create("UIListLayout", {
				Parent = UILibrary.KeyBindContainer,
				Padding = UDim.new(0, -18),
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Top
			})
			UILibrary.UseListSize = false
			function UILibrary:AddKeyBindList(KeyBindName)
				local KeyBindTitleFakeBackGround = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0, 0),
					Visible = true,
					BackgroundColor3 = UIStyle.UIcolors.FullWhite,
					BackgroundTransparency = 1,
					BorderColor3 = UIStyle.UIcolors.FullWhite,
					BorderMode = Enum.BorderMode.Outline,
					BorderSizePixel = 0,
					Name = KeyBindName,
					Parent = UILibrary.KeyBindContainer, 
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 0, 14),
					ZIndex = 6
				})
				local KeyBindTitleEventLogContainer = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = UIStyle.UIcolors.FullWhite,
					BackgroundTransparency = 0,
					BorderColor3 = UIStyle.UIcolors.FullWhite,
					BorderMode = Enum.BorderMode.Outline,
					BorderSizePixel = 0,
					Name = KeyBindName,
					Parent = KeyBindTitleFakeBackGround, 
					Position = UDim2.new(0, 0, 0, 3),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 7
				})
				local KeyBindTitleBackGroundStyling
				if KeyBindName == "Keybinds" then -- too lazy srry
					local PercentageCover = 10/KeyBindTitleFakeBackGround.AbsoluteSize.Y
					KeyBindTitleBackGroundStyling = UIUtilities:Create("UIGradient", {
						Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
							ColorSequenceKeypoint.new(PercentageCover - PercentageCover/8, UIStyle.UIcolors.ColorA),
							ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
						}),
						Rotation = 90,
						Parent = KeyBindTitleEventLogContainer
					})
				else
					KeyBindTitleBackGroundStyling = UIUtilities:Create("UIGradient", {
						Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorA),
							ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
						}),
						Rotation = 0,
						Parent = KeyBindTitleEventLogContainer
					})
				end
				local v1 = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = UIStyle.UIcolors.ColorC,
					BorderSizePixel = 0,
					Name = "v1",
					Parent = KeyBindTitleEventLogContainer,
					Position = UDim2.new(0.5, 0, 0.5, -1),
					Size = UDim2.new(1, 2, 1, 3),
					ZIndex = 5
				})
				local v2 = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = UIStyle.UIcolors.ColorB,
					BorderSizePixel = 0,
					Name = "v2",
					Parent = v1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, 2, 1, 2),
					ZIndex = v1.ZIndex - 1
				})
				local KeyBindTitleBackGroundAccent = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = UIStyle.UIcolors.FullWhite,
					BorderSizePixel = 0,
					BorderColor3 = UIStyle.UIcolors.ColorG,
					BackgroundTransparency = 0,
					Name = KeyBindName,
					Parent = KeyBindTitleFakeBackGround,
					Position = UDim2.new(0.5, 0, 0, 1),
					Size = UDim2.new(0, 0, 0, 2),
					ZIndex = 6
				})
				local KeyBindTitleBackGroundAccentBorder = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = UIStyle.UIcolors.ColorG,
					BorderSizePixel = 0,
					BorderColor3 = UIStyle.UIcolors.ColorG,
					BackgroundTransparency = 0,
					Name = "nut",
					Parent = KeyBindTitleBackGroundAccent,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, 1, 1, 1),
					ZIndex = 4
				})
				local KeyBindTitleHue, KeyBindTitleSat, KeyBindTitleVal = RGBtoHSV(UIStyle.UIcolors.Accent)
				local KeyBindTitleBackGroundAccentStyling = UIUtilities:Create("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromHSV(KeyBindTitleHue, KeyBindTitleSat, KeyBindTitleVal - 0.1)),
						ColorSequenceKeypoint.new(1, Color3.new(UIStyle.UIcolors.Accent.R, UIStyle.UIcolors.Accent.G, UIStyle.UIcolors.Accent.B))
					}),
					Rotation = 90,
					Parent = KeyBindTitleBackGroundAccent
				})
				table.insert(UIAccents, KeyBindTitleBackGroundAccentStyling)
				local KeyBindTitleBackGroundText = UIUtilities:Create("TextLabel", {
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundTransparency = 1, 
					Position = UDim2.new(1, 0, 0.5, 0),
					Parent = KeyBindTitleEventLogContainer,
					Name = "TEXTEFFECT",
					Size = UDim2.new(1, -4, 1, 0),
					Position = UDim2.new(1, 4, 0, 9),
					ZIndex = 7,
					Font = UIStyle.HeaderFont.Font,
					LineHeight = 1,
					Text = KeyBindName,
					TextColor3 = UIStyle.UIcolors.FullWhite,
					TextSize = UIStyle.HeaderFont.WatermarkTxtSize,
					TextTransparency = 0,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center
				})
				KeyBindList[KeyBindName] = KeyBindTitleBackGroundText
				KeyBindTitleFakeBackGround.Size = UDim2.new(0, TextService:GetTextSize(KeyBindName, UIStyle.HeaderFont.WatermarkTxtSize, UIStyle.HeaderFont.Font, Vector2.new(10000, 0)).X + 8, 0, 36)
				local function UpdateSize()
					if UILibrary.UseListSize then
						for i, v in next, (KeyBindList) do
							v.Parent.Parent.Size = UDim2.new(0, TextService:GetTextSize(v.Text, UIStyle.HeaderFont.WatermarkTxtSize, UIStyle.HeaderFont.Font, Vector2.new(10000, 0)).X + 8, 0, 36)
						end
					else
						local biggest = 0
						for i, v in next, (KeyBindList) do
							local size = TextService:GetTextSize(v.Text, UIStyle.HeaderFont.WatermarkTxtSize, UIStyle.HeaderFont.Font, Vector2.new(10000, 0)).X + 8
							if v.Visible and size > biggest then
								biggest = size
							end
						end
						KeyBindTitleBackGroundText.Size = UDim2.new(0, biggest, 0, 36)
						for i, v in next, (KeyBindList) do
							v.Parent.Parent.Size = UDim2.new(0, biggest, 0, 36) 
						end
					end
				end
				KeyBindTitleBackGroundText:GetPropertyChangedSignal("Text"):Connect(function()
					KeyBindTitleFakeBackGround.Size = UDim2.new(0, TextService:GetTextSize(KeyBindTitleBackGroundText.Text, UIStyle.HeaderFont.WatermarkTxtSize, UIStyle.HeaderFont.Font, Vector2.new(10000, 0)).X + 8, 0, 36)
					UpdateSize()
				end)
				KeyBindTitleFakeBackGround:GetPropertyChangedSignal("Size"):Connect(function()
					KeyBindTitleBackGroundText.Size = KeyBindTitleFakeBackGround.Size
				end)
				KeyBindTitleBackGroundText:GetPropertyChangedSignal("Visible"):Connect(function()
					KeyBindTitleFakeBackGround.Visible = KeyBindTitleBackGroundText.Visible
					UpdateSize()
				end)
				KeyBindTitleBackGroundText.Visible = false
			end
			UILibrary:AddKeyBindList("Keybinds")
			KeyBindList["Keybinds"].Visible = true
			local MainContainer = UIUtilities:Create("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = UIStyle.UIcolors.FullWhite,
				BorderSizePixel = 0,
				Name = "UI",
				Parent = Core,
				Position = UDim2.new(0.5, 0, 0.5, -18),
				Size = UDim2.new(0, 498, 0, 632),
				ZIndex = 6,
				Active = true, 
				Selectable = true, 
			})

			local MainContainerOutline, MainContainerOutlinev1, MainContainerOutlinev2 = AutoApplyBorder(MainContainer, "A", 6, UIStyle.UIcolors.ColorC, UIStyle.UIcolors.ColorB, true)
			local MainContainerAccent, MainContainerAccentStyling = AutoApplyAccent(MainContainer, "A", 7, true)
			table.insert(OpenCloseItems, MainContainer)

			local MainContainerBackGroundGradient = UIUtilities:Create("UIGradient",{
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
					ColorSequenceKeypoint.new(0.06, UIStyle.UIcolors.ColorA),
					ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
				}),
				Rotation = 90,
				Parent = MainContainer
			})

			UILibrary.CheatNameText = UIUtilities:Create("TextLabel", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 1, 4),
				Size = UDim2.new(1, 0, 0, 14),
				ZIndex = 8,
				Font = UIStyle.TextFont.Font,
				Text = UIStyle.CheatName,
				Parent = MainContainerAccent,
				TextColor3 = UIStyle.UIcolors.FullWhite,
				LineHeight = 1.2,
				TextSize = UIStyle.TextFont.CheatTextSize,
				TextStrokeColor3 = Color3.new(),
				TextStrokeTransparency = 0.5,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center
			})
			table.insert(OpenCloseItems, UILibrary.CheatNameText)

			local CheatNameTextPadding = UIUtilities:Create("UIPadding", {
				Parent = UILibrary.CheatNameText,
				PaddingLeft = UDim.new(0, 4)
			})

			local stats = game.Players.LocalPlayer.Status

local function updateWatermark()
	local kills = stats.Kills.Value
	local deaths = stats.Deaths.Value
	local kdr = deaths > 0 and math.round(kills / deaths, 2) or kills
	local month, day, year = getDate()
	local cheatName = tostring(UILibrary.CheatNameText.Text)
	local message = cheatName .. "  |  " .. Parameters.UserType .. "  |  " .. tostring(months[month]) .. " " .. tostring(day) .. " " .. tostring(year).. "  |  Kills: " ..kills.. "  |  Deaths: " ..deaths.. "  |  KDR: " ..kdr
	local fullsize = TextService:GetTextSize(message, UIStyle.HeaderFont.WatermarkTxtSize, UIStyle.HeaderFont.Font, Vector2.new(16000, 0))
	UILibrary.Watermark.Size = UDim2.new(0, fullsize.X + 24, 0, fullsize.Y + 8)
	WatermarkText.Text = message
end

-- live stat update
stats.Kills:GetPropertyChangedSignal("Value"):Connect(updateWatermark)
stats.Deaths:GetPropertyChangedSignal("Value"):Connect(updateWatermark)

-- live cheat name update
UILibrary.CheatNameText:GetPropertyChangedSignal("Text"):Connect(updateWatermark)

function UILibrary.Setwatermarkcheatname(text)
	UILibrary.CheatNameText.Text = text
end

updateWatermark()

			local MainTabsContainer = UIUtilities:Create("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = UIStyle.UIcolors.FullWhite,
				BorderSizePixel = 0,
				Name = "UI",
				Parent = MainContainer,
				Position = UDim2.new(0.5, 0, 0.5, 7),
				Size = UDim2.new(1, -16, 1, -30),
				ZIndex = 9,
			})
			local MainTabsContainerOutline, MainTabsContainerOutlinev1, MainTabsContainerOutlinev2 = AutoApplyBorder(MainTabsContainer, "B", 9, UIStyle.UIcolors.ColorC, UIStyle.UIcolors.ColorB, true)
			local AccentB, AccentBStyling = AutoApplyAccent(MainTabsContainer, "B", 10, true)
			table.insert(OpenCloseItems, MainTabsContainer)

			local MainTabsContainerBackGroundGradient = UIUtilities:Create("UIGradient",{
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
					ColorSequenceKeypoint.new(0.06, UIStyle.UIcolors.ColorA),
					ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
				}),
				Rotation = 90,
				Parent = MainTabsContainer
			})

			local TabsHolder = UIUtilities:Create("Frame", {
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Name = "UI",
				Parent = MainTabsContainer,
				Position = UDim2.new(0.5, 0, 0, 4),
				Size = UDim2.new(1, 0, 0, 34),
				ZIndex = 12
			})

			local TopBar = UIUtilities:Create("Frame", {
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				BackgroundColor3 = UIStyle.UIcolors.ColorF,
				Name = "UI",
				Parent = MainTabsContainer,
				Position = UDim2.new(0.5, 0, 0, 2),
				Size = UDim2.new(1, 0, 0, 2),
				ZIndex = 12
			})
			table.insert(OpenCloseItems, TopBar)

			local BottomBar = UIUtilities:Create("Frame", {
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				BackgroundColor3 = UIStyle.UIcolors.ColorF,
				Name = "UI",
				Parent = MainTabsContainer,
				Position = UDim2.new(0.5, 0, 1, -1),
				Size = UDim2.new(1, 0, 0, 1),
				ZIndex = 12
			})
			table.insert(OpenCloseItems, BottomBar)

			local LeftBar = UIUtilities:Create("Frame", {
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				BackgroundColor3 = UIStyle.UIcolors.ColorF,
				Name = "UI",
				Parent = MainTabsContainer,
				Position = UDim2.new(0, 0, 0.5, 0),
				Size = UDim2.new(0, 1, 1, 0),
				ZIndex = 9
			})
			table.insert(OpenCloseItems, LeftBar)

			local RightBar = UIUtilities:Create("Frame", {
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				BackgroundColor3 = UIStyle.UIcolors.ColorF,
				Name = "UI",
				Parent = MainTabsContainer,
				Position = UDim2.new(1, -1, 0.5, 0),
				Size = UDim2.new(0, 1, 1, 0),
				ZIndex = 9
			})
			table.insert(OpenCloseItems, RightBar)

			local UIListLayoutTabsHolder = UIUtilities:Create("UIListLayout", {
				Padding = UDim.new(0, 4),
				Parent = TabsHolder,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center
			})

			local TabsContainer = UIUtilities:Create("Frame", {
				AnchorPoint = Vector2.new(0, 1),
				BackgroundTransparency = 1,
				BorderSizePixel = 1,
				Parent = MainTabsContainer,
				Position = UDim2.new(0, 0, 1, -2),
				Size = UDim2.new(1, 0, 1, -36),
				Visible = true,
			})

			for k, v in next, UIStyle.Tabs do
				local ClickAble = UIUtilities:Create("TextButton", {
					Active = true,
					BackgroundColor3 = UIStyle.UIcolors.ColorB,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = v,
					Parent = TabsHolder, 
					Selectable = true,
					Size = UDim2.new(1/#UIStyle.Tabs, -4, 1, -4),
					ZIndex = 12,
					Font = UIStyle.TextFont.Font,
					Text = v,
					TextColor3 = Color3.fromHSV(0, 0, 0.7),
					TextSize = UIStyle.TextFont.TabTextSize,
					LineHeight = 1.38,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center
				})
				table.insert(OpenCloseItems, ClickAble)
				local ClickAbleStyling = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = UIStyle.UIcolors.ColorE,
					BorderColor3 = UIStyle.UIcolors.ColorF,
					BorderMode = Enum.BorderMode.Middle,
					BorderSizePixel = 2,
					Name = "Out",
					Parent = ClickAble,
					Position = UDim2.new(0.5, 0, 0.5, -2),
					Size = UDim2.new(1, 4, 1, 2),
					ZIndex = 11
				})
				table.insert(OpenCloseItems, ClickAbleStyling)
				local Button = ClickAble
				local function OpenTab()
					ClickAbleStyling.Visible = false
					for k4, v4 in next, (TabsHolder:GetChildren()) do
						if v4:FindFirstChild("Out") then
							if v4.Text == ClickAble.Text then
								v4.TextColor3 = UIStyle.UIcolors.FullWhite
							else
								v4.TextColor3 = Color3.fromHSV(0, 0, 0.8)
							end
							for k5, v5 in next, (v4:GetChildren()) do
								if v4.Name == ClickAble.Text then
									v5.Visible = false
								else
									v5.Visible = true
								end
							end
						end
					end
					for k3, v3 in next, (CheatSections) do
						if v3.Name == ClickAble.Text then
							v3.Visible = true
						else
							v3.Visible = false
						end
					end
				end
				Button.MouseButton1Down:Connect(OpenTab)
				if k == 1 then
					thread(function()
						realWait()
						OpenTab()
					end)
				end
				Menu[v] = {}
				SubSections[v] = {}
			end

			for k2, v2 in next, UIStyle.Tabs do
				local CorrespondingTab = UIUtilities:Create("Frame", {
					BackgroundTransparency = 1,
					Name = v2,
					Parent = TabsContainer,
					Size = UDim2.new(1, 0, 1, -4),
					Visible = false,
					ZIndex = 10
				})
				table.insert(CheatSections, CorrespondingTab)
				local LeftSection = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundTransparency = 1,
					Name = "L",
					Parent = CorrespondingTab,
					Position = UDim2.new(0, 8, 0, 10),
					Size = UDim2.new(0.5, -14, 1, -12),
					Visible = true,
					ZIndex = 11
				})
				local LStabilizer = UIUtilities:Create("UIListLayout", {
					Padding = UDim.new(0, 8),
					Parent = LeftSection,
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Top
				})
				local RightSection = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0, 0),
					BackgroundTransparency = 1,
					Name = "R",
					Parent = CorrespondingTab,
					Position = UDim2.new(0.5, 6, 0, 10),
					Size = UDim2.new(0.5, -14, 1, -12),
					Visible = true,
					ZIndex = 11
				})
				local RStabilizer = UIUtilities:Create("UIListLayout", {
					Padding = UDim.new(0, 8),
					Parent = RightSection,
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Top
				})
			end

			function UILibrary:CreateSubSection(CheatSection, Tag, SubSubSections, RightSide, Sizeing, Comp)
				local Current, Side
				if RightSide == true then 
					Side = "R"
				else
					Side = "L"
				end
				for k6, v6 in next, CheatSections do
					if v6.Name == CheatSection then
						Current = v6
					end
				end
				if #SubSubSections <= 1 then
					for k7, v7 in next, SubSubSections do
						local Contained = UIUtilities:Create("Frame",{
							AnchorPoint = Vector2.new(0, 0),
							BackgroundTransparency = 0,
							BackgroundColor3 = UIStyle.UIcolors.FullWhite,
							Name = Tag,
							BorderSizePixel = 0,
							Parent = Current[Side],
							Position = UDim2.new(0, 0, 0, 0),
							Size = UDim2.new(1, 0, Sizeing, Comp),
							Visible = true,
							ZIndex = 18
						})
						table.insert(OpenCloseItems, Contained)
						AutoApplyBorder(Contained, v7, 18, UIStyle.UIcolors.ColorC, UIStyle.UIcolors.ColorB, true)
						AutoApplyAccent(Contained, v7, 18, UIStyle.UIcolors.ColorC, UIStyle.UIcolors.ColorB, true)
						local SubTabTag = UIUtilities:Create("TextLabel",{
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Position = UDim2.new(0, 0, 0, 4),
							Size = UDim2.new(1, 0, 0, 16),
							ZIndex = 19,
							Font = UIStyle.TextFont.Font,
							Text = v7,
							Parent = Contained,
							TextColor3 = UIStyle.UIcolors.FullWhite,
							TextSize = UIStyle.TextFont.TxtSize,
							TextStrokeColor3 = Color3.new(),
							TextStrokeTransparency = 0.5,
							TextXAlignment = Enum.TextXAlignment.Left,
							TextYAlignment = Enum.TextYAlignment.Center
						})
						table.insert(OpenCloseItems, SubTabTag)
						local ContainedSection = UIUtilities:Create("Frame", {
							AnchorPoint = Vector2.new(0, 1),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Name = v7,
							Parent = Contained,
							Position = UDim2.new(0, 0, 1, 0),
							Size = UDim2.new(1, 0, 1, -26),
							ZIndex = 19
						})
						local ContainedSectionOrganizer = UIUtilities:Create("UIListLayout", {
							Padding = UDim.new(0, 8),
							Parent = ContainedSection,
							SortOrder = Enum.SortOrder.LayoutOrder
						})
						local Absolute = Contained.AbsoluteSize
						local YSize = Absolute.Y
						local PercentageCover = 24/YSize
						local ContainedStyling = UIUtilities:Create("UIGradient", {
							Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
								ColorSequenceKeypoint.new(PercentageCover - PercentageCover/8, UIStyle.UIcolors.ColorA),
								ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
							}),
							Rotation = 90,
							Parent = Contained
						})
						local CheatNameTextPadding = UIUtilities:Create("UIPadding", {
							Parent = SubTabTag,	
							PaddingLeft = UDim.new(0, 6),
						})
						Menu[CheatSection][v7] = {}
						SubSections[CheatSection][v7] = ContainedSection
					end
				else
					local Contained = UIUtilities:Create("Frame",{
						AnchorPoint = Vector2.new(0, 0),
						BackgroundTransparency = 0,
						BackgroundColor3 = UIStyle.UIcolors.FullWhite,
						Name = Tag,
						BorderSizePixel = 0,
						Parent = Current[Side],
						Position = UDim2.new(0, 0, 0, 0),
						Size = UDim2.new(1, 0, Sizeing, Comp),
						Visible = true,
						ZIndex = 18
					})
					table.insert(OpenCloseItems, Contained)
					AutoApplyBorder(Contained, "G", 18, UIStyle.UIcolors.ColorC, UIStyle.UIcolors.ColorB, true)
					AutoApplyAccent(Contained, "G", 19, UIStyle.UIcolors.ColorC, UIStyle.UIcolors.ColorB, true)
					local Absolute = Contained.AbsoluteSize
					local YSize = Absolute.Y
					local PercentageCover = 24/YSize
					local ContainedStyling = UIUtilities:Create("UIGradient", {
						Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromRGB(54, 54, 54)),
							ColorSequenceKeypoint.new(PercentageCover - PercentageCover/10, UIStyle.UIcolors.ColorA),
							ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
						}),
						Rotation = 90,
						Parent = Contained
					})
					local Holder = UIUtilities:Create("Frame", {
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = UIStyle.UIcolors.ColorB,
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Name = "Holder",
						Parent = Contained,
						Position = UDim2.new(0.5, 0, 0, 4),
						Size = UDim2.new(1, -4, 0, 16),
						ZIndex = 18
					})
					local HolderOrganizer = UIUtilities:Create("UIListLayout", {
						Padding = UDim.new(0, 2),
						Parent = Holder,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Left,
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center
					})
					local SubSectionsSizePixel = 0
					for k7, v7 in next, SubSubSections do
						local ElTextSize = UIStyle.TextFont.TxtSize
						local TextSize = TextService:GetTextSize(
							v7,
							ElTextSize,
							UIStyle.TextFont.Font,
							Vector2.new(1000, 1000)
						)
						local ClickAble2 = UIUtilities:Create("TextButton", {
							AnchorPoint = Vector2.new(0, 0),
							AutoButtonColor = false,
							BackgroundColor3 = UIStyle.UIcolors.ColorE,
							BackgroundTransparency = 1,
							BorderColor3 = UIStyle.UIcolors.ColorF,
							BorderSizePixel = 2,
							Name = v7,
							Parent = Holder,
							Size = UDim2.new(0, TextSize.X + 8, 1, 0),
							ZIndex = 19,
							Font = UIStyle.TextFont.Font,
							Text = v7,
							TextColor3 = Color3.fromHSV(0, 0, 0.7),
							TextSize = UIStyle.TextFont.TxtSize,
							TextStrokeColor3 = Color3.new(),
							TextStrokeTransparency = 0.5,
							TextXAlignment = Enum.TextXAlignment.Center,
							TextYAlignment = Enum.TextYAlignment.Center
						})
						table.insert(OpenCloseItems, ClickAble2)
						SubSectionsSizePixel = SubSectionsSizePixel + TextSize.X + 8
						local Spacer = UIUtilities:Create("Frame", {
							BackgroundColor3 = UIStyle.UIcolors.ColorE,
							BackgroundTransparency = 0,
							BorderColor3 = UIStyle.UIcolors.ColorF,
							BorderSizePixel = 2,
							Name = "Spacer",
							Parent = ClickAble2,
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = 18
						})
						table.insert(OpenCloseItems, Spacer)
						local SubSubSectionContainer = UIUtilities:Create("Frame", {
							Active = false,
							AnchorPoint = Vector2.new(0, 1),
							BackgroundTransparency = 1,
							Parent = Contained,
							Name = v7,
							Position = UDim2.new(0, 0, 1, 0),
							Size = UDim2.new(1, 0, 1, -32),
							Visible = false
						})
						local ContainedSectionOrganizer = UIUtilities:Create("UIListLayout", {
							Padding = UDim.new(0, 8),
							Parent = SubSubSectionContainer,
							SortOrder = Enum.SortOrder.LayoutOrder
						})
						local Button = ClickAble2
						function OpenSubSection()
							for k8, v8 in next, (Holder:GetChildren()) do
								if v8:FindFirstChild("Spacer") and v8:IsA("TextButton") then
									for k9, v9 in next, (v8:GetChildren()) do
										if v8.Text == ClickAble2.Text then
											v8.TextColor3 = Color3.fromHSV(0, 0, 1)
										else
											v8.TextColor3 = Color3.fromHSV(0, 0, 0.8)
										end
										if v8.Name == ClickAble2.Text then
											v9.Visible = false
										else
											v9.Visible = true
										end
									end
								end
							end
							for kA, vA in next, (Contained:GetChildren()) do
								if vA.Name == ClickAble2.Text and vA:IsA("Frame") then
									vA.Visible = true
								elseif vA.Name ~= ClickAble2.Text and vA:IsA("Frame") and vA.Name ~= "UI" and vA.Name ~= "Holder" then
									vA.Visible = false
								end
							end
						end
						if k7 == 1 then
							OpenSubSection()
						end
						Button.MouseButton1Down:Connect(OpenSubSection)
						Menu[CheatSection][v7] = {}
						SubSections[CheatSection][v7] = SubSubSectionContainer
					end
					local modify = 4
					if #SubSubSections >= 3 then
						modify = 4 + (2 * (#SubSubSections - 2))
					end
					local Filler = UIUtilities:Create("Frame", {
						BackgroundColor3 = UIStyle.UIcolors.ColorE,
						BackgroundTransparency = 0,
						BorderColor3 = UIStyle.UIcolors.ColorF,
						BorderSizePixel = 2,
						Name = "FILLER",
						Parent = Holder,
						Size = UDim2.new(1, (-1 * SubSectionsSizePixel) - modify, 1, 0),
						ZIndex = 18
					})
					table.insert(OpenCloseItems, Filler)
				end
			end

			function UILibrary:CreateButton(Parameters)
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name] = {}
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"] = {}
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"].Changed = Signal.new()
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name].Save = function()
					return Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Color 2"] and {
						["Toggle"] = {
							["Enabled"] = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"]
						},
						["Color 1"] = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Color 1"].Save(),
						["Color 2"] = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Color 2"].Save(),
					} or Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Color 1"] and {
						["Toggle"] = {
							["Enabled"] = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"]
						},
						["Color 1"] = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Color 1"].Save(),
					} or Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Bind"] and {
						["Toggle"] = {
							["Enabled"] = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"]
						},
						["Bind"] = {
							["Activation Type"] = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Bind"]["Activation Type"],
							["Key"] = tostring(Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Bind"]["Key"]),
						}
					} or {
						["Toggle"] = {
							["Enabled"] = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"]
						}
					}
				end
				local Proxy = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]
				local Hitbox = UIUtilities:Create("TextButton", {
					BackgroundTransparency = 1,
					Name = Parameters.Name,
					Parent = SubSections[Parameters.Tab][Parameters.Section],
					Size = UDim2.new(1, 0, 0, 8),
					Visible = true,
					ZIndex = 19,
					Text = ""
				})

				if Parameters.Tooltip then
					Hitbox.MouseEnter:Connect(function()
						UILibrary.CallToolTip(Parameters.Tooltip, Hitbox.AbsolutePosition, Hitbox.AbsolutePosition + Vector2.new(8, 16), Hitbox.AbsoluteSize)
					end)
				end

				local Bool = UIUtilities:Create("BoolValue", {
					Name = Parameters.Name,
					Parent = Hitbox,
					Value = false
				})
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"] = Bool.Value
				local ClickMask = UIUtilities:Create("Frame", {
					BackgroundColor3 = UIStyle.UIcolors.ColorD,
					BackgroundTransparency = 0,
					AnchorPoint = Vector2.new(0, 0.5),
					BorderSizePixel = 0,
					Name = "ButtonMask",
					Parent = Hitbox,
					Position = UDim2.new(0, 8, 0.5, 0),
					Size = UDim2.new(0, 8, 0, 8),
					ZIndex = 24
				})
				table.insert(UIAccents, ClickMask)
				table.insert(OpenCloseItems, ClickMask)
				AutoApplyBorder(ClickMask, Parameters.Name, 24, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH, true)
				local ClickMaskStyling = UIUtilities:Create("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 160))
					}),
					Rotation = 90,
					Parent = ClickMask
				})
				local TextBox = UIUtilities:Create("TextLabel", {
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = 1,
					Parent = Hitbox,
					Position = UDim2.new(1, 0, 0, 0),
					Size = UDim2.new(1, -22, 1, 0),
					ZIndex = 19,
					Text = Parameters.Name,
					TextColor3 = UIStyle.UIcolors.FullWhite,
					Font = UIStyle.TextFont.Font,
					LineHeight = 1.05,
					TextSize = UIStyle.TextFont.TxtSize,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center
				})
				table.insert(OpenCloseItems, TextBox)
				if Parameters.Colors then
					for i, v in next, (Parameters.Colors) do
						CreateColorThing({Pos = -1 * (((i - 1) * 24) + (10 * i - 1)), Parented = Hitbox, Stance = i, StartColor = v, StartTrans = Parameters.Transparency and Parameters.Transparency[i], Tab = Parameters.Tab, ObjectName = Parameters.Name, Section = Parameters.Section})
					end
				else
					if Parameters.KeyBind then
						CreateKeyBindThing(Hitbox, Parameters.KeyBind, Parameters.Tab, Parameters.Section, Parameters.Name)
					end	
				end
					--[[Hitbox.MouseButton1Down:Connect(function()
						Bool.Value = not Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"]
						Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"] = Bool.Value
						Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"].Changed:Fire(Bool.Value)
					end)]]
				Hitbox.MouseButton1Down:Connect(function()
					if isColorThingOpen then return end
					Bool.Value = not Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"]
				end)

				Bool.Changed:Connect(function()
					Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"] = Bool.Value
					Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"].Changed:Fire(Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"])
					if Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"] == true then
						ClickMask.BackgroundColor3 = UIStyle.UIcolors.Accent
					else
						ClickMask.BackgroundColor3 = UIStyle.UIcolors.ColorD
					end
					if Parameters.KeyBind then
						KeyBindList[Parameters.Section .. ": " .. Parameters.Name].Visible = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"]
						if Parameters.Callback then
							Parameters.Callback(Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"], Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Bind"]["Active"])
						end
						Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"].Changed:Fire(v, Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Bind"]["Active"])
					else
						if Parameters.Callback then
							Parameters.Callback(Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"])
						end
						Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"].Changed:Fire(Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"]["Enabled"])
					end
				end)

				Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Toggle"] = setmetatable({}, {
					__index = function(self, i)
						return Proxy[i]
					end,
					__newindex = function(self, i, v) -- so that you can do Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"] = true or false
						if i == "Enabled" then-- if ur tryna set the value of the toggle
							Bool.Value = v
						end
						Proxy[i] = v
					end
				})
			end
			function UILibrary:CreateSlider(Parameters) -- Parameters.MaximumNumber
				Parameters.DefaultValue = Parameters.DefaultValue and math.max(math.min(Parameters.DefaultValue, Parameters.MaximumNumber), Parameters.MinimumNumber) or nil
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name] = {}
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name].Changed = Signal.new()
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name].Save = function()
					return {["Value"] = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"]}
				end
				local Proxy = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]
				if not Parameters.Suffix then
					Parameters.Suffix = ""
				end
				local Slider = UIUtilities:Create("Frame", {
					Name = Parameters.Name,
					Parent = SubSections[Parameters.Tab][Parameters.Section],
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					ZIndex = 22,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 0, 20)
				})
				local TextLabel = UIUtilities:Create("TextButton", {
					Parent = Slider,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0, -4),
					Size = UDim2.new(1, 0, 0, 15),
					Font = UIStyle.TextFont.Font,
					ZIndex = 22,
					Text = Parameters.Name,
					TextColor3 = UIStyle.UIcolors.FullWhite,
					TextStrokeColor3 = Color3.new(),
					LineHeight = 1.2,
					TextStrokeTransparency = 0.5,
					TextSize = UIStyle.TextFont.TxtSize,
					TextXAlignment = Enum.TextXAlignment.Left
				})
				local AddText = UIUtilities:Create("TextButton", {
					Parent = Slider,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -32, 0, -4),
					Size = UDim2.new(0, 8, 0, 15),
					Font = UIStyle.TextFont.Font,
					ZIndex = 22,
					Visible = false,
					Text = "+",
					TextColor3 = UIStyle.UIcolors.FullWhite,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
					TextSize = UIStyle.TextFont.TxtSize,
					TextXAlignment = Enum.TextXAlignment.Center
				})
				local SubtractText = UIUtilities:Create("TextButton", {
					Parent = Slider,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -22, 0, -4),
					Size = UDim2.new(0, 8, 0, 15),
					Font = UIStyle.TextFont.Font,
					ZIndex = 22,
					Visible = false,
					Text = "-",
					TextColor3 = UIStyle.UIcolors.FullWhite,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
					TextSize = UIStyle.TextFont.TxtSize,
					TextXAlignment = Enum.TextXAlignment.Center
				})
				table.insert(OpenCloseItems, TextLabel)
				local Button = UIUtilities:Create("TextButton", {
					AnchorPoint = Vector2.new(0.5, 0),
					Name = "Button",
					Parent = Slider,
					BackgroundTransparency = 1,
					BackgroundColor3 = UIStyle.UIcolors.ColorD,
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0, 12),
					Size = UDim2.new(1, -18, 0, 8),
					AutoButtonColor = false,
					ZIndex = 21,
					Text = ""
				})
				local ButtonStyle = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					Name = "Button",
					Parent = Button,
					BackgroundTransparency = 0,
					BackgroundColor3 = UIStyle.UIcolors.ColorD,
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 22
				})
				local ButtonStyleStyling = UIUtilities:Create("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
					}),
					Rotation = 90,
					Parent = ButtonStyle
				})
				table.insert(OpenCloseItems, ButtonStyle)
				AutoApplyBorder(ButtonStyle, Parameters.Name, 22, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH, true)
				local Frame = UIUtilities:Create("Frame", {
					Parent = Button,
					BackgroundColor3 = UIStyle.UIcolors.Accent,
					BorderSizePixel = 0,
					ZIndex = 22,
					Size = UDim2.new(0, (Parameters.DefaultValue and (Parameters.DefaultValue - Parameters.MinimumNumber) or 0) / (Parameters.MaximumNumber - Parameters.MinimumNumber) * Button.AbsoluteSize.X, 1, 0)
				})
				
				local FrameStyling = UIUtilities:Create("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
					}),
					Rotation = 90,
					Parent = Frame
				})
				table.insert(UIAccents, Frame)
				table.insert(OpenCloseItems, Frame)
				--local sliderText = (Parameters.DefaultValue and ((Parameters.MaximumText and Parameters.DefaultValue == Parameters.MaximumNumber) and Parameters.MaximumText) or ((Parameters.MinimumText and Parameters.DefaultValue == Parameters.MinimumNumber) and Parameters.MinimumText) or Parameters.DefaultValue) or (Parameters.MinimumText or Parameters.MinimumNumber .. Parameters.Suffix)
				local Value = UIUtilities:Create("TextLabel", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					Name = "Value",
					Parent = ButtonStyle,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, 0, 0, 2),
					LineHeight = 1.1,
					Font = UIStyle.TextFont.Font,
					Text = (Parameters.DefaultValue and ((Parameters.MaximumText and Parameters.DefaultValue == Parameters.MaximumNumber) and Parameters.MaximumText) or ((Parameters.MinimumText and Parameters.DefaultValue == Parameters.MinimumNumber) and Parameters.MinimumText) or Parameters.DefaultValue) or (Parameters.MinimumText or Parameters.MinimumNumber .. Parameters.Suffix), -- Text = Parameters.DefaultValue or Parameters.MinimumText or Parameters.MinimumNumber .. Parameters.Suffix,
					ZIndex = 24,
					TextColor3 = UIStyle.UIcolors.FullWhite,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
					TextSize = UIStyle.TextFont.TxtSize,
					TextXAlignment = Enum.TextXAlignment.Center
				})
				table.insert(OpenCloseItems, Value)
				local NumberValue = UIUtilities:Create("NumberValue", {
					Value = Parameters.DefaultValue or Parameters.MinimumNumber,
					Parent = Slider,
					Name = Parameters.Name
				})
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"] = NumberValue.Value
				local mouse = Mouse
				local val
				local Absolute = Button.AbsoluteSize.X
				local Moving = false
				if Parameters.Tooltip then
					Button.MouseEnter:Connect(function()
						UILibrary.CallToolTip(Parameters.Tooltip, Button.AbsolutePosition, Button.AbsolutePosition + Vector2.new(0, 16), Button.AbsoluteSize)
					end)
				end
				Button.MouseButton1Down:Connect(function()
					if moveconnection then
						moveconnection:Disconnect()
					end
					if releaseconnection then
						releaseconnection:Disconnect() -- fixing the issue where if ur mouse goes off screen while dragging itll cancel it on click
					end
					if isColorThingOpen then
						return
					end
					Moving = true
					Frame.Size = UDim2.new(0, math.clamp(mouse.X - Frame.AbsolutePosition.X, 0, Absolute), 1, 0)
					val = math.floor(0.5 + (((Parameters.MaximumNumber - Parameters.MinimumNumber) / Absolute) * Frame.AbsoluteSize.X) + Parameters.MinimumNumber) or 0
					NumberValue.Value = val
					moveconnection = mouse.Move:Connect(function()
						Frame.Size = UDim2.new(0, math.clamp(mouse.X - Frame.AbsolutePosition.X, 0, Absolute), 1, 0)
						val = math.floor(0.5 + (((Parameters.MaximumNumber - Parameters.MinimumNumber) / Absolute) * Frame.AbsoluteSize.X) + Parameters.MinimumNumber)
						NumberValue.Value = val
					end)
					releaseconnection = UserInputService.InputEnded:Connect(function(Mouse)
						if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
							Frame.Size = UDim2.new(0, math.clamp(mouse.X - Frame.AbsolutePosition.X, 0, Absolute), 1, 0)
							val = (((Parameters.MaximumNumber - Parameters.MinimumNumber) / Absolute) * Frame.AbsoluteSize.X) + Parameters.MinimumNumber
							moveconnection:Disconnect()
							releaseconnection:Disconnect()
							Moving = false
						end
					end)
				end)
				NumberValue.Changed:Connect(function()
					NumberValue.Value = math.clamp(NumberValue.Value, Parameters.MinimumNumber, Parameters.MaximumNumber)
					if not Moving then
						local Portion = 0.5
						if Parameters.MinimumNumber > 0 then
							Portion = ((NumberValue.Value - Parameters.MinimumNumber)) / (Parameters.MaximumNumber - Parameters.MinimumNumber)
						else
							Portion = (NumberValue.Value - Parameters.MinimumNumber) / (Parameters.MaximumNumber - Parameters.MinimumNumber)
						end
						Frame.Size = UDim2.new(Portion, 0, 1, 0) -- itll go back to offset when someone tries moving it
						val = math.floor(0.5 + (((Parameters.MaximumNumber - Parameters.MinimumNumber) / Absolute) * Frame.AbsoluteSize.X) + Parameters.MinimumNumber) or 0
					end
					if NumberValue.Value == Parameters.MaximumNumber and Parameters.MaximumText ~= nil then
						Value.Text = Parameters.MaximumText
					elseif NumberValue.Value == Parameters.MinimumNumber and Parameters.MinimumText ~= nil then
						Value.Text = Parameters.MinimumText
					else
						Value.Text = val .. Parameters.Suffix  
					end
					Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"] = NumberValue.Value
					if Parameters.Callback then
						Parameters.Callback(NumberValue.Value)
					end
					Menu[Parameters.Tab][Parameters.Section][Parameters.Name].Changed:Fire(NumberValue.Value)
				end)
				Slider.MouseEnter:Connect(function()
					AddText.Visible = true
					SubtractText.Visible = true
				end)
				Slider.MouseLeave:Connect(function()
					AddText.Visible = false
					SubtractText.Visible = false
				end)
				AddText.MouseEnter:Connect(function()
					AddText.TextColor3 = UIStyle.UIcolors.Accent
				end)
				AddText.MouseLeave:Connect(function()
					AddText.TextColor3 = UIStyle.UIcolors.FullWhite
				end)
				SubtractText.MouseEnter:Connect(function()
					SubtractText.TextColor3 = UIStyle.UIcolors.Accent
				end)
				SubtractText.MouseLeave:Connect(function()
					SubtractText.TextColor3 = UIStyle.UIcolors.FullWhite
				end)
				AddText.MouseButton1Down:Connect(function()
					NumberValue.Value = NumberValue.Value + 1
				end)
				SubtractText.MouseButton1Down:Connect(function()
					NumberValue.Value = NumberValue.Value - 1
				end)
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name] = setmetatable({}, {
					__index = function(self, i)
						return Proxy[i]
					end,
					__newindex = function(self, i, v)
						if i == "Value" then
							NumberValue.Value = v
						end
						Proxy[i] = v
					end
				})
			end

			function UILibrary:CreateDropdown(Parameters)
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name] = {}
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Dropdown"] = {}
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Dropdown"].Changed = Signal.new()
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name].Save = function()
					return {
						["Value"] = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"]
					}
				end
				local Contained = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0),
					Name = Parameters.Name,
					Parent = SubSections[Parameters.Tab][Parameters.Section],
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0, 0),
					Size = UDim2.new(1, 0, 0, 32),
					ZIndex = 22,
				})
				local ValueContainer = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0),
					Name = "ValueContainer",
					Parent = Contained,
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 1, 4),
					Size = UDim2.new(1, -18, 0, 16),
					Visible = false,
					ZIndex = 23,
				})
				local FakeSelection = UIUtilities:Create("TextButton", {
					Active = true,
					AnchorPoint = Vector2.new(0.5, 1),
					Name = "FAKE",
					Parent = Contained,
					BackgroundColor3 = Color3.fromRGB(44, 44, 44),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(39, 39, 39),
					BorderSizePixel = 3,
					Position = UDim2.new(0.5, 0, 1, 0),
					Selectable = true,
					Size = UDim2.new(1, -18, 0, 20),
					ZIndex = 24,
					Font = UIStyle.TextFont.Font,
					ClipsDescendants = false,
					LineHeight = 1.1,
					Text = "",
					TextColor3 = UIStyle.UIcolors.FullWhite,
					TextSize = UIStyle.TextFont.TxtSize,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Left,
				})
				local Selection = UIUtilities:Create("TextButton", {
					Active = true,
					AnchorPoint = Vector2.new(0.5, 1),
					Name = "Selection",
					Parent = Contained,
					BackgroundColor3 = Color3.fromRGB(44, 44, 44),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(39, 39, 39),
					BorderSizePixel = 3,
					Position = UDim2.new(0.5, 0, 1, 0),
					Selectable = true,
					Size = UDim2.new(1, -18, 0, 20),
					ZIndex = 24,
					Font = UIStyle.TextFont.Font,
					ClipsDescendants = true,
					LineHeight = 1.1,
					Text = Parameters.Values[1],
					TextColor3 = UIStyle.UIcolors.FullWhite,
					TextSize = UIStyle.TextFont.TxtSize,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Left,
				})
				local DropDownTypeText = UIUtilities:Create("TextButton", {
					AnchorPoint = Vector2.new(0.5, 1),
					Name = "TypeOf",
					Parent = Contained,
					BackgroundColor3 = Color3.fromRGB(44, 44, 44),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(39, 39, 39),
					BorderSizePixel = 3,
					Position = UDim2.new(0.5, 0, 1, 0),
					Size = UDim2.new(1, -32, 0, 18),
					ZIndex = 23,
					Font = UIStyle.TextFont.Font,
					LineHeight = 1.1,
					Text = "-",
					TextColor3 = UIStyle.UIcolors.FullWhite,
					TextSize = UIStyle.TextFont.TxtSize,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Right,
				})
				if Parameters.MultiChoice then 
					DropDownTypeText.Text = "..."
				end
				table.insert(OpenCloseItems, DropDownTypeText)
				table.insert(OpenCloseItems, Selection)
				local Padding = UIUtilities:Create("UIPadding", {
					Parent = Selection,
					PaddingLeft = UDim.new(0, 12)
				}) 
				local Padding2 = UIUtilities:Create("UIPadding", {
					Parent = FakeSelection,
					PaddingLeft = UDim.new(0, 12)
				}) 
				local SelectionStyling = UIUtilities:Create("Frame", {
					BackgroundColor3 = UIStyle.UIcolors.FullWhite,
					Parent = FakeSelection,
					BorderSizePixel = 0,
					Position = UDim2.new(0, -12, 0, 0),
					Size = UDim2.new(1, 12, 1, 0),
					ZIndex = 23,
				})
				table.insert(OpenCloseItems, SelectionStyling)
				local SelectionStylingGradient = UIUtilities:Create("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
						ColorSequenceKeypoint.new(0.84, UIStyle.UIcolors.ColorA),
						ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
					}),
					Rotation = 90,
					Parent = SelectionStyling
				})
				AutoApplyBorder(SelectionStyling, "SelectionStyling", 22, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH, true)
				local NameTag = UIUtilities:Create("TextLabel", {
					Name = "NAMETAG",
					Parent = Contained,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0, 0),
					Size = UDim2.new(1, -12, 1, -24),
					Font = UIStyle.TextFont.Font,
					Text = Parameters.Name,
					TextColor3 = UIStyle.UIcolors.FullWhite,
					TextSize = UIStyle.TextFont.TxtSize,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 22
				})
				table.insert(OpenCloseItems, NameTag)
				local Organizer = UIUtilities:Create("UIListLayout", {
					Padding = UDim.new(0, 0),
					Parent = ValueContainer,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
				})
				for iC, vC in next, (Parameters.Values) do
					local Button = UIUtilities:Create("TextButton", {
						AnchorPoint = Vector2.new(0.5, 0),
						Name = "Button",
						Parent = ValueContainer,
						AutoButtonColor = false,
						BackgroundColor3 = UIStyle.UIcolors.ColorI,
						BorderColor3 = UIStyle.UIcolors.ColorB,
						BorderSizePixel = 0,
						BackgroundTransparency = 0,
						Position = UDim2.new(0.5, 0, 0, 0),
						Size = UDim2.new(1, 0, 0, 18),
						ZIndex = 32,
						Font = UIStyle.TextFont.Font,
						TextStrokeColor3 = Color3.new(),
						TextStrokeTransparency = 0,
						Text = vC,
						TextColor3 = UIStyle.UIcolors.FullWhite,
						TextSize = UIStyle.TextFont.TxtSize
					})
					local valsthing = UIUtilities:Create("BoolValue", {
						Parent = Button,
						Value = false,
						Name = "Selection"
					})
					if iC == 1 and Parameters.MultiChoice then
						Button.TextColor3 = UIStyle.UIcolors.Accent
						valsthing.Value = true
					end
					local ButtonStyling = UIUtilities:Create("Frame", {
						AnchorPoint = Vector2.new(0.5, 0.5),
						Parent = Button,
						BackgroundColor3 = UIStyle.UIcolors.ColorA,
						BorderSizePixel = 1,
						BorderColor3 = UIStyle.UIcolors.ColorB,
						Position = UDim2.new(0.5, 0, 0.5, 0),
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = 31
					})
					AutoApplyBorder(ButtonStyling, vC, 31, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
				end
				local closeconnection
				local inDropDown = false
				local mouseent, mouseext
				local function trigger()
					if isColorThingOpen then
						return
					end
					if isDropDownOpen and isDropDownOpen ~= ValueContainer then
						return
					end
					ValueContainer.Size = UDim2.new(1, -18, 0, #Parameters.Values * 18)
					ValueContainer.Visible = not ValueContainer.Visible
					isDropDownOpen = ValueContainer.Visible and ValueContainer or nil

					if ValueContainer.Visible then
						if not Parameters.MultiChoice then
							for _, Button in next, (ValueContainer:GetChildren()) do
								if Button:IsA("TextButton") then
									if Button.Text == Selection.Text then
										Button.TextColor3 = UIStyle.UIcolors.Accent
									else
										Button.TextColor3 = UIStyle.UIcolors.FullWhite
									end	
								end
							end
						else
							for _, Button in next, (ValueContainer:GetChildren()) do
								if Button:IsA("TextButton") then
									if Button.Selection.Value then
										Button.TextColor3 = UIStyle.UIcolors.Accent
									else
										Button.TextColor3 = UIStyle.UIcolors.FullWhite
									end	
								end
							end
						end
						task.wait()
						mouseent = ValueContainer.MouseEnter:Connect(function()
							inDropDown = true
						end)
						mouseext = ValueContainer.MouseLeave:Connect(function()
							inDropDown = false
						end)
						closeconnection = UserInputService.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
								if not inDropDown then
									ValueContainer.Visible = false
									closeconnection:Disconnect()
									mouseent:Disconnect()
									mouseext:Disconnect()
								end
							end
						end)
					else
						if closeconnection then
							closeconnection:Disconnect()
						end
						if mouseent then
							mouseent:Disconnect()
						end
						if mouseext then
							mouseext:Disconnect()
						end
					end
				end
				Selection.MouseButton1Down:Connect(trigger)
				if Parameters.Tooltip then
					Selection.MouseEnter:Connect(function()
						UILibrary.CallToolTip(Parameters.Tooltip, Selection.AbsolutePosition, Selection.AbsolutePosition + Vector2.new(0, 24), Selection.AbsoluteSize)
					end)
				end
				local function update()
					local chosentext = {}
					Selection.Text = ""

					for cf, c in next, (ValueContainer:GetChildren()) do
						if c:IsA("TextButton") then
							if c:FindFirstChild("Selection") and c.Selection.Value == true then
								table.insert(chosentext, c.Text)
							end
						end
					end

					for e = 1, #chosentext do
						if e == #chosentext then
							Selection.Text = Selection.Text .. chosentext[e]
						else
							Selection.Text = Selection.Text .. chosentext[e] .. ", "
						end
					end
				end           
				local function initialize()
					if Parameters.MultiChoice then	
						Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"] = {Parameters.Values[1]}

						for _, button in next, (ValueContainer:GetChildren()) do
							if button:IsA("TextButton") then
								button.MouseButton1Down:Connect(function()
									button.Selection.Value = not button.Selection.Value
									if button:FindFirstChild("Selection") and button.Selection.Value == true then
										button.TextColor3 = UIStyle.UIcolors.Accent
									else
										button.TextColor3 = UIStyle.UIcolors.FullWhite
									end
									update()

									local chosentext = {}

									for cf, c in next, (ValueContainer:GetChildren()) do
										if c:IsA("TextButton") then
											if c:FindFirstChild("Selection") and c.Selection.Value == true then
												table.insert(chosentext, c.Text)
											end
										end
									end

									Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"] = chosentext
								end)
							end
						end

					else
						Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"] = Parameters.Values[1]
						for _, ButtonA in next, (ValueContainer:GetChildren()) do
							if ButtonA:IsA("TextButton") then
								ButtonA.MouseButton1Down:Connect(function()
									Selection.Text = ButtonA.Text
									trigger()
									Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"] = Selection.Text
								end)
							end
						end
					end
				end
				initialize()
				Selection:GetPropertyChangedSignal("Text"):Connect(function()
					if Parameters.Callback then
						Parameters.Callback(Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"])
					end
					Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Dropdown"].Changed:Fire(Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"])
				end)
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name].UpdateValues = function(NewValues)
					if Parameters.MultiChoice then
						Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"] = {}
					else
						Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"] = ""
					end
					for i, v in next, (ValueContainer:GetChildren()) do
						if v ~= Organizer then
							v:Destroy()
						end
					end
					for iC, vC in next, (NewValues) do
						local Button = UIUtilities:Create("TextButton", {
							AnchorPoint = Vector2.new(0.5, 0),
							Name = "Button",
							Parent = ValueContainer,
							AutoButtonColor = false,
							BackgroundColor3 = UIStyle.UIcolors.ColorI,
							BorderColor3 = UIStyle.UIcolors.ColorB,
							BorderSizePixel = 0,
							BackgroundTransparency = 0,
							Position = UDim2.new(0.5, 0, 0, 0),
							Size = UDim2.new(1, 0, 0, 18),
							ZIndex = 32,
							Font = UIStyle.TextFont.Font,
							TextStrokeColor3 = Color3.new(),
							TextStrokeTransparency = 0,
							Text = vC,
							TextColor3 = UIStyle.UIcolors.FullWhite,
							TextSize = UIStyle.TextFont.TxtSize
						})
						if iC == 1 and Parameters.MultiChoice then
							Button.TextColor3 = UIStyle.UIcolors.Accent
						end
						local ButtonStyling = UIUtilities:Create("Frame", {
							AnchorPoint = Vector2.new(0.5, 0.5),
							Parent = Button,
							BackgroundColor3 = UIStyle.UIcolors.ColorA,
							BorderSizePixel = 1,
							BorderColor3 = UIStyle.UIcolors.ColorB,
							Position = UDim2.new(0.5, 0, 0.5, 0),
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = 31
						})
						AutoApplyBorder(ButtonStyling, vC, 31, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH)
					end
					Parameters.Values = NewValues
					Selection.Text = NewValues[1]
					initialize()
				end
				local Proxy = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name] = setmetatable({}, {
					__index = function(self, i)
						return Proxy[i]
					end,
					__newindex = function(self, i, v)
						Proxy[i] = v
						if i == "Value" then
							if Parameters.MultiChoice then
								for _, button in next, (ValueContainer:GetChildren()) do
									if button:IsA("TextButton") then
										button.Selection.Value = false
									end
								end
								for _, button in next, (ValueContainer:GetChildren()) do
									if button:IsA("TextButton") then
										for ball, sack in next, v do
											if button.Text == sack then
												button.Selection.Value = true
											end
										end 
										update()
									end
								end
								if Parameters.Callback then
									Parameters.Callback(Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"])
								end
								Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Dropdown"].Changed:Fire(Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"])
							else
								Selection.Text = v
								if Parameters.Callback then
									Parameters.Callback(Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"])
								end
								Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Dropdown"].Changed:Fire(Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"])
							end
						end
					end
				})
			end

			function UILibrary:CreateTap(Parameters)
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name] = {}
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Button"] = {}
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Button"].Pressed = Signal.new()
				local Hitbox = UIUtilities:Create("TextButton", {
					BackgroundTransparency = 1,
					Name = Parameters.Name,
					Parent = SubSections[Parameters.Tab][Parameters.Section],
					Size = UDim2.new(1, 0, 0, 20),
					ZIndex = 24,
					Font = UIStyle.TextFont.Font,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
					Text = Parameters.Name,
					TextSize = UIStyle.TextFont.TxtSize,
					TextColor3 = UIStyle.UIcolors.FullWhite
				})
				table.insert(OpenCloseItems, Hitbox)
				local HitboxStyling = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = UIStyle.UIcolors.FullWhite,
					BorderSizePixel = 0,
					Name = "Styling",
					Parent = Hitbox,
					Position = UDim2.new(0.5, 0, 0, 0),
					Size = UDim2.new(1, -18, 1, 0),
					ZIndex = 23
				})
				AutoApplyBorder(HitboxStyling, Parameters.Name, 21, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH, true)
				table.insert(OpenCloseItems, HitboxStyling)
				local HitboxStylingGradient = UIUtilities:Create("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
						ColorSequenceKeypoint.new(0.84, UIStyle.UIcolors.ColorA),
						ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
					}),
					Rotation = 90,
					Parent = HitboxStyling
				})
				local releaseconnection
				if Parameters.Tooltip then
					Hitbox.MouseEnter:Connect(function()
						UILibrary.CallToolTip(Parameters.Tooltip, Hitbox.AbsolutePosition, Hitbox.AbsolutePosition + Vector2.new(0, 24), Hitbox.AbsoluteSize)
					end)
				end
				Hitbox.MouseButton1Down:Connect(function()
					HitboxStylingGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorA),
						ColorSequenceKeypoint.new(0.84, UIStyle.UIcolors.ColorA),
						ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
					})
					releaseconnection = UserInputService.InputEnded:Connect(function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 then
							realWait()
							HitboxStylingGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
								ColorSequenceKeypoint.new(0.84, UIStyle.UIcolors.ColorA),
								ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
							})
							releaseconnection:Disconnect()
						end
					end)
				end)
				local LastActivation
				local connection
				Hitbox.MouseButton1Down:Connect(function()
					if Parameters.Confirmation then
						if Hitbox.Text ~= "Confirm?" then
							Hitbox.Text = "Confirm?"
							Hitbox.TextColor3 = UIStyle.UIcolors.Accent
							LastActivation = tick()
							connection = RunService.Heartbeat:Connect(function()
								if tick() - LastActivation > 2 then
									Hitbox.Text = Parameters.Name
									Hitbox.TextColor3 = UIStyle.UIcolors.FullWhite
									LastActivation = tick()
									connection:Disconnect()
								end
							end)
						else
							if Parameters.Callback then
								Parameters.Callback()
							end
							Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Button"].Pressed:Fire()
							Hitbox.Text = Parameters.Name
							Hitbox.TextColor3 = UIStyle.UIcolors.FullWhite
							connection:Disconnect()
							LastActivation = tick()
						end
					else
						if Parameters.Callback then
							Parameters.Callback()
						end
						Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Button"].Pressed:Fire()
					end
				end)	
			end

			function UILibrary:CreateTextBox(Parameters)
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name] = {}
				local Proxy = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"] = Parameters.Default
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name].Changed = Signal.new()
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name].Save = function()
					return {["Value"] = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"]}
				end
				local Hitbox = UIUtilities:Create("TextButton", {
					BackgroundTransparency = 1,
					Name = Parameters.Name,
					Parent = SubSections[Parameters.Tab][Parameters.Section],
					Size = UDim2.new(1, 0, 0, 20),
					ZIndex = 24,	
					TextTruncate = Enum.TextTruncate.AtEnd,
					Text = ""
				})
				table.insert(OpenCloseItems, Hitbox)
				local HitboxStyling = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = UIStyle.UIcolors.FullWhite,
					BorderSizePixel = 0,
					Name = "Styling",
					Parent = Hitbox,
					Size = UDim2.new(1, -18, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					ZIndex = 24
				})
				AutoApplyBorder(HitboxStyling, Parameters.Name, 21, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH, true)
				table.insert(OpenCloseItems, HitboxStyling)
				local EntryBox = UIUtilities:Create("TextBox", {
					ClearTextOnFocus = false,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Parent = Hitbox,
					Name = Parameters.Name,
					Position = UDim2.new(0.5, 14, 0.5, 0),
					Size = UDim2.new(1, -14, 1, 0),
					ZIndex = 24,
					Font = UIStyle.TextFont.Font,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextColor3 = UIStyle.UIcolors.FullWhite,
					LineHeight = 1.1,
					TextStrokeColor3 = Color3.new(),
					TextStrokeTransparency = 0.5,
					PlaceholderText = "...",
					Text = Parameters.Default,
					TextSize = UIStyle.TextFont.TxtSize
				})
				table.insert(OpenCloseItems, EntryBox)
				local HitboxStylingGradient = UIUtilities:Create("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, UIStyle.UIcolors.ColorD),
						ColorSequenceKeypoint.new(0.84, UIStyle.UIcolors.ColorA),
						ColorSequenceKeypoint.new(1, UIStyle.UIcolors.ColorA)
					}),
					Rotation = 90,
					Parent = HitboxStyling
				})
				EntryBox.Focused:Connect(function()
					EntryBox.TextColor3 = UIStyle.UIcolors.Accent
				end)
				EntryBox.FocusLost:Connect(function()
					EntryBox.TextColor3 = UIStyle.UIcolors.FullWhite
				end)
				EntryBox:GetPropertyChangedSignal("Text"):Connect(function()
					Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"] = EntryBox.Text
					Menu[Parameters.Tab][Parameters.Section][Parameters.Name].Changed:Fire()
				end)
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name] = setmetatable({}, {
					__index = function(self, i)
						return Proxy[i]
					end,
					__newindex = function(self, i, v)
						if i == "Value" then
							EntryBox.Text = v
						end
						Proxy[i] = v
					end
				})
			end

			function UILibrary:CreateScrollingList(Parameters)
				Menu[Parameters.Tab][Parameters.Section][Parameters.Name] = {}
				local Proxy = Menu[Parameters.Tab][Parameters.Section][Parameters.Name]
				local TotalMenu = {}
				local OffsetThing = 0
				local Bounds = UIUtilities:Create("Frame", {
					BackgroundTransparency = 1,
					Parent = SubSections[Parameters.Tab][Parameters.Section],
					Name = Parameters.Name,
					ZIndex = 26,
					Size = UDim2.new(1, 0, 0, Parameters.Size),
				})
				if Parameters.Name ~= "" then
					local NameTag = UIUtilities:Create("TextLabel", {
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundTransparency = 1,
						Parent = Bounds,
						Size = UDim2.new(1, -24, 0, 18),
						Position = UDim2.new(0.5, 0, 0, -4),
						ZIndex = 26,
						Font = UIStyle.TextFont.Font,
						TextStrokeColor3 = Color3.new(),
						TextStrokeTransparency = 0.5,
						Text = Parameters.Name,
						TextSize = UIStyle.TextFont.TxtSize,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextColor3 = UIStyle.UIcolors.FullWhite
					})
					OffsetThing = 18
					table.insert(OpenCloseItems, NameTag)
				end
				local OtherBounds = UIUtilities:Create("Frame", {
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundTransparency = 1,
					Parent = Bounds,
					Name = "Scrollerbound",
					ZIndex = 26,
					Size = UDim2.new(1, -16, 1, -1 * (OffsetThing - 2)),
					Position = UDim2.new(0.5, 0, 0, OffsetThing - 2)
				})
				AutoApplyAccent(OtherBounds, " e", 26)
				AutoApplyBorder(OtherBounds, " scroll", 26, UIStyle.UIcolors.ColorG, UIStyle.UIcolors.ColorH, true)
				local ScrollableFrame = UIUtilities:Create("ScrollingFrame", {
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundColor3 = UIStyle.UIcolors.ColorA,
					BorderSizePixel = 0,
					Parent = OtherBounds,
					ZIndex = 26,
					ScrollBarThickness = 0,
					CanvasSize = UDim2.new(1, 0, 0, #Parameters.Values * 18),
					Size = UDim2.new(1, 0, 1, -2),
					Position = UDim2.new(0.5, 0, 0, 2) 
				})
				local Organizer = UIUtilities:Create("UIListLayout", {
					Padding = UDim.new(0, 0),
					Parent = ScrollableFrame,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
				})
				table.insert(OpenCloseItems, ScrollableFrame)
				local Selection = UIUtilities:Create("StringValue", {
					Value = "",
					Name = "ScrollingListResult",
					Parent = Bounds
				}) 
				for k, v in next, (Parameters.Values) do
					local Hitbox = UIUtilities:Create("TextButton", {
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundTransparency = 1,
						Name = v,
						Parent = ScrollableFrame,
						Size = UDim2.new(1, -16, 0, 18),
						Position = UDim2.new(0.5, 0, 0, 0),
						ZIndex = 26,	
						Font = UIStyle.TextFont.Font,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextColor3 = UIStyle.UIcolors.FullWhite,
						LineHeight = 1.1,
						TextStrokeColor3 = Color3.new(),
						TextStrokeTransparency = 0.5,
						Text = v,
						TextSize = UIStyle.TextFont.TxtSize,
						TextTruncate = Enum.TextTruncate.AtEnd,
					})
					if k == 1 then
						Hitbox.TextColor3 = UIStyle.UIcolors.Accent
					end
					table.insert(UIAccents, Hitbox)
					table.insert(OpenCloseItems, Hitbox)
					table.insert(TotalMenu, Hitbox)
					Hitbox.MouseButton1Down:Connect(function()
						Selection.Value = Hitbox.Text
						for i, v in next, (TotalMenu) do
							if v.Text == Hitbox.Text then
								v.TextColor3 = UIStyle.UIcolors.Accent
							else
								v.TextColor3 = UIStyle.UIcolors.FullWhite
							end
						end
					end)
				end
				Selection.Changed:Connect(function()	
					for i, v in next, (TotalMenu) do
						if Selection.Value == v.Text then
							v.TextColor3 = UIStyle.UIcolors.Accent
						else
							v.TextColor3 = UIStyle.UIcolors.FullWhite
						end
					end
					Menu[Parameters.Tab][Parameters.Section][Parameters.Name]["Value"] = Selection.Value
				end)

				Menu[Parameters.Tab][Parameters.Section][Parameters.Name] = setmetatable({}, {
					__index = function(self, i)
						return Proxy[i]
					end,
					__newindex = function(self, i, v)
						if i == "Value" then
							Selection.Value = v
						end
						Proxy[i] = v
					end
				})
			end
			-- i went with the alan route, alr had this function from before the ui was even in use so im using this instead of utilizing the __newindex shit im doing
			function UILibrary:OldSaveConfiguration()
				local Configuration = {}
				for i, v in next, (Core:GetDescendants()) do
					if v:IsA("TextButton") then
						if v:FindFirstChildOfClass("BoolValue") then
							local SubConfiguration = {}
							table.insert(SubConfiguration, "NewButton")
							table.insert(SubConfiguration, v.Parent.Name)
							for i2, v2 in next, (v:GetChildren()) do
								if v2:IsA("BoolValue") then
									table.insert(SubConfiguration, v2.Name)
									table.insert(SubConfiguration, v2.Value)
								end
								if v2.Name == "Bind" then
									table.insert(SubConfiguration, "Bind")
									table.insert(SubConfiguration, v2.Text)
									table.insert(SubConfiguration, v2.BindType.Value)
									table.insert(SubConfiguration, v2.RealKey.Value)
								end
								if v2.Name == "ColorP1" then
									table.insert(SubConfiguration, v2.Name)
									table.insert(SubConfiguration, v2.BackgroundColor3.R)
									table.insert(SubConfiguration, v2.BackgroundColor3.G)
									table.insert(SubConfiguration, v2.BackgroundColor3.B)
									table.insert(SubConfiguration, v2.BackgroundTransparency)
								end
								if v2.Name == "ColorP2" then
									table.insert(SubConfiguration, v2.Name)
									table.insert(SubConfiguration, v2.BackgroundColor3.R)
									table.insert(SubConfiguration, v2.BackgroundColor3.G)
									table.insert(SubConfiguration, v2.BackgroundColor3.B)
									table.insert(SubConfiguration, v2.BackgroundTransparency)
								end
							end
							table.insert(Configuration, SubConfiguration)
						end
						if v:FindFirstChildOfClass("TextBox") and v.Parent ~= SubSections["Settings"]["Configurations"] then -- ignore the configs section
							local SubConfiguration = {}
							table.insert(SubConfiguration, "NewTextEntry")
							table.insert(SubConfiguration, v.Parent.Name)
							table.insert(SubConfiguration, v.Name)
							for i2, v2 in next, (v:GetChildren()) do
								if v2:IsA("TextBox") then
									table.insert(SubConfiguration, v2.Text)
								end
							end
							table.insert(Configuration, SubConfiguration)
						end
					elseif v:IsA("Frame") and v.Parent ~= SubSections["Settings"]["Configurations"] then -- ignore the configs section
						if v:FindFirstChildOfClass("NumberValue") then
							local SubConfiguration = {}
							table.insert(SubConfiguration, "NewSlider")
							table.insert(SubConfiguration, v.Parent.Name)
							for i2, v2 in next, (v:GetChildren()) do
								if v2:IsA("NumberValue") then
									table.insert(SubConfiguration, v2.Name)
									table.insert(SubConfiguration, v2.Value)
								end
							end
							table.insert(Configuration, SubConfiguration)
						elseif v:FindFirstChild("Selection") then
							local SubConfiguration = {}
							table.insert(SubConfiguration, "NewDropDown")
							table.insert(SubConfiguration, v.Parent.Name)
							for i2, v2 in next, (v:GetChildren()) do
								if v2.Name == "NAMETAG" then
									table.insert(SubConfiguration, v2.Text)
								end
								if v2.Name == "Selection" then
									table.insert(SubConfiguration, v2.Text)
								end
							end
							table.insert(Configuration, SubConfiguration)
						elseif v:FindFirstChildOfClass("StringValue") then
							local SubConfiguration = {}
							table.insert(SubConfiguration, "NewScrollingList")
							table.insert(SubConfiguration, v.Name)
							table.insert(SubConfiguration, v.Parent.Name)
							table.insert(SubConfiguration, v.ScrollingListResult.Value)
							table.insert(Configuration, SubConfiguration)
						end
					end
				end
				Configuration = HttpService:JSONEncode(Configuration)
				return Configuration
			end

			function UILibrary:OldLoadConfiguration(Tbl)
				local MainTable = HttpService:JSONDecode(Tbl)
				local UIIndex = Core:GetDescendants()
				for i, v in next, (UIIndex) do
					if v:IsA("TextButton") then
						if v:FindFirstChildOfClass("BoolValue") then
							for index, SubConfiguration in next, (MainTable) do
								if SubConfiguration[1] == "NewButton" then
									if v.Parent.Name == SubConfiguration[2] then
										if v.Name == SubConfiguration[3] then
											for ObjectIndex, Object in next, (v:GetChildren()) do
												if Object:IsA("BoolValue") then
													Object.Value = SubConfiguration[4]
												end
												if Object.Name == "Bind" then
													Object.Text = SubConfiguration[6]
													Object:FindFirstChild("BindType").Value = SubConfiguration[7]
													Object:FindFirstChild("RealKey").Value = SubConfiguration[8]
												end
												if Object.Name == "ColorP1" then
													Object.BackgroundColor3 = Color3.new(SubConfiguration[6], SubConfiguration[7], SubConfiguration[8])
													Object.BackgroundTransparency = SubConfiguration[9]
												end
												if Object.Name == "ColorP2" then
													Object.BackgroundColor3 = Color3.new(SubConfiguration[11], SubConfiguration[12], SubConfiguration[13])
													Object.BackgroundTransparency = SubConfiguration[14]
												end
											end
										end
									end
								end
							end
						end
						if v:FindFirstChildOfClass("TextBox") then
							for index, SubConfiguration in next, (MainTable) do
								if SubConfiguration[1] == "NewTextEntry" then
									if v.Parent.Name == SubConfiguration[2] then
										if v.Name == SubConfiguration[3] then
											for ObjectIndex, Object in next, (v:GetChildren()) do
												if Object:IsA("TextBox") then
													Object.Text = SubConfiguration[4]
												end
											end
										end
									end
								end
							end
						end
					elseif v:IsA("Frame") then
						if v:FindFirstChildOfClass("NumberValue") then
							for index, SubConfiguration in next, (MainTable) do
								if SubConfiguration[1] == "NewSlider" then
									if v.Parent.Name == SubConfiguration[2] then
										if v.Name == SubConfiguration[3] then
											for ObjectIndex, Object in next, (v:GetChildren()) do
												if Object:IsA("NumberValue") then
													Object.Value = SubConfiguration[4]
												end
											end
										end
									end
								end
							end
						elseif v:FindFirstChild("Selection") then
							for index, SubConfiguration in next, (MainTable) do
								if SubConfiguration[1] == "NewDropDown" then
									if v.Parent.Name == SubConfiguration[2] then
										if v.Name == SubConfiguration[4] then
											for ObjectIndex, Object in next, (v:GetChildren()) do
												if Object.Name == "Selection" then
													Object.Text = SubConfiguration[3]
												end
											end
										end
									end
								end
							end
						elseif v:FindFirstChildOfClass("StringValue") then
							for index, SubConfiguration in next, (MainTable) do
								if SubConfiguration[1] == "NewScrollingList" then
									if v.Name == SubConfiguration[2] then
										if v.Parent.Name == SubConfiguration[3] then
											for ObjectIndex, Object in next, (v:GetChildren()) do
												if Object.Name == "ScrollingListResult" then
													Object.Value = SubConfiguration[4]
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		
			function UILibrary:SaveConfiguration()
				local Configuration = {}

				for tab, section in next, Menu do
					if SubSections[tab] then
						Configuration[tab] = {}
						for panel, elements in next, section do
							Configuration[tab][panel] = {}
							if panel ~= "Configurations" then
								for element, data in next, elements do
									if data.Save then
										Configuration[tab][panel][element] = {}
										for key, value in next, data.Save() do
											Configuration[tab][panel][element][key] = value
										end
									end
								end
							end
						end
					end
				end

				return HttpService:JSONEncode(Configuration)
			end

			function UILibrary:LoadConfiguration(Tbl)
				local MainTable = HttpService:JSONDecode(Tbl)

				for tab, section in next, MainTable do
					if Menu[tab] then
						for panel, elements in next, section do
							if Menu[tab][panel] then
								for element, data in next, elements do
									if Menu[tab][panel][element] then
										for k, v in next, data do
											if type(v) == "table" and k ~= "Value" then
												for k2, v2 in next, v do
													if type(v2) == "table" and not v2.r then
														if k2 == "Animation Selection" then
															Menu[tab][panel][element][k][k2]["Value"] = v2["Value"]
														elseif k2 == "Animations" then
															local animdata = v2
															for anim, data in next, animdata do
																for name, values in next, data do
																	if animdata[anim][name]["Value"] then
																		Menu[tab][panel][element][k][k2][anim][name]["Value"] = animdata[anim][name]["Value"]
																	elseif animdata[anim][name]["Color"] then
																		Menu[tab][panel][element][k][k2][anim][name]["Color"] = {r = animdata[anim][name]["Color"].r, g = animdata[anim][name]["Color"].g, b = animdata[anim][name]["Color"].b}
																		if animdata[anim][name]["Transparency"] then
																			Menu[tab][panel][element][k][k2][anim][name]["Transparency"] = animdata[anim][name]["Transparency"]
																		end
																	end
																end
															end
														end
													else
														-- minor error
														Menu[tab][panel][element][k][k2] = v2
													end
												end
											else
												Menu[tab][panel][element][k] = v
											end
										end
									end
								end
							end
						end
					end
				end
			end

			-- UI Open/Close animation
			local tweentime = 0
			local OpenTweens = {}
			local CloseTweens = {}
			local OpenObjects = {}
			local bullshit = {} -- yes i FUCKING had to do this bullshit

			local tweenstyle = Enum.EasingStyle.Linear
			local easingdir = Enum.EasingDirection.InOut

			--integor was here
			local backgroundTransShit = Instance.new("NumberValue")

			backgroundTransShit.Value = 0

			local imageEnabledShit = Instance.new("BoolValue");
			imageEnabledShit.Value = true

			local textTransShit = Instance.new("NumberValue")
			textTransShit.Value = 0

			local fadedconnections = {}

			local function UpdateTweens()
				for i = 1, #fadedconnections do
					local conn = fadedconnections[i]
					conn:Disconnect()
				end
				table.clear(bullshit)
				for i = 1, #OpenCloseItems do
					local val = OpenCloseItems[i]
					if val:IsA("Frame") or val:IsA("ScrollingFrame") then
						fadedconnections[1 + #fadedconnections] = backgroundTransShit.Changed:Connect(function()
							val.BackgroundTransparency = backgroundTransShit.Value
						end)
					elseif val:IsA("ImageButton") then
						if val.Name == "Alpha" then
							fadedconnections[1 + #fadedconnections] = backgroundTransShit.Changed:Connect(function()
								val.ImageTransparency = backgroundTransShit.Value
							end)
						end
						if val.Name:match("ColorP") then
							if val:FindFirstChild("actual") then
								table.insert(bullshit, val)
							else
								fadedconnections[1 + #fadedconnections] = backgroundTransShit.Changed:Connect(function()
									val.BackgroundTransparency = backgroundTransShit.Value
								end)
							end
						end
					elseif val:IsA("TextLabel") or val:IsA("TextButton") or val:IsA("TextBox") then
						fadedconnections[1 + #fadedconnections] = textTransShit.Changed:Connect(function()
							val.TextTransparency = textTransShit.Value
							val.TextStrokeTransparency = textTransShit.Value
						end)
					end
				end
			end

			UILibrary.updateFade = UpdateTweens
			
			function OpenUI()
				fading = true
				easingdir = Enum.EasingDirection.Out
				MainContainer.Visible = true
				TweenService:Create(backgroundTransShit, TweenInfo.new(tweentime, tweenstyle, easingdir), {Value = 0}):Play()
				TweenService:Create(textTransShit, TweenInfo.new(tweentime, tweenstyle, easingdir), {Value = 0}):Play()
				for i, v in next, (bullshit) do
					TweenService:Create(v, TweenInfo.new(tweentime, tweenstyle, easingdir), {BackgroundTransparency = v.actual.Value}):Play()
				end
				realWait(tweentime)
				imageEnabledShit.Value = true
				task.wait()
				Menu.closed = false
				fading = false
			end
			function CloseUI()
				fading = true
				easingdir = Enum.EasingDirection.In
				imageEnabledShit.Value = false
				TweenService:Create(backgroundTransShit, TweenInfo.new(tweentime, tweenstyle, easingdir), {Value = 1}):Play()
				TweenService:Create(textTransShit, TweenInfo.new(tweentime, tweenstyle, easingdir), {Value = 1}):Play()
				for i, v in next, (bullshit) do
					TweenService:Create(v, TweenInfo.new(tweentime, tweenstyle, easingdir), {BackgroundTransparency = 1}):Play()
				end
				realWait(tweentime)
				MainContainer.Visible = false
				task.wait()
				Menu.closed = true
				fading = false
			end
			CloseUI()
			realWait(0.2)
			tweentime = 0.25
			RunService.Heartbeat:Connect(function()
				if MainContainer.Visible == true then 
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
				else
					UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
				end
			end)
				--cursor
				-- Create the triangle cursor
				local CursorTriangle = Drawing.new("Triangle")
				CursorTriangle.Filled = true
				CursorTriangle.Color = UIStyle.UIcolors.Accent
				CursorTriangle.Thickness = 1
				CursorTriangle.Visible = MainContainer.Visible
local radius = 10
			function UpdateCursor()
				if MainContainer.Visible then
					local mouse = UserInputService:GetMouseLocation()
					local x, y = mouse.X, mouse.Y

					local p1 = Vector2.new(x, y - radius)
					local p2 = Vector2.new(x - radius * 0.866, y + radius / 2)
					local p3 = Vector2.new(x + radius * 0.866, y + radius / 2)

					CursorTriangle.PointA = p1
					CursorTriangle.PointB = p2
					CursorTriangle.PointC = p3
					CursorTriangle.Visible = true
				else
					CursorTriangle.Visible = false
				end
			end
			function UILibrary:Initialize()
			MainContainer:GetPropertyChangedSignal("Visible"):Connect(UpdateCursor)

			UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					UpdateCursor()
				end
			end)
				local gui = MainContainer

				local dragging
				local dragInput
				local dragStart
				local startPos

				local function update(input)
					local delta = input.Position - dragStart
					gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				end

				gui.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
						dragStart = input.Position
						startPos = gui.Position
						
						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								dragging = false
							end
						end)
					end
				end)

				gui.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
						dragInput = input
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if input == dragInput and dragging then
						update(input)
					end
				end)	
				UpdateTweens()
				-- retarded
				task.wait()
				OpenUI()
				UserInputService.InputBegan:Connect(function(Input, gameProcessedEvent)
					if Input.UserInputType == Enum.UserInputType.Keyboard then
						if Input.KeyCode == Enum.KeyCode.Insert or Input.KeyCode == Enum.KeyCode.Delete or Input.KeyCode == Enum.KeyCode.Backquote then
							if MainContainer.BackgroundTransparency == 0 and MainContainer.Visible == true then
								CloseUI()
							else
								if MainContainer.BackgroundTransparency ~= 0 and MainContainer.Visible ~= true then
									OpenUI()
								end
							end
						end 
					end
				end)
			end
		end

		Library = {["UI"] = UILibrary, ["Menu"] = Menu, ["Accents"] = UIAccents, ["Subsections"] = SubSections, ["KeyBindList"] = KeyBindList, ["Signal"] = Signal, ["Utilities"] = UIUtilities}
	end

	env.Hack = Library
	local spring = loadstring(game:HttpGet("https://raw.githubusercontent.com/Quenty/NevermoreEngine/5a429e871d54646ba54011c18321e77afa76d657/Modules/Shared/Physics/Spring.lua"))()

	local Menu = Library.Menu
	local UILibrary = Library.UI	

	local particleImages = {["Star"] = "rbxassetid://5946093983", ["Lightning"] = "rbxassetid://882168791", ["Flash"] = "rbxassetid://6673021984", ["Ring"] = "rbxassetid://6900421398"}
	local particleImagesDropDown = {}
	for i, v in next, particleImages do
		particleImagesDropDown[1 + #particleImagesDropDown] = i
	end

	local forcefieldAnimations = {["Off"] = "rbxassetid://0",["Web"] = "rbxassetid://301464986",["Scan"] = "rbxassetid://5843010904",["Swirl"] = "rbxassetid://8133639623",["Checkerboard"] = "rbxassetid://5790215150",["Christmas"] = "rbxassetid://6853532738",["Player"] = "rbxassetid://4494641460",["Shield"] = "rbxassetid://361073795",["Dots"] = "rbxassetid://5830615971",["Bubbles"] = "rbxassetid://1461576423",["Matrix"] = "rbxassetid://10713189068",["Groove"] = "rbxassetid://10785404176",["Cloud"] = "rbxassetid://5176277457",["Sky"] = "rbxassetid://1494603972",["Smudge"] = "rbxassetid://6096634060",["Scrapes"] = "rbxassetid://6248583558",["Galaxy"] = "rbxassetid://1120738433",["Stars"] = "rbxassetid://598201818",["Rainbow"] = "rbxassetid://10037165803", ["Triangular"]="rbxassetid://4504368932", ["Wall"] = "rbxassetid://4271279"}
	local forcefieldAnimationsDropDown = {}
	for i, v in next, forcefieldAnimations do
		forcefieldAnimationsDropDown[1 + #forcefieldAnimationsDropDown] = i
	end

	local Themes = {
		default = {
			FullWhite = Color3.fromRGB(255, 255, 255),
			ColorA = Color3.fromRGB(36, 36, 36),
			ColorB = Color3.fromRGB(0, 0, 0),
			ColorC = Color3.fromRGB(20, 20, 20),
			ColorD = Color3.fromRGB(50, 50, 50),
			ColorE = Color3.fromRGB(30, 30, 30),
			ColorF = Color3.fromRGB(20, 20, 20),
			ColorG = Color3.fromRGB(10, 10, 10),
			ColorH = Color3.fromRGB(32, 32, 32),
			ColorI = Color3.fromRGB(40, 40, 40),
			Accent = Color3.fromRGB(127, 72, 163)
		},
		kfcsenze = { -- i was kinda bored lol
			FullWhite = Color3.fromRGB(220, 220, 220),
			ColorA = Color3.fromRGB(4, 1, 11),
			ColorB = Color3.fromRGB(28, 28, 28),
			ColorC = Color3.fromRGB(15, 15, 15),
			ColorD = Color3.fromRGB(32, 32, 32),
			ColorE = Color3.fromRGB(10, 10, 10),
			ColorF = Color3.fromRGB(20, 20, 20),
			ColorG = Color3.fromRGB(8, 2, 22),
			ColorH = Color3.fromRGB(16, 4, 44),
			ColorI = Color3.fromRGB(28, 28, 28),
			Accent = Color3.fromRGB(163, 254, 226)
		},
	}

	local MenuParameters = {
		Tabs = {
			"Legit",
			"Rage",
			"ESP",
			"Visuals", 
			"Misc",
			"Settings"	
		},
		CheatName = "pastexpectional",
		UserType = "fixed" ,
		UIcolors = Themes.default,
		TextFont = {
			CheatTextSize = 14,
			TabTextSize = 14,
			TxtSize = 14,
			Font = Enum.Font.RobotoMono
		},
	HeaderFont = {
		WatermarkTxtSize = 14.3,
		Font = Enum.Font.Arial
	},
}

	UILibrary:Start(MenuParameters)

	local function getconfigs()
		local cfgs = {}
		for i, v in next, (listfiles("bloxsense/bloxsense_configs")) do
			cfgs[1 + #cfgs] = string.sub(v, 29, 256):sub(0, -5) -- remove the "bloxsense/bloxsense_configs" and the ".cfg"
		end
		return cfgs
	end

	-- ANCHOR pasted menu setup
	do
		-- Legit
		UILibrary:CreateSubSection("Legit", "AimAssist", {"Aim Assist"}, false, 1, 0)
		UILibrary:CreateSubSection("Legit", "Triggerbot", {"Trigger Bot"}, true, 0.5, 0)
		UILibrary:CreateSubSection("Legit", "SilentAim", {"Bullet Redirection"}, true, 0.5, -8)
		
		-- Rage
		UILibrary:CreateSubSection("Rage", "Aimbot", {"Aimbot", "Settings", "Tracking"}, false, 0.5, 0) 
		UILibrary:CreateSubSection("Rage", "ExtraMisc", {"Sniper", "Auto", "Other"}, false, 0.5, -8)
		UILibrary:CreateSubSection("Rage", "HvH", {"HvH", "Anti Aim", "Fake Lag", "Hitpart"}, true, 1, 0)

		-- ESP
		UILibrary:CreateSubSection("ESP", "Enemy ESP", {"Enemy ESP", "Team ESP"}, false, 1, 0) 
		UILibrary:CreateSubSection("ESP", "DroppedESP", {"ESP Settings"}, true, 0.6, 0)
		UILibrary:CreateSubSection("ESP", "DroppedESP", {"Dropped ESP"}, true, 0.4, -8)

		-- Visuals
		UILibrary:CreateSubSection("Visuals", "ESP", {"Local", "Fumo", "Player"}, false, 1, 0)
		UILibrary:CreateSubSection("Visuals", "CamViewModel", {"Camera", "Viewmodel", "Crosshair", "Particle"}, true, 0.44, 0)
		UILibrary:CreateSubSection("Visuals", "RandomESP", {"World", "Bloom", "Atmosphere"}, true, 0.27, -8)
		UILibrary:CreateSubSection("Visuals", "RandomESP2", {"Misc", "Extra", "Bullets", "Hits", "FOV"}, true, 0.29, -8)
		
		-- Misc
		UILibrary:CreateSubSection("Misc", "MovementTweaks", {"Movement", "Tweaks"}, false, 0.5)
		UILibrary:CreateSubSection("Misc", "WeaponModifiers", {"Weapon Modifications"}, false, 0.5, -8)
		UILibrary:CreateSubSection("Misc", "ExtraMisc", {"Extra", "Exploits"}, true, 1, 0)

		-- Settings
		UILibrary:CreateSubSection("Settings", "CheatSettings", {"Menu Settings"}, false, 0.32, 0)
		UILibrary:CreateSubSection("Settings", "CheatSettings", {"Extra"}, false, 0.21, -8)
		UILibrary:CreateSubSection("Settings", "Configurations", {"Configurations"}, false, 0.47, -8)
		UILibrary:CreateSubSection("Settings", "Scripts", {"Scripts"}, true, 1, 0)

		UILibrary:CreateButton({Name = "Enabled", Tab = "Legit", Section = "Aim Assist", Tooltip = "Master switch for assisting your aim"})
		UILibrary:CreateSlider({Name = "Aimbot FOV", Tab = "Legit", Section = "Aim Assist", MinimumNumber = 0, MaximumNumber = 180, Suffix = "°", Tooltip = "Controls how close from the center of your screen an enemy must be before the aim assist considers aiming at them"})
		UILibrary:CreateSlider({Name = "Speed", Tab = "Legit", Section = "Aim Assist", MinimumNumber = 0, MaximumNumber = 100, Suffix = "%", Tooltip = "Controls how fast the aim assist will move your mouse to the target"})
		UILibrary:CreateDropdown({Name = "Speed Type", Tab = "Legit", Section = "Aim Assist", Values = {"Linear", "Exponential"}, Tooltip = "Controls how the speed changes with remaining aiming distance"})
		UILibrary:CreateSlider({Name = "Randomization", Tab = "Legit", Section = "Aim Assist", MinimumNumber = 0, MaximumNumber = 25, MinimumText = "Off", Tooltip = "Randomises where the aim assist will aim at"})
		UILibrary:CreateSlider({Name = "Deadzone FOV", Tab = "Legit", Section = "Aim Assist", MinimumNumber = 0, MaximumNumber = 50, Suffix = "°", MinimumText = "Off", Tooltip = "Controls how close from the center of your screen an enemy must be before the aim assist stops aiming at them"})
		UILibrary:CreateSlider({Name = "Target Switch Delay", Tab = "Legit", Section = "Aim Assist", MinimumNumber = 0, MaximumNumber = 2000, Suffix = "ms", Tooltip = "Controls how fast the aim assist will consider a new target after it has stopped aiming at the previous target"})
		UILibrary:CreateSlider({Name = "Maximum Lock-On Time", Tab = "Legit", Section = "Aim Assist", MinimumNumber = 0, MaximumNumber = 8000, Suffix = "ms", MaximumText = "Inf", Tooltip = "Controls how long the aim assist will aim at a target before re-considering what to aim at"})
		UILibrary:CreateSlider({Name = "Accuracy", Tab = "Legit", Section = "Aim Assist", MinimumNumber = 0, MaximumNumber = 100, Suffix = "%", Tooltip = "Controls how often the Hitscan Priority will be considered first"})
		UILibrary:CreateDropdown({Name = "Aimbot Key", Tab = "Legit", Section = "Aim Assist", Values = {"Mouse 1", "Mouse 2", "Always"}, Tooltip = "Controls when the aim assist will aim at a target, note it is always searching for a target"})
		UILibrary:CreateDropdown({Name = "Hitscan Priority", Tab = "Legit", Section = "Aim Assist", Values = {"Head", "Body", "Closest"}, Tooltip = "Controls what the aim assist will consider first on an enemy"})
		UILibrary:CreateDropdown({Name = "Hitscan Points", Tab = "Legit", Section = "Aim Assist", Values = {"Head", "Body", "Arms", "Legs"}, MultiChoice = true, Tooltip = "Controls what the aim assist will consider on an enemy at all"})
		UILibrary:CreateSlider({Name = "Recoil Compesation Pitch", Tab = "Legit", Section = "Aim Assist", MinimumNumber = 0, MaximumNumber = 120, Suffix = "%", Tooltip = "Controls how hard the aim assist tries to compensate for recoil vertically"})
		UILibrary:CreateSlider({Name = "Recoil Compesation Yaw", Tab = "Legit", Section = "Aim Assist", MinimumNumber = 0, MaximumNumber = 120, Suffix = "%", Tooltip = "Controls how hard the aim assist tries to compensate for recoil horizontally"})
		UILibrary:CreateButton({Name = "Aim Through Flash", Tab = "Legit", Section = "Aim Assist", Tooltip = "Controls if the aim assist will continue aiming whilst flashed"})
		UILibrary:CreateButton({Name = "Aim Through Smoke", Tab = "Legit", Section = "Aim Assist", Tooltip = "Controls if the aim assist will consider enemies obstructed by smoke"})
		UILibrary:CreateButton({Name = "Aim At Backtrack", Tab = "Legit", Section = "Aim Assist", Tooltip = "Controls if the aim assist will consider aiming at backtracked parts"})
		UILibrary:CreateButton({Name = "Require Mouse Movement", Tab = "Legit", Section = "Aim Assist", "Controls whether or not the aim assist requires mouse movement to aim"})

		UILibrary:CreateButton({Name = "Enabled", Tab = "Legit", Section = "Trigger Bot", KeyBind = "None", Tooltip = "Master switch for automatically clicking when an enemy intersects your crosshair"})
		UILibrary:CreateSlider({Name = "Reaction Time", Tab = "Legit", Section = "Trigger Bot", MinimumText = "Instant", Suffix = "ms", MinimumNumber = 0, MaximumNumber = 500, Tooltip = "Controls how long a hitbox must be tracked for before being automatically clicked on"})
		UILibrary:CreateDropdown({Name = "Trigger Bot Hitboxes", Tab = "Legit", Section = "Trigger Bot", Values = {"Head", "Body", "Arms", "Legs"}, MultiChoice = true, Tooltip = "Controls what hitboxes the trigger bot will consider clicking on at all"})
		UILibrary:CreateButton({Name = "Auto Wall", Tab = "Legit", Section = "Trigger Bot", Tooltip = "Controls if the trigger bot automatically clicks through walls if the enemy can be wallbanged"})
		UILibrary:CreateSlider({Name = "Auto Wall Minimum Damage", Tab = "Legit", Section = "Trigger Bot", Suffix = "hp", MinimumNumber = 0, MaximumNumber = 105, Tooltip = "Controls how much damage must be done through a wallbang to automatically click"})
		UILibrary:CreateButton({Name = "Magnet Triggerbot", Tab = "Legit", Section = "Trigger Bot", Tooltip = "Master switch for aim assisting with custom fov and speed on activation"})
		UILibrary:CreateSlider({Name = "Magnet FOV", Tab = "Legit", Section = "Trigger Bot", MinimumNumber = 0, MaximumNumber = 90, Suffix = "°", Tooltip = "Controls the custom fov to be used for the aim assist on activation of the magnet triggerbot"})
		UILibrary:CreateSlider({Name = "Magnet Speed", Tab = "Legit", Section = "Trigger Bot", MinimumNumber = 0, MaximumNumber = 100, Suffix = "%", Tooltip = "Controls the custom speed to be used for the aim assist on activation of the magnet triggerbot"})
		UILibrary:CreateDropdown({Name = "Magnet Priority", Tab = "Legit", Section = "Trigger Bot", Values = {"Head", "Body"}, MultiChoice = false, Tooltip = "Controls the custom Hitscan priority to be used for the aim assist on activation of the magnet triggerbot. Note this will override accuracy to 100% on activation"})

		UILibrary:CreateButton({Name = "Silent Aim", Tab = "Legit", Section = "Bullet Redirection", Tooltip = "Master switch for redirecting bullets at a target"})
		UILibrary:CreateSlider({Name = "Silent Aim FOV", Tab = "Legit", Section = "Bullet Redirection", MinimumNumber = 0, MaximumNumber = 180, Suffix = "°", Tooltip = "Controls how close from the center of your screen an enemy must be before the silent aim considers aiming at them"})
		UILibrary:CreateSlider({Name = "Hit Chance", Tab = "Legit", Section = "Bullet Redirection", MinimumNumber = 0, MaximumNumber = 100, Suffix = "%", Tooltip = "Controls the chance of a bullet being redirected at a target at all"})
		UILibrary:CreateSlider({Name = "Accuracy", Tab = "Legit", Section = "Bullet Redirection", MinimumNumber = 0, MaximumNumber = 100, Suffix = "%", Tooltip = "Controls how often the Hitscan Priority is considered first"})
		UILibrary:CreateDropdown({Name = "Hitscan Priority", Tab = "Legit", Section = "Bullet Redirection", Values = {"Head", "Body", "Closest"}, Tooltip = "Controls what the silent aim will consider first on an enemy"})
		UILibrary:CreateDropdown({Name = "Hitscan Points", Tab = "Legit", Section = "Bullet Redirection", Values = {"Head", "Body", "Arms", "Legs"}, MultiChoice = true, Tooltip = "Controls what the silent aim will consider on an enemy at all"})
		UILibrary:CreateButton({Name = "Aim Through Flash", Tab = "Legit", Section = "Bullet Redirection", Tooltip = "Controls if the silent aim will continue aiming whilst flashed"})
		UILibrary:CreateButton({Name = "Aim Through Smoke", Tab = "Legit", Section = "Bullet Redirection", Tooltip = "Controls if the silent aim will consider enemies obstructed by smoke"})
		UILibrary:CreateButton({Name = "Auto Wall", Tab = "Legit", Section = "Bullet Redirection", Tooltip = "Controls if enemies behind walls will be considered if they may be wallbanged"})
		--UILibrary:CreateButton({Name = "Aim At Backtrack", Tab = "Legit", Section = "Bullet Redirection"})

		UILibrary:CreateButton({Name = "Enabled", Tab = "Rage", Section = "Aimbot", KeyBind = "None", Tooltip = "Master switch for aimbot"})
		UILibrary:CreateButton({Name = "Silent Aim", Tab = "Rage", Section = "Aimbot", Tooltip = "Controls if the aimbot is locally visible"})
		UILibrary:CreateButton({Name = "Rotate Viewmodel", Tab = "Rage", Section = "Aimbot", Tooltip = "Controls if your viewmodel will point to where the aimbot is shooting"})
		UILibrary:CreateSlider({Name = "Aimbot FOV", Tab = "Rage", Section = "Aimbot", Suffix = "°", MinimumNumber = 0, MaximumNumber = 180, DefaultValue = 180, MaximumText = "Ignored", Tooltip = "Controls how close from the center of your screen an enemy must be before the aimbot considers aiming at them"})
		UILibrary:CreateButton({Name = "Auto Wall", Tab = "Rage", Section = "Aimbot", Tooltip = "Controls if the aimbot considers people through walls that may be wallbanged"})
		UILibrary:CreateButton({Name = "Auto Shoot", Tab = "Rage", Section = "Aimbot", Tooltip = "Controls if the aimbot shoots automatically once a target is found"})
		UILibrary:CreateDropdown({Name = "Auto Shoot Type", Tab = "Rage", Section = "Aimbot", Values = {"Standard", "Aura"}, Tooltip = "Controls the type of Auto Shoot. Aura rapidly kill all targets at the same time regardless of obstruction."})

		UILibrary:CreateButton({Name = "Hit Logs", Tab = "Rage", Section = "Settings", Tooltip = "Logs Who You Shot At (ragebot only)"})
		UILibrary:CreateSlider({Name = "Hit Logs Delay", Tab = "Rage", Section = "Settings", MinimumNumber = 0, MaximumNumber = 10, Suffix = " .sec", Tooltip = "yeh yeh yeh"})

		UILibrary:CreateDropdown({Name = "Double Tap", Tab = "Rage", Section = "Aimbot", Values = {"Off", "Fast", "Faster", "Fastest"}, Tooltip = "Controls if the aimbot may shoot two bullets in quick succession"})
		UILibrary:CreateButton({Name = "Knife Bot", Tab = "Rage", Section = "Aimbot", KeyBind = "None", Tooltip = "Controls if the aimbot will aim with the knife"})
		UILibrary:CreateSlider({Name = "Knife Bot Range", Tab = "Rage", Section = "Aimbot", MinimumNumber = 1, MaximumNumber = 256, Suffix = " st.", Tooltip = "Controls how close an enemy must be to you before being considered for being knifed"})
		UILibrary:CreateDropdown({Name = "Knife Bot Type", Tab = "Rage", Section = "Aimbot", Values = {"Single Aura", "Multi Aura"}, Tooltip = "Controls the type of knife bot. Multi Aura rapidly stabs all targets at the same time within the radius regardless of obstruction."})

		UILibrary:CreateSlider({Name = "Maximum Hitscanning Points", Tab = "Rage", Section = "HvH", Suffix = "", MinimumNumber = 8, MaximumNumber = 64, Tooltip = "Controls the maximum number of scans per frame the aimbot is allowed to do. Turn this down for better performance."})
		UILibrary:CreateSlider({Name = "Hitscan Modifier", Tab = "Rage", Section = "HvH", Suffix = "", MinimumNumber = 10, MaximumNumber = 100, Tooltip = "insert tooltip here"})
		UILibrary:CreateButton({Name = "Autowall Hitscan", Tab = "Rage", Section = "HvH", Tooltip = "Controls if the aimbot scans around your player for multiple places to shoot from other than your player. Not recommended for typical hack versus hack."})
		UILibrary:CreateDropdown({Name = "Hitscan Points", Tab = "Rage", Section = "HvH", Values = {"Up", "Down", "Left", "Right", "Forward", "Backward", "Towards"}, MultiChoice = true, Tooltip = "Controls the directions that Autowall Hitscan will attempt to shoot from."})
		UILibrary:CreateButton({Name = "Resolve Positions", Tab = "Rage", Section = "HvH", Tooltip = "Controls if the aimbot makes an attempt to resolve certain desync exploits. Disable if you are having issues with shooting nowhere near the enemy."})
		UILibrary:CreateButton({Name = "Wait For Round Start", Tab = "Rage", Section = "HvH", Tooltip = "Controls if the aimbot waits for round start before finding targets."})
		UILibrary:CreateSlider({Name = "Ping Compensation", Tab = "Rage", Section = "HvH", Suffix = "ms", MinimumNumber = 0, MaximumNumber = 100, Tooltip = " Lower value for high ping, higher value for low ping. Example: 200ms ping = 10, 100ms ping = 20."})
		UILibrary:CreateButton({Name = "Auto Peek", Tab = "Rage", Section = "HvH", KeyBind = "None", Tooltip = "Hitscans from in front of your camera and teleports you to it if a target is found from it."})
		UILibrary:CreateButton({Name = "Force Headshots", Tab = "Rage", Section = "HvH", Tooltip = "Controls if the aimbot will make every shot it fires a headshot regardless of the hitbox it really hit."})
		UILibrary:CreateButton({Name = "Prediction", Tab = "Rage", Section = "HvH", Tooltip = "Controls if the aimbot shoots ahead of the enemy in the direction of their movement to increase the chance of the shot hitting."})
		UILibrary:CreateDropdown({Name = "Prediction Type", Tab = "Rage", Section = "HvH", Values = {"Lag Compensation", "Exploit"}, Tooltip = "Controls the type of prediction the aimbot will use. Exploit hits every time and is highly recommended for hack versus hack."})
		UILibrary:CreateSlider({Name = "Multiplier", Tab = "Rage", Section = "HvH", Suffix = "ms", MinimumNumber = 0, MaximumNumber = 2000, MinimumText = "Automatic", Tooltip = "Manually overrides how far ahead the prediction is"})

		UILibrary:CreateButton({Name = "Back Tracking", Tab = "Rage", Section = "Tracking", Tooltip = "Standalone. Saves previous enemy positions and allows you to hit them."})
		UILibrary:CreateSlider({Name = "Back Tracking Time", Tab = "Rage", Section = "Tracking", Suffix = "ms", MinimumNumber = 0, MaximumNumber = 4000, Tooltip = "Controls how far back in time the enemy positions are saved."})
		UILibrary:CreateDropdown({Name = "Back Tracking Points", Tab = "Rage", Section = "Tracking", Values = {"Head", "Chest", "Pelvis", "Arms", "Legs", "Feet"}, MultiChoice = true, "Controls which backtrack hitboxes the aimbot will consider. Note that these hitboxes must also be selected in the weapon config."})
		UILibrary:CreateButton({Name = "Extrapolation", Tab = "Rage", Section = "Tracking", Tooltip = "Controls if the aimbot extrapolates where the enemy is on their own screen and allows you to predict a shot such that the enemy runs into it. Useful for preventing people from peeking you successfully."})
        UILibrary:CreateButton({Name = "Ignore walls", Tab = "Rage", Section = "Tracking"})
        UILibrary:CreateSlider({Name = "Steps to Scan", Tab = "Rage", Section = "Tracking", Suffix = " ticks", MinimumNumber = 0, MaximumNumber = 100})
		UILibrary:CreateSlider({Name = "Extrapolation Tuning", Tab = "Rage", Section = "Tracking", Suffix = "ms", MinimumNumber = 0, MaximumNumber = 4000, Tooltip = "Controls how much extra time ahead an enemy is extrapolated."})
		UILibrary:CreateDropdown({Name = "Extrapolation Points", Tab = "Rage", Section = "Tracking", Values = {"Head", "Chest", "Pelvis", "Arms", "Legs", "Feet"}, MultiChoice = true, Tooltip = "Controls which extrapolated hitboxes the aimbot will consider. Note that these hitboxes must also be selected in the weapon config."})
		UILibrary:CreateButton({Name = "Multi Point", Tab = "Rage", Section = "HvH", Tooltip = "Controls if the aimbot considers spots on the hitbox outside of the direct center."})
		UILibrary:CreateSlider({Name = "Multi Point Scale", Tab = "Rage", Section = "HvH", MinimumNumber = 1, MaximumNumber = 8000, Suffix = "%", Tooltip = "Controls up to how far from the direct center of the hitbox the aimbot is allowed to consider shooting at."})
		UILibrary:CreateDropdown({Name = "Multi Point Points", Tab = "Rage", Section = "HvH", Values = {"Head", "Chest", "Pelvis", "Arms", "Legs", "Feet"}, MultiChoice = true, Tooltip = "Controls which multipoint hitboxes the aimbot will consider. Note that these hitboxes must also be selected in the weapon config."})

		UILibrary:CreateButton({Name = "Loop Kill", Tab = "Rage", Section = "Hitpart", Tooltip = "loop keel"})
		UILibrary:CreateDropdown({Name = "Player in Focus", Tab = "Rage", Section = "Hitpart", Values = {}})
		UILibrary:CreateButton({Name = "Wait For Round Start", Tab = "Rage", Section = "Hitpart", Tooltip = "Controls if the aimbot waits for round start before finding targets."})
	local function getPlayerNames()
		local tbl = {}
		for _, player in next, game.Players:GetPlayers() do
			if player ~= game.Players.LocalPlayer then
				table.insert(tbl, player.Name)
			end
		end
		return tbl
	end

	-- Function to update the dropdown values
	local function updateDropdown()
		local playerNames = getPlayerNames()
		if #playerNames == 0 then
			Menu["Rage"]["Hitpart"]["Player in Focus"].UpdateValues({"No Players To Focus"})
			Menu["Rage"]["Hitpart"]["Player in Focus"]["Value"] = "No Players To Focus"
		else
			Menu["Rage"]["Hitpart"]["Player in Focus"].UpdateValues(playerNames)
			-- Retain the old value if it exists in the updated list
			local oldValue = Menu["Rage"]["Hitpart"]["Player in Focus"]["Value"]
			if table.find(playerNames, oldValue) then
				Menu["Rage"]["Hitpart"]["Player in Focus"]["Value"] = oldValue
			else
				Menu["Rage"]["Hitpart"]["Player in Focus"]["Value"] = playerNames[1] -- Set to first player if old value is not found
			end
		end
	end

	-- Initial dropdown update
	updateDropdown()

	-- When a player is added or removed, update the dropdown values
	game.Players.PlayerAdded:Connect(function()
		task.wait()  -- Slight delay to ensure everything is ready
		updateDropdown()
	end)

	game.Players.PlayerRemoving:Connect(function()
		task.wait()  -- Slight delay to ensure everything is ready
		updateDropdown()
	end)

		for i, v in next, ({"Auto Sniper", "AWP", "Scout", "Rifle", "SMG", "LMG", "Shotgun", "Heavy Pistol", "Light Pistol"}) do
			local Section = "Other"
			if i <= 3 then
				Section = "Sniper"
			elseif i <= 6 then
				Section = "Auto"
			end
			UILibrary:CreateDropdown({Name = v .. " Hitboxes", Tab = "Rage", Section = Section, Values = {"Head", "Chest", "Pelvis", "Arms", "Legs", "Feet"}, MultiChoice = true, Tooltip = "The hitboxes that will be targeted when this weapon is equipped"})
			UILibrary:CreateSlider({Name = v .. " Minimum Damage", Tab = "Rage", Section = Section, MinimumNumber = 0, MaximumNumber = 115, Suffix = "hp", Tooltip = "The minimum damage that a shot must do before the aimbot considers aiming at them when this weapon is equipped"})
		end


		UILibrary:CreateDropdown({Name = "Pitch", Tab = "Rage", Section = "Anti Aim", Values = {"Off", "Default", "Up", "Zero", "Down", "Upside Down", "Roll Forward", "Roll Backward", "Random", "Bob", "Glitch"}, Tooltip = "Overrides your server pitch view angle."})
		UILibrary:CreateDropdown({Name = "Yaw Base", Tab = "Rage", Section = "Anti Aim", Values = {"Local view", "At targets"}, Tooltip = "Controls where the Yaw will be in relation to."})
		UILibrary:CreateDropdown({Name = "Yaw", Tab = "Rage", Section = "Anti Aim", Values = {"Off", "Forward", "Backward", "Spin", "Glitch Spin", "Stutter Spin"}, Tooltip = "Overrides your server yaw view angle."})
		UILibrary:CreateDropdown({Name = "Yaw Jitter", Tab = "Rage", Section = "Anti Aim", Values = {"Off", "Random", "Offset", "Center"}, Tooltip = "Adds a jitter angle to the yaw."})
		UILibrary:CreateDropdown({Name = "Freestanding", Tab = "Rage", Section = "Anti Aim", Values = {"Off", "Default"}, Tooltip = "Hides your head behind cover where possible, requires Yaw."})
		--UILibrary:CreateDropdown({Name = "Fake angle", Tab = "Rage", Section = "Anti Aim", Values = {"Off", "Default", "Random", "Opposite", "Spin", "Jitter"}})
		UILibrary:CreateSlider({Name = "Yaw angle", Tab = "Rage", Section = "Anti Aim", Suffix = "°", MinimumNumber = -180, MaximumNumber = 180, Tooltip = "Fine tunes yaw angle."})
		UILibrary:CreateSlider({Name = "Yaw Jitter angle", Tab = "Rage", Section = "Anti Aim", Suffix = "°", MinimumNumber = -180, MaximumNumber = 180, Tooltip = "Fine tunes yaw jitter angle."})
		UILibrary:CreateButton({Name = "Hide in Floor", Tab = "Rage", Section = "Anti Aim", Tooltip = "Lowers your body to be inside the floor."})
		UILibrary:CreateButton({Name = "Pitch Extension", Tab = "Rage", Section = "Anti Aim", Tooltip = "Amplifies pitch angle."})
		UILibrary:CreateButton({Name = "Slide Walk", Tab = "Rage", Section = "Anti Aim", Tooltip = "Overrides walking animations with empty ones."})

		UILibrary:CreateButton({Name = "Prevent Replication", Tab = "Rage", Section = "Fake Lag", KeyBind = "None", Tooltip = "Freezes all your server movement, making you appear stuck in place."})
		UILibrary:CreateButton({Name = "Enabled", Tab = "Rage", Section = "Fake Lag", Tooltip = "Master switch for fake lag."})
		UILibrary:CreateSlider({Name = "Replication Delay", Tab = "Rage", Section = "Fake Lag", MinimumNumber = 0, MaximumNumber = 2048, Suffix = "ms", Tooltip = "Delays your server movment"})
		UILibrary:CreateButton({Name = "Custom Triggers", Tab = "Rage", Section = "Fake Lag", Tooltip = "Controls if the fake lag is only working while certain conditions are met."})
		UILibrary:CreateDropdown({Name = "Amount", Tab = "Rage", Section = "Fake Lag", Values = {"On Moving", "On Peek"}, MultiChoice = true, Tooltip = "Optional conditions for activating fake lag."})
		UILibrary:CreateSlider({Name = "Limit", Tab = "Rage", Section = "Fake Lag", MinimumNumber = 0, MaximumNumber = 256, Tooltip = "Controls how long your server movement is frozen until it is refreshed. Each 64 ticks adds one second."})

		UILibrary:CreateButton({Name = "Enabled", Tab = "ESP", Section = "Team ESP"})
		UILibrary:CreateButton({Name = "Name", Tab = "ESP", Section = "Team ESP", Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateButton({Name = "Box", Tab = "ESP", Section = "Team ESP", Colors = {Color3.new(0, 1, 0)}})
		UILibrary:CreateButton({Name = "Filled Box", Tab = "ESP", Section = "Team ESP", Colors = {Color3.new(0, 1, 0)}, Transparency = {220/255}})
		UILibrary:CreateButton({Name = "Health Bar", Tab = "ESP", Section = "Team ESP", Colors = {Color3.new(0.4, 1, 0.4), Color3.new(1, 0.4, 0.4)}})
		UILibrary:CreateButton({Name = "Gradient Health Bar", Tab = "ESP", Section = "Team ESP"})
		UILibrary:CreateButton({Name = "Health Number", Tab = "ESP", Section = "Team ESP"}) --Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateButton({Name = "Held Weapon", Tab = "ESP", Section = "Team ESP", Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateButton({Name = "Held Weapon Icon", Tab = "ESP", Section = "Team ESP", Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateButton({Name = "Distance", Tab = "ESP", Section = "Team ESP", Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateButton({Name = "Armor", Tab = "ESP", Section = "Team ESP", Colors = {Color3.fromRGB(94, 150, 255)}})
		UILibrary:CreateButton({Name = "Money", Tab = "ESP", Section = "Team ESP", Colors = {Color3.new(0, 1, 0)}})
		UILibrary:CreateButton({Name = "Bomb", Tab = "ESP", Section = "Team ESP", Colors = {Color3.fromRGB(186, 252, 3)}})
		UILibrary:CreateButton({Name = "Hostage", Tab = "ESP", Section = "Team ESP", Colors = {Color3.fromRGB(232, 151, 70)}})
		UILibrary:CreateButton({Name = "Chams", Tab = "ESP", Section = "Team ESP", Colors = {Color3.fromRGB(0, 100, 0), Color3.fromRGB(0, 255, 0)}, Transparency = {155/255, 0/255}})
		UILibrary:CreateButton({Name = "Skeleton", Tab = "ESP", Section = "Team ESP", Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateButton({Name = "Snap Lines", Tab = "ESP", Section = "Team ESP", Colors = {Color3.new(1, 1, 1)}, Transparency = {0/255}})

		UILibrary:CreateButton({Name = "Enabled", Tab = "ESP", Section = "Enemy ESP"})
		UILibrary:CreateButton({Name = "Name", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateButton({Name = "Box", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(1, 0, 0)}})
		UILibrary:CreateButton({Name = "Filled Box", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(1, 0, 0)}, Transparency = {220/255}})
		UILibrary:CreateButton({Name = "Health Bar", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(0.4, 1, 0.4), Color3.new(1, 0.4, 0.4)}})
		UILibrary:CreateButton({Name = "Gradient Health Bar", Tab = "ESP", Section = "Enemy ESP"})
		UILibrary:CreateButton({Name = "Health Number", Tab = "ESP", Section = "Enemy ESP"})
		UILibrary:CreateButton({Name = "Held Weapon", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateButton({Name = "Held Weapon Icon", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateButton({Name = "Distance", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateButton({Name = "Armor", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.fromRGB(94, 150, 255)}})
		UILibrary:CreateButton({Name = "Money", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(0, 1, 0)}})
		UILibrary:CreateButton({Name = "Bomb", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.fromRGB(186, 252, 3)}})
		UILibrary:CreateButton({Name = "Hostage", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.fromRGB(232, 151, 70)}})
		UILibrary:CreateButton({Name = "Chams", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.fromRGB(100, 0, 0), Color3.fromRGB(255, 0, 0)}, Transparency = {155/255, 0/255}})
		UILibrary:CreateButton({Name = "Skeleton", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateButton({Name = "Snap Lines", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(1, 1, 1)}, Transparency = {0/255}})

		UILibrary:CreateButton({Name = "Fake", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(1, 0, 0)}})
		--UILibrary:CreateButton({Name = "Lag Compensation", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(1, 0, 0)}})
		if not (executor == "ScriptWare" and platform == "Mac") then
			UILibrary:CreateButton({Name = "Out of View Arrows", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(1, 1, 1)}})
			UILibrary:CreateSlider({Name = "Arrow Distance", Tab = "ESP", Section = "Enemy ESP", MinimumNumber = 10, MaximumNumber = 100, Suffix = "%"})
			UILibrary:CreateSlider({Name = "Arrow Size", Tab = "ESP", Section = "Enemy ESP", MinimumNumber = 4, MaximumNumber = 30, Suffix = ""})
			UILibrary:CreateButton({Name = "Dynamic Arrow Size", Tab = "ESP", Section = "Enemy ESP"})
		end
		UILibrary:CreateButton({Name = "Show Resolved Position", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateButton({Name = "Show Backtrack Position", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.new(0, 0, 0)}, Transparency = {200/255}})
		UILibrary:CreateButton({Name = "Show Extrapolation Position", Tab = "ESP", Section = "Enemy ESP", Colors = {Color3.fromRGB(113, 232, 70)}, Transparency = {0/255}})

		UILibrary:CreateButton({Name = "Arm Chams", Tab = "Visuals", Section = "Local", Colors = {Color3.fromRGB(106, 136, 213), Color3.fromRGB(181, 179, 253)}, Transparency = {0/255, 0/255}})
		UILibrary:CreateSlider({Name = "Arm Reflectivity", Tab = "Visuals", Section = "Local", MinimumNumber = 0, MaximumNumber = 240})
		UILibrary:CreateSlider({Name = "Sleeve Reflectivity", Tab = "Visuals", Section = "Local", MinimumNumber = 0, MaximumNumber = 240})
		UILibrary:CreateDropdown({Name = "Arm Cham Material", Tab = "Visuals", Section = "Local", Values = {"Ghost", "Flat", "Custom", "Reflective", "Metallic"}})
		UILibrary:CreateDropdown({Name = "Arm Cham Animation", Tab = "Visuals", Section = "Local", Values = forcefieldAnimationsDropDown})
		UILibrary:CreateButton({Name = "Weapon Chams", Tab = "Visuals", Section = "Local", Colors = {Color3.fromRGB(106, 136, 213)}, Transparency = {0/255}})
		UILibrary:CreateSlider({Name = "Weapon Reflectivity", Tab = "Visuals", Section = "Local", MinimumNumber = 0, MaximumNumber = 240})
		UILibrary:CreateDropdown({Name = "Weapon Cham Material", Tab = "Visuals", Section = "Local", Values = {"Ghost", "Flat", "Custom", "Reflective", "Metallic"}})
		UILibrary:CreateDropdown({Name = "Weapon Cham Animation", Tab = "Visuals", Section = "Local", Values = forcefieldAnimationsDropDown})
		UILibrary:CreateButton({Name = "Local Chams", Tab = "Visuals", Section = "Local", Colors = {Color3.fromRGB(106, 136, 213)}, Transparency = {0/255}})
		UILibrary:CreateDropdown({Name = "Local Cham Material", Tab = "Visuals", Section = "Local", Values = {"Ghost", "Flat", "Custom", "Reflective", "Metallic"}})
		UILibrary:CreateDropdown({Name = "Local Cham Animation", Tab = "Visuals", Section = "Local", Values = forcefieldAnimationsDropDown})


		UILibrary:CreateSlider({Name = "Max HP Visibility Cap", Tab = "ESP", Section = "ESP Settings", MaximumNumber = 100, MinimumNumber = 0, Suffix = "hp", DefaultValue = 98})
		UILibrary:CreateSlider({Name = "Text Size", Tab = "ESP", Section = "ESP Settings", MaximumNumber = 24, MinimumNumber = 8, DefaultValue = 13})
		UILibrary:CreateDropdown({Name = "Text Case", Tab = "ESP", Section = "ESP Settings", Values = {"Normal", "UPPERCASE", "lowercase"}})
		UILibrary:CreateDropdown({Name = "Text Font", Tab = "ESP", Section = "ESP Settings", Values = {"Plex", "Monospace", "UI", "System"}})
		UILibrary:CreateSlider({Name = "Flag Text Size", Tab = "ESP", Section = "ESP Settings", MaximumNumber = 24, MinimumNumber = 8, DefaultValue = 13})
		UILibrary:CreateDropdown({Name = "Flag Text Case", Tab = "ESP", Section = "ESP Settings", Values = {"Normal", "UPPERCASE", "lowercase"}})
		UILibrary:CreateDropdown({Name = "Flag Text Font", Tab = "ESP", Section = "ESP Settings", Values = {"Plex", "Monospace", "UI", "System"}})
		UILibrary:CreateButton({Name = "Highlight Aimbot Target", Tab = "ESP", Section = "ESP Settings", Colors = {Color3.new(1, 0, 0)}})

		UILibrary:CreateButton({Name = "Override FOV", Tab = "Visuals", Section = "Camera"})
		UILibrary:CreateSlider({Name = "FOV", Tab = "Visuals", Section = "Camera", MinimumNumber = 10, MaximumNumber = 120, Suffix = "°", DefaultValue = 80})
		UILibrary:CreateButton({Name = "Disable Scope FOV", Tab = "Visuals", Section = "Camera"})
		UILibrary:CreateButton({Name = "Disable Scope Border", Tab = "Visuals", Section = "Camera"})
		UILibrary:CreateButton({Name = "Remove Camera Recoil", Tab = "Visuals", Section = "Camera"})
		UILibrary:CreateButton({Name = "Disable Weapon Swaying", Tab = "Visuals", Section = "Camera"})

		UILibrary:CreateButton({Name = "Hit Marker", Tab = "Visuals", Section = "Camera", Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateDropdown({Name = "Hit Marker Type", Tab = "Visuals", Section = "Camera", Values = {"2D", "3D"}})
		UILibrary:CreateButton({Name = "Third Person", Tab = "Visuals", Section = "Camera", KeyBind = "None"})
		UILibrary:CreateSlider({Name = "Third Person Distance", Tab = "Visuals", Section = "Camera", MinimumNumber = 15, MaximumNumber = 150, DefaultValue = 90})

		UILibrary:CreateButton({Name = "Offset Viewmodel", Tab = "Visuals", Section = "Viewmodel"})
		UILibrary:CreateSlider({Name = "X Axis", Tab = "Visuals", Section = "Viewmodel", MinimumNumber = -270, MaximumNumber = 270, DefaultValue = 0})
		UILibrary:CreateSlider({Name = "Y Axis", Tab = "Visuals", Section = "Viewmodel", MinimumNumber = -270, MaximumNumber = 270, DefaultValue = 0})
		UILibrary:CreateSlider({Name = "Z Axis", Tab = "Visuals", Section = "Viewmodel", MinimumNumber = -270, MaximumNumber = 270, DefaultValue = 0})
		UILibrary:CreateSlider({Name = "Pitch", Tab = "Visuals", Section = "Viewmodel", MinimumNumber = -180, MaximumNumber = 180, Suffix = "°"})
		UILibrary:CreateSlider({Name = "Yaw", Tab = "Visuals", Section = "Viewmodel", MinimumNumber = -180, MaximumNumber = 180, Suffix = "°"})
		UILibrary:CreateSlider({Name = "Roll", Tab = "Visuals", Section = "Viewmodel", MinimumNumber = -180, MaximumNumber = 180, Suffix = "°"})

		UILibrary:CreateButton({Name = "Enable Fumo", Tab = "Visuals", Section = "Fumo"})
		UILibrary:CreateButton({Name = "Spin Itself", Tab = "Visuals", Section = "Fumo"})
		UILibrary:CreateButton({Name = "Highlight", Tab = "Visuals", Section = "Fumo", Colors = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(128, 128, 128)}})
		UILibrary:CreateSlider({Name = "Fill Transparency", Tab = "Visuals", Section = "Fumo", MinimumNumber = 0, MaximumNumber = 100, DefaultValue = 50})
		UILibrary:CreateSlider({Name = "Outline Transparency", Tab = "Visuals", Section = "Fumo", MinimumNumber = 0, MaximumNumber = 100, DefaultValue = 50})
		UILibrary:CreateSlider({Name = "Spin Speed", Tab = "Visuals", Section = "Fumo", MinimumNumber = 0, MaximumNumber = 360, DefaultValue = 100})
		UILibrary:CreateSlider({Name = "Orbit Speed", Tab = "Visuals", Section = "Fumo", MinimumNumber = 0, MaximumNumber = 360, DefaultValue = 100})
		UILibrary:CreateSlider({Name = "Distance", Tab = "Visuals", Section = "Fumo", MinimumNumber = 0, MaximumNumber = 10, DefaultValue = 6})
		UILibrary:CreateSlider({Name = "Height", Tab = "Visuals", Section = "Fumo", MinimumNumber = 0, MaximumNumber = 10, DefaultValue = 0})
		local function ChangeCharacter(model)
			local character = game.Players.LocalPlayer.Character
			if not character then return end

			-- Remove all current accessories from the character
			for _, item in ipairs(character:GetChildren()) do
				if item:IsA("Accessory") then
					item:Destroy()
				end
			end

			-- Match parts by name and update color and transparency
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					local newPart = model:FindFirstChild(part.Name, true)
					if newPart and newPart:IsA("BasePart") then
						part.Color = newPart.Color
						part.Transparency = newPart.Transparency

						-- Save original appearance data
						local colorVal = Instance.new("Color3Value")
						colorVal.Name = "OriginalColor"
						colorVal.Value = part.Color
						colorVal.Parent = part

						local materialVal = Instance.new("StringValue")
						materialVal.Name = "OriginalMaterial"
						materialVal.Value = tostring(part.Material)
						materialVal.Parent = part
					end
				end
			end

			-- Copy head decal (face) from model
			local head = character:FindFirstChild("Head")
			local newHead = model:FindFirstChild("Head")
			if head and newHead then
				local headDecal = head:FindFirstChildOfClass("Decal")
				local newHeadDecal = newHead:FindFirstChildOfClass("Decal")
				if headDecal and newHeadDecal then
					headDecal.Texture = newHeadDecal.Texture
				end
			end

			-- Helper function to copy clothing
			local function copyClothing(className)
				local old = character:FindFirstChildOfClass(className)
				if old then old:Destroy() end

				local new = model:FindFirstChildOfClass(className)
				if new then
					local clone = new:Clone()
					clone.Parent = character

					local value = Instance.new("StringValue")
					value.Name = "OriginalTexture"
					value.Value = clone[className .. "Template"]
					value.Parent = clone
				end
			end

			copyClothing("Shirt")
			copyClothing("Pants")

			-- Copy accessories
			for _, accessory in ipairs(model:GetChildren()) do
				if accessory:IsA("Accessory") then
					local cloned = accessory:Clone()
					local handle = cloned:FindFirstChild("Handle")

					if handle then
						for _, weld in ipairs(handle:GetChildren()) do
							if weld:IsA("Weld") and weld.Part1 then
								local match = character:FindFirstChild(weld.Part1.Name)
								if match then
									weld.Part1 = match
								end
							end
						end

						local colorVal = Instance.new("Color3Value")
						colorVal.Name = "OriginalColor"
						colorVal.Value = handle.Color
						colorVal.Parent = handle

						local materialVal = Instance.new("StringValue")
						materialVal.Name = "OriginalMaterial"
						materialVal.Value = tostring(handle.Material)
						materialVal.Parent = handle
					end

					cloned.Parent = character
				end
			end
		end

		local function ChangeCharacterToUserIdAvatar(userId)
			local model = game.Players:CreateHumanoidModelFromUserId(userId)

			-- Remove visual effects that shouldn't transfer
			for _, descendant in ipairs(model:GetDescendants()) do
				if descendant:IsA("ParticleEmitter") or
				descendant:IsA("Trail") or
				descendant:IsA("Beam") or
				descendant:IsA("Fire") or
				descendant:IsA("Sparkles") or
				descendant:IsA("Smoke") or
				descendant:IsA("Highlight") then
					descendant:Destroy()
				end
			end

			local fullOutline = model:FindFirstChild("FullOutline")
			if fullOutline then
				fullOutline:Destroy()
			end

			-- Prepare model
			model.Name = "TargetCharacter"
			model:WaitForChild("Humanoid")

			ChangeCharacter(model)

			model:Destroy()
		end

		UILibrary:CreateButton({Name = "Name Changer", Tab = "Visuals", Section = "Player"})
		UILibrary:CreateTextBox({Name = "Change To", Tab = "Visuals", Section = "Player", Default = "pastexpectional User"})
		-- Start character changer loop
task.spawn(function()
	while true do
		task.wait(0.5)

		local enabled = Menu["Visuals"]["Player"]["Character Changer"]["Toggle"]["Enabled"]
		local player = game:GetService("Players").LocalPlayer
		local char = player.Character
		local hasGun = char and char:FindFirstChild("Gun")

		if enabled and hasGun then
			local userId = Menu["Visuals"]["Player"]["Id"]["Value"]
			ChangeCharacterToUserIdAvatar(userId)
	end
end
end)

-- Manual button (still usable)
UILibrary:CreateButton({Name = "Character Changer", Tab = "Visuals",Section = "Player",Callback = function()
		local enabled = Menu["Visuals"]["Player"]["Character Changer"]["Toggle"]["Enabled"]
		local player = game:GetService("Players").LocalPlayer
		local char = player.Character
		local hasGun = char and char:FindFirstChild("Gun")

		if enabled and hasGun then
			local userId = Menu["Visuals"]["Player"]["Id"]["Value"]
			ChangeCharacterToUserIdAvatar(userId)
		end
	end
})

-- TextBox input
UILibrary:CreateTextBox({Name = "Id", Tab = "Visuals", Section = "Player",Default = "167954881", Callback = function(Value)
		local enabled = Menu["Visuals"]["Player"]["Character Changer"]["Toggle"]["Enabled"]
		local player = game:GetService("Players").LocalPlayer
		local char = player.Character
		local hasGun = char and char:FindFirstChild("Gun")

		if enabled and hasGun then
			ChangeCharacterToUserIdAvatar(Value)
		end
	end
})


		UILibrary:CreateButton({Name = "Custom Crosshair", Tab = "Visuals", Section = "Crosshair", Colors = {Color3.fromRGB(255, 255, 255)}, Transparency = {0/255}})
		UILibrary:CreateSlider({Name = "Crosshair Width", Tab = "Visuals", Section = "Crosshair", MinimumNumber = 0, MaximumNumber = 100, DefaultValue = 10})
		UILibrary:CreateSlider({Name = "Crosshair Length", Tab = "Visuals", Section = "Crosshair", MinimumNumber = 0, MaximumNumber = 100, DefaultValue = 10})
		UILibrary:CreateSlider({Name = "Crosshair Width Gap", Tab = "Visuals", Section = "Crosshair", MinimumNumber = 0, MaximumNumber = 100, DefaultValue = 5})
		UILibrary:CreateSlider({Name = "Crosshair Length Gap", Tab = "Visuals", Section = "Crosshair", MinimumNumber = 0, MaximumNumber = 100, DefaultValue = 5})
		UILibrary:CreateSlider({Name = "Crosshair Thickness", Tab = "Visuals", Section = "Crosshair", MinimumNumber = 1, MaximumNumber = 100, DefaultValue = 2})
		UILibrary:CreateSlider({Name = "Crosshair Rotation", Tab = "Visuals", Section = "Crosshair", MinimumNumber = 0, MaximumNumber = 360})
		UILibrary:CreateSlider({Name = "Crosshair Rotation Speed", Tab = "Visuals", Section = "Crosshair", MinimumNumber = -360, MaximumNumber = 360, DefaultValue = 0})

		UILibrary:CreateButton({Name = "Enabled", Tab = "Visuals", Section = "Particle", Colors = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 0, 0)}, Transparency = {0/255, 0/255}})
		UILibrary:CreateButton({Name = "Locked", Tab = "Visuals", Section = "Particle"})
		UILibrary:CreateDropdown({Name = "Texture", Tab = "Visuals", Section = "Particle", Values = particleImagesDropDown})
		UILibrary:CreateSlider({Name = "Speed", Tab = "Visuals", Section = "Particle", MinimumNumber = 1, MaximumNumber = 100, DefaultValue = 50})
		UILibrary:CreateSlider({Name = "Rate", Tab = "Visuals", Section = "Particle", MinimumNumber = 1, MaximumNumber = 100, DefaultValue = 5})
		UILibrary:CreateSlider({Name = "Life Time", Tab = "Visuals", Section = "Particle", MinimumNumber = 1, MaximumNumber = 10, DefaultValue = 2})
		UILibrary:CreateSlider({Name = "Rotation Speed", Tab = "Visuals", Section = "Particle", MinimumNumber = -360, MaximumNumber = 360, DefaultValue = 0})
		UILibrary:CreateSlider({Name = "Spread Angle", Tab = "Visuals", Section = "Particle", MinimumNumber = 0, MaximumNumber = 100, DefaultValue = 0})

		UILibrary:CreateButton({Name = "Ambience", Tab = "Visuals", Section = "World", Colors = {Color3.fromRGB(117, 76, 236), Color3.fromRGB(117, 76, 236)}})
		UILibrary:CreateButton({Name = "Force Time", Tab = "Visuals", Section = "World"})
		UILibrary:CreateSlider({Name = "Custom Time", Tab = "Visuals", Section = "World", MinimumNumber = 0, MaximumNumber = 24})
		UILibrary:CreateButton({Name = "Custom Saturation", Tab = "Visuals", Section = "World", Colors = {Color3.new(1, 1, 1)}})
		UILibrary:CreateSlider({Name = "Saturation Density", Tab = "Visuals", Section = "World", MinimumNumber = 0, MaximumNumber = 100, Suffix = "%"})
		UILibrary:CreateButton({Name = "Custom Bloom", Tab = "Visuals", Section = "Bloom"})
		UILibrary:CreateSlider({Name = "Bloom Intensity", Tab = "Visuals", Section = "Bloom", MinimumNumber = 0, MaximumNumber = 100, Suffix = "%"})
		UILibrary:CreateSlider({Name = "Bloom Size", Tab = "Visuals", Section = "Bloom", MinimumNumber = 0, MaximumNumber = 100, Suffix = "%"})
		UILibrary:CreateSlider({Name = "Bloom Threshold", Tab = "Visuals", Section = "Bloom", MinimumNumber = 0, MaximumNumber = 100, Suffix = "%"})
		UILibrary:CreateButton({Name = "Custom Atmosphere", Tab = "Visuals", Section = "Atmosphere", Colors = {Color3.fromRGB(50, 50, 50), Color3.fromRGB(30, 30, 30)}})
		UILibrary:CreateSlider({Name = "Density", Tab = "Visuals", Section = "Atmosphere", MinimumNumber = 0, MaximumNumber = 100, DefaultValue = 50})
		UILibrary:CreateSlider({Name = "Glare", Tab = "Visuals", Section = "Atmosphere", MinimumNumber = 0, MaximumNumber = 100, DefaultValue = 50})
		UILibrary:CreateSlider({Name = "Haze", Tab = "Visuals", Section = "Atmosphere", MinimumNumber = 0, MaximumNumber = 100, DefaultValue = 20})


		UILibrary:CreateButton({Name = "Custom Brightness", Tab = "Visuals", Section = "Misc"})
		UILibrary:CreateDropdown({Name = "Brightness Mode", Tab = "Visuals", Section = "Misc", Values = {"Nightmode", "Fullbright"}})
		UILibrary:CreateButton({Name = "Custom Skybox", Tab = "Visuals", Section = "Misc"})
		UILibrary:CreateDropdown({Name = "Skybox choice", Tab = "Visuals", Section = "Misc", Values = {"Cloudy Skies", "Bob's Skybox", "Space", "Nebula", "Vivid Skies"}})

		UILibrary:CreateButton({Name = "Ragdoll Chams", Tab = "Visuals", Section = "Extra", Colors = {Color3.new(0.282353, 0.427451, 0.737255)}, Transparency = {0/255}})
		UILibrary:CreateDropdown({Name = "Ragdoll Cham Material", Tab = "Visuals", Section = "Extra", Values = {"Ghost", "Flat", "Custom", "Reflective", "Metallic"}})
		UILibrary:CreateButton({Name = "Remove Flash", Tab = "Visuals", Section = "Extra"})
		UILibrary:CreateButton({Name = "Remove Smoke", Tab = "Visuals", Section = "Extra"})

		UILibrary:CreateButton({Name = "Hit Chams", Tab = "Visuals", Section = "Hits", Colors = {Color3.new(0.729412, 0.572549, 1)}, Transparency = {0/255}})
		UILibrary:CreateSlider({Name = "Hit Cham Life Time", Tab = "Visuals", Section = "Hits", MinimumNumber = 1, MaximumNumber = 10, Suffix = " s"})
		UILibrary:CreateSlider({Name = "Hit Cham Fade Time", Tab = "Visuals", Section = "Hits", MinimumNumber = 1, MaximumNumber = 10, Suffix = " s"})
		UILibrary:CreateDropdown({Name = "Hit Cham Material", Tab = "Visuals", Section = "Hits", Values = {"Ghost", "Flat", "Custom", "Reflective", "Metallic"}})

		UILibrary:CreateButton({Name = "Bullet Tracers", Tab = "Visuals", Section = "Bullets", Colors = {Color3.fromRGB(201, 69, 54)}, Transparency = {0/255}})
		UILibrary:CreateSlider({Name = "Bullet Tracer Life Time", Tab = "Visuals", Section = "Bullets", MinimumNumber = 1, MaximumNumber = 10, Suffix = " s"})
		UILibrary:CreateSlider({Name = "Bullet Tracer Fade Time", Tab = "Visuals", Section = "Bullets", MinimumNumber = 1, MaximumNumber = 10, Suffix = " s"})
		--UILibrary:CreateDropdown({Name = "Bullet Tracer Origin", Tab = "Visuals", Section = "Bullets", Values = {"Automatic", "Barrel", "Camera"}})

		UILibrary:CreateButton({Name = "Aim Assist FOV", Tab = "Visuals", Section = "FOV", Colors = {Color3.fromRGB(127, 72, 163)}, Transparency = {0/255}})
		UILibrary:CreateButton({Name = "Aim Assist Deadzone FOV", Tab = "Visuals", Section = "FOV", Colors = {Color3.fromRGB(50, 50, 50)}, Transparency = {0/255}})
		UILibrary:CreateButton({Name = "Magnet Triggerbot FOV", Tab = "Visuals", Section = "FOV", Colors = {Color3.fromRGB(85, 147, 201)}, Transparency = {0/255}})
		UILibrary:CreateButton({Name = "Bullet Redirection FOV", Tab = "Visuals", Section = "FOV", Colors = {Color3.fromRGB(163, 72, 127)}, Transparency = {0/255}})
		UILibrary:CreateButton({Name = "Aimbot FOV", Tab = "Visuals", Section = "FOV", Colors = {Color3.fromRGB(255, 210, 0)}, Transparency = {0/255}})

		UILibrary:CreateButton({Name = "Weapon Names", Tab = "ESP", Section = "Dropped ESP", Colors = {Color3.fromRGB(255, 125, 255)}})
		UILibrary:CreateButton({Name = "Weapon Ammo", Tab = "ESP", Section = "Dropped ESP", Colors = {Color3.fromRGB(61, 168, 235)}})
		UILibrary:CreateButton({Name = "Bomb Warning", Tab = "ESP", Section = "Dropped ESP", Colors = {Color3.fromRGB(77, 89, 250), Color3.fromRGB(131, 68, 219)}})
		--UILibrary:CreateButton({Name = "Grenade Warning", Tab = "ESP", Section = "Dropped ESP", Colors = {Color3.fromRGB(77, 89, 250), Color3.fromRGB(131, 68, 219)}})
		--UILibrary:CreateButton({Name = "Bomb", Tab = "ESP", Section = "Dropped ESP", Colors = {Color3.fromRGB(61, 145, 235)}})
		--UILibrary:CreateButton({Name = "Hostage", Tab = "ESP", Section = "Dropped ESP", Colors = {Color3.fromRGB(240, 161, 77)}})

		UILibrary:CreateButton({Name = "Fly", Tab = "Misc", Section = "Movement", KeyBind = "None"})
		UILibrary:CreateSlider({Name = "Fly Speed", Tab = "Misc", Section = "Movement", MinimumNumber = 0, MaximumNumber = 400, Suffix = " st/sec"})
		UILibrary:CreateButton({Name = "Automatic Jump", Tab = "Misc", Section = "Movement"})
		UILibrary:CreateButton({Name = "Speed", Tab = "Misc", Section = "Movement", KeyBind = "None"})
		UILibrary:CreateSlider({Name = "Speed Factor", Tab = "Misc", Section = "Movement", MinimumNumber = 0, MaximumNumber = 400, Suffix = " st/sec"})
		UILibrary:CreateDropdown({Name = "Speed Type", Tab = "Misc", Section = "Movement", Values = {"Velocity", "CFrame"}})
		UILibrary:CreateButton({Name = "Circle Strafe", Tab = "Misc", Section = "Movement", KeyBind = "None"})
		UILibrary:CreateSlider({Name = "Circle Strafe Radius", Tab = "Misc", Section = "Movement", MinimumNumber = 1, MaximumNumber = 100, Suffix = " st"})

		UILibrary:CreateButton({Name = "Custom Gravity", Tab = "Misc", Section = "Tweaks"})
		UILibrary:CreateSlider({Name = "Gravity Level", Tab = "Misc", Section = "Tweaks", MinimumNumber = 0, MaximumNumber = 600})
		UILibrary:CreateButton({Name = "Remove Crouch Cooldown", Tab = "Misc", Section = "Tweaks"})
		UILibrary:CreateButton({Name = "Bypass Fall Damage", Tab = "Misc", Section = "Tweaks"})
		UILibrary:CreateButton({Name = "No Clip", Tab = "Misc", Section = "Tweaks", KeyBind = "None"})
		UILibrary:CreateButton({Name = "Edge Jump", Tab = "Misc", Section = "Tweaks", KeyBind = "None"})

		UILibrary:CreateButton({Name = "Enabled", Tab = "Misc", Section = "Weapon Modifications"})
		UILibrary:CreateSlider({Name = "Fire Rate Scale", Tab = "Misc", Section = "Weapon Modifications", MinimumNumber = 100, MaximumNumber = 1200, Suffix = "%", MaximumText = "Rapid"})
		UILibrary:CreateSlider({Name = "Recoil Scale", Tab = "Misc", Section = "Weapon Modifications", MinimumNumber = 0, MaximumNumber = 100, Suffix = "%"})
		UILibrary:CreateButton({Name = "Instant Equip", Tab = "Misc", Section = "Weapon Modifications"})
		UILibrary:CreateButton({Name = "Instant Reload", Tab = "Misc", Section = "Weapon Modifications"})
		UILibrary:CreateButton({Name = "Infinite Ammo", Tab = "Misc", Section = "Weapon Modifications"})
		UILibrary:CreateButton({Name = "No Spread", Tab = "Misc", Section = "Weapon Modifications"})
		UILibrary:CreateButton({Name = "Fully Automatic", Tab = "Misc", Section = "Weapon Modifications"})
		UILibrary:CreateButton({Name = "Infinity Damage", Tab = "Misc", Section = "Weapon Modifications"})

		UILibrary:CreateButton({Name = "Kill All", Tab = "Misc", Section = "Extra"})
		UILibrary:CreateDropdown({Name = "Kill All Type", Tab = "Misc", Section = "Extra", Values = {"Rage", "HvH"}})
		UILibrary:CreateButton({Name = "Uncensor Chat", Tab = "Misc", Section = "Extra"})
		UILibrary:CreateButton({Name = "Infinite Money", Tab = "Misc", Section = "Extra"})
		UILibrary:CreateButton({Name = "Bypass Molotov Damage", Tab = "Misc", Section = "Extra"})
		UILibrary:CreateButton({Name = "Auto Buy Bot", Tab = "Misc", Section = "Extra"})
		local allweapons = {}
		if game:GetService("ReplicatedStorage"):FindFirstChild("Weapons") then
			for i, v in next, (game:GetService("ReplicatedStorage").Weapons:GetChildren()) do
				if (v:FindFirstChild("Primary") or v:FindFirstChild("Secondary")) and not v:FindFirstChild("Melee") then
					allweapons[1 + #allweapons] = v.Name
				end
			end
		end
		UILibrary:CreateDropdown({Name = "Buy Bot Primary", Tab = "Misc", Section = "Extra", Values = allweapons})
		UILibrary:CreateDropdown({Name = "Buy Bot Secondary", Tab = "Misc", Section = "Extra", Values = allweapons})
		UILibrary:CreateTap({Name = "Buy Weapons", Tab = "Misc", Section = "Extra", Confirmation = true})
		UILibrary:CreateButton({Name = "Hit Sound", Tab = "Misc", Section = "Extra"})
		UILibrary:CreateSlider({Name = "Hit Sound Volume", Tab = "Misc", Section = "Extra", MinimumNumber = 0, MaximumNumber = 100, Suffix = "%"})
		UILibrary:CreateTextBox({Name = "Hit Sound ID", Tab = "Misc", Section = "Extra", Default = "5447626464"})
		UILibrary:CreateButton({Name = "Kill Sound", Tab = "Misc", Section = "Extra"})
		UILibrary:CreateSlider({Name = "Kill Sound Volume", Tab = "Misc", Section = "Extra", MinimumNumber = 0, MaximumNumber = 100, Suffix = "%"})
		UILibrary:CreateTextBox({Name = "Kill Sound ID", Tab = "Misc", Section = "Extra", Default = ""})
		UILibrary:CreateButton({Name = "Kill Say", Tab = "Misc", Section = "Extra"})
		UILibrary:CreateDropdown({Name = "Kill Say Mode", Tab = "Misc", Section = "Extra", Values = {"Text Box", "File"}})
		UILibrary:CreateTextBox({Name = "Kill Say Message", Tab = "Misc", Section = "Extra", Default = "sit nn dog"})
		UILibrary:CreateButton({Name = "Remove Bullet Holes", Tab = "Misc", Section = "Extra"})
		UILibrary:CreateButton({Name = "Remove Hit Effects", Tab = "Misc", Section = "Extra"})
		--UILibrary:CreateButton({Name = "Remove Kill Bricks", Tab = "Misc", Section = "Extra"})
		--UILibrary:CreateButton({Name = "Auto Martyrdom", Tab = "Misc", Section = "Extra"})
		UILibrary:CreateTap({Name = "Join A New Game", Tab = "Misc", Section = "Extra", Confirmation = true})

		UILibrary:CreateButton({Name = "Unlock Inventory", Tab = "Misc", Section = "Exploits"})
		UILibrary:CreateButton({Name = "Shot players become mush", Tab = "Misc", Section = "Exploits"})
		UILibrary:CreateButton({Name = "Ping Spoofer", Tab = "Misc", Section = "Exploits"})
		UILibrary:CreateSlider({Name = "Minimum Ping", Tab = "Misc", Section = "Exploits", MinimumNumber = 2^31, MaximumNumber = 2^31, DefaultValue = 60, Suffix = "ms"})
		UILibrary:CreateSlider({Name = "Maximum Ping", Tab = "Misc", Section = "Exploits", MinimumNumber = 2^31, MaximumNumber = 2^31, DefaultValue = 250, Suffix = "ms"})
		--UILibrary:CreateButton({Name = "Replicate Skins", Tab = "Misc", Section = "Exploits"})
		--UILibrary:CreateButton({Name = "Block Weapon Dropping On Death", Tab = "Misc", Section = "Exploits"})
		--UILibrary:CreateTap({Name = "Crash Server", Tab = "Misc", Section = "Exploits", Confirmation = true})
		--[[UILibrary:CreateDropdown({Name = "Player in Focus", Tab = "Misc", Section = "Exploits", Values = {}})
		local function getnames()
			local tbl = {}
			
			for i, v in next, (game.Players:GetPlayers()) do
				tbl[1 + #tbl] = v.Name
			end
			Menu["Misc"]["Exploits"]["Player in Focus"].UpdateValues(tbl)
			
		end
		getnames()
		game.Players.PlayerRemoving:Connect(function()
			task.wait()
			local old = Menu["Misc"]["Exploits"]["Player in Focus"]["Value"]
			getnames()
			Menu["Misc"]["Exploits"]["Player in Focus"]["Value"] = old
		end)
		game.Players.PlayerAdded:Connect(function()
			task.wait()
			local old = Menu["Misc"]["Exploits"]["Player in Focus"]["Value"]
			getnames()
			Menu["Misc"]["Exploits"]["Player in Focus"]["Value"] = old
		end)
		UILibrary:CreateDropdown({Name = "Action", Tab = "Misc", Section = "Exploits", Values = {"Hold", "Bring", "Silent Kill", "Desync"}})
		UILibrary:CreateTap({Name = "Apply action to focused player", Tab = "Misc", Section = "Exploits", Confirmation = true})
		UILibrary:CreateTap({Name = "Apply action to all players", Tab = "Misc", Section = "Exploits", Confirmation = true})
		UILibrary:CreateTap({Name = "Kick all players", Tab = "Misc", Section = "Exploits", Confirmation = true})
		UILibrary:CreateTap({Name = "Crash Server", Tab = "Misc", Section = "Exploits", Confirmation = true})
		UILibrary:CreateDropdown({Name = "Crash Server Option", Tab = "Misc", Section = "Exploits", Values = {"Packet", "Object"}})
		UILibrary:CreateTap({Name = "God Mode", Tab = "Misc", Section = "Exploits", Confirmation = true})
		UILibrary:CreateDropdown({Name = "God Mode Type", Tab = "Misc", Section = "Exploits", Values = {"Hostage", "Fall"}})
		UILibrary:CreateTap({Name = "Instant Defuse", Tab = "Misc", Section = "Exploits", Confirmation = true})
		UILibrary:CreateTap({Name = "Instant Plant", Tab = "Misc", Section = "Exploits", Confirmation = true})
		UILibrary:CreateDropdown({Name = "Plant Position", Tab = "Misc", Section = "Exploits", Values = {"Bombsite", "Void", "Glitch"}})
		--UILibrary:CreateButton({Name = "Block Vision", Tab = "Misc", Section = "Exploits"})
		--UILibrary:CreateButton({Name = "Force Slow Walk", Tab = "Misc", Section = "Exploits"})
		UILibrary:CreateTap({Name = "Map destroyer", Tab = "Misc", Section = "Exploits", Confirmation = true})
		UILibrary:CreateButton({Name = "Fake Equip", Tab = "Misc", Section = "Exploits"})
		UILibrary:CreateDropdown({Name = "Fake Slot", Tab = "Misc", Section = "Exploits", Values = {"Primary", "Secondary", "Melee"}})]]


		--[[
		UILibrary:CreateDropdown({Name = "Action", Tab = "Misc", Section = "Exploits", Values = {"Kill", "Broken Kill", "Grab", "Hold"}})
		UILibrary:CreateTap({Name = "Apply action to focused player", Tab = "Misc", Section = "Exploits", Confirmation = true})
		UILibrary:CreateTap({Name = "Apply action to all players", Tab = "Misc", Section = "Exploits", Confirmation = true})
		UILibrary:CreateTap({Name = "Crash Server", Tab = "Misc", Section = "Exploits", Confirmation = true})
		--UILibrary:CreateTap({Name = "Instant Defuse", Tab = "Misc", Section = "Exploits", Confirmation = true})
		--UILibrary:CreateTap({Name = "Instant Plant", Tab = "Misc", Section = "Exploits", Confirmation = true})
		--UILibrary:CreateDropdown({Name = "Plant Position", Tab = "Misc", Section = "Exploits", Values = {"Bombsite", "Void", "Glitch"}})
		UILibrary:CreateButton({Name = "Fake Equip", Tab = "Misc", Section = "Exploits"})
		UILibrary:CreateDropdown({Name = "Fake Slot", Tab = "Misc", Section = "Exploits", Values = {"Primary", "Secondary", "Melee"}})
		UILibrary:CreateButton({Name = "Godmode", Tab = "Misc", Section = "Exploits"})
		--UILibrary:CreateButton({Name = "Uncensored Chat", Tab = "Misc", Section = "Exploits"})
		--UILibrary:CreateButton({Name = "Chat While Dead", Tab = "Misc", Section = "Exploits"})]]

		UILibrary:CreateButton({Name = "Menu Accent", Tab = "Settings", Section = "Menu Settings", Colors = {Color3.fromRGB(127, 72, 163)}})
		UILibrary:CreateButton({Name = "Watermark", Tab = "Settings", Section = "Menu Settings", Callback = function(toggled) Library.UI.Watermark.Visible = toggled end})
		UILibrary:CreateButton({Name = "Aurora Watermark", Tab = "Settings", Section = "Menu Settings"})
			local cur_date = os.date("*t")

			local watermark = Instance.new("ScreenGui")
			watermark.Name = "_watermark_"
			watermark.DisplayOrder = 1.88e+09
			watermark.ResetOnSpawn = false

			local watermark1 = Instance.new("Frame")
			watermark1.Name = "Watermark"
			watermark1.Active = true
			watermark1.BorderColor3 = Color3.fromRGB(0, 0, 0)
			watermark1.BorderSizePixel = 0
			watermark1.Position = UDim2.fromOffset(10, 10)
			watermark1.Size = UDim2.fromOffset(362, 22)
			watermark1.ZIndex = 200

			local frame = Instance.new("Frame")
			frame.Name = "Frame"
			frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			frame.BorderColor3 = Color3.fromRGB(22, 22, 22)
			frame.Size = UDim2.fromScale(1.141, 1.14)
			frame.ZIndex = 201

			local frame1 = Instance.new("Frame")
			frame1.Name = "Frame"
			frame1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			frame1.BackgroundTransparency = 1
			frame1.BorderSizePixel = 0
			frame1.Position = UDim2.fromOffset(1, 1)
			frame1.Size = UDim2.new(1, -2, 1, -2)
			frame1.ZIndex = 202

			local imageLabel = Instance.new("ImageLabel")
			imageLabel.Name = "ImageLabel"
			imageLabel.AnchorPoint = Vector2.new(0, 0.5)
			imageLabel.BackgroundTransparency = 1
			imageLabel.Image = "rbxassetid://140198300701593"
			imageLabel.Position = UDim2.new(0, 5, 0.5, 0)
			imageLabel.Size = UDim2.fromOffset(15, 15)
			imageLabel.ZIndex = 203
			imageLabel.Parent = frame1

			local textLabel = Instance.new("TextLabel")
			textLabel.Name = "TextLabel"
			textLabel.BackgroundTransparency = 1
			textLabel.Font = Enum.Font.SourceSans
			textLabel.Position = UDim2.fromOffset(17, 0)
			textLabel.RichText = true
			textLabel.Size = UDim2.new(1, -28, 1, 0)
			textLabel.TextColor3 = Color3.fromRGB(215, 215, 215)
			textLabel.TextSize = 17
			textLabel.TextXAlignment = Enum.TextXAlignment.Left
			textLabel.ZIndex = 203
			textLabel.Parent = frame1

			frame1.Parent = frame

			local frame2 = Instance.new("Frame")
			frame2.Name = "Frame"
			frame2.BackgroundColor3 = Color3.fromRGB(255, 37, 37)
			frame2.BorderColor3 = Color3.fromRGB(255, 37, 37)
			frame2.BorderSizePixel = 0
			frame2.Position = UDim2.new(0, -1, 1, 0)
			frame2.Size = UDim2.new(1, 2, 0, 2)
			frame2.ZIndex = 202
			frame2.Parent = frame

			frame.Parent = watermark1
			watermark1.Parent = watermark

			watermark.Parent = gethui()

			local rs = game:GetService("RunService")
			local sts = game:GetService("Stats")
			local frm = sts and sts:FindFirstChild("FrameRateManager")
			local ra = frm and frm:FindFirstChild("RenderAverage")

			local function GetFramerate(): number
				return math.floor((1000 / ra:GetValue()) + 0.5)
			end

			rs.RenderStepped:Connect(function()
				if Menu["Settings"]["Menu Settings"]["Aurora Watermark"]["Toggle"]["Enabled"] then
					watermark.Enabled = true
					textLabel.Text =
						"  <font color=\"#FF2525\">Aurora Legacy</font> <font color=\"#3f3f3f\" size=\"9\">v2.3.0</font> " ..
						GetFramerate() .. " fps 〡" ..
						math.floor(game:GetService("Players").LocalPlayer.Ping.Value) .. " ms 〡" ..
						os.date("%I:%M") .. " 〡" ..
						os.date("%A") .. ", " .. os.date("%B") .. " " .. cur_date.day
				else
					watermark.Enabled = false
				end
			end)
		UILibrary:CreateButton({Name = "Keybinds", Tab = "Settings", Section = "Menu Settings", Callback = function(toggled) Library.UI.KeyBindContainer.Visible = toggled end})
		UILibrary:CreateButton({Name = "Use List Size", Tab = "Settings", Section = "Menu Settings", Callback = function(toggled) Library.UI.UseListSize = toggled end})
		UILibrary:CreateButton({Name = "Custom Menu Name", Tab = "Settings", Section = "Menu Settings"})
		UILibrary:CreateTextBox({Name = "Custom Menu Name Text", Tab = "Settings", Section = "Menu Settings", Default = "pastexpectional"})
		UILibrary:CreateButton({Name = "Show Debug Info", Tab = "Settings", Section = "Menu Settings"})

		UILibrary:CreateTap({Name = "Set Clipboard Game ID", Tab = "Settings", Section = "Extra", Callback = function() setclipboard('Roblox.GameLauncher.joinGameInstance('..game.PlaceId..',"'..game.JobId..'")') end})
		UILibrary:CreateTap({Name = "Set Clipboard Teleport Code", Tab = "Settings", Section = "Extra", Callback = function() setclipboard('game:GetService("TeleportService"):TeleportToPlaceInstance('..game.PlaceId..',"'..game.JobId..'")') end})
		UILibrary:CreateTap({Name = "Rejoin", Tab = "Settings", Section = "Extra", Confirmation = true, Callback = function() UILibrary:EventLog("Rejoining the game...", 5) game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end})

		-- hit in(vaded)(teger)
		if not isfolder("bloxsense") then
			makefolder("bloxsense")
		end

		if not isfolder("bloxsense/bloxsense_configs") then
			makefolder("bloxsense/bloxsense_configs")
		end

		if not isfolder("bloxsense/bloxsense_auto_exec") then
			makefolder("bloxsense/bloxsense_auto_exec")
		end

		if not isfile("bloxsense/kill_say.txt") then
			writefile("bloxsense/kill_say.txt", "{victim} was killed with a {weapon}\nsit nn dog")
		end

		UILibrary:CreateTextBox({Name = "Config Text", Tab = "Settings", Section = "Configurations", Default = getconfigs()[1]})
		UILibrary:CreateDropdown({Name = "Configs", Tab = "Settings", Section = "Configurations", Values = getconfigs(), Callback = function(selection) Menu["Settings"]["Configurations"]["Config Text"]["Value"] = selection end})
		UILibrary:CreateTap({Name = "Load Config", Tab = "Settings", Section = "Configurations", Confirmation = true, Callback = function() local old = Menu["Settings"]["Configurations"]["Config Text"]["Value"]; UILibrary:LoadConfiguration(readfile("bloxsense/bloxsense_configs/" .. Menu["Settings"]["Configurations"]["Config Text"]["Value"] .. ".cfg")); Library.UI:EventLog("Loaded " .. Menu["Settings"]["Configurations"]["Config Text"]["Value"] .. ".cfg!", 5); Menu["Settings"]["Configurations"]["Configs"].UpdateValues(getconfigs()); Menu["Settings"]["Configurations"]["Config Text"]["Value"] = old end})
		UILibrary:CreateTap({Name = "Save Config", Tab = "Settings", Section = "Configurations", Confirmation = true, Callback = function() local old = Menu["Settings"]["Configurations"]["Config Text"]["Value"]; writefile("bloxsense/bloxsense_configs/" .. Menu["Settings"]["Configurations"]["Config Text"]["Value"] .. ".cfg", UILibrary:SaveConfiguration()); Library.UI:EventLog("Saved " .. Menu["Settings"]["Configurations"]["Config Text"]["Value"] .. ".cfg!", 5); Menu["Settings"]["Configurations"]["Configs"].UpdateValues(getconfigs()); Menu["Settings"]["Configurations"]["Config Text"]["Value"] = old end})
		UILibrary:CreateTap({Name = "Delete Config", Tab = "Settings", Section = "Configurations", Confirmation = true, Callback = function() local old = Menu["Settings"]["Configurations"]["Config Text"]["Value"]; delfile("bloxsense/bloxsense_configs/" .. Menu["Settings"]["Configurations"]["Config Text"]["Value"] .. ".cfg"); Library.UI:EventLog("Deleted " .. Menu["Settings"]["Configurations"]["Config Text"]["Value"] .. ".cfg!", 5); Menu["Settings"]["Configurations"]["Configs"].UpdateValues(getconfigs()); Menu["Settings"]["Configurations"]["Config Text"]["Value"] = old end})
	end

	--ANCHOR Services (this formatting is dumb and im gonna fucking use it to define constants and services)
	local workspace			= workspace --GETGLOBAL IS A BITCH
	local game				= game
	local math				= math
	local RaycastParams		= RaycastParams
	local table				= table
	local getnamecallmethod = getnamecallmethod
	local task 				= task
	local string			= string
	local next 				= next
	local debug             = debug
	local Enum				= Enum
	local soundService 		= game.SoundService
	local lighting			= game.Lighting
	local players			= game:GetService("Players")
	local runService		= game:GetService("RunService")
	local teleportService   = game:GetService("TeleportService")
	local userInputService	= game:GetService("UserInputService")
	local httpService		= game:GetService("HttpService")
	local replicatedStorage	= game:GetService("ReplicatedStorage")
	local userSettings		= UserSettings():GetService("UserGameSettings")
	local tweenService 		= game:GetService("TweenService")
	local physicsService	= game:GetService("PhysicsService")
	local ProximityPromptService = game:GetService("ProximityPromptService")
	local networkClient		= game:GetService("NetworkClient")

	--ANCHOR Common objects
	local materials			= Enum.Material
	local camera			= workspace.CurrentCamera
	local localPlayer		= players.localPlayer
	local crosshairs 		= localPlayer:FindFirstChild("PlayerGui").GUI.Crosshairs
	local mouse				= localPlayer:GetMouse()
	local client			= getsenv(localPlayer:FindFirstChild("PlayerGui").Client)
	local hitPart			= replicatedStorage:WaitForChild("Events", 1/0):WaitForChild("HitPart", 1/0)
	local replicateCamera  	= replicatedStorage:WaitForChild("Events", 1/0):WaitForChild("ReplicateCamera", 1/0)
	local controlTurn 		= replicatedStorage:WaitForChild("Events", 1/0):WaitForChild("ControlTurn", 1/0)
	local fallDamage		= replicatedStorage:WaitForChild("Events", 1/0):WaitForChild("FallDamage", 1/0)
	local playerChat		= replicatedStorage:WaitForChild("Events", 1/0):WaitForChild("PlayerChatted", 1/0)

		--[[do
			local localScripts = {}
			for i, v in next, localPlayer:FindFirstChild("PlayerGui"):GetChildren() do
				if v.ClassName == "LocalScript" then
					localScripts[v] = getprops(v)
				end
			end
			task.wait(1)
			for script, props in next, localScripts do
				if props.Name ~= script.Name then
					client = getsenv(script)
					break
				end
			end
		end]]


	--ANCHOR Funny constants
	--rth=-a-ts the  sLaOmeL thing
	-- LOL
	-- nah fuck u
	-- my cheat
	--nigger

	local nan				= math.sqrt(-1)
	local inf				= 1/0
	local smallestNumber	= -1.7*10^308
	local highestNumber		= -smallestNumber
	local pi				= math.pi
	local tau				= 2*pi
	local toDeg				= 180/pi
	local toRad				= pi/180
	local emptyVec3			= Vector3.new()
	local emptyVec2			= Vector2.new()
	local emptyCf			= CFrame.new()
	local viewportSize		= camera.ViewportSize
	local xz				= Vector3.one - Vector3.yAxis
	local nanVec			= Vector3.new(nan, nan, nan)


	--ANCHOR Table storages
	local cameraTasks		= {tasks = {}} --this is used to re Connect connections if the camera gets destroyed(never but be safe than sorry)
	local mathModule 		= {}
	local timer 			= {}
	local trajectory		= {}
	local ragebot 			= {}
	local legitbot 			= {}
	local misc				= {}
	local visuals			= {}
	local movement			= {} --yes invaded MOVEMENT CHEAT IN BLOXSENSE!!!! (how to make ishpedo jealous)
	local playerInfo		= {}
	local raycastUtils		= {}
	local exploits			= {}
	local menusettings 		= {}

	--ANCHOR Cache functions
	local fireServer = Instance.new("RemoteEvent").FireServer
	local pointToObjectSpace = emptyCf.PointToObjectSpace
	local newVector3 = Vector3.new
	local newVector2 = Vector2.new
	local newCframe = CFrame.new
	local workspaceRaycast = workspace.Raycast
	local findFirstChild = game.FindFirstChild
	local robloxWorldToViewport = camera.WorldToViewportPoint

	--ANCHOR Signals because cb is gay
	local playerDied = Library.Signal.new()
	local playerSpawned = Library.Signal.new()

	--ANCHOR Magic Sex Drive Booster
	networkClient:SetOutgoingKBPSLimit(0) --KYS 



	local function deepCopy(original)
		local copy = {}
		for k, v in pairs(original) do
			if type(v) == "table" then
				v = deepCopy(v)
			end
			copy[k] = v
		end
		return copy
	end

	do
		local function apply(plr)
			plr.CharacterAdded:Connect(function(character)
				repeat
					task.wait()
				until plr.Status.Alive.Value
				playerSpawned:Fire(plr, tick())
				local hum = character:WaitForChild("Humanoid")
				local sig; sig = hum.HealthChanged:Connect(function(newHealth)
					if newHealth == newHealth and newHealth <= 0 then
						sig:Disconnect()
						sig = nil
						playerDied:Fire(plr, tick())
					end
				end)
			end)
		end

		for i,v in next, players:GetPlayers() do
			apply(v)
		end

		players.PlayerAdded:Connect(apply)
	end


	do --ANCHOR Raycast stuff
		--https://github.com/Quenty/NevermoreEngine/blob/2d2d3a22ecebe84ed1334eb997118418ce4f00d5/src/raycaster/src/Shared/RaycastUtils.lua
		local empty = {}
		raycastUtils.raycastParam = RaycastParams.new()
		raycastUtils.exitParam = RaycastParams.new()
		raycastUtils.exitParam.FilterType = Enum.RaycastFilterType.Whitelist

		function raycastUtils.raycast(origin, direction, ignoreList, ignoreFunc, keepIgnoreListChanges, ignoreWater)
			--origin describes the ray's origin
			--direction describes the ray's direction
			--everything in ignorelist will get ignored by the raycast
			--will raycast indefinetely until a part thats not ignored by ignoreFunc is found or no parts are found
			--since the function edits the ignorelist, it has a toggle to keep the added part or remove them
			--ignorewater controls if the raycast will ignore water or not (dn)

			--(psst u can cheat an autowall by ignoring the uncollideable object and thus not incrementing the wall count we'vepassed, barely noticeable)

			local resultFinal
			local initialIgnoreListLength = #ignoreList

			raycastUtils.raycastParam.FilterDescendantsInstances = ignoreList
			raycastUtils.raycastParam.IgnoreWater = ignoreWater and true or false

			while true do
				local result = workspaceRaycast(workspace, origin, direction, raycastUtils.raycastParam)
				if ignoreFunc and result and ignoreFunc(result.Instance) then
					table.insert(ignoreList, result.Instance)
					raycastUtils.raycastParam.FilterDescendantsInstances = ignoreList
				else
					resultFinal = result
					break
				end
			end

			if not keepIgnoreListChanges then
				for i = #ignoreList, initialIgnoreListLength + 1, -1 do
					ignoreList[i] = nil
				end
			end

			raycastUtils.raycastParam.FilterDescendantsInstances = empty
			raycastUtils.raycastParam.IgnoreWater = false
			return resultFinal
		end

		function raycastUtils.raycastSingleExit(origin, direction, part)
			raycastUtils.exitParam.FilterDescendantsInstances = {part}
			local resultFinal = workspaceRaycast(workspace, origin + direction, -direction, raycastUtils.exitParam)
			raycastUtils.exitParam.FilterDescendantsInstances = empty
			return resultFinal
		end
	end


	do --ANCHOR cameraTasks
		function cameraTasks:addTask(getSignal, callback)
			local data = {
				getSignal = getSignal,
				callback = callback
			}
			local index = #self.tasks + 1
			self.tasks[index] = data
			return data, index
		end
		function cameraTasks.onCameraAdded()
			for i = 1, #cameraTasks.tasks do
				local task = cameraTasks.tasks[i]
				if task then
					task.connection = task.getSignal():Connect(task.callback)
				end
			end
		end
		function cameraTasks.unload()
			for i = #cameraTasks.tasks, 1, -1 do --reverse because remove shiftes the table
				local task = table.remove(cameraTasks.tasks, i)
				if task and task.connection then
					task.connection:Disconnnect()
				end
			end
			table.clear(cameraTasks.tasks) --make sure
			cameraTasks = {} --this is cringe
		end
	end

	--ANCHOR Camera updating signals (incase)
	workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		camera = workspace.CurrentCamera
		cameraTasks.onCameraAdded()
	end)

	do --ANCHOR mathModule
		--Misc
		function mathModule.truncateNumber(number, decimalPlaces)
			local d = 10^decimalPlaces
			return math.floor(number*d)/d
		end

		function mathModule.map(x, start0, stop0, start1, stop1)
			return (x - start0)/(stop0 - start0)*(stop1 - start1) + start1
		end

		function mathModule.safeUnit(vec, epsilon)
			--will safely unitize a vector3or2 if the magnitude is lower than epsilon (this function makes sure that it doesnt return nan)
			local magnitude = vec.magnitude
			if magnitude > (epsilon or 1e-10) then
				return vec/magnitude
			end
			return typeof(vec) == "Vector2" and emptyVec2 or emptyVec3
		end

		--Vector3s
		function mathModule.angleBetweenVector3(vec1, vec2)
			--abit slow but numerically more stable, and u dont have to unitize them :smiley:
			local angle = math.atan2(vec1:Cross(vec2).magnitude, vec1:Dot(vec2))
			if angle < 0 then
				angle = tau - angle
			end
			return angle
		end

		function mathModule.pitchYawToLookVec(pitch, yaw)
			local cx = math.cos(pitch)
			return newVector3(-cx*math.sin(yaw), math.sin(pitch), -cx*math.cos(yaw))
		end

		function mathModule.lookVecToPitchYaw(lookVec)
			local x, y, z = lookVec.x, lookVec.y, lookVec.z
			return math.atan2(y, (x*x + z*z)^0.5), math.atan2(-x, -z)
		end

		--Vector2s
		function mathModule.angleBetweenVector2(vec1, vec2)
			--trust me i hate arccos
			local ang = math.acos(mathModule.safeUnit(vec1):Dot(mathModule.safeUnit(vec2)))
			if ang < 0 then
				ang = tau - ang
			end
			return ang
		end

		function mathModule.rotationMatrix(vec, angle)
			--https://en.wikipedia.org/wiki/Rotation_matrix
			local mag = vec.Magnitude
			vec = mathModule.safeUnit(vec)
			local co, si = math.cos(angle), math.sin(angle)
			local x, y = vec.x, vec.y
			return mathModule.safeUnit(newVector2(x*co - y*si, x*si + y*co))*mag
		end

		function mathModule.normalizeAngle(angle)
			return ((angle + pi) % (2*pi)) - pi
		end

		do --ANCHOR mathModule for visuals (wtsp)
			local fov
			local viewportX, viewportY
			local frustumYScale
			local frustumXScale
			local rScaleX, rScaleY

			local function refresh()
				viewportSize = camera.ViewportSize
				fov = camera.FieldOfView * toRad
				viewportX, viewportY = viewportSize.x, viewportSize.y
				frustumYScale = math.tan(fov/2)
				frustumXScale = viewportX/viewportY * frustumYScale
				rScaleX = (1 + frustumXScale*frustumXScale)^0.5
				rScaleY = (1 + frustumYScale*frustumYScale)^0.5
			end

			refresh()
			cameraTasks:addTask(function()
				return camera:GetPropertyChangedSignal("FieldOfView")
			end, refresh)
			cameraTasks:addTask(function()
				return camera:GetPropertyChangedSignal("ViewportSize")
			end, refresh)

			--hello future skidders (incase this gets leaked which i doubt), if you're wondering what the fuck is this for, use ur brain and STOP PASTING STORMY :)
			-- https://cdn.discordapp.com/attachments/847345559132045352/890095011348234270/caption.gif
			function mathModule.worldToViewportPoint(worldPosition, clampEdge, clampOffset)
				local projectedPosition = pointToObjectSpace(camera.CFrame, worldPosition)
				local pX, pY, pZ = projectedPosition.x, projectedPosition.y, -projectedPosition.z
				local screenX = viewportX * (0.5 + pX/(2*pZ*frustumXScale))
				local screenY = viewportY * (0.5 - pY/(2*pZ*frustumYScale))
				local onScreen = pZ > 0 and screenX >= 0 and screenX <= viewportX and screenY >= 0 and screenY <= viewportY
				if not clampEdge then
					return newVector3(screenX, screenY, pZ), onScreen
				end
				if onScreen then
					return newVector3(screenX, screenY, pZ), true
				end
				local widthEdge, heightEdge = pX < 0 and clampOffset or viewportX - clampOffset, -pY < 0 and clampOffset or viewportY - clampOffset
				local m = 0.5*(pY*viewportX + pX*viewportY)
				local newY = (m - pY*widthEdge)/pX
				if newY > clampOffset and newY < (viewportY - clampOffset) then
					return newVector3(widthEdge, newY, pZ), false
				else
					local newX = (m - pX*heightEdge)/pY
					return newVector3(newX, heightEdge, pZ), false
				end
			end

			--scales the camera's frustum size according to the radius, useful to know if a character is fully offscreen or no
			function mathModule.spherePoint(worldPosition, radius)
				local projectedPosition = pointToObjectSpace(camera.CFrame, worldPosition)
				local pX, pY, pZ = projectedPosition.x, projectedPosition.y, -projectedPosition.z
				local rX = rScaleX*radius
				local rY = rScaleY*radius
				return -pZ*frustumXScale < pX+rX and pX-rX < pZ*frustumXScale and -pZ*frustumYScale < pY+rY and pY-rY < pZ*frustumYScale and pZ > -radius
			end
		end
		do -- timer class and trajectory bullshit (pasted)
			timer.__index = timer
			function timer.new(startTime)
				local self = setmetatable({}, timer)

				self.Active = false
				self.StartTime = startTime
				self.Time = startTime
				self.Events = {}

				self.timerEvent = runService.RenderStepped:Connect(function(dt)
					if (self.Active) then
						self.Time = self.Time + dt

						local events = self.Events
						for i = #events, 1, -1 do
							if (self.Time >= events[i][1]) then
								events[i][2](self.Time)
								table.remove(events, i)
							end
						end
					end
				end)

				return self
			end

			function timer:SetActive(bool)
				self.Active = bool
			end

			function timer:FireOntimereached(t, f)
				table.insert(self.Events, {t, f})
			end

			function timer:Destroy()
				self.timerEvent:Disconnect()
			end
		end
		do -- ok ok heres trajectory
			-- if u read this fuck u
			trajectory.__index = trajectory

			local nadelinestorage = workspace.Terrain

			local basebeam = Instance.new("Beam")
			basebeam.Color = ColorSequence.new(Color3.new(0, 1, 0))
			basebeam.Transparency = NumberSequence.new(0)
			basebeam.FaceCamera = true
			basebeam.Segments = 100
			basebeam.Width0 = 0.05
			basebeam.Width1 = 0.05

			local basepart = Instance.new("Part")
			basepart.Color = Color3.new(1, 0, 0)
			basepart.Anchored = true
			basepart.CanCollide = false
			basepart.Size = newVector3(0.15, 0.15, 0.15)
			basepart.Material = materials.SmoothPlastic

			
			local function reflect(v, n)
				return -2*v.Dot(v, n)*n + v
			end
			trajectory.reflect = reflect

			local function drawBeamProjectile(g, v0, x0, t, visible, color, bounce)
				local c = 0.5*0.5*0.5
				local p3 = 0.5*g*t*t + v0*t + x0
				local p2 = p3 - (g*t*t + v0*t)/3
				local p1 = (c*g*t*t + 0.5*v0*t + x0 - c*(x0+p3))/(3*c) - p2

				local curve0 = (p1 - x0).Magnitude
				local curve1 = (p2 - p3).Magnitude

				local b = (x0 - p3).unit
				local r1 = (p1 - x0).unit
				local u1 = r1:Cross(b).unit
				local r2 = (p2 - p3).unit
				local u2 = r2:Cross(b).unit
				b = u1:Cross(r1).unit

				local cfA = CFrame.fromMatrix(x0, r1, u1, b)
				local cfB = CFrame.fromMatrix(p3, r2, u2, b)

				local A0 = Instance.new("Attachment")
				local A1 = Instance.new("Attachment")
				local Beam = basebeam:Clone()
				local Bounce = basepart:Clone()

				A0.CFrame = cfA
				A0.Parent = nadelinestorage
				A1.CFrame = cfB
				A1.Parent = nadelinestorage

				Beam.Color = ColorSequence.new(color)
				Beam.Attachment0 = A0
				Beam.Attachment1 = A1
				Beam.CurveSize0 = curve0
				Beam.CurveSize1 = -curve1
				Beam.Parent = nadelinestorage
				Beam.Enabled = visible

				Bounce.Color = bounce
				Bounce.Transparency = visible and 0 or 1
				Bounce.Position = A1.CFrame.p
				Bounce.Parent = nadelinestorage

				return A0, A1, Beam, Bounce
			end

			function trajectory.new(Parameters)
				local self = setmetatable({}, trajectory)

				self.Gravity = Parameters.gravity
				self.TimeStep = Parameters.step
				self.MaxTime = Parameters.time
				self.MaxBounce = Parameters.bounces

				return self
			end

			function trajectory:Velocity(v0, t)
				-- g*t + v0
				return self.Gravity*t + v0
			end

			function trajectory:Position(x0, v0, t)
				-- 0.5*g*t^2 + v0*t + x0
				return 0.5*self.Gravity*t*t + v0*t + x0
			end

			function trajectory:PlaneQuadraticIntersection(x0, v0, p, n)
				local a = (0.5*self.Gravity):Dot(n)
				local b = v0:Dot(n)
				local c = (x0 - p):Dot(n)

				if (a ~= 0) then
					local d = math.sqrt(b*b - 4*a*c)
					return (-b - d)/(2*a)
				else
					return -c / b
				end
			end

			function trajectory:CalculateSingle(x0, v0, ignoreList)
				local t = 0
				local hit, pos, normal, material

				repeat
					local p0 = self:Position(x0, v0, t)
					local p1 = self:Position(x0, v0, t + self.TimeStep)
					t = t + self.TimeStep

					local ray = Ray.new(p0, p1 - p0)
					hit, pos, normal, material = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList, false, true)
				until ((hit and hit.CanCollide == true) or t >= self.MaxTime)

				if (hit and hit.CanCollide == true) then
					local t = self:PlaneQuadraticIntersection(x0, v0, pos, normal)
					local x1 = self:Position(x0, v0, t)
					return t, normal, PhysicalProperties.new(material)
				end
			end

			function trajectory:Cast(Parameters)
				local bounces = 0
				local t, x1, normal, pB
				local pA = Parameters.physics
				local path = {}

				local x0, v0 = Parameters.start, Parameters.velocity
				
				while (bounces <= self.MaxBounce) do
					t, normal, pB = self:CalculateSingle(x0, v0, Parameters.ignores)
					if (t) then
						path[1 + #path] = {x0, v0, t}

						local elasticity = (pA.Elasticity*pA.ElasticityWeight + pB.Elasticity*pB.ElasticityWeight)/(pA.ElasticityWeight+pB.ElasticityWeight)
						local friction = (pA.Friction*pA.FrictionWeight + pB.Friction*pB.FrictionWeight)/(pA.FrictionWeight+pB.FrictionWeight)
						-- check the weighting https://developer.roblox.com/en-us/api-reference/datatype/PhysicalProperties
						local dotprod = 1 - math.abs(v0.Unit:Dot(normal))

						x0 = self:Position(x0, v0, t)
						v0 = reflect(self:Velocity(v0, t), normal) * elasticity + v0 * friction * dotprod
						if normal.Y > normal.X and normal.Y > normal.Z then -- the surface is prob a floor
							bounces = bounces + 1
						end
					else
						bounces = self.MaxBounce + 1
					end
				end

				return path
			end

			function trajectory:Travel(part, path)
				local t = 0
				local timer = timer.new(0)

				local x0, v0, dt = unpack(path[1])
				part.CFrame = CFrame.new(x0, x0 + v0)

				for i = 1, #path do
					local x0, v0, dt = unpack(path[i])
					timer:FireOnTimeReached(t, function(currentTime)
						part.Velocity = v0
					end)
					t = t + dt
				end

				timer:FireOnTimeReached(t, function(currentTime)
					timer:Destroy()
				end)

				timer:SetActive(true)
			end

			function trajectory:Draw(Parameters)
				local things = {}
				local pathtodraw = Parameters.trail
				for i = 1, #pathtodraw do
					local x0, v0, t = unpack(pathtodraw[i])
					local a, b, c, d = drawBeamProjectile(self.Gravity, v0, x0, t, Parameters.visible, Parameters.color, Parameters.bounce)
					things[1 + #things] = {a, b, c, d}
				end
				return things
			end
		end
	end

	do --ANCHOR playerinfo module
		playerInfo.storage = {}


		local function refreshEnemyType(data)
			data.enemy = replicatedStorage.gametype.Value == "deathmatch" or (data.player ~= localPlayer and data.player.Team ~= localPlayer.Team)
		end
		localPlayer:GetPropertyChangedSignal("Team"):Connect(function()
			for player,data in next, playerInfo.storage do
				refreshEnemyType(data)
			end
		end)

		function playerInfo.add(player)
			local data = {}
			data.player = player
			data.lastVelocity = emptyVec3
			data.velocity = emptyVec3
			data.character = nil
			data.god = false
			data.currentPosition = emptyVec3
			data.lastPosition = emptyVec3
			data.lastcameracf = emptyCf
			data.camcf = emptyCf
			data.updates = {}

			data.enemy = replicatedStorage.gametype.Value == "deathmatch" or (player ~= localPlayer and player.Team ~= localPlayer.Team)

			player:GetPropertyChangedSignal("Team"):Connect(function()
				refreshEnemyType(data)
			end)
			
			data.step = runService.Stepped:Connect(function(delta)
				--debug.profilebegin(player.Name .. " pInfo update")
				--so this is supposed to give an accurate result of what roblox physics would calculate as they run in 60 fps, if this doesnt exist then the velocity result we get would be much higher if we have fps unlocker, before u scream "wouldnt that make our forward track beter", yes but scummy
				--which is what this line below fix, it wont forward track too far :)
				--lol
				local char = player.Character
				data.character = char
				data.humanoid = char and char:FindFirstChild("Humanoid")
				data.head = char and char:FindFirstChild("Head")
				data.rootpart = char and char:FindFirstChild("HumanoidRootPart")
				data.god = data.humanoid and data.humanoid.Health ~= data.humanoid.Health
				data.alive = (char and data.humanoid and data.humanoid.Parent and data.humanoid.Health > 0 and data.humanoid.Health == data.humanoid.Health and data.rootpart)
				
				if data.god or data.alive then
					data.protected = char and char:FindFirstChildOfClass("ForceField") ~= nil
					if data.currentPosition then
						data.lastPosition = data.currentPosition
					end
					data.currentPosition = data.rootpart and data.rootpart.Position
					if data.camcf then
						data.lastcameracf = data.camcf
					end
					data.camcf = player:FindFirstChild("CameraCF") and player:FindFirstChild("CameraCF").Value or emptyCf

					table.insert(data.updates, 1, {position = data.currentPosition, velocity = data.velocity, time = tick()})

					local samples = 5
					local totalDelta = 0
					local totalDistance = emptyVec3
					for i = 2, math.min(samples, #data.updates) do
						local now = data.updates[i]
						local prev = data.updates[i - 1]

						totalDelta = totalDelta + (now.time - prev.time)
						totalDistance = totalDistance + (now.position - prev.position)
					end

					data.velocity = totalDistance / totalDelta
				else
					table.clear(data.updates)
					data.protected = false
					data.character = nil
					data.alive = false
					data.lastVelocity = emptyVec3
					data.velocity = emptyVec3
					data.currentPosition = emptyVec3
					data.lastPosition = emptyVec3
					data.humanoid = nil
					data.head = nil
					data.rootpart = nil
				end
				--debug.profileend()
			end)
			playerInfo.storage[player] = data
		end

		function playerInfo.remove(player)
			if playerInfo.storage[player] then
				playerInfo.storage[player].step:Disconnect()
				table.clear(playerInfo.storage[player])
				playerInfo.storage[player] = nil
			end
		end

		function playerInfo.unload()
			for player,data in next, playerInfo.storage do
				playerInfo.remove(player)
			end
			table.clear(playerInfo)
			playerInfo = {}
		end

		for i,v in next, players:GetPlayers() do
			if v ~= localPlayer then
				playerInfo.add(v)
			end
		end
		players.PlayerAdded:Connect(playerInfo.add)
		players.PlayerRemoving:Connect(playerInfo.remove)
	end

	do --ANCHOR Visuals
		visuals.chamsFolder = Instance.new("Folder", game:GetService("CoreGui"))
		visuals.espObjects = {}
		visuals.allDrawingObjects = {}
		visuals.tracerObjects = {}
		visuals.lastragdollupdate = tick()
		visuals.lastcolorupdate = tick()
		visuals.droppedWeaponStorage = {}
		visuals.ragdollobjects = {}
		visuals.chammedbody = false
		visuals.imagecache = {}
		visuals.grenadetrajectories = {}
		visuals.particleemitter = nil -- particle thing 

		visuals.chammedobjects = {
			["Clothing"] = {},
			["Arms"] = {},
			["Weapon Objects"] = {},
			["Colored Arms"] = {},
			["Colored Weapons"] = {},
			["Colored Body"] = {},
			["Original"] = {},
			["Original Body"] = {} -- dn
		}
		visuals.materials = {
			["Ghost"] = materials.ForceField,
			["Flat"] = materials.Neon,
			["Custom"] = materials.SmoothPlastic,
			["Reflective"] = materials.Glass, -- this one will have reflectance set to 1
			["Metallic"] = materials.Glass,
			["Magic"] = materials.SmoothPlastic
		}
		visuals.forcefieldAnimations = forcefieldAnimations
		visuals.particleImages = particleImages
		visuals.skyboxes = {
			["Cloudy Skies"] = {
				SkyboxLf = "rbxassetid://151165191",
				SkyboxBk = "rbxassetid://151165214",
				SkyboxDn = "rbxassetid://151165197",
				SkyboxFt = "rbxassetid://151165224",
				SkyboxRt = "rbxassetid://151165206",
				SkyboxUp = "rbxassetid://151165227",
			},
			["Space"] = {
				SkyboxLf = "rbxassetid://159454286",
				SkyboxBk = "rbxassetid://159454299",
				SkyboxDn = "rbxassetid://159454296",
				SkyboxFt = "rbxassetid://159454293",
				SkyboxRt = "rbxassetid://159454300",
				SkyboxUp = "rbxassetid://159454288",
			},
			["Nebula"] = {
				SkyboxLf = "rbxassetid://149397684",
				SkyboxBk = "rbxassetid://149397692",
				SkyboxDn = "rbxassetid://149397686",
				SkyboxFt = "rbxassetid://149397697",
				SkyboxRt = "rbxassetid://149397688",
				SkyboxUp = "rbxassetid://149397702",
			},
			["Vivid Skies"] = {
				SkyboxLf = "rbxassetid://271042310",
				SkyboxBk = "rbxassetid://271042516",
				SkyboxDn = "rbxassetid://271077243",
				SkyboxFt = "rbxassetid://271042556",
				SkyboxRt = "rbxassetid://271042467",
				SkyboxUp = "rbxassetid://271077958",
			},
			["Bob's Skybox"] = {
				SkyboxLf = "rbxassetid://7264789109",
				SkyboxBk = "rbxassetid://7264789737",
				SkyboxDn = "rbxassetid://7264789487",
				SkyboxFt = "rbxassetid://7264789309",
				SkyboxRt = "rbxassetid://7264788930",
				SkyboxUp = "rbxassetid://7264788734",
			}
		}
		visuals.defaultlighting = { -- fuck it
			["de_dust2"] = {
				Ambient = Color3.fromRGB(90, 74, 62),
				OutdoorAmbient = Color3.fromRGB(165, 156, 140),
				ClockTime = 13
			},
			["de_seaside"] = {
				Ambient = Color3.fromRGB(211, 237, 255),
				OutdoorAmbient = Color3.fromRGB(180, 180, 180),
				ClockTime = 14
			},
			["de_train"] = {
				Ambient = Color3.fromRGB(130, 118, 95),
				OutdoorAmbient = Color3.fromRGB(163, 161, 146),
				ClockTime = 9.5
			},
			["de_mirage"] = {
				Ambient = Color3.fromRGB(214, 214, 214),
				OutdoorAmbient = Color3.fromRGB(165, 156, 140),
				ClockTime = 15
			},
			["de_cache"] = {
				Ambient = Color3.fromRGB(214, 214, 214),
				OutdoorAmbient = Color3.fromRGB(165, 156, 140),
				ClockTime = 14
			},
			["de_nuke"] = {
				Ambient = Color3.fromRGB(90, 74, 62),
				OutdoorAmbient = Color3.fromRGB(165, 156, 140),
				ClockTime = 13
			},
			["de_vertigo"] = {
				Ambient = Color3.fromRGB(255, 255, 255),
				OutdoorAmbient = Color3.fromRGB(255, 255, 255),
				ClockTime = 15
			},
			["de_inferno"] = {
				Ambient = Color3.fromRGB(130, 118, 95),
				OutdoorAmbient = Color3.fromRGB(163, 161, 146),
				ClockTime = 9.5
			},
			["de_aztec"] = {
				Ambient = Color3.fromRGB(149, 175, 179),
				OutdoorAmbient = Color3.fromRGB(149, 159, 191),
				ClockTime = 15
			}
		}
		visuals.thirdPersonConnections = {}
		function visuals.createDrawing(type, prop)
			local obj = Drawing.new(type)
			if prop then
				for index,value in next, prop do
					obj[index] = value
				end
			end
			table.insert(visuals.allDrawingObjects, obj)
			return obj
		end

		do --esp and chams
			visuals.gradentHealthBarSegments = 16
			visuals.defaultProp = {
				outlineBox = {
					Visible = false,
					Transparency = 0.7,
					Color = Color3.fromRGB(10, 10, 10),
					Thickness = 3,
					Filled = false
				},
				box = {
					Visible = false,
					Transparency = 1,
					Color = Color3.fromRGB(255, 255, 255),
					Thickness = 1,
					Filled = false
				},
				boxFilled = {
					Visible = false,
					Transparency = 0.1,
					Color = Color3.fromRGB(255, 255, 255),
					Filled = true
				},
				healthBarOutline = {
					Visible = false,
					Transparency = 0.7,
					Color = Color3.fromRGB(10, 10, 10),
					Thickness = 1,
					Filled = true
				},
				healthBarOutlineOutline = {
					Visible = false,
					Transparency = 0.7,
					Color = Color3.fromRGB(10, 10, 10),
					Thickness = 1,
					Filled = false
				},
				healthBar = {
					Visible = false,
					Transparency = 1,
					Color = Color3.fromRGB(0, 255, 0),
					Thickness = 1,
					Filled = true
				},
				nameTag = {
					Visible = false,
					Size = 13,
					Font = Drawing.Fonts.Plex,
					Color = Color3.fromRGB(255, 255, 255),
					Transparency = 1,
					Center = true,
					Outline = true
				},
				heldWeapon = {
					Visible = false,
					Size = 13,
					Font = 2,
					Color = Color3.fromRGB(255, 255, 255),
					Transparency = 1,
					Center = true,
					Outline = true
				},
				heldWeaponIcon = {
					Visible = false,
					Data = visuals.imagecache["C4"],
					Size = newVector2(56, 22),
					Rounding = 2,
					Transparency = 1,
				},
				healthNumber = {
					Visible = false,
					Size = 13,
					Font = Drawing.Fonts.Plex,
					Color = Color3.fromRGB(255, 255, 255),
					Transparency = 1,
					Center = true,
					Outline = true
				},
				distanceTag = {
					Visible = false,
					Size = 13,
					Font = 2,
					Color = Color3.fromRGB(255, 255, 255),
					Transparency = 1,
					Center = true,
					Outline = true
				},
				oofArrow = {
					Visible = false,
					Filled = true,
					Color = Color3.fromRGB(255, 0, 255),
					Thickness = 2,
					Transparency = 1
				},
				oofArrowOutline = {
					Visible = false,
					Filled = false,
					Color = Color3.fromRGB(255, 255, 255),
					Thickness = 4,
					Transparency = 0.9,
				},
				cameraCircle = {
					Visible = false,
					Thickness = 1,
					Radius = 3,
					Transparency = 1,
					Filled = false
				},
				snapLine = {
					Thickness = 1,
					Color = Color3.fromRGB(255, 255, 255),
					Transparency = 1,
					Visible = false
				},
				flags = {
					Visible = false,
					Size = 13,
					Font = Drawing.Fonts.Plex,
					Color = Color3.fromRGB(255, 255, 255),
					Transparency = 1,
					Center = true,
					Outline = true
				},
			}

			function visuals.initializeDrawingObjects(onScreen, offScreen, general)
				onScreen.outlineBox         = {
					object = visuals.createDrawing("Square", visuals.defaultProp.outlineBox),
					originalTransparency = visuals.defaultProp.outlineBox.Transparency
				}
				onScreen.box                = {
					object = visuals.createDrawing("Square", visuals.defaultProp.box),
					originalTransparency = visuals.defaultProp.box.Transparency
				}
				onScreen.boxFilled          = {
					object = visuals.createDrawing("Square", visuals.defaultProp.boxFilled),
					originalTransparency = visuals.defaultProp.boxFilled.Transparency
				}
				onScreen.healthBarOutline   = {
					object = visuals.createDrawing("Square", visuals.defaultProp.healthBarOutline),
					originalTransparency = visuals.defaultProp.healthBarOutline.Transparency
				}
				onScreen.healthBarOutlineOutline   = {
					object = visuals.createDrawing("Square", visuals.defaultProp.healthBarOutlineOutline),
					originalTransparency = visuals.defaultProp.healthBarOutline.Transparency
				}
				onScreen.healthBar          = {
					object = visuals.createDrawing("Square", visuals.defaultProp.healthBar),
					originalTransparency = visuals.defaultProp.healthBar.Transparency
				}

				for i = 1, visuals.gradentHealthBarSegments do
					onScreen["healthBarSegment" .. i]       = {
						object = visuals.createDrawing("Square", visuals.defaultProp.healthBar),
						originalTransparency = visuals.defaultProp.healthBar.Transparency
					}
				end

				onScreen.nameTag            = {
					object = visuals.createDrawing("Text", visuals.defaultProp.nameTag),
					originalTransparency = visuals.defaultProp.nameTag.Transparency
				}
				onScreen.heldWeapon         = {
					object = visuals.createDrawing("Text", visuals.defaultProp.heldWeapon),
					originalTransparency = visuals.defaultProp.heldWeapon.Transparency
				}
				onScreen.heldWeaponIcon      = {
					object = visuals.createDrawing("Image", visuals.defaultProp.heldWeaponIcon),
					originalTransparency = visuals.defaultProp.heldWeaponIcon.Transparency
				}
				onScreen.healthNumber       = {
					object = visuals.createDrawing("Text", visuals.defaultProp.healthNumber),
					originalTransparency = visuals.defaultProp.healthNumber.Transparency
				}
				onScreen.distanceTag        = {
					object = visuals.createDrawing("Text", visuals.defaultProp.distanceTag),
					originalTransparency = visuals.defaultProp.distanceTag.Transparency
				}
				onScreen.armorTag        = {
					object = visuals.createDrawing("Text", visuals.defaultProp.flags),
					originalTransparency = visuals.defaultProp.flags.Transparency
				}
				onScreen.bombTag		= {
					object = visuals.createDrawing("Text", visuals.defaultProp.flags),
					originalTransparency = visuals.defaultProp.flags.Transparency
				}
				onScreen.hostageTag		= {
					object = visuals.createDrawing("Text", visuals.defaultProp.flags),
					originalTransparency = visuals.defaultProp.flags.Transparency
				}
				onScreen.moneyTag        = {
					object = visuals.createDrawing("Text", visuals.defaultProp.flags),
					originalTransparency = visuals.defaultProp.flags.Transparency
				}
				onScreen.fakeTag       	= {
					object = visuals.createDrawing("Text", visuals.defaultProp.flags),
					originalTransparency = visuals.defaultProp.flags.Transparency
				}
				offScreen.oofArrow          = {
					object = visuals.createDrawing("Triangle", visuals.defaultProp.oofArrow),
					originalTransparency = visuals.defaultProp.oofArrow.Transparency
				}
				offScreen.oofArrowOutline   = {
					object = visuals.createDrawing("Triangle", visuals.defaultProp.oofArrowOutline),
					originalTransparency = visuals.defaultProp.oofArrowOutline.Transparency
				}
				onScreen.cameraCircle        = {
					object = visuals.createDrawing("Circle", visuals.defaultProp.cameraCircle),
					originalTransparency = visuals.defaultProp.cameraCircle.Transparency
				}
				general.snapLine            = {
					object = visuals.createDrawing("Line", visuals.defaultProp.snapLine),
					originalTransparency = visuals.defaultProp.snapLine.Transparency
				}
				for i = 1, 12 do
					general["lagCompLine" .. i]   = {
						object = visuals.createDrawing("Line", visuals.defaultProp.snapLine),
						originalTransparency = visuals.defaultProp.snapLine.Transparency
					}
				end
			end

			function visuals.getBoundingBox(rootCf, headCf, rootSize, headSize, hipHeight, cacheTable)
				if cacheTable and rootCf then
					cacheTable.rootCf = rootCf
					cacheTable.headCf = headCf
					cacheTable.rootSize = rootSize
					cacheTable.headSize = headSize
					cacheTable.hipHeight = hipHeight
				elseif not rootCf then
					rootCf = cacheTable.rootCf
					headCf = cacheTable.headCf
					rootSize = cacheTable.rootSize
					headSize = cacheTable.headSize
					hipHeight = cacheTable.hipHeight
				end
				local th = headCf * newVector3(0, headSize.y*0.5 + 0.5, 0)
				local bf = rootCf * newVector3(0, -(rootSize.y*0.5 + hipHeight + 0.5), 0)
				local td = (th - rootCf.p).Magnitude
				local bd = (rootCf.p - bf).Magnitude

				local up = rootCf.UpVector
				local tp = rootCf.p + up*td
				local bp = rootCf.p - up*bd

				local top = mathModule.worldToViewportPoint(tp)
				local bottom = mathModule.worldToViewportPoint(bp)

				local width = math.abs(top.x - bottom.x)
				local height = math.max(math.abs(top.y - bottom.y), width / 1.75)

				local size = newVector2(math.floor(math.max(height / 1.7, width * 2.5)), math.floor(height))
				local pos = newVector2(math.floor((bottom.x - size.x + top.x) / 2), math.floor(math.min(top.y, bottom.y)))

				return Rect.new(pos, pos + size)
			end

			function visuals.applyEsp(player)
				repeat task.wait() until playerInfo.storage[player]
				task.wait(1)
				local this = {}
				this.drawingObjects = {
					drawOnScreen    = {},
					drawOffScreen   = {},
					drawGeneral     = {}, --everything in general will always draw if the condition is met
					stoppedRenderingOnScreen    = true,
					stoppedRenderingOffScreen   = true,
					lastData = { --data needed for calculating getboundingbox to preserve the rotation
						headPos = nil,
						torsoCf = nil,
						health = nil,
						maxHealth = nil
					},
				}
				this.transparencyEvent = Instance.new("BindableEvent")
				this.healthPercentageSpring = spring.new()
				this.healthPercentageSpring.s = 24
				this.timePassed = 0
				this.chamsObjects = {}
				this.skeletons = {}
				this.chamsTransConnections = {}
				this.updatechams = false -- homo!!
				this.transConnections = {}
				this.theirpInfo = playerInfo.storage[player]
				
				visuals.initializeDrawingObjects(this.drawingObjects.drawOnScreen, this.drawingObjects.drawOffScreen, this.drawingObjects.drawGeneral)

				for i,v in next, this.drawingObjects.drawOnScreen do
					table.insert(this.transConnections, this.transparencyEvent.Event:Connect(function(transparency)
						v.object.Transparency = v.originalTransparency * (1 - transparency)
					end))
				end
				for i,v in next, this.drawingObjects.drawOffScreen do
					table.insert(this.transConnections, this.transparencyEvent.Event:Connect(function(transparency)
						v.object.Transparency = v.originalTransparency * (1 - transparency)
					end))
				end
				for i,v in next, this.drawingObjects.drawGeneral do
					table.insert(this.transConnections, this.transparencyEvent.Event:Connect(function(transparency)
						v.object.Transparency = v.originalTransparency * (1 - transparency)
					end))
				end

				function this.chamsremoved(character)
					for i = #this.chamsObjects, 1, -1 do
						local object = table.remove(this.chamsObjects, i)
						if object then
							object:Destroy()
							object = nil
						end
					end
					for i = #this.skeletons, 1, -1 do
						local v = table.remove(this.skeletons, i)
						if v then
							v.step:Disconnect()
							v.step = nil
							v.line:Remove()
							v.line = nil
							v.weld = nil
						end
					end
				end
				
				local transparencyFix = function()
					local character = player.Character
					if not character then
						return
					end
					local pInfo = playerInfo.storage[player]
					if not pInfo then
						return
					end
					local section = this and this.theirpInfo and this.theirpInfo.enemy and "Enemy ESP" or "Team ESP"
					local childs = character:GetChildren()
					for i = 1, #childs do
						local accessory = childs[i]
						if accessory and accessory.ClassName == "Accessory" then
							local c = accessory:GetChildren()
							for j = 1, #c do
								local part = c[j]
								if part and part:IsA("BasePart") then
									part.Transparency = Menu["ESP"][section]["Chams"]["Toggle"]["Enabled"] and 1 or 0
								end
							end
						end
					end
				end

				function this.chamsadded(character)
					repeat 
						task.wait() 
					until character ~= nil
					local humanoid = character:WaitForChild("Humanoid", 1/0)
					local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 1/0)
					if humanoid.Health <= 0 then
						return
					end
					local pInfo = playerInfo.storage[player]
					if not pInfo then
						repeat
							pInfo = playerInfo.storage[player]
							task.wait()
						until pInfo
					end
					--what the dog doing
					local section = this and this.theirpInfo and this.theirpInfo.enemy and "Enemy ESP" or "Team ESP"
					humanoidRootPart.AncestryChanged:Connect(function(child, new)
						if new == nil then
							this.chamsremoved()
						end
					end)
					local yeah = tick()
					local loop
					loop = runService.Stepped:Connect(function()
						if tick() - yeah > 5 then
							loop:Disconnect()
							loop = nil
						end
						transparencyFix()
					end)
					for i,v in next, character:GetChildren() do
						if v:IsA("MeshPart") or v:IsA("BasePart") and v:FindFirstChildOfClass("Motor6D") and (v.Transparency ~= 1 or v.Name == "Head") then
							if v.Name == "BackC4" then return end
							local weld = v:FindFirstChildOfClass("Motor6D")
							if weld.Part0 == character.HumanoidRootPart or weld.Part1 == character.HumanoidRootPart then
							else
								if weld and weld.Part0 and weld.Part1 then
									local data = {}
									data.weld = weld
									data.line = visuals.createDrawing("Line", {
										Thickness = 1,
										Color = Menu["ESP"][section]["Skeleton"]["Color 1"]["Color"],
										Visible = false,
										Transparency = 0.5
									})
									local hasBeenHidden = false
									data.step = runService.Stepped:Connect(function()
										local section = this and this.theirpInfo and this.theirpInfo.enemy and "Enemy ESP" or "Team ESP"
										if Menu["ESP"][section]["Enabled"]["Toggle"]["Enabled"] and Menu["ESP"][section]["Skeleton"]["Toggle"]["Enabled"] then
											hasBeenHidden = false
											local p0, v0 = mathModule.worldToViewportPoint(data.weld.Part0.Position)
											local p1, v1 = mathModule.worldToViewportPoint(data.weld.Part1.Position)
											if v0 and v1 then
												data.line.From = newVector2(math.floor(p0.x), math.floor(p0.y))
												data.line.To = newVector2(math.floor(p1.x), math.floor(p1.y))
												data.line.Color = Menu["ESP"][section]["Skeleton"]["Color 1"]["Color"]
												data.line.Visible = true
											else
												data.line.Visible = false
											end
										else
											if hasBeenHidden ~= true then
												data.line.Visible = false
												hasBeenHidden = true
											end
										end
									end)

									table.insert(this.skeletons, data)
								end
							end
						end
						if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and v.Name ~= "Gun" and v.Name ~= "BackC4" and v.Name ~= "HeadHB" and v.Name ~= "Head" then
							local isHead = v.Name == "FakeHead"
							local inner = Instance.new(isHead and "CylinderHandleAdornment" or "BoxHandleAdornment")
							local outline = inner:Clone()
							-- dn
							-- is 1 the inner or outline?
							-- 1 inner
							inner.Name = "inner"
							inner.AlwaysOnTop = true
							inner.Color3 = Menu["ESP"][section]["Chams"]["Color 1"]["Color"]
							inner.Transparency = Menu["ESP"][section]["Chams"]["Color 1"]["Transparency"]
							inner.Visible = Menu["ESP"][section]["Chams"]["Toggle"]["Enabled"]
							inner.ZIndex = 2
							inner.Adornee = v
							inner.Parent = visuals.chamsFolder

							outline.Name = "outer"
							outline.AlwaysOnTop = false
							outline.Color3 = Menu["ESP"][section]["Chams"]["Color 2"]["Color"]
							outline.Transparency = Menu["ESP"][section]["Chams"]["Color 2"]["Transparency"]
							outline.Visible = inner.Visible
							outline.ZIndex = -1
							outline.Adornee = v
							outline.Parent = visuals.chamsFolder

							if isHead then
								inner.CFrame = CFrame.Angles(pi / 2, 0, 0)
								inner.Radius = v.Size.x * 0.58 + 0.001
								inner.Height = v.Size.y + 0.17

								outline.CFrame = inner.CFrame
								outline.Radius = v.Size.x * 0.58 + 0.15
								outline.Height = v.Size.y + 0.32
							else
								inner.Size = v.Size + newVector3(0.001, 0.001, 0.001)
								outline.Size = v.Size + newVector3(0.15, 0.15, 0.15)
							end

							table.insert(this.chamsObjects, inner)
							table.insert(this.chamsObjects, outline)
						end
					end
				end

				function this.updateInnerChams()
					if not this or not this.theirpInfo then return end
					local section = this and this.theirpInfo and this.theirpInfo.enemy and "Enemy ESP" or "Team ESP"
					local chamsEnabled = Menu["ESP"][section]["Chams"]["Toggle"]["Enabled"] and Menu["ESP"][section]["Enabled"]["Toggle"]["Enabled"]
					if this.chamsObjects then
						for i, v in next, this.chamsObjects do
							v.Visible = Menu["ESP"][section]["Chams"]["Toggle"]["Enabled"]
							if v.Name == "inner" then
								v.Color3 = Menu["ESP"][section]["Chams"]["Color 1"]["Color"]
								v.Transparency = chamsEnabled and Menu["ESP"][section]["Chams"]["Color 1"]["Transparency"] or 1
							end
						end
					end
				end
				function this.updateOuterChams()
					if not this or not this.theirpInfo then return end
					local section = this and this.theirpInfo and this.theirpInfo.enemy and "Enemy ESP" or "Team ESP"
					local chamsEnabled = Menu["ESP"][section]["Chams"]["Toggle"]["Enabled"] and Menu["ESP"][section]["Enabled"]["Toggle"]["Enabled"]
					if this.chamsObjects then
						for i, v in next, this.chamsObjects do
							v.Visible = Menu["ESP"][section]["Chams"]["Toggle"]["Enabled"]
							if v.Name == "outer" then
								v.Color3 = Menu["ESP"][section]["Chams"]["Color 2"]["Color"]
								v.Transparency = chamsEnabled and Menu["ESP"][section]["Chams"]["Color 2"]["Transparency"] or 1
							end
						end
					end
				end
				function this.updateChams()
					if not this or not this.theirpInfo then return end
					local section = this and this.theirpInfo and this.theirpInfo.enemy and "Enemy ESP" or "Team ESP"
					local chamsEnabled = Menu["ESP"][section]["Chams"]["Toggle"]["Enabled"] and Menu["ESP"][section]["Enabled"]["Toggle"]["Enabled"]
					if this.chamsObjects then
						for i, v in next, this.chamsObjects do
							v.Visible = Menu["ESP"][section]["Chams"]["Toggle"]["Enabled"]
							if v.Name == "inner" then
								v.Color3 = Menu["ESP"][section]["Chams"]["Color 1"]["Color"]
								v.Transparency = chamsEnabled and Menu["ESP"][section]["Chams"]["Color 1"]["Transparency"] or 1
							elseif v.Name == "outer" then
								v.Color3 = Menu["ESP"][section]["Chams"]["Color 2"]["Color"]
								v.Transparency = chamsEnabled and Menu["ESP"][section]["Chams"]["Color 2"]["Transparency"] or 1
							end
						end
						transparencyFix()
					end
				end
				
				for i,section in next, {"Team ESP", "Enemy ESP"} do
					Menu["ESP"][section]["Enabled"]["Toggle"].Changed:Connect(this.updateChams)
					Menu["ESP"][section]["Chams"]["Toggle"].Changed:Connect(this.updateChams)
					Menu["ESP"][section]["Chams"]["Color 1"].Changed:Connect(this.updateInnerChams)
					Menu["ESP"][section]["Chams"]["Color 2"].Changed:Connect(this.updateOuterChams)
				end

				function this.renderOnScreen(info)
					--debug.profilebegin(player.Name .. " esp render on screen")
					if info.pInfo then
						this.drawingObjects.lastData.pInfo = info.pInfo
					else
						info.pInfo = this.drawingObjects.lastData.pInfo
					end

					local health = info.health
					local maxHealth = info.maxHealth
					local section = ((this and this.theirpInfo and this.theirpInfo.enemy and "Enemy") or "Team") .. " ESP"
					local boundingRect = info.boundingRect
					local drawOnScreen = this.drawingObjects.drawOnScreen
					local boxOutline = drawOnScreen.outlineBox.object
					local box = drawOnScreen.box.object
					local boxFilled =  drawOnScreen.boxFilled.object
					local healthBar = drawOnScreen.healthBar.object
					local healthBarOutline = drawOnScreen.healthBarOutline.object
					local healthBarOutlineOutline = drawOnScreen.healthBarOutlineOutline.object
					local healthNumber = drawOnScreen.healthNumber.object
					local heldWeapon = drawOnScreen.heldWeapon.object
					local heldWeaponIcon = drawOnScreen.heldWeaponIcon.object
					local distanceTag = drawOnScreen.distanceTag.object
					local nameTag = drawOnScreen.nameTag.object
					local armorTag = drawOnScreen.armorTag.object
					local moneyTag = drawOnScreen.moneyTag.object
					local fakeTag = drawOnScreen.fakeTag.object
					local bombTag = drawOnScreen.bombTag.object
					local hostageTag = drawOnScreen.hostageTag.object

					local fakeindicator = 0
					local flagoffset = 0 -- yeah yeah this is gay but fuck off ty!

					local textCase = Menu["ESP"]["ESP Settings"]["Text Case"]["Value"]
					local textSize = Menu["ESP"]["ESP Settings"]["Text Size"]["Value"]
					local textFont = Drawing.Fonts[Menu["ESP"]["ESP Settings"]["Text Font"]["Value"]]

					local textFlagCase = Menu["ESP"]["ESP Settings"]["Flag Text Case"]["Value"]
					local textFlagSize = Menu["ESP"]["ESP Settings"]["Flag Text Size"]["Value"]
					local textFlagFont = Drawing.Fonts[Menu["ESP"]["ESP Settings"]["Flag Text Font"]["Value"]]

					this.healthPercentageSpring.t = info.pInfo.god == true and 0 or health/maxHealth
					if info.pInfo.character and findFirstChild(info.pInfo.character, "EquippedTool") then
						this.drawingObjects.lastData.weapon = textCase == "lowercase" and info.pInfo.character.EquippedTool.Value:lower() or textCase == "UPPERCASE" and info.pInfo.character.EquippedTool.Value:upper() or info.pInfo.character.EquippedTool.Value
					end

					--debug.profilebegin(player.Name .. " esp render on screen box")
					if Menu["ESP"][section]["Box"]["Toggle"]["Enabled"] then
						box.Position = boundingRect.Min
						box.Size = boundingRect.Max - boundingRect.Min

						boxOutline.Position = box.Position
						boxOutline.Size = box.Size

						box.Color = Menu["ESP"][section]["Box"]["Color 1"]["Color"]
						boxFilled.Color = Menu["ESP"][section]["Filled Box"]["Color 1"]["Color"] 
						boxFilled.Transparency = 1 - Menu["ESP"][section]["Filled Box"]["Color 1"]["Transparency"]

						if Menu["ESP"][section]["Filled Box"]["Toggle"]["Enabled"] then
							boxFilled.Position = box.Position + newVector2(math.floor(box.Thickness / 2) + 1, math.floor(box.Thickness / 2) + 1)
							boxFilled.Size = box.Size - newVector2(box.Thickness + 1, box.Thickness + 1)
							boxFilled.Visible = true
						else
							boxFilled.Visible = false
						end
						box.Visible = true
						boxOutline.Visible = true
					else
						box.Visible = false
						boxFilled.Visible = false
						boxOutline.Visible = false
					end
					--debug.profileend()

					--debug.profilebegin(player.Name .. " esp render on screen health bar")
					if Menu["ESP"][section]["Health Bar"]["Toggle"]["Enabled"] then
						local hpMax = Menu["ESP"][section]["Health Bar"]["Color 1"]["Color"]
						local hpLow = Menu["ESP"][section]["Health Bar"]["Color 2"]["Color"]

						local healthPercentage = this.healthPercentageSpring.p
						local fullSize = boundingRect.Height
						local chunk = fullSize * healthPercentage

						healthBar.Size = newVector2(2, chunk)
						healthBar.Position = boundingRect.Min + newVector2(-5, fullSize - chunk)
						healthBarOutline.Size = newVector2(4, fullSize + 2)
						healthBarOutline.Position = boundingRect.Min + newVector2(-6, -1)
						healthBarOutlineOutline.Size = healthBarOutline.Size
						healthBarOutlineOutline.Position = healthBarOutline.Position
						healthBar.Color = hpLow:Lerp(hpMax, healthPercentage)

						local isGradient = Menu["ESP"][section]["Gradient Health Bar"]["Toggle"]["Enabled"]

						healthBar.Visible = not isGradient
						healthBarOutline.Visible = true
						healthBarOutlineOutline.Visible = true

						if isGradient then
							local sizePerSegment = math.ceil(fullSize / visuals.gradentHealthBarSegments)
							local maxSegments = fullSize / sizePerSegment + 1
							local minSegments = chunk / sizePerSegment + 1
							local skipped = maxSegments - minSegments

							local healthPos = healthBar.Position
							local healthSizeX = healthBar.Size.x
							local healthSizeY = healthBar.Size.y

							for i = 1, visuals.gradentHealthBarSegments do
								local segment = drawOnScreen["healthBarSegment" .. i].object

								local projectedPosMin = newVector2(0, (i-1) * sizePerSegment)
								local ProjectedPosMax = projectedPosMin + newVector2(0, sizePerSegment)

								if projectedPosMin.y > chunk then
									segment.Visible = false
								else
									segment.Visible = true
									segment.Position = healthPos + projectedPosMin
									segment.Size = newVector2(healthSizeX, ProjectedPosMax.y - healthSizeY > 0 and sizePerSegment - (ProjectedPosMax.y - healthSizeY) or sizePerSegment)
									segment.Color = hpMax:Lerp(hpLow, (i + skipped)/maxSegments)
								end
							end
						else
							if drawOnScreen["healthBarSegment1"].object.Visible == true then
								for i = 1, visuals.gradentHealthBarSegments do
									drawOnScreen["healthBarSegment" .. i].object.Visible = false
								end 
							end
						end
					else
						healthBar.Visible = false
						healthBarOutline.Visible = false
						healthBarOutlineOutline.Visible = false

						if drawOnScreen["healthBarSegment1"].object.Visible == true then
							for i = 1, visuals.gradentHealthBarSegments do
								drawOnScreen["healthBarSegment" .. i].object.Visible = false
							end 
						end
					end
					--debug.profileend()

					--debug.profilebegin(player.Name .. " esp render on screen health bar number")
					if Menu["ESP"][section]["Health Bar"]["Toggle"]["Enabled"] and ((Menu["ESP"][section]["Health Number"]["Toggle"]["Enabled"] and health <= Menu["ESP"]["ESP Settings"]["Max HP Visibility Cap"]["Value"]) or info.pInfo.god) then
						local godded = info.pInfo.god

						healthNumber.Text = godded and "God" or tostring(math.floor((this.healthPercentageSpring.p * maxHealth) + 0.5))
						local offset = godded and 0 or (2 * this.healthPercentageSpring.p) - 1
						healthNumber.Position = godded and boundingRect.Min + newVector2(-5 - healthBar.Size.x - (healthNumber.TextBounds.X/2), (boundingRect.Height*0.5) - healthNumber.TextBounds.Y/2 + (offset * (healthNumber.Size/4)) - (offset * 1)) or healthBar.Position + newVector2(-healthBar.Size.x - (healthNumber.TextBounds.X/2) - 1, -healthNumber.TextBounds.Y/2) + newVector2(0, (offset * (healthNumber.Size + 1) * 0.25))
						healthNumber.Color = Color3.new(1, 1, 1)
						healthNumber.Visible = true
					else
						healthNumber.Visible = false
					end
					--debug.profileend()

					--debug.profilebegin(player.Name .. " esp render on screen held weapon")
					local theOffsetBullshit = 0
					if Menu["ESP"][section]["Held Weapon"]["Toggle"]["Enabled"] then
						heldWeapon.Text = this.drawingObjects.lastData.weapon
						heldWeapon.Size = textSize
						heldWeapon.Font = textFont
						heldWeapon.Position = boundingRect.Min + newVector2(math.floor(boundingRect.Width / 2), boundingRect.Height + 2)
						heldWeapon.Color = Menu["ESP"][section]["Held Weapon"]["Color 1"]["Color"]
						heldWeapon.Visible = true
						theOffsetBullshit = theOffsetBullshit + textSize
					else
						heldWeapon.Visible = false
					end
					--debug.profileend()

					--debug.profilebegin(player.Name .. " esp render on screen held weapon icon")
					if Menu["ESP"][section]["Held Weapon Icon"]["Toggle"]["Enabled"] then
						local data = info.pInfo.character and findFirstChild(info.pInfo.character, "EquippedTool") and findFirstChild(info.pInfo.character, "EquippedTool").Value or this.drawingObjects.lastData.lastHeldWeapon
						if this.drawingObjects.lastData.lastHeldWeapon ~= data then
							heldWeaponIcon.Data = visuals.imagecache[data] or visuals.imagecache["C4"]
						end
						this.drawingObjects.lastData.lastHeldWeapon = data
						heldWeaponIcon.Position = boundingRect.Min + newVector2(math.floor((boundingRect.Width / 2) - (heldWeaponIcon.Size.X / 2)), boundingRect.Height + theOffsetBullshit + 2)
						heldWeaponIcon.Color = Menu["ESP"][section]["Held Weapon Icon"]["Color 1"]["Color"]
						heldWeaponIcon.Visible = true
						theOffsetBullshit = theOffsetBullshit + heldWeaponIcon.Size.Y
					else
						heldWeaponIcon.Visible = false
					end
					--debug.profileend()

					--debug.profilebegin(player.Name .. " esp render on screen distance")
					if Menu["ESP"][section]["Distance"]["Toggle"]["Enabled"] then
						distanceTag.Text = mathModule.truncateNumber((this.drawingObjects.lastData.headCf.p - camera.CFrame.p).Magnitude, 1) .. (textCase == "lowercase" and " st" or textCase == "UPPERCASE" and " ST" or " st")
						distanceTag.Position = boundingRect.Min + newVector2(math.floor(boundingRect.Width / 2), boundingRect.Height + theOffsetBullshit + 2)
						distanceTag.Size = textSize
						distanceTag.Font = textFont
						distanceTag.Color = Menu["ESP"][section]["Distance"]["Color 1"]["Color"]
						distanceTag.Visible = true
					else
						distanceTag.Visible = false
					end
					--debug.profileend()

					--debug.profilebegin(player.Name .. " esp render on screen name")
					if Menu["ESP"][section]["Name"]["Toggle"]["Enabled"] then
						nameTag.Color = Menu["ESP"][section]["Name"]["Color 1"]["Color"]
						nameTag.Text = textCase == "lowercase" and player.Name:lower() or textCase == "UPPERCASE" and player.Name:upper() or player.Name
						nameTag.Position = boundingRect.Min + newVector2(math.floor(boundingRect.Width / 2), -2 - nameTag.TextBounds.y)
						nameTag.Size = textSize
						nameTag.Font = textFont
						nameTag.Visible = true
					else
						nameTag.Visible = false
					end
					--debug.profileend()

					--debug.profilebegin(player.Name .. " esp render on screen armor")
					if Menu["ESP"][section]["Armor"]["Toggle"]["Enabled"] then
						armorTag.Color = Menu["ESP"][section]["Armor"]["Color 1"]["Color"]
						local str = ""
						if player:FindFirstChild("Helmet") then
							str = str .. "H"
						end
						if player:FindFirstChild("Kevlar") then
							str = str .. "K"
						end

						local rawText = str
						local rawTextSplit = string.split(rawText:lower(), "")
						if rawTextSplit[1] then
							rawTextSplit[1] = rawTextSplit[1]:upper()
							for i, char in next, rawTextSplit do
								if ((char == " " or char == "-") and i < #rawTextSplit) then
									rawTextSplit[i + 1] = rawTextSplit[i + 1]:upper()
								end
							end
						end
						local fixedText = table.concat(rawTextSplit)

						armorTag.Text = textFlagCase == "lowercase" and str:lower() or textFlagCase == "UPPERCASE" and str:upper() or fixedText
						armorTag.Position = boundingRect.Min + newVector2(math.floor(boundingRect.Width) + (armorTag.TextBounds.X / 2) + 2, -3)
						if str ~= "" then
							flagoffset = flagoffset + armorTag.TextBounds.Y
						end
						armorTag.Visible = true
						armorTag.Font = textFlagFont
						armorTag.Size = textFlagSize
					else
						armorTag.Visible = false
					end
					--debug.profileend()

					--debug.profilebegin(player.Name .. " esp render on screen money")
					if Menu["ESP"][section]["Money"]["Toggle"]["Enabled"] then
						moneyTag.Color = Menu["ESP"][section]["Money"]["Color 1"]["Color"]
						moneyTag.Text = tostring(player.Cash.Value) .. "$"

						moneyTag.Font = textFlagFont
						moneyTag.Size = textFlagSize

						moneyTag.Position = boundingRect.Min + newVector2(math.floor(boundingRect.Width) + (moneyTag.TextBounds.X / 2) + 2, -3 + flagoffset)
						flagoffset = flagoffset + moneyTag.TextBounds.Y
						moneyTag.Visible = true
					else
						moneyTag.Visible = false
					end
					--debug.profileend()

					--debug.profilebegin(player.Name .. " esp render on screen fake")
					local cameraCf = findFirstChild(player, "CameraCF")
					local desync = (cameraCf.Value.p - this.drawingObjects.lastData.headCf.p).Magnitude
					fakeindicator = (0.1 * desync - 1.2)
					if section == "Enemy ESP" and Menu["ESP"][section]["Fake"]["Toggle"]["Enabled"] and cameraCf.Value ~= emptyCf and cameraCf.Value == cameraCf.Value and desync > 12 and fakeindicator > 0 then
						fakeTag.Color = Menu["ESP"][section]["Fake"]["Color 1"]["Color"]
						fakeTag.Text =  textFlagCase == "lowercase" and "fake" or textFlagCase == "UPPERCASE" and "FAKE" or "Fake"
						fakeTag.Transparency = fakeindicator
						fakeTag.Position = boundingRect.Min + newVector2(math.floor(boundingRect.Width) + (fakeTag.TextBounds.X / 2) + 2, -3 + flagoffset)
						flagoffset = flagoffset + fakeTag.TextBounds.Y
						fakeTag.Visible = true
					else
						fakeTag.Visible = false
					end
					--debug.profileend()

					--debug.profilebegin(player.Name .. " esp render on screen bomb")
					if workspace:FindFirstChild("Status") and workspace.Status:FindFirstChild("HasBomb") and workspace.Status.HasBomb.Value == player.Name then
						this.drawingObjects.lastData.hadBomb = true
					else
						this.drawingObjects.lastData.hadBomb = false
					end
					if Menu["ESP"][section]["Bomb"]["Toggle"]["Enabled"] and this.drawingObjects.lastData.hadBomb then
						bombTag.Color = Menu["ESP"][section]["Bomb"]["Color 1"]["Color"]
						bombTag.Text =  textFlagCase == "lowercase" and "bomb" or textFlagCase == "UPPERCASE" and "BOMB" or "Bomb"
						bombTag.Position = boundingRect.Min + newVector2(math.floor(boundingRect.Width) + (bombTag.TextBounds.X / 2) + 2, -3 + flagoffset)
						flagoffset = flagoffset + bombTag.TextBounds.Y
						bombTag.Visible = true
					else
						bombTag.Visible = false
					end
					--debug.profileend()

					--debug.profilebegin(player.Name .. " esp render on screen hostage")
					if workspace:FindFirstChild("Ray_Ignore") and workspace.Ray_Ignore:FindFirstChild(player.Name) and workspace.Ray_Ignore[player.Name]:FindFirstChild("Hostage") then
						this.drawingObjects.lastData.hadHostage = true
					else
						this.drawingObjects.lastData.hadHostage = false
					end
					if Menu["ESP"][section]["Hostage"]["Toggle"]["Enabled"] and this.drawingObjects.lastData.hadHostage then
						hostageTag.Color = Menu["ESP"][section]["Hostage"]["Color 1"]["Color"]
						hostageTag.Text =  textFlagCase == "lowercase" and "hostage" or textFlagCase == "UPPERCASE" and "HOSTAGE" or "Hostage"
						hostageTag.Position = boundingRect.Min + newVector2(math.floor(boundingRect.Width) + (hostageTag.TextBounds.X / 2) + 2, -3 + flagoffset)
						flagoffset = flagoffset + hostageTag.TextBounds.Y
						hostageTag.Visible = true
					else
						hostageTag.Visible = false
					end
					--debug.profileend()

					--debug.profilebegin(player.Name .. " esp render on screen hightlight")
					if (ragebot and ragebot.currenttarget and ragebot.currenttarget.player == player or legitbot and legitbot.aimassisttarget and legitbot.aimassisttarget.player == player) and Menu["ESP"]["ESP Settings"]["Highlight Aimbot Target"]["Toggle"]["Enabled"] then
						for i, v in next, this.chamsObjects do 
							if v.Name == "inner" then
								local color = Menu["ESP"]["ESP Settings"]["Highlight Aimbot Target"]["Color 1"]["Color"]
								v.Color3 = Color3.fromRGB(math.clamp((color.R * 255) - 75, 0, 255), math.clamp((color.G * 255) - 75, 0, 255), math.clamp((color.B * 255) - 75, 0, 255))
							else
								v.Color3 = Menu["ESP"]["ESP Settings"]["Highlight Aimbot Target"]["Color 1"]["Color"]
							end
						end
						this.updatechams = true
						for i, v in next, drawOnScreen do
							if v.object == healthBarOutline or v.object == healthBarOutlineOutline or v.object == boxOutline then
							else
								v.object.Color = Menu["ESP"]["ESP Settings"]["Highlight Aimbot Target"]["Color 1"]["Color"]
							end
						end
					else
						if this.updatechams == true then
							this.updateChams()
							this.updatechams = false
						end
					end
					--debug.profileend()
					--make visible
					this.drawingObjects.stoppedRenderingOnScreen = false

					if not this.drawingObjects.stoppedRenderingOffScreen then
						this.drawingObjects.stoppedRenderingOffScreen = true
						for i,v in next, this.drawingObjects.drawOffScreen do
							v.object.Visible = false
						end
					end
					--debug.profileend()
				end

				function this.renderOffScreen(info)
					--debug.profilebegin(player.Name .. " esp render off screen")
					local pos = CFrame.lookAt(camera.CFrame.p, camera.CFrame.p + camera.CFrame.LookVector * newVector3(1, 0, 1)):PointToObjectSpace(info.position)

					--arrow
					if not (executor == "ScriptWare" and platform == "Mac") then
						local oofArrow = this.drawingObjects.drawOffScreen.oofArrow.object
						local oofArrowOutline = this.drawingObjects.drawOffScreen.oofArrowOutline.object
						if Menu["ESP"]["Enemy ESP"]["Out of View Arrows"]["Toggle"]["Enabled"] and this and this.theirpInfo and this.theirpInfo.enemy then
							local angle = math.atan2(pos.z, pos.x)

							local cx, sy = math.cos(angle), math.sin(angle)
							local cx1, sy1 = math.cos(angle + pi/2), math.sin(angle + pi/2)
							local cx2, sy2 = math.cos(angle + pi/2*3), math.sin(angle + pi/2*3)

							local viewport = camera.ViewportSize
							local bigger = math.max(viewport.x, viewport.y)
							local smaller = math.min(viewport.x, viewport.y)
							local arrowSize = math.clamp(Menu["ESP"]["Enemy ESP"]["Dynamic Arrow Size"]["Toggle"]["Enabled"] and mathModule.map((info.position - camera.CFrame.p).Magnitude, 1, 100, 30, 10) or Menu["ESP"]["Enemy ESP"]["Arrow Size"]["Value"], 4, 1/0)
							local arrowPercentage = Menu["ESP"]["Enemy ESP"]["Arrow Distance"]["Value"]

							local arrowOrigin = viewport/2 + (Vector2.new(cx, sy) * Vector2.new(bigger * arrowPercentage/200, smaller * arrowPercentage/200))

							oofArrow.PointA = arrowOrigin + Vector2.new(arrowSize*2 * cx, arrowSize*2 * sy)
							oofArrow.PointB = arrowOrigin + Vector2.new(arrowSize * cx1, arrowSize * sy1)
							oofArrow.PointC = arrowOrigin + Vector2.new(arrowSize * cx2, arrowSize * sy2)
							oofArrow.Color = Menu["ESP"]["Enemy ESP"]["Out of View Arrows"]["Color 1"]["Color"]

							oofArrowOutline.PointA = oofArrow.PointA
							oofArrowOutline.PointB = oofArrow.PointB
							oofArrowOutline.PointC = oofArrow.PointC
							
							oofArrowOutline.Color = Color3.new(math.max(0, Menu["ESP"]["Enemy ESP"]["Out of View Arrows"]["Color 1"]["Color"].r * 0.5), math.max(0, Menu["ESP"]["Enemy ESP"]["Out of View Arrows"]["Color 1"]["Color"].g * 0.5), math.max(0, Menu["ESP"]["Enemy ESP"]["Out of View Arrows"]["Color 1"]["Color"].b * 0.5))

							local trans = ((math.cos(tick() * 2 * pi) * (0.75 - (0.25 * (math.cos(tick() * 2 * pi))))) / 2) + 0.75
							this.drawingObjects.drawOffScreen.oofArrow.originalTransparency = trans
							this.drawingObjects.drawOffScreen.oofArrowOutline.originalTransparency = trans

							oofArrow.Transparency = trans
							oofArrowOutline.Transparency = trans

							oofArrow.Visible = true
							oofArrowOutline.Visible = true
						else
							oofArrowOutline.Visible = false
							oofArrow.Visible = false
						end
					end

					this.drawingObjects.stoppedRenderingOffScreen = false

					if not this.drawingObjects.stoppedRenderingOnScreen then
						this.drawingObjects.stoppedRenderingOnScreen = true
						for i,v in next, this.drawingObjects.drawOnScreen do
							v.object.Visible = false
						end
					end
					--debug.profileend()
				end

				function this.renderGeneral(info)
					--debug.profilebegin(player.Name .. " esp render general")
					local snapLine = this.drawingObjects.drawGeneral.snapLine.object
					local pos, onScreen = mathModule.worldToViewportPoint(info.position, false, 50)

					if not onScreen then
						local angle
						local centerX, centerY = viewportSize.x/2, viewportSize.y/2
						if pos.z > 0 then
							angle = math.atan2(pos.y - centerY, pos.x - centerX)
						else
							angle = math.atan2(centerY - pos.y, centerX - pos.x)
						end

						local x = math.cos(angle)
						local y = math.sin(angle)
						local slope = y/x
						local xEdge, yEdge = viewportSize.x, viewportSize.y
						if y < 0 then
							yEdge = 0
						end

						if x < 0 then
							xEdge = 0
						end

						local newY = slope*xEdge + centerY - slope*centerX
						if newY > 0 and newY < viewportSize.y then
							pos = Vector2.new(xEdge, newY)
						else
							pos = Vector2.new((yEdge - centerY + slope*centerX)/slope, yEdge)
						end
					end

					local section = (this and this.theirpInfo and this.theirpInfo.enemy and "Enemy" or "Team") .. " ESP"
					if Menu["ESP"][section]["Snap Lines"]["Toggle"]["Enabled"] then
						local trans = (1 - Menu["ESP"][section]["Snap Lines"]["Color 1"]["Transparency"]) * (onScreen and 1 or 0.5)
						snapLine.From = newVector2(math.floor(viewportSize.x / 2), math.floor(viewportSize.y - 50))
						snapLine.To = Vector2.new(pos.x, pos.y)
						snapLine.Transparency = trans
						snapLine.Color = Menu["ESP"][section]["Snap Lines"]["Color 1"]["Color"]
						snapLine.Visible = true
					else
						snapLine.Visible = false
					end

					local cameraCircle = this.drawingObjects.drawOnScreen.cameraCircle.object
					local cameraCf = findFirstChild(player, "CameraCF")
					local desync = (cameraCf.Value.p - info.position).Magnitude
					fakeindicator = (0.1 * desync - 1.2)
					if section:find("Enemy") and Menu["ESP"]["Enemy ESP"]["Show Resolved Position"]["Toggle"]["Enabled"] and findFirstChild(player, "CameraCF") and this.timePassed == 0 then
						if cameraCf.Value ~= emptyCf and cameraCf.Value == cameraCf.Value and desync > 12 then
							local pos, onScreen = mathModule.worldToViewportPoint(cameraCf.Value.p)
							if onScreen then
								cameraCircle.Position = newVector2(math.floor(pos.x), math.floor(pos.y))
								cameraCircle.Transparency = fakeindicator
								cameraCircle.Color = Menu["ESP"]["Enemy ESP"]["Show Resolved Position"]["Color 1"]["Color"]
								cameraCircle.Visible = true
							else
								cameraCircle.Visible = false
							end
						else
							cameraCircle.Visible = false
						end
					else
						cameraCircle.Visible = false
					end

					if section:find("Enemy") and Menu["ESP"]["Enemy ESP"]["Show Extrapolation Position"]["Toggle"]["Enabled"] and Menu["Rage"]["Tracking"]["Extrapolation"]["Toggle"]["Enabled"] and player.Character and player.Character:FindFirstChild("Humanoid") and this.timePassed == 0 and info.pInfo.velocity.Magnitude > 0.01 then
						local extrapolatedparam = RaycastParams.new()
						extrapolatedparam.IgnoreWater = true
						extrapolatedparam.FilterType = Enum.RaycastFilterType.Whitelist
						extrapolatedparam.FilterDescendantsInstances = {workspace.Map} -- this cannot be moved through under normal circumstances	

						local cf = CFrame.new(info.pInfo.currentPosition)
						local size = Vector3.new(2, 6, 2)
						local extrapolateby = info.pInfo.velocity * ((Menu["Rage"]["Tracking"]["Extrapolation Tuning"]["Value"] + (game.Stats.PerformanceStats.Ping:GetValue() * 2)) / 1000) -- this is how far ahead in time we are extrapolating

						local cast = workspaceRaycast(workspace, cf.p, extrapolateby, extrapolatedparam)
						local extrapolated = cast and cast.Position or cf.p + extrapolateby

						-- this is terrible but i need to do this asap
						local currentColor = Menu["ESP"]["Enemy ESP"]["Show Extrapolation Position"]["Color 1"]["Color"]
						do
							local verticee1 = extrapolated + Vector3.new(size.x / 2, size.y / 2, size.z / 2)
							local verticee2 = extrapolated + Vector3.new(size.x / 2, -size.y / 2, size.z / 2)

							local pos1, onScreen1 = mathModule.worldToViewportPoint(verticee1)
							local pos2, onScreen2 = mathModule.worldToViewportPoint(verticee2)

							local segment = this.drawingObjects.drawGeneral.lagCompLine1.object
							if onScreen1 and onScreen2 then
								segment.From = newVector2(pos1.x, pos1.y)
								segment.To = newVector2(pos2.x, pos2.y)
								segment.Color = currentColor
								segment.Visible = true
							else
								segment.Visible = false
							end
						end
						do
							local verticee1 = extrapolated + Vector3.new(-size.x / 2, size.y / 2, size.z / 2)
							local verticee2 = extrapolated + Vector3.new(-size.x / 2, -size.y / 2, size.z / 2)

							local pos1, onScreen1 = mathModule.worldToViewportPoint(verticee1)
							local pos2, onScreen2 = mathModule.worldToViewportPoint(verticee2)

							local segment = this.drawingObjects.drawGeneral.lagCompLine2.object
							if onScreen1 and onScreen2 then
								segment.From = newVector2(pos1.x, pos1.y)
								segment.To = newVector2(pos2.x, pos2.y)
								segment.Color = currentColor
								segment.Visible = true
							else
								segment.Visible = false
							end
						end
						do
							local verticee1 = extrapolated + Vector3.new(-size.x / 2, size.y / 2, -size.z / 2)
							local verticee2 = extrapolated + Vector3.new(-size.x / 2, -size.y / 2, -size.z / 2)

							local pos1, onScreen1 = mathModule.worldToViewportPoint(verticee1)
							local pos2, onScreen2 = mathModule.worldToViewportPoint(verticee2)

							local segment = this.drawingObjects.drawGeneral.lagCompLine3.object
							if onScreen1 and onScreen2 then
								segment.From = newVector2(pos1.x, pos1.y)
								segment.To = newVector2(pos2.x, pos2.y)
								segment.Color = currentColor
								segment.Visible = true
							else
								segment.Visible = false
							end
						end
						do
							local verticee1 = extrapolated + Vector3.new(size.x / 2, size.y / 2, -size.z / 2)
							local verticee2 = extrapolated + Vector3.new(size.x / 2, -size.y / 2, -size.z / 2)

							local pos1, onScreen1 = mathModule.worldToViewportPoint(verticee1)
							local pos2, onScreen2 = mathModule.worldToViewportPoint(verticee2)

							local segment = this.drawingObjects.drawGeneral.lagCompLine4.object
							if onScreen1 and onScreen2 then
								segment.From = newVector2(pos1.x, pos1.y)
								segment.To = newVector2(pos2.x, pos2.y)
								segment.Color = currentColor
								segment.Visible = true
							else
								segment.Visible = false
							end
						end
						-- animated bits (tits)
						local upper = math.sin(tick() * 2)
						do
							local verticee1 = extrapolated + Vector3.new(size.x / 2, size.y / 2 * upper, size.z / 2)
							local verticee2 = extrapolated + Vector3.new(-size.x / 2, size.y / 2 * upper, size.z / 2)

							local pos1, onScreen1 = mathModule.worldToViewportPoint(verticee1)
							local pos2, onScreen2 = mathModule.worldToViewportPoint(verticee2)

							local segment = this.drawingObjects.drawGeneral.lagCompLine5.object
							if onScreen1 and onScreen2 then
								segment.From = newVector2(pos1.x, pos1.y)
								segment.To = newVector2(pos2.x, pos2.y)
								segment.Color = currentColor
								segment.Visible = true
							else
								segment.Visible = false
							end
						end
						do
							local verticee1 = extrapolated + Vector3.new(size.x / 2, size.y / 2 * upper, size.z / 2)
							local verticee2 = extrapolated + Vector3.new(size.x / 2, size.y / 2 * upper, -size.z / 2)

							local pos1, onScreen1 = mathModule.worldToViewportPoint(verticee1)
							local pos2, onScreen2 = mathModule.worldToViewportPoint(verticee2)

							local segment = this.drawingObjects.drawGeneral.lagCompLine6.object
							if onScreen1 and onScreen2 then
								segment.From = newVector2(pos1.x, pos1.y)
								segment.To = newVector2(pos2.x, pos2.y)
								segment.Color = currentColor
								segment.Visible = true
							else
								segment.Visible = false
							end
						end
						do
							local verticee1 = extrapolated + Vector3.new(-size.x / 2, size.y / 2 * upper, -size.z / 2)
							local verticee2 = extrapolated + Vector3.new(-size.x / 2, size.y / 2 * upper, size.z / 2)

							local pos1, onScreen1 = mathModule.worldToViewportPoint(verticee1)
							local pos2, onScreen2 = mathModule.worldToViewportPoint(verticee2)

							local segment = this.drawingObjects.drawGeneral.lagCompLine7.object
							if onScreen1 and onScreen2 then
								segment.From = newVector2(pos1.x, pos1.y)
								segment.To = newVector2(pos2.x, pos2.y)
								segment.Color = currentColor
								segment.Visible = true
							else
								segment.Visible = false
							end
						end
						do
							local verticee1 = extrapolated + Vector3.new(-size.x / 2, size.y / 2 * upper, -size.z / 2)
							local verticee2 = extrapolated + Vector3.new(size.x / 2, size.y / 2 * upper, -size.z / 2)

							local pos1, onScreen1 = mathModule.worldToViewportPoint(verticee1)
							local pos2, onScreen2 = mathModule.worldToViewportPoint(verticee2)

							local segment = this.drawingObjects.drawGeneral.lagCompLine8.object
							if onScreen1 and onScreen2 then
								segment.From = newVector2(pos1.x, pos1.y)
								segment.To = newVector2(pos2.x, pos2.y)
								segment.Color = currentColor
								segment.Visible = true
							else
								segment.Visible = false
							end
						end
						upper = -upper
						do
							local verticee1 = extrapolated + Vector3.new(size.x / 2, size.y / 2 * upper, size.z / 2)
							local verticee2 = extrapolated + Vector3.new(-size.x / 2, size.y / 2 * upper, size.z / 2)

							local pos1, onScreen1 = mathModule.worldToViewportPoint(verticee1)
							local pos2, onScreen2 = mathModule.worldToViewportPoint(verticee2)

							local segment = this.drawingObjects.drawGeneral.lagCompLine9.object
							if onScreen1 and onScreen2 then
								segment.From = newVector2(pos1.x, pos1.y)
								segment.To = newVector2(pos2.x, pos2.y)
								segment.Color = currentColor
								segment.Visible = true
							else
								segment.Visible = false
							end
						end
						do
							local verticee1 = extrapolated + Vector3.new(size.x / 2, size.y / 2 * upper, size.z / 2)
							local verticee2 = extrapolated + Vector3.new(size.x / 2, size.y / 2 * upper, -size.z / 2)

							local pos1, onScreen1 = mathModule.worldToViewportPoint(verticee1)
							local pos2, onScreen2 = mathModule.worldToViewportPoint(verticee2)

							local segment = this.drawingObjects.drawGeneral.lagCompLine10.object
							if onScreen1 and onScreen2 then
								segment.From = newVector2(pos1.x, pos1.y)
								segment.To = newVector2(pos2.x, pos2.y)
								segment.Color = currentColor
								segment.Visible = true
							else
								segment.Visible = false
							end
						end
						do
							local verticee1 = extrapolated + Vector3.new(-size.x / 2, size.y / 2 * upper, -size.z / 2)
							local verticee2 = extrapolated + Vector3.new(-size.x / 2, size.y / 2 * upper, size.z / 2)

							local pos1, onScreen1 = mathModule.worldToViewportPoint(verticee1)
							local pos2, onScreen2 = mathModule.worldToViewportPoint(verticee2)

							local segment = this.drawingObjects.drawGeneral.lagCompLine11.object
							if onScreen1 and onScreen2 then
								segment.From = newVector2(pos1.x, pos1.y)
								segment.To = newVector2(pos2.x, pos2.y)
								segment.Color = currentColor
								segment.Visible = true
							else
								segment.Visible = false
							end
						end
						do
							local verticee1 = extrapolated + Vector3.new(-size.x / 2, size.y / 2 * upper, -size.z / 2)
							local verticee2 = extrapolated + Vector3.new(size.x / 2, size.y / 2 * upper, -size.z / 2)

							local pos1, onScreen1 = mathModule.worldToViewportPoint(verticee1)
							local pos2, onScreen2 = mathModule.worldToViewportPoint(verticee2)

							local segment = this.drawingObjects.drawGeneral.lagCompLine12.object
							if onScreen1 and onScreen2 then
								segment.From = newVector2(pos1.x, pos1.y)
								segment.To = newVector2(pos2.x, pos2.y)
								segment.Color = currentColor
								segment.Visible = true
							else
								segment.Visible = false
							end
						end
					else
						for i = 1, 12 do
							local segment = this.drawingObjects.drawGeneral["lagCompLine" .. i].object
							segment.Visible = false
						end
					end
					--debug.profileend()
				end

				function this.onSpawned()
					local pInfo = playerInfo.storage[player]
					repeat 
						task.wait()
					until pInfo and pInfo.alive -- FUCK INTEGER HARD
					if this.step then
						this.step:Disconnect()
						this.step = nil
					end
					this.transparencyEvent:Fire(0)
					this.fadefinished = true
					
					this.step = runService.Stepped:Connect(function(upTime, deltaTime)
						--debug.profilebegin(player.Name .. " esp spawned render")
						if pInfo and (pInfo.alive or pInfo.god) then
							local section = pInfo.enemy and "Enemy" or "Team"
							local health, maxHealth = pInfo.humanoid.Health, pInfo.humanoid.MaxHealth
							this.drawingObjects.lastData.health = health
							this.drawingObjects.lastData.maxHealth = maxHealth
							local enabled = Menu["ESP"][section .. " ESP"]["Enabled"]["Toggle"]["Enabled"]
							if enabled then
								this.timePassed = 0
								local onScreen = mathModule.spherePoint(pInfo.head.Position, 4)
								if onScreen then
									this.renderOnScreen({
										boundingRect = visuals.getBoundingBox(pInfo.rootpart.CFrame, pInfo.head.CFrame, pInfo.rootpart.Size, pInfo.head.Size, pInfo.humanoid.HipHeight, this.drawingObjects.lastData),
										pInfo = pInfo,
										health = health,
										maxHealth = maxHealth
									})
								else
									this.renderOffScreen({
										position = pInfo.currentPosition
									})
								end
								this.renderGeneral({
									position = pInfo.currentPosition,
									pInfo = pInfo
								})
							else
								this.timePassed = 1
								if not this.drawingObjects.stoppedRenderingOnScreen then
									this.drawingObjects.stoppedRenderingOnScreen = true
									for i,v in next, this.drawingObjects.drawOnScreen do
										v.object.Visible = false
									end
								end
								if not this.drawingObjects.stoppedRenderingOffScreen then
									this.drawingObjects.stoppedRenderingOffScreen = true
									for i,v in next, this.drawingObjects.drawOffScreen do
										v.object.Visible = false
									end
								end
								for i,v in next, this.drawingObjects.drawGeneral do
									v.object.Visible = false
								end
							end
						else
							if this and this.onDied then
								this.onDied()
							end
						end
						--debug.profileend()
					end)
				end
				function this.onDied()
					local pInfo = playerInfo.storage[player]
					if this.step then
						this.step:Disconnect()
						this.step = nil	
					end
					this.fadefinished = false
					this.timePassed = 0
					this.step = runService.Stepped:Connect(function(upTime, deltaTime)
						--debug.profilebegin(player.Name .. " esp died render")
						if not this.timePassed then
							this.timePassed = 1
						end
						this.timePassed = this.timePassed + (deltaTime * 4)
						if this.timePassed >= 1 then
							if this.step then
								this.step:Disconnect()
							end
							for i,v in next, this.drawingObjects.drawOnScreen do
								v.object.Visible = false
							end
							for i,v in next, this.drawingObjects.drawOffScreen do
								v.object.Visible = false
							end
							for i,v in next, this.drawingObjects.drawGeneral do
								v.object.Visible = false
							end
							this.drawingObjects.stoppedRenderingOffScreen = true
							this.drawingObjects.stoppedRenderingOnScreen = true

							for i = #this.chamsTransConnections, 1, -1 do
								local con = table.remove(this.chamsTransConnections, i)
								if con then
									con:Disconnect()
									con = nil
								end
							end

							for i = #this.chamsObjects, 1, -1 do
								local object = table.remove(this.chamsObjects, i)
								if object then
									object:Destroy()
									object = nil
								end
							end
							if this.step then
								this.step:Disconnect()
								this.step = nil
							end
							this.transparencyEvent:Fire(0)
							this.fadefinished = true
						else
							this.transparencyEvent:Fire(mathModule.map(this.timePassed, 0, 1, 0, 1))
							local section = pInfo.enemy and "Enemy" or "Team"
							local enabled = Menu["ESP"][section .. " ESP"]["Enabled"]["Toggle"]["Enabled"]
							if enabled and this.drawingObjects.lastData.headCf then
								local onScreen = mathModule.spherePoint(this.drawingObjects.lastData.headCf.p, 4)
								if onScreen then
									this.renderOnScreen({
										boundingRect = visuals.getBoundingBox(nil, nil, nil, nil, nil, this.drawingObjects.lastData),
										health = 0,
										maxHealth = this.drawingObjects.lastData.maxHealth
									})
								else
									this.renderOffScreen({
										position = this.drawingObjects.lastData.headCf.p
									})
								end
								this.renderGeneral({
									position = this.drawingObjects.lastData.headCf.p
								})	
							else
								if not this.drawingObjects.stoppedRenderingOnScreen then
									this.drawingObjects.stoppedRenderingOnScreen = true
									for i,v in next, this.drawingObjects.drawOnScreen do
										v.object.Visible = false
									end
								end
								if not this.drawingObjects.stoppedRenderingOffScreen then
									this.drawingObjects.stoppedRenderingOffScreen = true
									for i,v in next, this.drawingObjects.drawOffScreen do
										v.object.Visible = false
									end
								end
								for i,v in next, this.drawingObjects.drawGeneral do
									v.object.Visible = false
								end
							end
						end
						--debug.profileend()
					end)
				end
				if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					this.onSpawned()
					this.chamsadded(player.Character)
				end
				visuals.espObjects[player] = this
			end

			function visuals.removeEsp(player)
				local this = visuals.espObjects[player]
				if this then
					if this.step then
						this.step:Disconnect()
					end
					for i,v in next, this.drawingObjects.drawOnScreen do
						v.object:Remove()
						v.object = nil
						table.clear(v)
					end
					for i,v in next, this.drawingObjects.drawOffScreen do
						v.object:Remove()
						v.object = nil
						table.clear(v)
					end
					for i,v in next, this.drawingObjects.drawGeneral do
						v.object:Remove()
						v.object = nil
						table.clear(v)
					end
					for i = #this.chamsTransConnections, 1, -1 do
						local con = table.remove(this.chamsTransConnections, i)
						if con then
							con:Disconnect()
							con = nil
						end
					end
					for i = #this.transConnections, 1, -1 do
						local con = table.remove(this.transConnections, i)
						if con then
							con:Disconnect()
							con = nil
						end
					end
					this.transparencyEvent:Destroy()
					this.healthPercentageSpring = nil
					table.clear(this)
					visuals.espObjects[player] = nil
					this = nil
				end
			end
			playerSpawned:Connect(function(plr, tick)
				local this = visuals.espObjects[plr]
				if this then
					this.chamsadded(plr.Character)
					this.onSpawned()
				end
			end)
		end
		function visuals.saveViewmodel()
			visuals.chammedobjects["Weapon Objects"] = {} -- guns are not re used
			visuals.chammedobjects["Arms"] = {}
			visuals.chammedobjects["Clothing"] = {}
			visuals.chammedobjects["Original"] = {}
			if localPlayer.Status.Alive.Value == false then
				return
			end
			if camera:FindFirstChild("Arms") then
				for i, v in next, (camera.Arms:GetChildren()) do
					if v:IsA("Model") and v:FindFirstChild("Right Arm") and v:FindFirstChild("Left Arm") then
						table.insert(visuals.chammedobjects["Arms"], v["Right Arm"])
						table.insert(visuals.chammedobjects["Arms"], v["Left Arm"])

						table.insert(visuals.chammedobjects["Clothing"], v["Right Arm"]:FindFirstChild("RGlove") or v["Right Arm"]:FindFirstChild("Glove"))
						table.insert(visuals.chammedobjects["Clothing"], v["Left Arm"]:FindFirstChild("LGlove") or v["Left Arm"]:FindFirstChild("Glove"))

						table.insert(visuals.chammedobjects["Clothing"], v["Right Arm"]:FindFirstChild("Sleeve"))
						table.insert(visuals.chammedobjects["Clothing"], v["Left Arm"]:FindFirstChild("Sleeve"))
					elseif (v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("SpecialMesh") or v:IsA("SurfaceAppearance")) and v.Transparency == 0 or v.Name == "HumanoidRootPart" then
						if v.Name == "HumanoidRootPart" then -- fixing rolve issue
							v.Transparency = 1
						else
							table.insert(visuals.chammedobjects["Weapon Objects"], v)
							if v:FindFirstChild("SurfaceAppearance") then
								table.insert(visuals.chammedobjects["Weapon Objects"], v:FindFirstChild("SurfaceAppearance"))
							end
						end
					end
				end
			else
				return
			end

			-- FUCK YOU NIGGER I HATE THIS SO FUCKING MUCH IF U READ THIS FUCK YOU
			for idx, objects in next, ({visuals.chammedobjects["Arms"], visuals.chammedobjects["Clothing"], visuals.chammedobjects["Weapon Objects"]}) do
				for i, v in next, (objects) do 
					if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("SpecialMesh") then
						local property = { -- i would getprops(v) but that shits laggy
							Color = v.Color,
							Material = v.Material,
							Reflectance = v.Reflectance,
							Transparency = v.Transparency
						}
						if v:IsA("MeshPart") then
							property.TextureID = v.TextureID
						elseif v:IsA("SpecialMesh") then
							property.TextureId = v.TextureId
						end
						visuals.chammedobjects["Original"][v] = property
						if v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("SpecialMesh") then
							local HiddenMesh = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("SpecialMesh")
							if HiddenMesh:IsA("MeshPart") then
								visuals.chammedobjects["Original"][HiddenMesh] = {
									TextureID = HiddenMesh.TextureID
								}
							else
								visuals.chammedobjects["Original"][HiddenMesh] = {
									TextureId = HiddenMesh.TextureId,
									VertexColor = HiddenMesh.VertexColor
								}
							end
						end
					elseif v:IsA("SurfaceAppearance") then
						visuals.chammedobjects["Original"][v] = {
							Parent = v.Parent
						}
					end
				end
			end
		end

		function visuals.updatelocalobjects(char) -- fucking hell man
			visuals.chammedobjects["Original Body"] = {}
			for i, v in next, (char:GetChildren()) do
				if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("SpecialMesh") then
					if not (v.Name == "HumanoidRootPart" or v.Name == "BackC4" or v.Name == "___") then
						local property = {
							Transparency = v.Transparency,
							Color = v.Color,
							Material = v.Material
						}
						if v:IsA("MeshPart") then
							property.TextureID = v.TextureID
						elseif v:IsA("SpecialMesh") then
							property.TextureId = v.TextureId
						end
						visuals.chammedobjects["Original Body"][v] = property
					end
				elseif v:IsA("Accessory") and v:FindFirstChild("Handle") then
					for i2, v2 in next, (v:GetChildren()) do
						if v2:IsA("BasePart") or v2:IsA("MeshPart") or v2:IsA("SpecialMesh") then 
							local property2 = {
								Transparency = v2.Transparency,
								Color = v2.Color,
								Material = v2.Material
							}
							if v2:IsA("MeshPart") then
								property2.TextureID = v2.TextureID
							elseif v2:IsA("SpecialMesh") then
								property2.TextureId = v2.TextureId
							end
							visuals.chammedobjects["Original Body"][v2] = property2
							local HiddenMesh = --[[v2:FindFirstChildOfClass("MeshPart") or]] v2:FindFirstChildOfClass("SpecialMesh") or nil
							if HiddenMesh ~= nil then
								local hiddenmeshproperty = {}
								if HiddenMesh:IsA("MeshPart") then
									hiddenmeshproperty.TextureID = HiddenMesh.TextureID
								else
									hiddenmeshproperty.TextureId = HiddenMesh.TextureId
								end
								hiddenmeshproperty.VertexColor = HiddenMesh.VertexColor
								visuals.chammedobjects["Original Body"][HiddenMesh] = hiddenmeshproperty
							end
						end
					end
				elseif v:IsA("Shirt") or v:IsA("Pants") then
					visuals.chammedobjects["Original Body"][v] = {Parent = v.Parent}
				end
			end
		end

		function visuals.updateWeaponChams()
			for i, v in next, (visuals.chammedobjects["Colored Weapons"]) do
				local originalproperties = visuals.chammedobjects["Original"][v]
				if originalproperties then
					for i2, v2 in next, (originalproperties) do
						v[i2] = v2
					end
				end
			end
			visuals.chammedobjects["Colored Weapons"] = {} -- shit aint colored no more

			if Menu["Visuals"]["Local"]["Weapon Chams"]["Toggle"]["Enabled"] then
				local Animation = ""
				local thing = visuals.chammedobjects["Colored Weapons"] -- save the shit that we colored
				if Menu["Visuals"]["Local"]["Weapon Cham Material"]["Value"] == "Ghost" or Menu["Visuals"]["Local"]["Weapon Cham Material"]["Value"] == "Magic" then
					Animation = visuals.forcefieldAnimations[Menu["Visuals"]["Local"]["Weapon Cham Animation"]["Value"]]
				end
				for i, v in next, (visuals.chammedobjects["Weapon Objects"]) do
					if Menu["Visuals"]["Local"]["Arm Cham Material"]["Value"] == "Magic" then

					else
						if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("SpecialMesh") then
							thing[1 + #thing] = v
							v.Transparency = Menu["Visuals"]["Local"]["Weapon Chams"]["Color 1"]["Transparency"]
							if v.Name ~= "Dot" then
								v.Color = Menu["Visuals"]["Local"]["Weapon Chams"]["Color 1"]["Color"]
								v.Material = visuals.materials[Menu["Visuals"]["Local"]["Weapon Cham Material"]["Value"]]
								v.Reflectance = Menu["Visuals"]["Local"]["Weapon Reflectivity"]["Value"]
								if v:IsA("MeshPart") then
									v.TextureID = Animation
								end
								if v:IsA("SpecialMesh") then
									v.TextureId = Animation
								end
								local HiddenMesh = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("SpecialMesh")
								if HiddenMesh ~= nil then
									if HiddenMesh:IsA("MeshPart") then
										HiddenMesh.TextureID = Animation
										HiddenMesh.Color = v.Color
										HiddenMesh.Material = v.Material
										HiddenMesh.Reflectance = v.Reflectance
									else
										HiddenMesh.TextureId = Animation
										HiddenMesh.VertexColor = newVector3(v.Color.r, v.Color.g, v.Color.b)
									end

									thing[1 + #thing] = HiddenMesh
								end
							end
						elseif v:IsA("SurfaceAppearance") then
							thing[1 + #thing] = v
							v.Parent = nil
						end
					end
				end
			end
		end
--
--
getgenv().playername = game:GetService("Players").LocalPlayer.Name

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local playerId = Players:GetUserIdFromNameAsync(getgenv().playername)
getgenv().newpfp = playerId


local function getNewName()
    return Menu["Visuals"]["Player"]["Change To"]["Value"]
end

local GUI
if game.GameId == 115797356 then
    GUI = localPlayer:WaitForChild("PlayerGui"):FindFirstChild("GUI")
end

local mt = getrawmetatable(game)
local __oldNewIndex = mt.__newindex
if setreadonly then setreadonly(mt, false) else make_writeable(mt) end

mt.__newindex = newcclosure(function(self, k, v)
    local toggle = Menu["Visuals"]["Player"]["Name Changer"]["Toggle"]["Enabled"]
    if toggle then
        local newname = getNewName()
        if (game.IsA(self, "TextLabel") or game.IsA(self, "TextButton")) and k == "Text" and string.find(v, getgenv().playername) then
            return __oldNewIndex(self, k, string.gsub(v, getgenv().playername, newname))
        elseif (game.IsA(self, "ImageLabel") or game.IsA(self, "ImageButton")) and k == "Image" then
            if string.find(v, tostring(playerId)) then
                return __oldNewIndex(self, k, string.gsub(v, tostring(playerId), tostring(getgenv().newpfp)))
            elseif string.find(v, getgenv().playername) then
                return __oldNewIndex(self, k, string.gsub(v, getgenv().playername, Players:GetNameFromUserIdAsync(playerId)))
            end
        end
    end
    return __oldNewIndex(self, k, v)
end)

if setreadonly then setreadonly(mt, true) else make_readonly(mt) end

local function patchText(v)
    if v:IsA("TextLabel") or v:IsA("TextButton") then
        local function update()
            local toggle = Menu["Visuals"]["Player"]["Name Changer"]["Toggle"]["Enabled"]
            local newname = getNewName()
            if toggle then
                v.Text = string.gsub(v.Text, getgenv().playername, newname)
            else
                v.Text = string.gsub(v.Text, newname, getgenv().playername)
            end
        end
        update()
        v:GetPropertyChangedSignal("Text"):Connect(update)
    end
end

for _, v in pairs(game:GetDescendants()) do
    patchText(v)
end

game.DescendantAdded:Connect(patchText)

if GUI then
    for _, v in pairs(GUI.TopRight:GetChildren()) do
        if v:FindFirstChild("Killer") and v:FindFirstChild("Victim") then
            v.Killer:GetPropertyChangedSignal("Text"):Connect(function()
                local toggle = Menu["Visuals"]["Player"]["Name Changer"]["Toggle"]["Enabled"]
                local newname = getNewName()
                if toggle and string.find(v.Killer.Text, newname) then
                    v.Outline.Visible = true
                end
            end)

            v.Outline:GetPropertyChangedSignal("Visible"):Connect(function()
                local toggle = Menu["Visuals"]["Player"]["Name Changer"]["Toggle"]["Enabled"]
                local newname = getNewName()
                if toggle and (string.find(v.Killer.Text, newname) or string.find(v.Victim.Text, newname)) then
                    v.Outline.Visible = true
                end
            end)
        end
    end
end

-- Accessory Visuals Module
local model, handle, highlight = nil, nil, nil
local angle, spin = 0, 0
local lastAssetId = 0

-- Destroy current accessory and cleanup
function destroyAccessory()
    if model then
        pcall(function() model:Destroy() end)
        model = nil
    end

    if handle then
        pcall(function() handle:Destroy() end)
        handle = nil
    end

    highlight = nil
end

-- Apply highlight effect to the accessory
function applyHighlight()
    -- Clear existing highlight
    if highlight then
        pcall(function() highlight:Destroy() end)
        highlight = nil
    end

    -- Ensure handle is valid
    if not handle or not handle:IsA("BasePart") or not handle:IsDescendantOf(workspace) then
        return
    end

    -- Create new highlight
    local h = Instance.new("Highlight")
    h.Name = "AccessoryHighlight"
    h.Adornee = handle
    h.Enabled = Menu["Visuals"]["Fumo"]["Highlight"]["Toggle"]["Enabled"]
	h.FillColor = Menu["Visuals"]["Fumo"]["Highlight"]["Color 1"]["Color"]
	h.OutlineColor = Menu["Visuals"]["Fumo"]["Highlight"]["Color 2"]["Color"]
	h.FillTransparency = Menu["Visuals"]["Fumo"]["Fill Transparency"]["Value"]/100
	h.OutlineTransparency = Menu["Visuals"]["Fumo"]["Outline Transparency"]["Value"]/100
    h.Parent = handle

    highlight = h
end

-- Load accessory from asset ID
function loadAccessory()
    destroyAccessory()

    local assetId = tonumber(17899556174)
    if not assetId or assetId <= 0 then return end

    local success, asset = pcall(function()
        return game:GetObjects("rbxassetid://" .. assetId)[1]
    end)
    if not success or typeof(asset) ~= "Instance" then return end

    local part = asset:FindFirstChild("Handle", true)
    if not part or not part:IsA("BasePart") then return end

    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 0
    part.Parent = workspace

    model = asset
    handle = part

    applyHighlight()
end

-- Render loop: update accessory visuals
runService.RenderStepped:Connect(function(dt)
    -- Reload accessory if ID changed
    local currentId = tonumber(17899556174)
    if currentId ~= lastAssetId then
        lastAssetId = currentId or 0
        loadAccessory()
    end

    -- Hide accessory if disabled
    if not Menu["Visuals"]["Fumo"]["Enable Fumo"]["Toggle"]["Enabled"] then
        if handle then handle.Transparency = 1 end
        if highlight then highlight.Enabled = false end
        return
    end

    -- Reload if handle is lost
    if not handle or not handle:IsDescendantOf(workspace) then
        loadAccessory()
        return
    end

    -- Accessory follows the player
    local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    handle.Transparency = 0

    -- Update highlight settings
    if highlight then
        highlight.Enabled = Menu["Visuals"]["Fumo"]["Highlight"]["Toggle"]["Enabled"]
        highlight.FillColor = Menu["Visuals"]["Fumo"]["Highlight"]["Color 1"]["Color"]
        highlight.OutlineColor = Menu["Visuals"]["Fumo"]["Highlight"]["Color 2"]["Color"]
		highlight.FillTransparency = Menu["Visuals"]["Fumo"]["Fill Transparency"]["Value"]/100
		highlight.OutlineTransparency = Menu["Visuals"]["Fumo"]["Outline Transparency"]["Value"]/100
    end

    -- Animate accessory movement
    angle += Menu["Visuals"]["Fumo"]["Orbit Speed"]["Value"] * dt
    spin += Menu["Visuals"]["Fumo"]["Spin Speed"]["Value"] * dt

    local orbit = Vector3.new(
        math.cos(math.rad(angle)) * Menu["Visuals"]["Fumo"]["Distance"]["Value"],
        Menu["Visuals"]["Fumo"]["Height"]["Value"],
        math.sin(math.rad(angle)) * Menu["Visuals"]["Fumo"]["Distance"]["Value"]
    )

    handle.Position = root.Position + orbit
    handle.Orientation = Menu["Visuals"]["Fumo"]["Spin Itself"]["Toggle"]["Enabled"]
        and Vector3.new(0, spin % 360, 0)
        or Vector3.zero
end)



		function visuals.updateArmChams() -- call this when we feel like it
			for i, v in next, (visuals.chammedobjects["Colored Arms"]) do
				local originalproperties = visuals.chammedobjects["Original"][v]
				if originalproperties then
					for i2, v2 in next, (originalproperties) do
						v[i2] = v2
					end
				end
			end
			visuals.chammedobjects["Colored Arms"] = {}
			if Menu["Visuals"]["Local"]["Arm Chams"]["Toggle"]["Enabled"] then
				local thing = visuals.chammedobjects["Colored Arms"] -- save the shit that we colored
				local Animation = ""
				if Menu["Visuals"]["Local"]["Arm Cham Material"]["Value"] == "Ghost" or Menu["Visuals"]["Local"]["Arm Cham Material"]["Value"] == "Magic" then
					Animation = visuals.forcefieldAnimations[Menu["Visuals"]["Local"]["Arm Cham Animation"]["Value"]]
				end
				for idx, objects in next, ({visuals.chammedobjects["Arms"], visuals.chammedobjects["Clothing"]}) do
					for i, v in next, (objects) do 
						if Menu["Visuals"]["Local"]["Arm Cham Material"]["Value"] == "Magic" then
							-- FUCK FEMMI FUCK FEMMI FUCK FEMMI FUCK FEMMI FUCK FEMMI FUCK FEMMI

						else
							if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("SpecialMesh") then
								v.Color = Menu["Visuals"]["Local"]["Arm Chams"]["Color " .. idx]["Color"]
								v.Transparency = Menu["Visuals"]["Local"]["Arm Chams"]["Color " .. idx]["Transparency"]
								v.Material = visuals.materials[Menu["Visuals"]["Local"]["Arm Cham Material"]["Value"]]
								thing[1 + #thing] = v
								v.Reflectance = idx == 1 and Menu["Visuals"]["Local"]["Arm Reflectivity"]["Value"] or Menu["Visuals"]["Local"]["Sleeve Reflectivity"]["Value"]
								if --[[v:IsA("MeshPart") or]] v:IsA("SpecialMesh") then
									v.VertexColor = newVector3(v.Color.r, v.Color.g, v.Color.b)
									if v:IsA("MeshPart") then
										v.TextureID = Animation
									else
										v.TextureId = Animation
									end
								end
								if v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("SpecialMesh") then
									local HiddenMesh = v:FindFirstChildOfClass("MeshPart") or v:FindFirstChildOfClass("SpecialMesh")

									thing[1 + #thing] = HiddenMesh
									if HiddenMesh:IsA("MeshPart") then
										HiddenMesh.TextureID = Animation
									else
										HiddenMesh.VertexColor = newVector3(v.Color.r, v.Color.g, v.Color.b)
										HiddenMesh.TextureId = Animation
									end
								end
							end
						end
					end
				end
			end
		end

		local haltLocalChams = false

		camera.ChildAdded:Connect(function()
			haltLocalChams = true
			task.wait()
			visuals.saveViewmodel()
			haltLocalChams = false
		end)


		function visuals.updatelocalplayerchams()
			if (Menu["Visuals"]["Camera"]["Third Person"]["Toggle"]["Enabled"] and Menu["Visuals"]["Camera"]["Third Person"]["Bind"]["Active"]) and Menu["Visuals"]["Local"]["Local Chams"]["Toggle"]["Enabled"] and visuals.chammedbody == true and localPlayer.Character then
				local thing = visuals.chammedobjects["Colored Body"]
				local texture = ""
				if Menu["Visuals"]["Local"]["Local Cham Material"]["Value"] == "Ghost" then
					texture = visuals.forcefieldAnimations[Menu["Visuals"]["Local"]["Local Cham Animation"]["Value"]]
				end
				for i, v in next, (localPlayer.Character:GetChildren()) do
					if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("SpecialMesh") then
						if not (v.Name == "HumanoidRootPart" or v.Name == "BackC4" or v.Name == "___") then
							v.Color = Menu["Visuals"]["Local"]["Local Chams"]["Color 1"]["Color"]
							v.Material = visuals.materials[Menu["Visuals"]["Local"]["Local Cham Material"]["Value"]]
							v.Transparency = Menu["Visuals"]["Local"]["Local Chams"]["Color 1"]["Tranparency"]
							if v:IsA("MeshPart") then
								v.TextureID = texture
							elseif v:IsA("SpecialMesh") then
								v.TextureId = texture
							end
							if v.Name == "FakeHead" or v.Name == "HeadHB" then
								v.Transparency = 1
							end
							thing[1 + #thing] = v
						end
					elseif v:IsA("Accessory") and v:FindFirstChild("Handle") then
						for i2, v2 in next, (v:GetChildren()) do
							if v2:IsA("BasePart") or v2:IsA("MeshPart") or v2:IsA("SpecialMesh") then 
								v2.Transparency = Menu["Visuals"]["Local"]["Local Chams"]["Color 1"]["Transparency"]
								v2.Color = Menu["Visuals"]["Local"]["Local Chams"]["Color 1"]["Color"]
								v2.Material = visuals.materials[Menu["Visuals"]["Local"]["Local Cham Material"]["Value"]]
								if v2:IsA("MeshPart") then
									v2.TextureID = texture
								elseif v2:IsA("SpecialMesh") then
									v2.TextureId = texture
								end
								thing[1 + #thing] = v2
								local HiddenMesh = v2:FindFirstChildOfClass("MeshPart") or v2:FindFirstChildOfClass("SpecialMesh") or nil
								if HiddenMesh ~= nil then
									if HiddenMesh:IsA("MeshPart") then
										HiddenMesh.TextureID = texture
										HiddenMesh.Color = v.Color
										HiddenMesh.Material = v.Material
										HiddenMesh.Reflectance = v.Reflectance
										HiddenMesh.TextureID = texture
									else
										HiddenMesh.VertexColor = newVector3(v2.Color.r, v2.Color.g, v2.Color.b)
										HiddenMesh.TextureId = texture
									end

									thing[1 + #thing] = HiddenMesh
								end
							end
						end
					elseif v:IsA("Shirt") or v:IsA("Pants") then
						v.Parent = nil -- eh
						thing[1 + #thing] = v
					end
				end
			else
				for i, v in next, (visuals.chammedobjects["Colored Body"]) do
					local originalproperties = visuals.chammedobjects["Original Body"][v]
					if originalproperties then
						for i2, v2 in next, (originalproperties) do
							if i2 == "TextureId" or i2 == "TextureID" or i2 == "Material" or i2 == "Color" or i2 == "VertexColor" or i2 == "Reflectance" or i2 == "Transparency" or i2 == "Parent" then
								v[i2] = v2
							end
						end
					end
				end
				visuals.chammedobjects["Colored Body"] = {}
			end
		end
		Menu["Visuals"]["Local"]["Local Chams"]["Toggle"].Changed:Connect(visuals.updatelocalplayerchams)
		local lastLocalChamColor = tick()
		Menu["Visuals"]["Local"]["Local Cham Material"]["Dropdown"].Changed:Connect(visuals.updatelocalplayerchams)
		Menu["Visuals"]["Local"]["Local Cham Animation"]["Dropdown"].Changed:Connect(visuals.updatelocalplayerchams)
		Menu["Visuals"]["Camera"]["Third Person"]["Toggle"].Changed:Connect(visuals.updatelocalplayerchams)
		Menu["Visuals"]["Camera"]["Third Person"]["Bind"].Changed:Connect(visuals.updatelocalplayerchams)
		
		local everyOther = 0
		local everyEveryOther = 2
		runService.Stepped:Connect(function()
			everyEveryOther = everyEveryOther + 1
			if (Menu["Visuals"]["Camera"]["Third Person"]["Toggle"]["Enabled"] and Menu["Visuals"]["Camera"]["Third Person"]["Bind"]["Active"]) then
				if everyEveryOther > 4 then
					visuals.updatelocalplayerchams()
					everyEveryOther = 0
				end
				return
			end
			if haltLocalChams == true then
				return
			end
			everyOther = everyOther + 1
			if everyOther > 4 then
				visuals.updateArmChams()
				everyOther = 0
			end
			visuals.updateWeaponChams()
		end)

		localPlayer.CharacterAdded:Connect(function()
			visuals.chammedobjects["Original Body"] = {}
			repeat 
				task.wait(.1)
			until localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") and localPlayer.Character.Humanoid.Health > 0
			visuals.updatelocalobjects(localPlayer.Character)
			task.wait()
			visuals.chammedbody = true
			visuals.updatelocalplayerchams()
		end)
		if localPlayer.Character then
			visuals.chammedbody = true	
			visuals.updatelocalobjects(localPlayer.Character)
		end
		localPlayer.CharacterRemoving:Connect(function()
			visuals.chammedbody = false
			visuals.chammedobjects["Original Body"] = {}
		end)

		local oldads = client.updateads 
		client.updateads = function(...)
			coroutine.wrap(function()
				task.wait()
				if localPlayer.Character ~= nil then
					for i, v in next, (localPlayer.Character:GetDescendants()) do
						if v:IsA("Part") or v:IsA("MeshPart") then
							if v.Transparency ~= 1 then
								v.Transparency = localPlayer.Character:FindFirstChild("AIMING") and 0.75 or 0
							end
						end
						if v:IsA("Accessory") then
							v.Handle.Transparency = localPlayer.Character:FindFirstChild("AIMING") and 0.75 or 0
						end
					end
				end
			end)()
			return oldads(...)
		end

	local oldNewIndex
oldNewIndex = hookmetamethod(game, "__newindex", newcclosure(function(self, key, value)
	if not checkcaller() and self == camera and key == "FieldOfView" then
		if Menu["Visuals"]["Camera"]["Override FOV"]["Toggle"]["Enabled"] then
			return -- Block FOV override by the game
		end
	end
	return oldNewIndex(self, key, value)
end))

-- Keep enforcing custom FOV using RunService Heartbeat
runService.Heartbeat:Connect(function()
	if Menu["Visuals"]["Camera"]["Override FOV"]["Toggle"]["Enabled"] then
		camera.FieldOfView = Menu["Visuals"]["Camera"]["FOV"]["Value"]
	end
end)

-- Prevent FOV change when scoping (i.e. game tries to modify it via internal methods)
camera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
	if Menu["Visuals"]["Camera"]["Disable Scope FOV"]["Toggle"]["Enabled"]
		and Menu["Visuals"]["Camera"]["Override FOV"]["Toggle"]["Enabled"] then
		camera.FieldOfView = Menu["Visuals"]["Camera"]["FOV"]["Value"]
	end
end)

local playerGui = localPlayer:WaitForChild("PlayerGui")

local screenGui = playerGui:FindFirstChild("ScopeGUI")
if not screenGui then
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ScopeGUI"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = playerGui
end

local scopelb
local scopeImage = game:GetObjects("rbxassetid://10644136402")[1]

if scopeImage:IsA("Decal") or scopeImage:IsA("Texture") then
    scopelb = screenGui:FindFirstChild("ScopeLabel") or Instance.new("ImageLabel")
    scopelb.Name = "ScopeLabel"
    scopelb.BackgroundTransparency = 1
    scopelb.AnchorPoint = Vector2.new(0.5, 0.501)
    scopelb.Position = UDim2.new(0.5, 0, 0.501, 0)
    scopelb.Size = UDim2.new(0, 233, 0, 227)
    scopelb.ZIndex = 99999
    scopelb.Image = scopeImage.Texture or scopeImage.TextureID
    scopelb.Visible = false
    scopelb.Parent = screenGui
end

runService.Heartbeat:Connect(function()
    if scopelb then
        if Menu["Visuals"]["Camera"]["Disable Scope Border"]["Toggle"]["Enabled"] then
            if crosshairs then
                crosshairs.Scope.ImageTransparency = 1
                crosshairs.Scope.Scope.Visible = false
                crosshairs.Scope.Scope.Blur.ImageTransparency = 1
                crosshairs.Frame1.Transparency = 1
                crosshairs.Frame2.Transparency = 1
                crosshairs.Frame3.Transparency = 1
                crosshairs.Frame4.Transparency = 1
            end
			if crosshairs.Frame1.Visible == true then
				scopelb.Visible = true
			elseif crosshairs.Frame1.Visible == false then
            scopelb.Visible = false
			end
		
        else
            if crosshairs then
                crosshairs.Scope.ImageTransparency = 0
                crosshairs.Scope.Scope.Visible = true
                crosshairs.Scope.Scope.Blur.ImageTransparency = 0
                crosshairs.Frame1.Transparency = 0
                crosshairs.Frame2.Transparency = 0
                crosshairs.Frame3.Transparency = 0
                crosshairs.Frame4.Transparency = 0
            end

			
        end
    end
end)

		for i,v in next, players:GetPlayers() do
			if v ~= localPlayer then
				task.spawn(visuals.applyEsp, v)
			end
		end

		players.PlayerAdded:Connect(visuals.applyEsp)
		players.PlayerRemoving:Connect(visuals.removeEsp)

		visuals.crosshair = {}
		visuals.crosshair.drawingObjects = {}
		visuals.crosshair.drawingObjects.outlines = {}
		for i = 1, 4 do
			visuals.crosshair.drawingObjects.outlines[i] = visuals.createDrawing("Line", {
				Thickness = 3,
				Color = Color3.fromRGB(0, 0, 0),
				Transparency = 1,
				Visible = true
			})
		end
		visuals.crosshair.drawingObjects.objects = {}
		for i = 1, 4 do
			visuals.crosshair.drawingObjects.objects[i] = visuals.createDrawing("Line", {
				Thickness = 1,
				Color = Color3.fromRGB(255, 255, 255),
				Transparency = 1,
				Visible = true
			})
		end
		visuals.crosshair.currentaddedrotation = 0
		visuals.crosshair.currentrotation = 0
		function visuals.updateGUI(upTime, deltaTime) -- pasted from vaderhaxx
			local customCrosshair = Menu["Visuals"]["Crosshair"]["Custom Crosshair"]["Toggle"]["Enabled"] and not (Menu["Visuals"]["Camera"]["Third Person"]["Toggle"]["Enabled"] and Menu["Visuals"]["Camera"]["Third Person"]["Bind"]["Active"])
			if customCrosshair then
				local crosshairColor = Menu["Visuals"]["Crosshair"]["Custom Crosshair"]["Color 1"]["Color"]
				local crosshairTrans = Menu["Visuals"]["Crosshair"]["Custom Crosshair"]["Color 1"]["Transparency"]
				local crosshairThickness = Menu["Visuals"]["Crosshair"]["Crosshair Thickness"].Value
				local crosshairOutline = false -- not enough space for toggle :(
				for _, frame in next, localPlayer.PlayerGui.GUI.Crosshairs.Crosshair:GetChildren() do
					if frame:IsA("ImageLabel") then 
					else
						frame.BackgroundTransparency = 1
					end
				end
				local screenPos = newVector2(math.floor(camera.ViewportSize.x / 2), math.floor(camera.ViewportSize.y / 2))
				for i, v in next, visuals.crosshair.drawingObjects.objects do
					v.Visible = customCrosshair
					v.Color = crosshairColor
					v.Thickness = crosshairThickness
					v.Transparency = localPlayer.PlayerGui.GUI.Crosshairs.Scope.Visible and 0 or 1 - crosshairTrans
					visuals.crosshair.drawingObjects.outlines[i].Visible = v.Visible and crosshairOutline or false
					visuals.crosshair.drawingObjects.outlines[i].Thickness = v.Thickness + 2
				end
				local width = Menu["Visuals"]["Crosshair"]["Crosshair Width"].Value
				local length = Menu["Visuals"]["Crosshair"]["Crosshair Length"].Value
				local widthgap = Menu["Visuals"]["Crosshair"]["Crosshair Width Gap"].Value
				local lengthgap = Menu["Visuals"]["Crosshair"]["Crosshair Length Gap"].Value

				local rotation = Menu["Visuals"]["Crosshair"]["Crosshair Rotation"].Value
				local rotationspeed = Menu["Visuals"]["Crosshair"]["Crosshair Rotation Speed"].Value

				visuals.crosshair.currentaddedrotation = (rotationspeed ~= 0) and visuals.crosshair.currentaddedrotation + (rotationspeed * deltaTime) or 0
				visuals.crosshair.currentrotation = pi/180 * (rotation + visuals.crosshair.currentaddedrotation)

				local cx, sy = math.sin(visuals.crosshair.currentrotation), math.cos(visuals.crosshair.currentrotation)
				local from = (newVector2(cx, sy) * newVector2(widthgap, lengthgap))
				local to = from + (newVector2(cx, sy) * newVector2(width, length))
				local outfrom = (newVector2(cx, sy) * newVector2(widthgap - 1, lengthgap - 1))
				local outto = outfrom + (newVector2(cx, sy) * newVector2(width + 1, length + 1))
				
				local cx2, sy2 = math.sin(visuals.crosshair.currentrotation + pi/2), math.cos(visuals.crosshair.currentrotation + pi/2)
				local from2 = (newVector2(cx2, sy2) * newVector2(widthgap, lengthgap))
				local to2 = from2 + (newVector2(cx2, sy2) * newVector2(width, length))
				local outfrom2 = (newVector2(cx2, sy2) * newVector2(widthgap - 1, lengthgap - 1))
				local outto2 = outfrom2 + (newVector2(cx2, sy2) * newVector2(width + 1, length + 1))
				
				local a, a1 = visuals.crosshair.drawingObjects.objects[1], visuals.crosshair.drawingObjects.outlines[1]
				a.From = newVector2(screenPos.x - from.x, screenPos.y - from.y)
				a.To = newVector2(screenPos.x - to.x, screenPos.y - to.y)
				a1.From = newVector2(screenPos.x - outfrom.x, screenPos.y - outfrom.y)
				a1.To = newVector2(screenPos.x - outto.x, screenPos.y - outto.y)
				
				local b, b1 = visuals.crosshair.drawingObjects.objects[2], visuals.crosshair.drawingObjects.outlines[2]
				b.From = newVector2(screenPos.x + from.x, screenPos.y + from.y)
				b.To = newVector2(screenPos.x + to.x, screenPos.y + to.y)
				b1.From = newVector2(screenPos.x + outfrom.x, screenPos.y + outfrom.y)
				b1.To = newVector2(screenPos.x + outto.x, screenPos.y + outto.y)
				
				local c, c1 = visuals.crosshair.drawingObjects.objects[3], visuals.crosshair.drawingObjects.outlines[3]
				c.From = newVector2(screenPos.x - from2.x, screenPos.y - from2.y)
				c.To = newVector2(screenPos.x - to2.x, screenPos.y - to2.y)
				c1.From = newVector2(screenPos.x - outfrom2.x, screenPos.y - outfrom2.y)
				c1.To = newVector2(screenPos.x - outto2.x, screenPos.y - outto2.y)
				
				local d, d1 = visuals.crosshair.drawingObjects.objects[4], visuals.crosshair.drawingObjects.outlines[4]
				d.From = newVector2(screenPos.x + from2.x, screenPos.y + from2.y)
				d.To = newVector2(screenPos.x + to2.x, screenPos.y + to2.y)
				d1.From = newVector2(screenPos.x + outfrom2.x, screenPos.y + outfrom2.y)
				d1.To = newVector2(screenPos.x + outto2.x, screenPos.y + outto2.y)
			else
				for i, v in next, visuals.crosshair.drawingObjects.objects do
					v.Visible = false
					visuals.crosshair.drawingObjects.outlines[i].Visible = false
				end
			end
		end
		visuals.updaterGUI = runService.Stepped:Connect(visuals.updateGUI)

		Menu["Visuals"]["Crosshair"]["Custom Crosshair"]["Toggle"].Changed:Connect(function()
			if not Menu["Visuals"]["Crosshair"]["Custom Crosshair"]["Toggle"]["Enabled"] and not (Menu["Visuals"]["Camera"]["Third Person"]["Toggle"]["Enabled"] and Menu["Visuals"]["Camera"]["Third Person"]["Bind"]["Active"]) then
				for _, frame in next, localPlayer.PlayerGui.GUI.Crosshairs.Crosshair:GetChildren() do
					if frame:IsA("ImageLabel") then else frame.BackgroundTransparency = 0 end
				end
			end
		end)

		visuals.particleEmitterUpdate = function()
			if not Menu["Visuals"]["Particle"]["Enabled"]["Toggle"]["Enabled"] then return end
			if localPlayer.Character and ragebot.realhrp then
				if ragebot.realhrp:FindFirstChild("_p") then -- _p_p_p_p
					visuals.particleemitter = ragebot.realhrp["_p"]
				else
					visuals.particleemitter = Instance.new("ParticleEmitter", ragebot.realhrp)
					visuals.particleemitter.Name = "_p" -- so secret!
					visuals.particleemitter.Size = NumberSequence.new(0.35)
					visuals.particleemitter.Brightness = 10
					visuals.particleemitter.LightEmission = 1
					visuals.particleemitter.LightInfluence = 1
				end
				visuals.particleemitter.Texture = visuals.particleImages[Menu["Visuals"]["Particle"]["Texture"]["Value"] ]
				visuals.particleemitter.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Menu["Visuals"]["Particle"]["Enabled"]["Color 2"]["Color"]), ColorSequenceKeypoint.new(1, Menu["Visuals"]["Particle"]["Enabled"]["Color 1"]["Color"])}
				visuals.particleemitter.Transparency = not (Menu["Visuals"]["Camera"]["Third Person"]["Toggle"]["Enabled"] and Menu["Visuals"]["Camera"]["Third Person"]["Bind"]["Active"]) and NumberSequence.new(1) or NumberSequence.new{NumberSequenceKeypoint.new(0, Menu["Visuals"]["Particle"]["Enabled"]["Color 2"]["Transparency"]), NumberSequenceKeypoint.new(1, Menu["Visuals"]["Particle"]["Enabled"]["Color 1"]["Transparency"])}
				visuals.particleemitter.Speed = NumberRange.new(Menu["Visuals"]["Particle"]["Speed"].Value, Menu["Visuals"]["Particle"]["Speed"].Value)
				visuals.particleemitter.Rate = Menu["Visuals"]["Particle"]["Rate"].Value * 10
				visuals.particleemitter.Rotation = Menu["Visuals"]["Particle"]["Rotation Speed"].Value ~= 0 and NumberRange.new(-180, 180) or NumberRange.new(0, 0)
				visuals.particleemitter.RotSpeed = NumberRange.new(-Menu["Visuals"]["Particle"]["Rotation Speed"].Value, Menu["Visuals"]["Particle"]["Rotation Speed"].Value)
				visuals.particleemitter.Lifetime = NumberRange.new(1, Menu["Visuals"]["Particle"]["Life Time"].Value)
				visuals.particleemitter.SpreadAngle = Vector2.new(Menu["Visuals"]["Particle"]["Spread Angle"].Value, Menu["Visuals"]["Particle"]["Spread Angle"].Value)
				visuals.particleemitter.LockedToPart = Menu["Visuals"]["Particle"]["Locked"]["Toggle"]["Enabled"]
			end
		end

		visuals.particleEmitterUpdater = runService.RenderStepped:Connect(visuals.particleEmitterUpdate)
		Menu["Visuals"]["Particle"]["Enabled"]["Toggle"].Changed:Connect(function(state)
			if not state then if localPlayer.Character and ragebot.realhrp and visuals.particleemitter then visuals.particleemitter:Destroy() end end
		end)
			
			
		Instance.new("BloomEffect", camera)
		local customAtmosphere = Instance.new("Atmosphere", lighting)
		local updateWorldColorStop = tick()
		function visuals.updateworldcolor()
			if tick() - updateWorldColorStop < 1/20 then
				return
			end
			updateWorldColorStop = tick()
			--debug.profilebegin("world color update")
			if Menu["Visuals"]["World"]["Ambience"]["Toggle"]["Enabled"] then
				lighting.OutdoorAmbient = Menu["Visuals"]["World"]["Ambience"]["Color 1"]["Color"]
				lighting.Ambient = Menu["Visuals"]["World"]["Ambience"]["Color 1"]["Color"]
			else
				if findFirstChild(workspace, "Map") and findFirstChild(workspace.Map, "Origin") then
					if visuals.defaultlighting[workspace.Map.Origin.Value] ~= nil then
						for i, v in next, (visuals.defaultlighting[workspace.Map.Origin.Value]) do
							lighting[i] = v
						end
					end
				else
					lighting.OutdoorAmbient = Color3.new(0.647059, 0.611765, 0.54902) -- dust II
					lighting.Ambient = Color3.new(0.509804, 0.462745, 0.372549) -- dust II
				end
			end
			if Menu["Visuals"]["World"]["Force Time"]["Toggle"]["Enabled"] then
				lighting.ClockTime = Menu["Visuals"]["World"]["Custom Time"]["Value"]
			else
				lighting.ClockTime = 9
			end
			if Menu["Visuals"]["World"]["Custom Saturation"]["Toggle"]["Enabled"] then -- this colorcorrection effect doesnt get removed ever
				camera.ColorCorrection.TintColor = Menu["Visuals"]["World"]["Custom Saturation"]["Color 1"]["Color"]
				camera.ColorCorrection.Saturation = Menu["Visuals"]["World"]["Saturation Density"]["Value"] / 100
			else
				camera.ColorCorrection.Saturation = 0
				camera.ColorCorrection.TintColor = Color3.new(1, 1, 1)
			end
			camera.Bloom.Enabled = Menu["Visuals"]["Bloom"]["Custom Bloom"]["Toggle"]["Enabled"]
			if Menu["Visuals"]["Bloom"]["Custom Bloom"]["Toggle"]["Enabled"] then
				camera.Bloom.Intensity = Menu["Visuals"]["Bloom"]["Bloom Intensity"]["Value"] / 100
				camera.Bloom.Size = Menu["Visuals"]["Bloom"]["Bloom Size"]["Value"] * 14 / 25
				camera.Bloom.Threshold = Menu["Visuals"]["Bloom"]["Bloom Threshold"]["Value"] / 400
			else
				camera.Bloom.Intensity = 0
				camera.Bloom.Size = 0
				camera.Bloom.Threshold = 0
			end
			if Menu["Visuals"]["Atmosphere"]["Custom Atmosphere"]["Toggle"]["Enabled"] then
				customAtmosphere.Color = Menu["Visuals"]["Atmosphere"]["Custom Atmosphere"]["Color 1"]["Color"]
				customAtmosphere.Decay = Menu["Visuals"]["Atmosphere"]["Custom Atmosphere"]["Color 2"]["Color"]
				customAtmosphere.Density = Menu["Visuals"]["Atmosphere"]["Density"]["Value"] / 100
				customAtmosphere.Glare = Menu["Visuals"]["Atmosphere"]["Glare"]["Value"] / 10
				customAtmosphere.Haze = Menu["Visuals"]["Atmosphere"]["Haze"]["Value"] / 10
			else
				customAtmosphere.Density = 0
				customAtmosphere.Glare = 0
				customAtmosphere.Haze = 0
			end
			if Menu["Visuals"]["Misc"]["Custom Brightness"]["Toggle"]["Enabled"] then
				if Menu["Visuals"]["Misc"]["Brightness Mode"]["Value"] == "Fullbright" then
					lighting.Brightness = 1
					lighting.GlobalShadows = false
				else
					lighting.Brightness = 0
				end
			else
				lighting.GlobalShadows = true
				lighting.Brightness = 1 -- fixes inferno
			end
			--debug.profileend()
		end

		visuals.updateworldcolors = runService.Stepped:Connect(visuals.updateworldcolor)

		function visuals.updatesky()
			if lighting:FindFirstChildOfClass("Sky") then
				lighting:FindFirstChildOfClass("Sky"):Destroy()
			end
			if Menu["Visuals"]["Misc"]["Custom Skybox"]["Toggle"]["Enabled"] then
				local sky = lighting:FindFirstChildOfClass("Sky")
				if sky == nil then
					sky = Instance.new("Sky", lighting)
				end
				for i, v in next, (visuals.skyboxes[Menu["Visuals"]["Misc"]["Skybox choice"]["Value"]]) do
					sky[i] = v
				end
			end
		end
		
		Menu["Visuals"]["Misc"]["Custom Skybox"]["Toggle"].Changed:Connect(visuals.updatesky)
		Menu["Visuals"]["Misc"]["Skybox choice"]["Dropdown"].Changed:Connect(visuals.updatesky)
		lighting.ChildAdded:Connect(visuals.updatesky)

		function visuals.addWeaponESP(weapon)
			if weapon:IsA("Part") and weapon:FindFirstChild("GunDrop") then
				local ammoShit = weapon:WaitForChild("Ammo")
				local storedammoShit = weapon:WaitForChild("StoredAmmo")
				visuals.droppedWeaponStorage[weapon] = {
					weaponName = visuals.createDrawing("Text", {
						Font = 2,
						Text = string.upper(weapon.Name),
						Visible = false,
						Position = newVector2(),
						Size = 13,
						Transparency = 1,
						Color = Color3.new(1, 1, 1),
						Center = true,
						Outline = true,
					}),
					weaponAmmo = visuals.createDrawing("Text", {
						Font = 2,
						Text = tostring(ammoShit.Value),
						Visible = false,
						Position = newVector2(),
						Size = 13,
						Transparency = 1,
						Color = Color3.new(1, 1, 1),
						Center = true,
						Outline = true
					})
				}
				local referenceWeapName = visuals.droppedWeaponStorage[weapon].weaponName
				local referenceWeapAmmo = visuals.droppedWeaponStorage[weapon].weaponAmmo
				visuals.droppedWeaponStorage[weapon].step = runService.Stepped:Connect(function()
					--debug.profilebegin(weapon.Name .. " esp")
					if Menu["ESP"]["Dropped ESP"]["Weapon Names"]["Toggle"]["Enabled"] or Menu["ESP"]["Dropped ESP"]["Weapon Ammo"]["Toggle"]["Enabled"] then
						local distance = (weapon.Position - camera.CFrame.p).Magnitude
						if distance <= 80 then
							local weaponPosition, weaponOnScreen = mathModule.worldToViewportPoint(weapon.Position, true, 50)
							local gunTrans = 1
							if distance >= 50 then
								gunTrans = math.max(gunTrans - ((distance - 50)/30), 0)
							end
							referenceWeapName.Color = Menu["ESP"]["Dropped ESP"]["Weapon Names"]["Color 1"]["Color"]
							referenceWeapAmmo.Color = Menu["ESP"]["Dropped ESP"]["Weapon Ammo"]["Color 1"]["Color"]
							referenceWeapName.Transparency = gunTrans
							referenceWeapName.Position = newVector2(math.floor(weaponPosition.x), math.floor(weaponPosition.y + 11))
							referenceWeapAmmo.Transparency = gunTrans
							referenceWeapAmmo.Position = newVector2(math.floor(weaponPosition.x), math.floor(weaponPosition.y))
							referenceWeapAmmo.Text = "[ " .. tostring(ammoShit.Value) .. " / " ..  tostring(storedammoShit.Value).. " ]"
							referenceWeapName.Visible = Menu["ESP"]["Dropped ESP"]["Weapon Names"]["Toggle"]["Enabled"]
							referenceWeapAmmo.Visible = Menu["ESP"]["Dropped ESP"]["Weapon Ammo"]["Toggle"]["Enabled"]
						else
							referenceWeapName.Visible = false
							referenceWeapAmmo.Visible = false
						end
					else
						referenceWeapName.Visible = false
						referenceWeapAmmo.Visible = false
					end
					--debug.profileend()
				end)
			end
		end

		function visuals.removeWeaponESP(weapon)
			if visuals.droppedWeaponStorage[weapon] then
				visuals.droppedWeaponStorage[weapon].step:Disconnect()
				visuals.droppedWeaponStorage[weapon].weaponName:Remove()
				visuals.droppedWeaponStorage[weapon].weaponAmmo:Remove()
				visuals.droppedWeaponStorage[weapon].weaponName = nil
				visuals.droppedWeaponStorage[weapon].weaponAmmo = nil
				table.clear(visuals.droppedWeaponStorage[weapon])
				visuals.droppedWeaponStorage[weapon] = nil
			end
		end

		function visuals.addRagdollChamObjects(ragdoll)
			if ragdoll:IsA("Model") and players:FindFirstChild(ragdoll.Name) then
				visuals.ragdollobjects[ragdoll.Name] = {}
				for i, v in next, (ragdoll:GetChildren()) do
					table.insert(visuals.ragdollobjects[ragdoll.Name], v)
				end
			end
		end

		for i, child in next, (workspace.Debris:GetChildren()) do
			visuals.addRagdollChamObjects(child)
		end

		function visuals.updateRagdollChams()
			if tick() - visuals.lastragdollupdate > 0.1 then
				visuals.lastragdollupdate = tick()
				if Menu["Visuals"]["Extra"]["Ragdoll Chams"]["Toggle"]["Enabled"] then
					local Animation = ""
					if Menu["Visuals"]["Extra"]["Ragdoll Cham Material"]["Value"] == "Ghost" then
						Animation = visuals.forcefieldAnimations["Off"]
					end
					for i, v in next, (players:GetPlayers()) do
						if visuals.ragdollobjects[v.Name] then
							for i2, v2 in next, (visuals.ragdollobjects[v.Name]) do
								if v2:IsA("Accessory") or v2:IsA("Shirt") or v2:IsA("Pants") then
									v2:Destroy()
								elseif v2:IsA("BasePart") or v2:IsA("MeshPart") and v2.Transparency < 1 and not (v2.Name == "BackC4") then
									v2.Transparency = Menu["Visuals"]["Extra"]["Ragdoll Chams"]["Color 1"]["Transparency"]
									v2.Color = Menu["Visuals"]["Extra"]["Ragdoll Chams"]["Color 1"]["Color"]
									v2.Material = visuals.materials[Menu["Visuals"]["Extra"]["Ragdoll Cham Material"]["Value"]]
									if v2:IsA("MeshPart") or v2:IsA("SpecialMesh") then
										if v2:IsA("MeshPart") then 
											v2.TextureID = Animation
										else
											v2.TextureId = Animation
										end
									end
									local HiddenMesh = v2:FindFirstChildOfClass("MeshPart") or v2:FindFirstChildOfClass("SpecialMesh") or nil
									if HiddenMesh then
										if HiddenMesh:IsA("MeshPart") then
											HiddenMesh.TextureID = Animation
										else
											HiddenMesh.TextureId = Animation
										end
									end
								end
							end
						end
					end
				end
			else
				return
			end
		end
			--[[
				I love how feminine I feel wearing my thigh highs while coding
			]]
		visuals.ragdollChamsUpdater = runService.Stepped:Connect(function()
			--debug.profilebegin("ragdoll chams")
			visuals.updateRagdollChams()
			--debug.profileend()
		end)

		workspace.Debris.ChildAdded:Connect(function(child)
			task.wait()
			visuals.addWeaponESP(child) -- there
			visuals.addRagdollChamObjects(child)
		end)

		workspace.Debris.ChildRemoved:Connect(visuals.removeWeaponESP)

		for i,v in next, workspace.Debris:GetChildren() do
			visuals.addWeaponESP(v)
		end

		function visuals.addBombESP(child)
			if child.Name == "C4" then -- ok i made this awful because initially it wasnt done with circles n icons in mind
				local ExplosionTime = tick() + 40
				local elNig = tick()
				local thisStuff = {}
				thisStuff["C4"] = {}
				thisStuff["C4"]["Drawings"] = {}
				thisStuff["C4"]["Drawings"]["BackerCircle"] = visuals.createDrawing("Circle", {
					Visible = false,
					Transparency = 1,
					Color = Color3.fromRGB(24, 24, 24),
					NumSides = 360,
					Radius = 38,
					Filled = true,
					Position = newVector2(),
				})
				thisStuff["C4"]["Drawings"]["BackCircle"] = visuals.createDrawing("Circle", {
					Visible = false,
					Transparency = 1,
					Color = Color3.fromRGB(64, 64, 64),
					NumSides = 360,
					Radius = 36,
					Filled = true,
					Position = newVector2(),
				})
				local radius = 36
				local lines = 2 * pi * radius
				for i = 1, lines do -- i am so sorry
					thisStuff["C4"]["Drawings"][tostring(i)] = visuals.createDrawing("Line", {
						Thickness = 2,
						Visible = true,
						Color = Color3.fromRGB(255, 0, 0),
					})
				end
				thisStuff["C4"]["Drawings"]["FrontCircle"] = visuals.createDrawing("Circle", {
					Visible = false,
					Transparency = 1,
					Color = Color3.fromRGB(24, 24, 24),
					NumSides = 360,
					Radius = 34,
					Filled = true,
					Position = newVector2(),
				})
				thisStuff["C4"]["Drawings"]["Icon"] = visuals.createDrawing("Image", {
					Data = visuals.imagecache["C4"],
					Size = newVector2(90, 32),
					Transparency = 1,
				})
				thisStuff["C4"]["Drawings"]["NameText"] = visuals.createDrawing("Text", {
					Font = 2,
					Text = child.Name,
					Visible = false,
					Position = newVector2(),
					Size = 13,
					Transparency = 1,
					Color = Color3.new(1, 1, 1),
					Center = true,
					Outline = true,
				})
				thisStuff["C4"]["Drawings"]["DamageText"] = visuals.createDrawing("Text", {
					Font = 2,
					Text = "100",
					Visible = false,
					Position = newVector2(),
					Size = 13,
					Transparency = 1,
					Color = Color3.new(1, 1, 1),
					Center = true,
					Outline = true,
				})


				thisStuff["C4"].step = runService.Stepped:Connect(function()
					--debug.profilebegin("c4 esp")
					if child.Parent ~= workspace or not child.PrimaryPart or not child.PrimaryPart.Position then -- get rid of this shit
						thisStuff["C4"].step:Disconnect()
						for i, v in next, (thisStuff["C4"]["Drawings"]) do
							v.Visible = false
							--v:Remove() -- unstable??? tf??
							v = nil
						end
						thisStuff["C4"]["Drawings"] = nil
						thisStuff["C4"] = nil
						return
					else
						if Menu["ESP"]["Dropped ESP"]["Bomb Warning"]["Toggle"]["Enabled"] then
							local bombPosition, bombOnScreen = mathModule.worldToViewportPoint(child.PrimaryPart.Position, true, 50)
							local bombDamage = math.ceil(math.max(254 - ((((child.PrimaryPart.Position - camera.CFrame.p).Magnitude)/120)*254), 0)) + 1
							local percentagetime = workspace.Status.Defused.Value == false and ((ExplosionTime - tick()) / 40) or 1
							local percentagetoexplode = workspace.Status.Defused.Value == false and math.clamp(((tick() - ExplosionTime) / 40), -1, 0) or -1
							local lower = Menu["ESP"]["Dropped ESP"]["Bomb Warning"]["Color 1"]["Color"]
							local upper = Menu["ESP"]["Dropped ESP"]["Bomb Warning"]["Color 2"]["Color"]

							bombPosition = newVector2(math.floor(bombPosition.x), math.floor(bombPosition.y))

							thisStuff["C4"]["Drawings"].BackerCircle.Color = Color3.fromRGB(24, 24, 24)
							thisStuff["C4"]["Drawings"].BackCircle.Color = Color3.fromRGB(0, 0, 0)
							thisStuff["C4"]["Drawings"].FrontCircle.Color = Color3.fromRGB(24, 24, 24)
							thisStuff["C4"]["Drawings"].DamageText.Color = Color3.new(1, 1, 1)

							if workspace.Status.Defused.Value == false then
								if ExplosionTime - tick() > 0 then
									thisStuff["C4"]["Drawings"].NameText.Text = tostring(mathModule.truncateNumber(ExplosionTime - tick(), 1)) .. "s"
								else
									thisStuff["C4"]["Drawings"].NameText.Text = "Exploding"
								end
								if (localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")) then
									thisStuff["C4"]["Drawings"].DamageText.Text = tostring(bombDamage)
									if bombDamage <= 1 then
										thisStuff["C4"]["Drawings"].DamageText.Text = "Safe"
									elseif bombDamage > localPlayer.Character.Humanoid.Health then
										thisStuff["C4"]["Drawings"].DamageText.Text = "Lethal"
										thisStuff["C4"]["Drawings"].DamageText.Color = Color3.new(1, 0.2, 0.2)
									end
								else
									thisStuff["C4"]["Drawings"].DamageText.Text = "Safe"
								end
							else
								thisStuff["C4"]["Drawings"].NameText.Text = "0.0s"
								thisStuff["C4"]["Drawings"].DamageText.Text = "Defused"
							end

							thisStuff["C4"]["Drawings"].Icon.Position = bombPosition - newVector2(math.floor(thisStuff["C4"]["Drawings"].Icon.Size.X / 2), 30) 
							thisStuff["C4"]["Drawings"].NameText.Position = bombPosition + newVector2(0, 1)
							thisStuff["C4"]["Drawings"].DamageText.Position = bombPosition + newVector2(0, 15)
							thisStuff["C4"]["Drawings"].BackerCircle.Position = bombPosition
							thisStuff["C4"]["Drawings"].BackCircle.Position = bombPosition
							thisStuff["C4"]["Drawings"].FrontCircle.Position = bombPosition

							thisStuff["C4"]["Drawings"].Icon.Visible = true
							thisStuff["C4"]["Drawings"].NameText.Visible = true
							thisStuff["C4"]["Drawings"].DamageText.Visible = true
							thisStuff["C4"]["Drawings"].BackerCircle.Visible = true
							thisStuff["C4"]["Drawings"].BackCircle.Visible = true
							thisStuff["C4"]["Drawings"].FrontCircle.Visible = true


							local percent = (tick() - elNig) / (ExplosionTime - elNig)
							local lerpcolor = lower:lerp(upper, percent)
							local toshow = thisStuff["C4"]["Drawings"].DamageText.Text == "Defused" and lines * 1 or math.floor(lines * percent)
							
							local centerpos = thisStuff["C4"]["Drawings"].FrontCircle.Position
							for i = 1, lines do
								local the = tostring(i)
								local elLine = thisStuff["C4"]["Drawings"][the]
								if elLine then
									if i < toshow then
										elLine.Visible = false
									else
										elLine.Visible = true
										local mangle = (i / lines) * 360
										local cx, cy = math.sin(toRad * mangle), math.cos(toRad * mangle)

										elLine.From = centerpos
										elLine.To = centerpos + newVector2(math.floor(cx * radius), math.floor(cy * radius))
										elLine.Color = lerpcolor
									end
								end
							end
						else
							for i, v in next, (thisStuff["C4"]["Drawings"]) do
								v.Visible = false
							end
						end
					end
					--debug.profileend()
				end)
			end
		end

		workspace.ChildAdded:Connect(function(child)
			task.wait()
			visuals.addBombESP(child)
		end)


		do --ANCHOR Bullet Tracer
			visuals.tracerParent = Instance.new("Part", workspace:WaitForChild("Terrain", 1/0))
			visuals.tracerParent.Anchored = true
			visuals.tracerParent.CanCollide = false
			visuals.tracerParent.Transparency = 1
			for i = 1, 10 do
				visuals.tracerObjects[i] = {
					beam = Instance.new("Beam"),
					a0 = Instance.new("Attachment"),
					a1 = Instance.new("Attachment"),
					used = false
				}
			end
			visuals.shotIndex = 0

			function visuals.bulletTracer(origin, target)
				visuals.shotIndex = visuals.shotIndex + 1
				if visuals.shotIndex > 10 then
					for i = 1, 10 do
						visuals.tracerObjects[i] = {
							beam = Instance.new("Beam"),
							a0 = Instance.new("Attachment"),
							a1 = Instance.new("Attachment"),
							used = false
						}
					end
					visuals.shotIndex = 1
				end
				local object = visuals.tracerObjects[visuals.shotIndex]
				object.used = true
				local m = "Camera"
				if origin == nil then
					local cameraCf = camera.CFrame
					if Menu["Visuals"]["Camera"]["Third Person"]["Toggle"]["Enabled"] and Menu["Visuals"]["Camera"]["Third Person"]["Bind"]["Active"] then
						cameraCf = cameraCf * newCframe(0, 0, -Menu["Visuals"]["Camera"]["Third Person Distance"].Value/10)
					end
					if m == "Automatic" then
						--u want it to use barrel if its not ads, if its ads then use camera cf
						if getupvalue(client.updateads, 1) then
							origin = localPlayer.Character.HumanoidRootPart.Position -- exactly how i want it
						elseif Menu["Visuals"]["Camera"]["Third Person"]["Toggle"]["Enabled"] and Menu["Visuals"]["Camera"]["Third Person"]["Bind"]["Active"] then
							origin = cameraCf.p
						else
							local arms = camera:FindFirstChild("Arms")
							if arms then
								local flash = arms:FindFirstChild("Flash")
								if flash then
									origin = flash.Position
								else
									origin = cameraCf.p --never what the fuck
								end
							end
						end -- done
					elseif m == "Barrel" then
						local arms = camera:FindFirstChild("Arms")
						if arms then
							local flash = arms:FindFirstChild("Flash")
							if flash then
								origin = flash.Position
							else
								origin = cameraCf.p --never what the fuck
							end
						end
					elseif m == "Camera" then
						origin = cameraCf.p
					end
				end
				object.a0.WorldPosition = origin
				object.a1.WorldPosition = target
				object.beam.Attachment0 = object.a0
				object.beam.Attachment1 = object.a1
				object.beam.FaceCamera = true
				object.beam.LightInfluence = 0
				object.beam.Color = ColorSequence.new(Menu["Visuals"]["Bullets"]["Bullet Tracers"]["Color 1"]["Color"])
				object.beam.Transparency = NumberSequence.new(Menu["Visuals"]["Bullets"]["Bullet Tracers"]["Color 1"]["Transparency"])
				object.beam.Texture = "rbxassetid://446111271"
				object.beam.TextureLength = 12
				object.beam.TextureSpeed = 6
				object.beam.ZOffset = -1
				object.beam.TextureMode = Enum.TextureMode.Wrap
				object.a0.Parent = visuals.tracerParent
				object.a1.Parent = visuals.tracerParent
				object.beam.Parent = visuals.tracerParent
				task.delay(Menu["Visuals"]["Bullets"]["Bullet Tracer Life Time"]["Value"], function()
					local originalWidth0 = object.beam.Width0
					local originalWidth1 = object.beam.Width1

					local passed = 0
					while passed < Menu["Visuals"]["Bullets"]["Bullet Tracer Fade Time"]["Value"] do
						object.beam.Width0 = originalWidth0 * (Menu["Visuals"]["Bullets"]["Bullet Tracer Fade Time"]["Value"] - passed)
						object.beam.Width1 = originalWidth1 * (Menu["Visuals"]["Bullets"]["Bullet Tracer Fade Time"]["Value"] - passed)
						passed = passed + task.wait()
					end

					object.beam.Destroy(object.beam)
					object.a0.Destroy(object.a0)
					object.a1.Destroy(object.a1)
					table.clear(object)
					visuals.tracerObjects[visuals.shotIndex] = nil
					object = nil
				end)
			end

			function visuals.updateTracerProperties()
				for i,v in next, visuals.tracerParent:GetChildren() do
					if v.ClassName == "Beam" then
						v.Color = ColorSequence.new(Menu["Visuals"]["Bullets"]["Bullet Tracers"]["Color 1"]["Color"])
						v.Transparency = NumberSequence.new(not Menu["Visuals"]["Bullets"]["Bullet Tracers"]["Toggle"]["Enabled"] and 1 or Menu["Visuals"]["Bullets"]["Bullet Tracers"]["Color 1"]["Transparency"])
					end
				end
			end

			Menu["Visuals"]["Bullets"]["Bullet Tracers"]["Color 1"].Changed:Connect(visuals.updateTracerProperties)
			Menu["Visuals"]["Bullets"]["Bullet Tracers"]["Toggle"].Changed:Connect(visuals.updateTracerProperties)
		end
		--  dn
		function visuals.createHitChams(character)
			local old = getthreadidentity()
			setthreadidentity(8)

			character.Archivable = true
			local cloned = character:Clone()
			cloned.Parent = workspace.Ray_Ignore
			cloned:SetPrimaryPartCFrame(character:GetPrimaryPartCFrame())

			if cloned:FindFirstChildOfClass("Humanoid") then
				cloned:FindFirstChildOfClass("Humanoid"):Destroy()
			end
			--yo whats like the fucking delay sldier or sum shit idfk
			-- idk
			-- 1 sec
			-- fuck it for now
			-- no iwan finish this
			-- fuck u i have to make a whole new section

			local transNumber = Instance.new("NumberValue")

			for i,v in next, cloned:GetDescendants() do
				if v:IsA("BasePart") then -- ue
					v.CanCollide = false
					v.Anchored = true
					if v.Transparency ~= 1 then
						v.Material = visuals.materials[Menu["Visuals"]["Hits"]["Hit Cham Material"]["Value"]]
						v.Color = Menu["Visuals"]["Hits"]["Hit Chams"]["Color 1"]["Color"]
						v.Transparency = Menu["Visuals"]["Hits"]["Hit Chams"]["Color 1"]["Transparency"]
						if Menu["Visuals"]["Hits"]["Hit Cham Material"]["Value"] == "Reflective" then -- dn
							v.Reflectance = 1
						end
						transNumber:GetPropertyChangedSignal("Value"):Connect(function()
							v.Transparency = transNumber.Value
						end)
					end
				elseif v:IsA("MeshPart") then
					v.CanCollide = false
				end
				if v.Name == "HeadHB" or v:IsA("Shirt") or v:IsA("Pants") then -- nigga
					v:Destroy()
				end
				if v:IsA("MeshPart") then
					v.TextureID = visuals.forcefieldAnimations["Off"] -- local function __llll(_, __ll_, _l_l)
				end
			end
			task.delay(Menu["Visuals"]["Hits"]["Hit Cham Life Time"].Value, function()
				local tween = tweenService:Create(transNumber, TweenInfo.new(Menu["Visuals"]["Hits"]["Hit Cham Fade Time"].Value), {
					Value = 1
				})
				tween:Play()
				--ik this looks dumb but trust me this is better as it loops in the c++ side so its faster (proof = ur ui tweening is done like this)
				-- okayy
				--also its kinda multithreaded so everything will go like, instantly and not just one prat and then move on yk
				--downside = might cause memory leak but like for a while

				tween.Completed:Wait()
				tween:Destroy()
				cloned:Destroy()
				transNumber:Destroy()
			end)
			setthreadidentity(old)
		end

		function visuals.unload()
			visuals.espStepConnection:Disconnect()
			for i = #visuals.allDrawingObjects, 1, -1 do
				local draw = visuals.allDrawingObjects[i]
				if draw then
					pcall(function()
						draw.Visible = false
						draw.Transparency = 0
						draw:Remove()
						draw = nil
					end)
				end
			end
			table.clear(visuals.allDrawingObjects)
			table.clear(visuals.espObjects)
			visuals = {}
		end

		function visuals.RemoveFlash()
			localPlayer.PlayerGui.Blnd.Blind.Visible = not Menu["Visuals"]["Extra"]["Remove Flash"]["Toggle"]["Enabled"]
		end

		Menu["Visuals"]["Extra"]["Remove Flash"]["Toggle"].Changed:Connect(visuals.RemoveFlash)

		function visuals.ModifySmoke(smoke)
			local particleemitter = smoke:WaitForChild("ParticleEmitter", 1/0)
			if particleemitter.Enabled ~= Menu["Visuals"]["Extra"]["Remove Smoke"]["Toggle"]["Enabled"] then
				if Menu["Visuals"]["Extra"]["Remove Smoke"]["Toggle"]["Enabled"] then
					particleemitter:Clear()
				else
					particleemitter:Emit(10)
				end
			end
			particleemitter.Enabled = not Menu["Visuals"]["Extra"]["Remove Smoke"]["Toggle"]["Enabled"]
		end

		function visuals.ModifySmokes()
			for i, v in next, (workspace.Ray_Ignore.Smokes:GetChildren()) do
				visuals.ModifySmoke(v)
			end
		end

		local lastSmokeModification = tick()
		runService.Stepped:Connect(function()
			if tick() - lastSmokeModification > 1/10 then
				--debug.profilebegin("smoke modifier")
				lastSmokeModification = tick()
				visuals.ModifySmokes()
				--debug.profileend()
			end
		end)

		--[[function visuals.nadewarning(nade)
			local bodyforce = emptyVec3
			local grenadetype
			local handle = nade:FindFirstChild("Handle2")
			if handle == nil then return end
			local nadetexture = handle.TextureID
			local nadedata = {}
			for i, v in next, (replicatedStorage.Weapons:GetChildren()) do
				if v:FindFirstChild("Grenade") then
					local model = v:FindFirstChild("Model")
					if nadetexture == model.Handle2.TextureID then -- FUCK ROLVE FUCK ROLVE
						grenadetype = v.Name
					end
				end
			end
			if nade:FindFirstChild("GunDrop") then return end -- ok this is a dropped one, not one that has been thrown
			for i, v in next, (replicatedStorage.Weapons:FindFirstChild(grenadetype):GetChildren()) do
				if v:IsA("NumberValue") or v:IsA("IntValue") then
					nadedata[v.Name] = v.Value
				end
			end
			local predict = trajectory.new({
				gravity = newVector3(0, -workspace.Gravity, 0), -- #fuck rolve
				step = 1/60, -- just a thousand steps, were good here
				time = 2.5, -- look, rolve nades are really fucking convoluted
				bounces = (grenadetype == "Molotov" or grenadetype == "Incendiary Grenade") and 0 or 4,
			})
			local ignorelist = { -- ignore this fuck
				findFirstChild(workspace.Map, "Clips"),
				findFirstChild(workspace.Map, "SpawnPoints"),
				camera,
				findFirstChild(workspace, "Debris"),
				findFirstChild(workspace, "Ray_Ignore"),
			}
			for i, v in next, (nade:GetDescendants()) do
				ignorelist[1 + #ignorelist] = v
			end
			for i, v in next, (players:GetPlayers()) do
				if v.Character then
					ignorelist[1 + #ignorelist] = v.Character
				end
			end
			
			local origin = nade.Handle2.CFrame.p
			local vel = nade:FindFirstChild("Velocity2").Value
			local pA = nade.CustomPhysicalProperties

			local path = predict:Cast({
				start = origin,
				velocity = vel,
				physics = pA, 
				ignores = ignorelist
			})

			local objects = predict:Draw({
				trail = path, 
				visible = true, 
				color = Color3.new(0, 1, 0), 
				bounce = Color3.new(1, 0, 0)
			})

			local endpos = objects[#objects][4].Position + newVector3(0, 1, 0)
			--create the actual warning
			local esp = {}
			esp.drawings = {
				["backcircle"] = visuals.createDrawing("Circle", {
					Visible = false,
					Transparency = 0.25,
					Color = Color3.fromRGB(64, 64, 64),
					NumSides = 360,
					Radius = 32,
					Filled = true,
					Position = newVector2(),
				}),
				["frontcircle"] = visuals.createDrawing("Circle", {
					Visible = false,
					Transparency = 0.25,
					Color = Color3.fromRGB(24, 24, 24),
					NumSides = 360,
					Radius = 30,
					Filled = true,
					Position = newVector2(),
				}),
				["icon"] = visuals.createDrawing("Image", {
					Data = visuals.imagecache[grenadetype],
					Size = grenadetype:match("HE") and newVector2(100, 38) or newVector2(128, 50),
					Transparency = 0.25,
				}),
			}
			local remove = false
			esp.updater = runService.RenderStepped:Connect(function(dt)
				local nadeposition, nadeonscreen = mathModule.worldToViewportPoint(endpos, true, 50)
				local center = newVector2(nadeposition.X, nadeposition.Y)
				esp.drawings.backcircle.Position = center
				esp.drawings.frontcircle.Position = center
				esp.drawings.backcircle.Color = Color3.fromRGB(64, 64, 64)
				esp.drawings.frontcircle.Color = Color3.fromRGB(24, 24, 24)
				esp.drawings.icon.Position = center - newVector2(esp.drawings.icon.Size.x / 2, esp.drawings.icon.Size.y / 2) -- preserve it

				if nade:FindFirstChild("Handle2") == nil or nade.Handle2.Transparency > 0 or nade.Parent ~= workspace.Debris or remove == true then
					remove = true
				else
					if Menu["ESP"]["Dropped ESP"]["Grenade Warning"]["Toggle"]["Enabled"] then
						for i, v in next, (esp.drawings) do
							v.Visible = true
						end
						local ignores = { -- ignore this
							findFirstChild(workspace.Map, "Clips"),
							findFirstChild(workspace.Map, "SpawnPoints"),
							camera,
							localPlayer.Character,
							findFirstChild(workspace, "Debris"),
							findFirstChild(workspace, "Ray_Ignore"),
						}

						local hit, pos = workspace:FindPartOnRayWithIgnoreList(Ray.new(camera.CFrame.p, endpos - camera.CFrame.p), ignores, false, true)
						if pos == endpos then
							-- its visible
							for i, v in next, (esp.drawings) do
								v.Transparency = math.clamp(v.Transparency + (dt * 2), 0.25, 1)
							end
							if grenadetype:match("HE") or grenadetype == "Molotov" or grenadetype == "Incendiary Grenade" then -- keep ur distance from these
								if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
									if (camera.CFrame.p - endpos).Magnitude < nadedata.MaxStudsForMaxDmg then
										local safety = (camera.CFrame.p - endpos).Magnitude / nadedata.MaxStudsForMaxDmg

										local result1 = Color3.fromRGB(245, 0, 0):lerp(Color3.fromRGB(64, 64, 64), safety)
										local result2 = Color3.fromRGB(205, 0, 0):lerp(Color3.fromRGB(24, 24, 24), safety)

										esp.drawings.backcircle.Color = result1
										esp.drawings.frontcircle.Color = result2
									end
								end
							elseif grenadetype:match("Flash") then -- just look away
								local angle = math.clamp(((math.abs(math.deg(math.acos((camera.CFrame.LookVector):Dot(newCframe(camera.CFrame.p, endpos).LookVector)))) * 2) / 180), 0, 1)

								local result1 = Color3.fromRGB(245, 0, 0):lerp(Color3.fromRGB(64, 64, 64), angle)
								local result2 = Color3.fromRGB(205, 0, 0):lerp(Color3.fromRGB(24, 24, 24), angle)

								esp.drawings.backcircle.Color = result1
								esp.drawings.frontcircle.Color = result2
							end	
						else
							for i, v in next, (esp.drawings) do
								v.Transparency = math.clamp(v.Transparency - (dt * 2), 0.25, 1)
							end
						end
					else
						for i, v in next, (esp.drawings) do
							v.Visible = false
						end
					end
				end
				if remove == true then
					for i, v in next, (esp.drawings) do
						v.Transparency = v.Transparency - (dt * 4)
					end
					if esp.drawings.backcircle.Transparency < 0 then
						esp.updater:Disconnect()
						for i, v in next, (esp.drawings) do
							v.Visible = false
							v = nil
						end
						for i, v in next, (objects) do
							for i2, v2 in next, (v) do
								v2:Destroy()
							end
						end
					end
				end
			end)
			visuals.grenadetrajectories[1 + #visuals.grenadetrajectories] = {predict, path, objects, esp}
		end
		workspace.Debris.ChildAdded:Connect(function(child)
			task.wait()
			if child:FindFirstChild("Explode") then
				visuals.nadewarning(child)
			end
		end)]]

		visuals.fovCircles = {}
		do
			local fovCircles = {}
			fovCircles.circles = {}
			for i = 1, 5 do
				local circle1 = visuals.createDrawing("Circle", {
					Visible = false,
					Thickness = 1,
					Radius = 3,
					Transparency = 1,
					Filled = false
				})
				local circle2 = visuals.createDrawing("Circle", {
					Visible = false,
					Thickness = 3,
					Color = Color3.new(),
					Radius = 3,
					Transparency = 0.25,
					Filled = false
				})

				fovCircles.circles[i] = {
					colored = circle1,
					outline = circle2
				}
			end
			local refreshedFovCircles = tick()
			fovCircles.loop = runService.Stepped:Connect(function()
				if tick() - refreshedFovCircles < 1/5 then
					return
				end
				--debug.profilebegin("fov circles")
				refreshedFovCircles = tick()
				camFov = camera.FieldOfView * 2
				local screenSize = camera.ViewportSize
				local centerScreen = newVector2(math.floor(screenSize.x / 2), math.floor(screenSize.y / 2))

				for iter, v in next, {"Aim Assist FOV", "Aim Assist Deadzone FOV", "Magnet Triggerbot FOV", "Bullet Redirection FOV", "Aimbot FOV"} do
					local enabled = Menu["Visuals"]["FOV"][v]["Toggle"]["Enabled"]
					local color = Menu["Visuals"]["FOV"][v]["Color 1"]["Color"]

					for o, c in next, fovCircles.circles[iter] do
						c.Visible = enabled
						if o == "colored" then
							c.Color = color
						end
						c.Position = centerScreen
					end
				end
					
				fovCircles.circles[1].colored.Radius = Menu["Legit"]["Aim Assist"]["Aimbot FOV"]["Value"] / camFov * screenSize.x
				fovCircles.circles[1].outline.Radius = fovCircles.circles[1].colored.Radius

				fovCircles.circles[2].colored.Radius = Menu["Legit"]["Aim Assist"]["Deadzone FOV"]["Value"] / camFov * screenSize.x
				fovCircles.circles[2].outline.Radius = fovCircles.circles[2].colored.Radius

				fovCircles.circles[3].colored.Radius = Menu["Legit"]["Trigger Bot"]["Magnet FOV"]["Value"] / camFov * screenSize.x
				fovCircles.circles[3].outline.Radius = fovCircles.circles[3].colored.Radius

				fovCircles.circles[4].colored.Radius = Menu["Legit"]["Bullet Redirection"]["Silent Aim FOV"]["Value"] / camFov * screenSize.x
				fovCircles.circles[4].outline.Radius = fovCircles.circles[4].colored.Radius

				fovCircles.circles[5].colored.Radius = Menu["Rage"]["Aimbot"]["Aimbot FOV"]["Value"] / camFov * screenSize.x
				fovCircles.circles[5].outline.Radius = fovCircles.circles[5].colored.Radius
				--debug.profileend()
			end)

			visuals.fovCircles = fovCircles
		end
	end

	do --ANCHOR Ragebot
		ragebot.fakeanimation = Instance.new("Animation")
		ragebot.fakeanimation.AnimationId = "rbxassetid://0"
		ragebot.fakehrp = nil -- the one that u control
		ragebot.realhrp = nil -- the one the server sees
		ragebot.lasthrpCf = CFrame.new()
		ragebot.returnpitch = false
		ragebot.jitterone = false
		ragebot.lastcrouch = tick()
		ragebot.lastcameracf = emptyCf
		ragebot.lastpitch = tick()
		ragebot.lastpitchangle = 0
		ragebot.lastcamupdate = tick()
		ragebot.hrpfix = nil
		ragebot.manualhrp = false
		ragebot.lby = tick()
		ragebot.autopeekrecovery = tick()
		ragebot.lastupdate = tick()
		ragebot.laststance = "Crouched"
		ragebot.shotindex = 0
		ragebot.lastreplicationtick = tick()
		ragebot.lastdt = tick()
		ragebot.lastshot = tick()
		ragebot.lastreload = tick()
		ragebot.triggerfl = false
		ragebot.currentindex = 1
		ragebot.hitboxes = {"Head", "UpperTorso", "LowerTorso", "LeftLowerArm", "RightLowerArm", "LeftLowerLeg", "RightLowerLeg", "LeftFoot", "RightFoot"}
		ragebot.minimumDamage = 36
		ragebot.shootSound = Instance.new("Sound", camera);
		ragebot.currenttarget = {
			player = nil,
			instance = nil,
			position = nil,
			modifier = nil,
			wallbang = nil,
			pInfo = nil
		}

		ragebot.baseantiaimbotangles = {
			pitch = {
				["Default"] = -0.65,
				["Up"] = 0.9,
				["Down"] = -0.9,
				["Zero"] = 0,
				["Upside Down"] = -5,
				["Roll Forward"] = 0,
				["Roll Backward"] = 0,
				["Random"] = 0,
				["Bob"] = 0,
				["Glitch"] = math.sqrt(-1)
			},
			yaw = {
				["Forward"] = 0,
				["Backward"] = 180,
				["Spin"] = 0 ,
				["Random"] = 0,
				["Glitch Spin"] = 180,
				["Stutter Spin"] = 180
			},
		}

		function ragebot.restrictangle(angle)
			if angle > 360 then
				return angle - 360
			elseif angle < 0 then
				return angle + 360
			else
				return angle
			end
		end

		ragebot.backtracks = {}
		ragebot.allPartsForBacktrack = {}
		ragebot.bodyParts = {
			"Head", "UpperTorso", "LowerTorso", "LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot"
		}

		function ragebot.setupbacktrack(player)
			task.wait()
			local this = {}
			this.middlepoint = newVector3()

			repeat task.wait() until playerInfo.storage[player] ~= nil
			
			local pInfo = playerInfo.storage[player]
			
			this.backtrackParts = {}
			this.visualizations = {}
			this.frameLogs = {}
			this.tickLogs = {}
			
			this.spawnParts = function(characterModel)
				for i = 1, #ragebot.bodyParts do
					local partName = ragebot.bodyParts[i]
					local part = characterModel:FindFirstChild(partName)
					if part and not this.backtrackParts[partName] then
						local bPart = Instance.new("Part")
						bPart.Size = part.Size
						bPart.Name = "HeadHB" -- holy shit invaded is a genius, (if 1 > PartHit.Transparency or PartHit.Name == "HeadHB" then) cb decompile
						bPart.Transparency = 1
						bPart.Color = Color3.new(1, 1, 1)
						bPart.Anchored = true
						bPart.CanCollide = false
						bPart.Parent = characterModel
							--[[ fixes a dt issue where it would go thru backtrack then through their playermodel, this should make the game ignore their player model as well once the backtrack is shot
								if PartHit and PartHit.Parent and PartHit.Parent.Name == "Hitboxes" or PartHit and PartHit.Parent and PartHit.Parent.Parent and PartHit.Parent.Parent:FindFirstChild("Humanoid2") or PartHit and PartHit.Parent and PartHit.Parent:FindFirstChild("Humanoid2") or PartHit and PartHit.Parent and PartHit.Parent:FindFirstChild("Humanoid") and (1 > PartHit.Transparency or PartHit.Name == "HeadHB") and PartHit.Parent:IsA("Model") then
									table.insert(hitlist, PartHit.Parent)
								else
									table.insert(hitlist, PartHit)
								end
							]]

						this.backtrackParts[partName] = bPart
						ragebot.allPartsForBacktrack[bPart] = part

						local vis = Instance.new("BoxHandleAdornment")
						vis.Parent = visuals.chamsFolder
						vis.ZIndex = 2
						vis.Adornee = bPart
						vis.Size = bPart.Size
						vis.Visible = false
						vis.AlwaysOnTop = true
						this.visualizations[partName] = vis
					end	
				end
			end
			this.onCharacterAdded = function(characterModel)
				this.onCharacterRemoved()
				this.spawnParts(characterModel)
			end
			this.updateBacktrack = function(upTime, deltaTime)
				--debug.profilebegin(player.Name .. " backtrack")
				local characterModel = player.Character
				if not characterModel then
					return
				end

				local thisTick = tick()

				local backtrackTime = (Menu["Rage"]["Tracking"]["Back Tracking"]["Toggle"]["Enabled"] and (Menu["Rage"]["Tracking"]["Back Tracking Time"]["Value"] / 1000) or 0)

				local backtrackedFrame
				for i, time in next, this.tickLogs do
					local behindBy = thisTick - time
					if behindBy > backtrackTime then
						backtrackedFrame = this.frameLogs[time]
						break
					end
				end
				
				local canShow = Menu["Rage"]["Tracking"]["Back Tracking"]["Toggle"]["Enabled"] and Menu["ESP"]["Enemy ESP"]["Show Backtrack Position"]["Toggle"]["Enabled"] and pInfo and pInfo.enemy and this.backtrackParts.LowerTorso ~= nil and characterModel:FindFirstChild("LowerTorso") and backtrackedFrame and backtrackedFrame.LowerTorso and (backtrackedFrame.LowerTorso.p - characterModel.LowerTorso.Position).Magnitude > 0.25
				local colorShow = Menu["ESP"]["Enemy ESP"]["Show Backtrack Position"]["Color 1"]["Color"]
				local transShow = Menu["ESP"]["Enemy ESP"]["Show Backtrack Position"]["Color 1"]["Transparency"]
				
				for i = 1, #ragebot.bodyParts do -- for each body part
					local d = ragebot.bodyParts[i]
					
					local btPart = this.backtrackParts[d]
					if btPart then
						if backtrackedFrame and backtrackedFrame[d] and canShow then
							btPart.CFrame = backtrackedFrame[d] -- move backtrack there
						else
							if btPart.Position ~= emptyVec3 then
								btPart.Position = emptyVec3
							end
						end

						local v = this.visualizations[d]
						
						if v then
							if canShow then
								v.Color3 = colorShow
								v.Transparency = transShow
								v.Visible = true
							else
								if v.Visible == true then
									v.Visible = false
									v.Transparency = 1
								end
							end	
						end
					else
						this.onCharacterAdded(characterModel)
						break
					end
				end

				local thisFrame = {}
				for i = 1, #ragebot.bodyParts do -- for each body part
					local d = ragebot.bodyParts[i]
					local part = characterModel:FindFirstChild(d)
					if part then
						thisFrame[d] = part.CFrame -- record this body part
					end
				end

				table.insert(this.tickLogs, 1, thisTick)
				this.frameLogs[thisTick] = thisFrame -- record the entire frame

				--debug.profileend()
			end
			this.step = runService.Stepped:Connect(this.updateBacktrack)   
			this.onCharacterRemoved = function()
				if this.frameLogs then
					table.clear(this.frameLogs)
				end
				if this.tickLogs then
					table.clear(this.tickLogs)
				end
				if this.backtrackParts then
					for i, v in next, this.backtrackParts do
						if ragebot.allPartsForBacktrack[v] then
							ragebot.allPartsForBacktrack[v] = nil
						end
						v:Destroy()
					end
					table.clear(this.backtrackParts)
				end
				if this.visualizations then
					for i,v in next, this.visualizations do
						v:Destroy()
					end
					table.clear(this.visualizations)
				end
			end

			if player.Character and player.Character:FindFirstChild("Humanoid") then
				this.onCharacterAdded(player.Character)
			end
			
			player.CharacterAdded:Connect(this.onCharacterAdded)
			ragebot.backtracks[player] = this
		end

		function ragebot.removebacktrack(player)
			local this = ragebot.backtracks[player]
			if this then
				this.step:Disconnect()
				this.step = nil
				this.onCharacterRemoved()
				if this.backtrackParts then
					for i, v in next, this.backtrackParts do
						if ragebot.allPartsForBacktrack[v] then
							ragebot.allPartsForBacktrack[v] = nil
						end
						v:Destroy()
						v = nil
					end
					table.clear(this.backtrackParts)
					this.backtrackParts = nil
				end
				if ragebot.backtracks[player].visualizations then
					for i,v in next, ragebot.backtracks[player].visualizations do
						v:Destroy()
						v = nil
					end
					table.clear(ragebot.backtracks[player].visualizations)
				end
				ragebot.backtracks[player] = nil
			end
		end

		for i, v in next, players:GetPlayers() do
			if v ~= localPlayer then
				task.spawn(ragebot.setupbacktrack, v)
			end
		end

		players.PlayerAdded:Connect(ragebot.setupbacktrack)
		players.PlayerRemoving:Connect(ragebot.removebacktrack)

		function ragebot.updatedynamicangles(delta) -- kinda scuffed but dn
			if tick() - ragebot.lastupdate < 1/64 then return end
			
			ragebot.lastupdate = tick()
			ragebot.jitterone = not ragebot.jitterone
			ragebot.baseantiaimbotangles.pitch["Roll Backward"] = ragebot.baseantiaimbotangles.pitch["Roll Backward"] + (delta * 24)
			if ragebot.baseantiaimbotangles.pitch["Roll Backward"] > 4 then
				ragebot.baseantiaimbotangles.pitch["Roll Backward"] = -4
			end

			ragebot.baseantiaimbotangles.pitch["Roll Forward"] = ragebot.baseantiaimbotangles.pitch["Roll Forward"] - (delta * 24)
			if ragebot.baseantiaimbotangles.pitch["Roll Forward"] < -4 then
				ragebot.baseantiaimbotangles.pitch["Roll Forward"] = 4
			end
			ragebot.baseantiaimbotangles.pitch.Random = math.random(-1000, 1000)/1000
			ragebot.baseantiaimbotangles.pitch.Bob = 0.5 * math.cos(16*tick())

			ragebot.baseantiaimbotangles.yaw.Spin = ragebot.restrictangle(ragebot.baseantiaimbotangles.yaw.Spin + ((Menu["Rage"]["Anti Aim"]["Yaw angle"]["Value"] * 30) * delta))
			local upperbound, lowerbound, dir
			if Menu["Rage"]["Anti Aim"]["Yaw angle"]["Value"] > 0 then
				upperbound = Menu["Rage"]["Anti Aim"]["Yaw angle"]["Value"]
				lowerbound = -1 * Menu["Rage"]["Anti Aim"]["Yaw angle"]["Value"]
				dir = 1
			else
				upperbound = -1 * Menu["Rage"]["Anti Aim"]["Yaw angle"]["Value"]
				lowerbound = Menu["Rage"]["Anti Aim"]["Yaw angle"]["Value"]
				dir = -1
			end

			ragebot.baseantiaimbotangles.yaw["Glitch Spin"] = ragebot.restrictangle(ragebot.baseantiaimbotangles.yaw["Glitch Spin"] + ((Menu["Rage"]["Anti Aim"]["Yaw angle"]["Value"] + (math.cos(tick() * 16) * math.sin(tick() * 32) * math.random(8, 12) * dir * math.random(-lowerbound, upperbound)))))
			ragebot.baseantiaimbotangles.yaw["Stutter Spin"] = ragebot.restrictangle(ragebot.baseantiaimbotangles.yaw["Stutter Spin"] + ((Menu["Rage"]["Anti Aim"]["Yaw angle"]["Value"] + (math.cos(tick() * 8) * 4 * dir * math.random(lowerbound, upperbound)))))
		end
		
		function ragebot.setweapons()
			local primary = Menu["Misc"]["Extra"]["Buy Bot Primary"]["Value"]
			local secondary = Menu["Misc"]["Extra"]["Buy Bot Secondary"]["Value"]

			local replicatedStorage = game:GetService("ReplicatedStorage")
			local selectedWeapon1 = Menu["Misc"]["Extra"]["Buy Bot Secondary"]["Value"]
	

			if replicatedStorage:FindFirstChild("Weapons") then
				local weaponData = replicatedStorage.Weapons[selectedWeapon1]
				client.secondary = selectedWeapon1
				client.secondaryowner = localPlayer.Name
				client.secondaryskin = "pastexpectional"
				client.secondarystattrak = nil
			-- client.realgun = selectedWeapon
				client.vars.ammocount2 = weaponData.Ammo.Value
				client.vars.secondarystored = weaponData.StoredAmmo.Value
				client.updateInventory()
			end
			local replicatedStorage = game:GetService("ReplicatedStorage")
			local selectedWeapon = 	Menu["Misc"]["Extra"]["Buy Bot Primary"]["Value"]

			if replicatedStorage:FindFirstChild("Weapons") then
				local weaponData = replicatedStorage.Weapons[selectedWeapon]
				client.primary = selectedWeapon
				client.primaryowner = localPlayer.Name
				client.primaryskin = "pastexpectional"
				client.primarystattrak = nil
				client.realgun = selectedWeapon
				client.vars.ammocount = weaponData.Ammo.Value
				client.vars.primarystored = weaponData.StoredAmmo.Value
				client.updateInventory()
			end
		end
		Menu["Misc"]["Extra"]["Buy Weapons"]["Button"].Pressed:Connect(function()
			if ragebot.fakehrp then
				ragebot.setweapons()
			end
		end)

		function ragebot.nearesttocrosshair()
			local lowest = inf
			local nearest
			for i, pInfo in next, (playerInfo.storage) do
				if pInfo.alive and pInfo.enemy and not (pInfo.protected or pInfo.god) then
					local angle = (math.abs(math.deg(math.acos((camera.CFrame.LookVector):Dot(newCframe(camera.CFrame.p, pInfo.character.HumanoidRootPart.Position).LookVector))))) * 2 -- cope!!!
					if angle < lowest then
						lowest = angle
						nearest = pInfo
					end
				end
			end
			return nearest
		end
		
		local targetThirdPersonDistance = 0
		local timeSinceLast3p = 0
		runService.RenderStepped:Connect(function(deltaTime)
			if Menu["Visuals"]["Camera"]["Third Person"]["Toggle"]["Enabled"] and Menu["Visuals"]["Camera"]["Third Person"]["Bind"]["Active"] and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
				local thingy = math.clamp((1 / (-2.71828 ^ (8 * math.clamp(timeSinceLast3p, 0, 2)))) + 1, 0, 1) * Menu["Visuals"]["Camera"]["Third Person Distance"]["Value"] / 10
				targetThirdPersonDistance = thingy
				timeSinceLast3p = timeSinceLast3p + deltaTime
			else
				timeSinceLast3p = 0
				targetThirdPersonDistance = 0
			end
		end)
		local oldNIndex; oldNIndex = hookmetamethod(game, "__newindex", function(self, k, v)
			if self == camera and k == "CFrame" then
				if tostring(getcallingscript()) == "Client" and Menu["Visuals"]["Camera"]["Remove Camera Recoil"]["Toggle"]["Enabled"] then
					return
				end
			end
			return oldNIndex(self, k, v)
		end)
		local oldIndex; oldIndex = hookmetamethod(game, "__index", function(self, k)
			if k == "Velocity" and self.Parent == localPlayer.Character and ragebot.fakehrp then
				return oldIndex(ragebot.fakehrp, k)
			end
			return oldIndex(self, k)
		end)
		
		runService:BindToRenderStep("cameraFix", Enum.RenderPriority.Camera.Value + 1, function()
			if Menu["Visuals"]["Camera"]["Third Person"]["Toggle"]["Enabled"] and Menu["Visuals"]["Camera"]["Third Person"]["Bind"]["Active"] then
				local wall, pos, norm = workspace:FindPartOnRayWithWhitelist(Ray.new(camera.CFrame.p, (camera.CFrame * CFrame.new(0, 0, targetThirdPersonDistance).p) - camera.CFrame.p), {workspace.Map}, true)
				camera.CFrame = camera.CFrame * CFrame.new(0, 0, (pos - camera.CFrame.p).Magnitude - (wall and 0.15 or 0))
				if camera.CameraType ~= Enum.CameraType.Track and targetThirdPersonDistance > 0 then
					camera.CameraType = Enum.CameraType.Track
				end
			else
				if camera.CameraType ~= Enum.CameraType.Custom then
					camera.CameraType = Enum.CameraType.Custom
				end
			end
		end)

		function ragebot.setupfakehrp(char)
			local oldhrp = char:WaitForChild("HumanoidRootPart", 1/0)

			ragebot.realhrp = oldhrp
			ragebot.lasthrpCf = ragebot.realhrp.CFrame
			ragebot.fakehrp = oldhrp:Clone() --then u are leaking fakelag
			
			ragebot.realhrp.Name = "___"
			ragebot.fakehrp.Name = "HumanoidRootPart"

			ragebot.fakehrp.Parent = char
			cache.replace(ragebot.realhrp, ragebot.fakehrp)

			ragebot.fakehrp.CFrame = ragebot.lasthrpCf
			ragebot.realhrp.CFrame = ragebot.lasthrpCf
			
			physicsService:SetPartCollisionGroup(ragebot.fakehrp, "Debris")
		end

		ragebot.hrpfix = runService.Stepped:Connect(function(delta)
			--debug.profilebegin("hrp fix")
			local char = localPlayer.Character
			if not ragebot.realhrp or not ragebot.fakehrp or not char then 
				return
			end
			
			if not ragebot.manualhrp then
				ragebot.realhrp.CFrame = ragebot.lasthrpCf
			end

			ragebot.realhrp.AssemblyLinearVelocity = emptyVec3
			--ragebot.realhrp.AssemblyLinearVelocity = newVector3(ragebot.realhrp.AssemblyLinearVelocity.x, 0, ragebot.realhrp.AssemblyLinearVelocity.z)
			--[[if findFirstChild(char, "Gun") then
				for i, v in next, (char.Gun:GetChildren()) do
					if v.Name == "GunWeld" then
						v.Part0 = nil
					end
				end
			end]]
			--debug.profileend()
		end)

		function ragebot.removefakehrp()
			if ragebot.fakehrp == nil then return end
			ragebot.fakehrp.Name = "___"
			ragebot.realhrp.CFrame = ragebot.fakehrp.CFrame -- sync the fuck
			ragebot.realhrp.Name = "HumanoidRootPart"
			ragebot.fakehrp:Destroy()
			ragebot.fakehrp = nil
			ragebot.realhrp = nil
		end

		if localPlayer.Character then
			ragebot.setupfakehrp(localPlayer.Character)
		end

		localPlayer.CharacterAdded:Connect(function()
			repeat task.wait() until localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") and localPlayer.Character.Humanoid.Health > 0
			task.wait(.1)
			if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
				ragebot.setupfakehrp(localPlayer.Character)
				if Menu["Misc"]["Extra"]["Auto Buy Bot"]["Toggle"]["Enabled"] then
					ragebot.setweapons()
				end
			end
		end)

		localPlayer.CharacterRemoving:Connect(ragebot.removefakehrp)

		local necko = CFrame.new(-5.96046448e-08, 0.799999952, 1.1920929e-07, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		local armo2 = CFrame.new(-1.24989128, 0.549999952, 1.1920929e-07, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		local armo1 = CFrame.new(1.24998045, 0.549999952, 1.1920929e-07, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		local uppat = CFrame.new(-1.1920929e-07, 0.550000072, 7.64462551e-20, 1, 0, 0, 0, 1, 0, 0, 0, 1)	

		function ragebot.controlturn(player, ylookvector, climbing)
			if player.Character and player.Character:FindFirstChild("UpperTorso") and player.Character:FindFirstChild("RightUpperArm") and player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("Neck") then
				local neck = player.Character.Head.Neck
				local arm = player.Character.LeftUpperArm.LeftShoulder
				local arm2 = player.Character.RightUpperArm.RightShoulder
				local waist = player.Character.UpperTorso.Waist
				if waist then
					local angle = ((pi / 3) * 1) * (ylookvector) * 0.6

					waist.C0 = uppat * CFrame.Angles(angle, 0, 0)

				end
				if neck then
					neck.C0 = necko * CFrame.Angles(((pi / 3) * 1) * ylookvector, 0, 0)
				end
				if arm then
					arm.C0 = armo2 * CFrame.Angles(((pi / 3) * 1) * ylookvector * 0.5, 0, 0)

				end
				if arm2 then
					arm2.C0 = armo1 * CFrame.Angles(((pi / 3) * 1) * ylookvector * 0.5, 0, 0)
				end
				if climbing then
					waist.C0 = uppat
					neck.C0 = necko
					arm.C0 = armo2
					arm2.C0 = armo1
				end
			end
		end
		--fakelagstart
		ragebot.fakeLagging = false
		local fakeReplicationUpdate = function(uptime, delta)
			local delayedcf, pitch

			if not ragebot.fakehrp or not ragebot.realhrp or not localPlayer.Status.Alive.Value or not localPlayer.Character then
				return
			end
			
			if movement and movement.step then
				movement.step(delta)
			end
			if ragebot.fakehrp and ragebot.realhrp then -- establish our un-fucked angles
				delayedcf = ragebot.fakehrp.CFrame
				local camerapitch, camerayaw = mathModule.lookVecToPitchYaw(camera.CFrame.LookVector)
				pitch = toDeg * camerapitch / 90

				-- shaky model fix
				ragebot.realhrp.AssemblyLinearVelocity = emptyVec3
				
				ragebot.controlturn(localPlayer, ragebot.lastpitchangle, lastClimbStatus)
			end
	
			
			ragebot.fakeLagging = false
			-- we dont actually change the fakehrp shit, this makes climbing ladders n shit really easy
			-- we just base the unfucked angles on fakehrp, manipulate that then set the realhrp cframe to the fucked one

			if Menu["Rage"]["Fake Lag"]["Enabled"]["Toggle"]["Enabled"] then
				task.wait(Menu["Rage"]["Fake Lag"]["Replication Delay"]["Value"]/1000)
				ragebot.fakeLagging = true
			end

			if localPlayer.Character:FindFirstChild("HeadHB") and localPlayer.Character:FindFirstChild("FakeHead") then
				if not localPlayer.Character.HeadHB:FindFirstChild("Weld") and not localPlayer.Character.FakeHead:FindFirstChild("Weld") then
					localPlayer.Character.FakeHead.AssemblyLinearVelocity = newVector3()
					localPlayer.Character.HeadHB.AssemblyLinearVelocity = newVector3()

					localPlayer.Character.FakeHead.CFrame = localPlayer.Character.Head.CFrame
					localPlayer.Character.HeadHB.CFrame = localPlayer.Character.Head.CFrame
				end
			end

			-- prevent replication
			if Menu["Rage"]["Fake Lag"]["Prevent Replication"]["Toggle"]["Enabled"] and Menu["Rage"]["Fake Lag"]["Prevent Replication"]["Bind"]["Active"] then
				ragebot.fakeLagging = true
				return
			end

			local triggerfl = false
			if Menu["Rage"]["Fake Lag"]["Enabled"]["Toggle"]["Enabled"] then
				if Menu["Rage"]["Fake Lag"]["Custom Triggers"]["Toggle"]["Enabled"] then
					if table.find(Menu["Rage"]["Fake Lag"]["Amount"]["Value"], "On Moving") then
						if ragebot.fakehrp.Velocity.Magnitude > 4 then
							triggerfl = true
						end
					end
					if table.find(Menu["Rage"]["Fake Lag"]["Amount"]["Value"], "On Peek") and trigger ~= true then
						for i, v in next, (players:GetPlayers()) do
							if v ~= localPlayer and trigger ~= true then
								local pInfo = playerInfo.storage[v]
								if pInfo and pInfo.alive and pInfo.enemy and pInfo.character and pInfo.character:FindFirstChild("HumanoidRootPart") and workspace:FindFirstChild("Map") then
									local ignore = {
										findFirstChild(workspace.Map, "Clips"),
										findFirstChild(workspace.Map, "SpawnPoints"),
										camera,
										localPlayer.Character,
										findFirstChild(workspace, "Debris"),
										findFirstChild(workspace, "Ray_Ignore"),
										pInfo.character
									}
									if ragebot.backtracks[v].backtrackParts then
										for i2, v2 in next, (ragebot.backtracks[v].backtrackParts) do
											ignore[1 + #ignore] = v2
										end
									end
									local _, nextpos = workspace:FindPartOnRayWithIgnoreList(Ray.new(camera.CFrame.p, ragebot.fakehrp.Velocity * (Menu["Rage"]["Fake Lag"]["Limit"]["Value"] / 256)), ignore, false, true)
									local _, pos = workspace:FindPartOnRayWithIgnoreList(Ray.new(nextpos, pInfo.character.HumanoidRootPart.Position - nextpos), ignore, false, true)
									local _, pos2 = workspace:FindPartOnRayWithIgnoreList(Ray.new(camera.CFrame.p, pInfo.character.HumanoidRootPart.Position - camera.CFrame.p), ignore, false, true)
									if pos == pInfo.character.HumanoidRootPart.Position or pos2 == pInfo.character.HumanoidRootPart.Position then -- we WILL peek or we are alr visible
										triggerfl = true
										break
									end
								end
							end
						end
					end
				else
					triggerfl = true
				end

				if triggerfl then
					local timesincelastrefresh = tick() - ragebot.lastreplicationtick
					local limit = Menu["Rage"]["Fake Lag"]["Limit"]["Value"] / 64
					if timesincelastrefresh < limit then
						ragebot.fakeLagging = true
						return
					end
				end
			end--FAKELAGEND

			-- pitch
			if Menu["Rage"]["Anti Aim"]["Pitch"]["Value"] ~= "Off" then
				pitch = ragebot.baseantiaimbotangles.pitch[Menu["Rage"]["Anti Aim"]["Pitch"]["Value"]]
				if Menu["Rage"]["Anti Aim"]["Pitch Extension"]["Toggle"]["Enabled"] then
					pitch = pitch * 2
				end
			end

			if Menu["Rage"]["Anti Aim"]["Yaw"]["Value"] ~= "Off" then
				local closesttocross = ragebot.nearesttocrosshair()
				local targetpos = ragebot.currenttarget.position and ragebot.currenttarget.position or closesttocross and closesttocross.character.HumanoidRootPart.Position or nil

				if Menu["Rage"]["Anti Aim"]["Yaw Base"]["Value"] == "At targets" then
					if targetpos then
						-- correct our cf to face ragetarget or nearest player
						delayedcf = newCframe(delayedcf.p, newVector3(targetpos.x, delayedcf.p.y, targetpos.z))
					end
				end

				-- now that we have our target cf, apply the rotation to it
				local realangle = (ragebot.baseantiaimbotangles.yaw[Menu["Rage"]["Anti Aim"]["Yaw"]["Value"]] + Menu["Rage"]["Anti Aim"]["Yaw angle"]["Value"])

				if Menu["Rage"]["Anti Aim"]["Freestanding"]["Value"] ~= "Off" and targetpos then
					local extraignored = {
						findFirstChild(workspace.Map, "Clips"),
						findFirstChild(workspace.Map, "SpawnPoints"),
						camera,
						localPlayer.Character,
						findFirstChild(workspace, "Debris"),
						findFirstChild(workspace, "Ray_Ignore"),
					} -- ignoring every player model since that doesnt block bullets :sad:
					for i, v in next, players:GetPlayers() do
						if v.Character then
							extraignored[1 + #extraignored] = v.Character 
						end
					end


					local shotfrom = targetpos
					local maximumsim = 4
					local shotFromDir = CFrame.new(delayedcf.p, newVector3(shotfrom.x, delayedcf.p.y, shotfrom.z))

					local baseDirs = {}
					local scanfrom = {}
					local scores = {}

					baseDirs[newVector3(1, 0, 0).unit] = {}
					baseDirs[newVector3(-1, 0, 0).unit] = {}
					baseDirs[newVector3(0, 0, 1).unit] = {}
					baseDirs[newVector3(0, 0, -1).unit] = {}

					for dir, from in next, baseDirs do
						local thisPoint = (shotFromDir * (dir * maximumsim))
						local trueDir = thisPoint - delayedcf.p

						scanfrom[trueDir] = {}
						scores[trueDir] = 0

						local wall, point = workspace:FindPartOnRayWithWhitelist(Ray.new(delayedcf.p, thisPoint - delayedcf.p), {workspace.Map}, true)
						if (point - delayedcf.p).Magnitude >= 1 then
							for extendedBy = 1, maximumsim do
								scanfrom[trueDir][1 + #scanfrom[trueDir]] = {point, (maximumsim / extendedBy) / 1.875} -- generate things as to simulate what would happen if our head was there, give it the importance amount too
							end
						else
							scores[trueDir] = scores[trueDir] - 0.5
						end
					end

					-- assuming this is where we are about to be shot from
					for dir, points in next, scanfrom do
						for i, data in next, points do
							local origin = data[1]
							local hit, damagemodifier, wallbang = ragebot.autowall(shotfrom, origin, extraignored, {maxPenetration = 3, maxWalls = 4})
							-- the logic is that it tests how hard it is to shoot at our head if we are left or right, the side with more wall will be the one we hide our head behind
							if hit then
								scores[dir] = scores[dir] - (data[2] * damagemodifier)
							else
								scores[dir] = scores[dir] + data[2]
							end
						end
					end

					local idealFreestand
					local min = inf
					for dir, score in next, scores do
						if score < min then
							idealFreestand = dir
							min = score
						end
					end

					if idealFreestand then
						delayedcf = newCframe(delayedcf.p, (delayedcf.p + idealFreestand)) -- freestand the opposite of the most dangerous vector

						--[[if Menu["Rage"]["Anti Aim"]["Fake angle"]["Value"] ~= "Off" then
							realangle = realangle + 180
							if Menu["Rage"]["Anti Aim"]["Fake angle"]["Value"] == "Default" then
								realangle = realangle + math.random(-45, 45)
							elseif Menu["Rage"]["Anti Aim"]["Fake angle"]["Value"] == "Random" then
								realangle = realangle + math.random(0, 360)
							elseif Menu["Rage"]["Anti Aim"]["Fake angle"]["Value"] == "Spin" then
								realangle = realangle + (-(2 * 45 / pi)) * math.atan(-math.tan((pi * tick()) / 0.5))
							elseif Menu["Rage"]["Anti Aim"]["Fake angle"]["Value"] == "Jitter" then
								realangle = realangle + (ragebot.jitterone and 45 or -45)
							end

							if localPlayer.Character.HeadHB:FindFirstChild("Weld") then
								localPlayer.Character.HeadHB.Weld:Destroy()
							end
							if localPlayer.Character.FakeHead:FindFirstChild("Weld") then
								localPlayer.Character.FakeHead.Weld:Destroy()
							end
							if tick() - ragebot.lby > 63/64 then
								if tick() - ragebot.lby > 1 then
									ragebot.lby = tick()
								end
							end
						end]]
					end
				end

				realangle = toDeg * mathModule.normalizeAngle(realangle * toRad)
				--[[if localPlayer.Character:FindFirstChild("HeadHB") and localPlayer.Character:FindFirstChild("FakeHead") then
					if not localPlayer.Character.HeadHB:FindFirstChild("Weld") and not localPlayer.Character.FakeHead:FindFirstChild("Weld") and Menu["Rage"]["Anti Aim"]["Fake angle"]["Value"] ~= "Off" and targetpos then
						if tick() - ragebot.lby < 63/64 then
							localPlayer.Character.LowerTorso.Root.C0 = CFrame.new(0, -0.649999976, 0) * CFrame.Angles(0, pi - (toRad * realangle), 0)
						else
							localPlayer.Character.LowerTorso.Root.C0 = CFrame.new(0, -0.649999976, 0) * CFrame.Angles(0, 0 -(toRad * realangle), 0)
						end
					else
						localPlayer.Character.LowerTorso.Root.C0 = CFrame.new(0, -0.649999976, 0) * CFrame.Angles(0, 0, 0)
					end
				end]]
				
				
				if Menu["Rage"]["Anti Aim"]["Yaw Jitter"]["Value"] ~= "Off" then
					local jitterangle = Menu["Rage"]["Anti Aim"]["Yaw Jitter angle"]["Value"]
					if jitterangle ~= 0 then
						if Menu["Rage"]["Anti Aim"]["Yaw Jitter"]["Value"] == "Random" then
							realangle = realangle + math.random(-1 * math.abs(jitterangle), math.abs(jitterangle))
						elseif Menu["Rage"]["Anti Aim"]["Yaw Jitter"]["Value"] == "Offset" then
							realangle = realangle + (ragebot.jitterone and jitterangle or 0)
						elseif Menu["Rage"]["Anti Aim"]["Yaw Jitter"]["Value"] == "Center" then
							realangle = realangle + ((ragebot.jitterone and jitterangle or -jitterangle) * 0.5)
						end
					end
				end

				-- now that we've finished choosing our real angle, change the delayed cf
				delayedcf = delayedcf * CFrame.Angles(0, toRad * realangle, 0)
			end

			if Menu["Rage"]["Anti Aim"]["Hide in Floor"]["Toggle"]["Enabled"] then
				delayedcf = delayedcf - newVector3(0, 4, 0)
			end
			
			ragebot.lasthrpCf = delayedcf

			-- here we manipulate our cf n shit
			ragebot.updatedynamicangles(tick() - ragebot.lastreplicationtick)

			ragebot.lastreplicationtick = tick()

			if localPlayer.Character:FindFirstChild("HeadHB") and localPlayer.Character:FindFirstChild("FakeHead") then
				if not localPlayer.Character.HeadHB:FindFirstChild("Weld") and not localPlayer.Character.FakeHead:FindFirstChild("Weld") then
					localPlayer.Character.FakeHead.AssemblyLinearVelocity = newVector3(0, 0, 0)
					localPlayer.Character.HeadHB.AssemblyLinearVelocity = newVector3(0, 0, 0)

					localPlayer.Character.FakeHead.CFrame = localPlayer.Character.Head.CFrame
					localPlayer.Character.HeadHB.CFrame = localPlayer.Character.Head.CFrame
				end
			end

			local viewheight = localPlayer.Character.Humanoid.CameraOffset
			local targetpos = triggerfl and delayedcf.p or ragebot.fakehrp.Position
			local realcameracf = newCframe((targetpos + newVector3(0, 1.35, 0) + viewheight), (targetpos + newVector3(0, 1.35, 0) + viewheight) + mathModule.pitchYawToLookVec(toRad * (pitch * 90), toRad * ragebot.realhrp.Orientation.Y))

			if tick() - ragebot.lastshot < 1/2 and ragebot.currenttarget.position then
				realcameracf = newCframe(realcameracf.p, ragebot.currenttarget.position)
			end
			
			if tick() - ragebot.lastcamupdate > 1/64 then
				ragebot.lastcamupdate = tick()
				ragebot.lastcameracf = realcameracf
			end

			if tick() - ragebot.lastpitch > 1/64 then
				ragebot.lastpitch = tick()
				ragebot.lastpitchangle = pitch
			end
		end
		ragebot.fakeReplication = runService.Stepped:Connect(fakeReplicationUpdate)

		--:nerd:
		-- here we can see femboy doing his programming weird shit in his natural habitat so called man cave
		-- fuck u
		ragebot.hitgroups = {
			["Head"] = {"Head"},
			["Chest"] = {"UpperTorso"},
			["Pelvis"] = {"LowerTorso"},
			["Arms"] = {"LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm"},
			["Legs"] = {"LeftLowerLeg", "LeftUpperLeg", "RightLowerLeg", "RightUpperLeg"},
			["Feet"] = {"LeftFoot", "RightFoot"}
		}

		ragebot.weaponconfigs = { -- kinda fucked this up
			["Sniper"] = {
				["Auto Sniper"] = {"G3SG1"},
				["Scout"] = {"Scout"},
				["AWP"] = {"AWP"},
			},
			["Auto"] = {
				["Rifle"] = {"M4A4", "AK47", "Famas", "Galil", "AUG", "SG", "M4A1"},
				["SMG"] = {"P90", "MAC10", "MP7", "Bizon", "MP9", "UMP", "MP7-SD"},
				["LMG"] = {"Negev", "M249"},
			},
			["Other"] = {
				["Light Pistol"] = {"USP", "P2000", "Glock", "DualBerettas", "P250", "FiveSeven", "Tec9", "CZ"}, --:nerd:
				["Heavy Pistol"] = {"R8", "DesertEagle"},
				["Shotgun"] = {"SawedOff", "Sawed-Off", "Sawed Off", "Nova", "MAG7", "XM"}
			}
		}

		ragebot.multipointdirections = {}
		for x = -1, 1 do
			for y = -1, 1 do
				for z = -1, 1 do
					if x == 0 and y == 0 and z == 0 then
					else
						ragebot.multipointdirections[1 + #ragebot.multipointdirections] = {newVector3(x, y, z).unit, (x == 0 and "" or x > 0 and "+X, " or x < 0 and "-X, ") .. (y == 0 and "" or y > 0 and "+Y, " or y < 0 and "-Y, ") .. (z == 0 and "" or z > 0 and "+Z, " or z < 0 and "-Z, ")}
					end
				end
			end
		end

		ragebot.hitmodifier = {
			Head = 4,
			FakeHead = 4,
			HeadHB = 4,
			UpperTorso = 1,
			LowerTorso = 1.25,
			LeftUpperArm = 1,
			LeftLowerArm = 1,
			LeftHand = 1,
			RightUpperArm = 1,
			RightLowerArm = 1,
			RightHand = 1,
			LeftUpperLeg = 0.75,
			LeftLowerLeg = 0.75,
			LeftFoot = 0.75,
			RightUpperLeg = 0.75,
			RightLowerLeg = 0.75,
			RightFoot = 0.75
		}

		function ragebot.kevlardamage(armorpen, kevlar, helmet, headshot)
			if not kevlar then return 1 end
			if headshot and helmet then
				return 0.01 * armorpen
			else
				return 0.01 * armorpen
			end
		end

		function ragebot.distancedamagemodifier(distance, rangemodifier)
			return math.clamp((rangemodifier / 100) ^ (distance / (500 * 0.0694)), 0.45, 1)
		end



		function ragebot.fakeshoot(Parameters)
			local fireAnimation = debug.getupvalue(client.reloadwep, 9)
			if fireAnimation and client.fgun ~= "none" then
				fireAnimation:Play()
				client.updateads()
				replicatedStorage.Events.ReplicateAnimation:FireServer("Fire")
				if localPlayer.Character:FindFirstChild("Gun") then
					local soundData = findFirstChild(localPlayer.Character.Gun, "SShoot") or findFirstChild(localPlayer.Character.Gun, "Shoot") or findFirstChild(localPlayer.Character.Gun, "Shoot1") -- shoot1 for the knife swing sound

					local newSound = ragebot.shootSound:Clone()
					newSound.Parent = camera
					newSound.SoundId = soundData.Value
					newSound.PlayOnRemove = true
					newSound:Destroy()

					if findFirstChild(localPlayer.Character.Gun, "Flash") and findFirstChild(camera, "Arms") and findFirstChild(camera.Arms, "Flash") then
						client.createparticle("muzzle", camera.Arms.Flash)
						replicatedStorage.Events.RemoteEvent:FireServer({"createpiarticle", "muzzle", localPlayer.Character.Gun.Flash, nil})
						if Parameters.walls then
							for i, v in next, (Parameters.walls) do
								client.hitobject(v["Hit"], v["Enter"], v["Normal"], client.fgun, false)
								client.hitobject(v["Hit"], v["Exit"], -v["Normal"], client.fgun, false)
							end
						end
					end
				end
			end

			--local bodyFireAnimation = debug.getupvalue(client.usethatgun, 29)
			--bodyFireAnimation:Play()
		end
function ragebot.fire(Parameters) -- everything that takes place once someone CAN be shot
		if client.fgun == "none" then
			return
		end
		if not Menu["Rage"]["Aimbot"]["Silent Aim"]["Toggle"]["Enabled"] then
			camera.CFrame = newCframe(camera.CFrame.p, ragebot.currenttarget.position)
		end
        if Menu["Rage"]["Aimbot"]["Auto Shoot"]["Toggle"]["Enabled"] then
            local connection
            connection = runService.Heartbeat:Connect(function()
                connection:Disconnect()
        
                local origin = Parameters.origin
        
                local gunstats = {
                    maxPenetration = client.fgun.Penetration.Value * 0.02,
                    maxWalls = 9999e9999,
                }
        
                for _ = 1, client.fgun.Bullets.Value do
                    hitPart:FireServer(
                        Menu["Rage"]["HvH"]["Force Headshots"]["Toggle"]["Enabled"]
                            and Parameters.instance.Parent.Head or Parameters.instance,
                        Parameters.position,
                        client.fgun.Name,
                        -9999e9999,
                        localPlayer.Character:FindFirstChild("Gun"),
                        nil,
                        9999e9999,
                        false,
                        Parameters.wallbang,
                        Parameters.origin,
                        -9999e9999,
                        zeroVec3,
                        true,
                        "r",
                        nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
                    )
                end
        
        
                local function getAllValidTargets()
                    local targets = {}
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                            if player.Character.Humanoid.Health > 0 then
                                table.insert(targets, player.Character)
                            end
                        end
                    end
                    return targets
                end
        
                local targets = getAllValidTargets()
                for _, target in pairs(targets) do
                    if Parameters.instance:IsDescendantOf(target) then continue end
        
                    local targetPart = Menu["Rage"]["HvH"]["Force Headshots"]["Toggle"]["Enabled"]
                        and target:FindFirstChild("Head") or target:FindFirstChild("HumanoidRootPart") or target.PrimaryPart
        
                    if targetPart then
                        local canHit = ragebot.autowall(origin, targetPart.Position, {localPlayer.Character}, gunstats)
                        if canHit then
                            for _ = 1, client.fgun.Bullets.Value do
                                hitPart:FireServer(
                                    targetPart,
                                    Parameters.position,
                                    client.fgun.Name,
                                    -9999e9999,
                                    localPlayer.Character:FindFirstChild("Gun"),
                                    nil,
                                    9999e9999,
                                    false,
                                    Parameters.wallbang,
                                    Parameters.origin,
                                    -9999e9999,
                                    zeroVec3,
                                    true,
                                    "r",
                                    nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
                                )
                            end
                        end
                    end
                end
            end)    
			if Menu["Rage"]["Aimbot"]["Auto Shoot Type"]["Value"] == "Standard" then
				ragebot.fakeshoot({walls = Parameters.walls})
			end


			if Menu["Rage"]["HvH"]["Hit Logs"]["Toggle"]["Enabled"] then
				local target = ragebot.currenttarget
				local gun = client.fgun
			
				if target and target.player and target.instance and gun and gun.Name then
					local message = "Shot at " .. ragebot.currenttarget.player.Name .. " for " .. tostring(math.floor(Parameters.damageInflicted + 0.5)) .. ", in the " .. ragebot.currenttarget.instance.Name .. "\n( " .. tostring(math.clamp(math.floor(Parameters.instance.Parent.Humanoid.Health - (Parameters.damageInflicted * client.gun.Bullets.Value) + 0.5), 0, 100)) .. " hp remaining)" .. " (type: " .. Parameters.type .. ", origin: " .. Parameters.origintype .. ")"
					UILibrary:EventLog(message, Menu["Rage"]["HvH"]["Hit Logs Delay"]["Value"])
				end
			end			
		end
	end 
		--warning autowall is kinda scuffed it ,makes u look like stormy paste user
		--nnvm i know how to fix fix

		function ragebot.autowall(origin, target, ignored, gunstats) -- theres no simulations here, only headshots, also did this so u can simulate shot anywhere, instead of being limited to when u have a gun or whatever
			local ignore = {unpack(ignored)} -- I AM SPEED

			local maxPenetration = gunstats.maxPenetration  
			local maxWalls = gunstats.maxWalls

			local penetrationPassed = 0
			local wallsPenetrated = 0

			local direction = (target - origin)
			local unitdir = direction.unit

			local enterParam = RaycastParams.new()
			enterParam.FilterType = Enum.RaycastFilterType.Blacklist
			enterParam.IgnoreWater = true
			enterParam.FilterDescendantsInstances = ignore

			local exitParam = RaycastParams.new()
			exitParam.FilterType = Enum.RaycastFilterType.Whitelist

			repeat
				local enterresult = workspaceRaycast(workspace, origin, direction, enterParam)

				if not enterresult then	
					return true, (1 - penetrationPassed / maxPenetration), wallsPenetrated > 0, emptyVec3
				end

				local wall = enterresult.Instance
				local enter = enterresult.Position
				local material = wall.Material

				--add it to the ignore list so that autowall doesnt scan it next round
				ignore[#ignore + 1] = wall

				local modifier = 1 --a multiplier for the raw wall depth
				-- save the materials shit like this, because once u get the material u cant change that
				if wall.Name == "nowallbang" then
					modifier = 100 --yo read #chatting its a fucking mess LMFAO
					return -- this isnt wallbangable
				end

				if material == materials.DiamondPlate then --diamondplate
					modifier = 3
				elseif material == materials.CorrodedMetal or material == materials.Metal or material == materials.Concrete or material == materials.Brick then --corrodedmetal or metal or concrete or brick
					modifier = 2 --hi check dms
				elseif material == materials.Wood or material == materials.WoodPlanks then
					modifier = 0.1
				end

				-- this shit is dynamic or whatever
				if wall.Name == "Grate" or findFirstChild(wall.Parent, "Humanoid") then
					if findFirstChild(wall.Parent, "Humanoid") then
						ignore[1 + #ignore] = wall.Parent -- ignore their entire body
					end
					modifier = 0.1
				end

				if wall.Transparency == 1 or not wall.CanCollide or wall.Name == "Glass" or wall.Name == "Cardboard" or wall.Parent.Name == "Hitboxes" then
					modifier = 0
				end

				local partModifier = findFirstChild(wall, "PartModifier")
				if partModifier then
					modifier = tonumber(partModifier.Value)
				end

				if modifier >= 100 then return end
				if modifier > 0 then
					--finds the exit position of the ray so we could find the wall depth
					local penetrableDepth = math.min((maxPenetration - penetrationPassed) / modifier, (enter - target).Magnitude) -- optimization, this is the most we can penetrate with our remaining energy, if we dont hit the same wall with this depth, the wall is too thick
					if penetrableDepth <= 0 then return end -- no remaining depth for our bulletssss$ (???)

					exitParam.FilterDescendantsInstances = {wall}

					local wallPenetration = (unitdir * penetrableDepth)
					local exitresult = workspaceRaycast(workspace, enter + wallPenetration, -wallPenetration, exitParam)

					if not exitresult then return end -- wall was too thick to penetrate

					penetrationPassed = penetrationPassed + ((penetrableDepth - exitresult.Distance) * modifier) -- how much opposition the bullet encountered
					wallsPenetrated = wallsPenetrated + 1
				end
				enterParam.FilterDescendantsInstances = ignore
			until penetrationPassed >= maxPenetration or wallsPenetrated >= maxWalls
		end

		function ragebot.getwallspassed(origin, target, ignored, gunstats)
			local ignore = table.clone(ignored) -- I AM SPEED

			local maxPenetration = gunstats.maxPenetration  
			local maxWalls = gunstats.maxWalls

			local penetrationPassed = 0
			local wallPassed = {}
			local wallsPenetrated = 0

			local direction = (target - origin)
			local unitdir = direction.unit

			local enterParam = RaycastParams.new()
			enterParam.FilterType = Enum.RaycastFilterType.Blacklist
			enterParam.FilterDescendantsInstances = ignore
			enterParam.IgnoreWater = true

			repeat
				local enterresult = workspaceRaycast(workspace, origin, direction, enterParam)

				if not enterresult then
					return true, (1 - penetrationPassed / maxPenetration), wallsPenetrated > 0, emptyVec3, wallPassed
				end

				local wall = enterresult.Instance
				local enter = enterresult.Position
				local normalhit = enterresult.Normal
				local material = wall.Material

				--add it to the ignore list so that autowall doesnt scan it next round
				ignore[#ignore + 1] = wall

				local modifier = 1 --a multiplier for the raw wall depth
				if wall.Name == "nowallbang" then
					return
				elseif material == materials.DiamondPlate then
					modifier = 3
				elseif material == materials.CorrodedMetal or material == materials.Metal or material == materials.Concrete or material == materials.Brick then
					modifier = 2
				elseif material == materials.Wood or material == materials.WoodPlanks then
					modifier = 0.1
				end

				if wall.Name == "Grate" or findFirstChild(wall.Parent, "Humanoid") then
					if findFirstChild(wall.Parent, "Humanoid") then
						ignore[#ignore + 1] = wall.Parent
						-- if we hit someones body, the game ignores the rest of their body after the first thing we hit
					end
					modifier = 0.1
				end
				if wall.Transparency == 1 or not wall.CanCollide or wall.Name == "Glass" or wall.Name == "Cardboard" or wall.Parent.Name == "Hitboxes" then
					modifier = 0
				end
				if findFirstChild(wall, "PartModifier") then
					modifier = tonumber(wall.PartModifier.Value) -- apparently its not a number sometimes??
				end

				enterParam.FilterDescendantsInstances = ignore

				if modifier >= 100 then return end
				if modifier <= 0 then
				else
					--finds the exit position of the ray so we could find the wall depth
					local maxremainingdepth = (maxPenetration - penetrationPassed) / modifier -- optimization, this is the most we can penetrate with our remaining energy, if we dont hit the same wall with this depth, the wall is too thick
					if maxremainingdepth <= 0 then return end -- no remaining depth for our bulletssss$

					local exitParam = RaycastParams.new()
					exitParam.FilterType = Enum.RaycastFilterType.Whitelist
					exitParam.FilterDescendantsInstances = {wall}

					local maxwallpenetration = (unitdir * maxremainingdepth)
					local exitresult = workspaceRaycast(workspace, enter + maxwallpenetration, -maxwallpenetration, exitParam)

					if not exitresult then return end -- wall was too thick to penetrate

					local wallDepth = (maxremainingdepth - exitresult.Distance) * modifier -- HOW TO MAKE YOUR AUTOWALL LITERAL SPEED

					penetrationPassed = penetrationPassed + wallDepth -- how much opposition the bullet encountered
					wallsPenetrated = wallsPenetrated + 1
					wallPassed[wallsPenetrated] = {Hit = wall, Enter = enter, Exit = exitresult.Position, Normal = normalhit} -- record the shit, (used for bullet holes)
				end
			until penetrationPassed >= maxPenetration or wallsPenetrated >= maxWalls
			return
		end

		function ragebot.getweaponconfig(weapon)
			local currentweapon = weapon.Name
			for i, weapongroup in next, (ragebot.weaponconfigs) do
				for i2, weapontype in next, (weapongroup) do
					for i3, weapon in next, (weapontype) do
						if currentweapon == weapon then
							local hitParts = {}
							for i4, v4 in next, (Menu["Rage"][i][i2 .. " Hitboxes"]["Value"]) do
								for i5, v5 in next, (ragebot.hitgroups[v4]) do -- translated to dn
									hitParts[1 + #hitParts] = v5
								end
							end
							return hitParts, Menu["Rage"][i][i2 .. " Minimum Damage"]["Value"]
						end
					end
				end
			end
		end

		function ragebot.hitgrouptohitbox(hitboxes)
			local chosenhitboxes = {}
			for i, v in next, (hitboxes) do
				for i2, v2 in next, (ragebot.hitgroups[v]) do -- translate the hitgroups
					chosenhitboxes[1 + #chosenhitboxes] = v2
				end
			end
			return chosenhitboxes
		end

		-- OMG DUDE
		function ragebot.getorigins(toward)
			local origins = {}
			local from = localPlayer.Character.HumanoidRootPart.Position + newVector3(0, 1.4, 0) + localPlayer.Character.Humanoid.CameraOffset
			origins[1 + #origins] = {from, "Base"}
			local base = newCframe(from, from + camera.CFrame.LookVector.unit)

			local factor = Menu["Rage"]["HvH"]["Hitscan Modifier"]["Value"]
			if Menu["Rage"]["HvH"]["Autowall Hitscan"]["Toggle"]["Enabled"] then
				local offsetOrigins = {}
				if table.find(Menu["Rage"]["HvH"]["Hitscan Points"]["Value"], "Up") ~= nil then
					offsetOrigins[1 + #offsetOrigins] = {(base * newCframe(0, factor, 0)).p, "Up"} -- up
				end
				if table.find(Menu["Rage"]["HvH"]["Hitscan Points"]["Value"], "Down") ~= nil then
					offsetOrigins[1 + #offsetOrigins] = {(base * newCframe(0, -factor, 0)).p, "Down"} -- down
				end
				if table.find(Menu["Rage"]["HvH"]["Hitscan Points"]["Value"], "Left") ~= nil then
					offsetOrigins[1 + #offsetOrigins] = {(base * newCframe(-factor, 0, 0)).p, "Left"} -- left
				end
				if table.find(Menu["Rage"]["HvH"]["Hitscan Points"]["Value"], "Right") ~= nil then
					offsetOrigins[1 + #offsetOrigins] = {(base * newCframe(factor, 0, 0)).p, "Right"} -- right
				end
				if table.find(Menu["Rage"]["HvH"]["Hitscan Points"]["Value"], "Backward") ~= nil then
					offsetOrigins[1 + #offsetOrigins] = {(base * newCframe(0, 0, factor)).p, "Backward"} -- backwards
				end
				if table.find(Menu["Rage"]["HvH"]["Hitscan Points"]["Value"], "Forward") ~= nil then
					offsetOrigins[1 + #offsetOrigins] = {(base * newCframe(0, 0, -factor)).p, "Forward"} -- forwards
				end
				if table.find(Menu["Rage"]["HvH"]["Hitscan Points"]["Value"], "Towards") ~= nil then
					offsetOrigins[1 + #offsetOrigins] = {(base + (newCframe(from, toward).LookVector.Unit * factor)).p, "Towards"} -- towards
				end

				for i = 1, #offsetOrigins do
					local shootFromData = offsetOrigins[i]
					local shootFrom = shootFromData[1]
						--[[local dir = (shootFrom - base.p).unit
						for pullFactor = 1, factor, 1 do
							origins[1 + #origins] = {base.p + (dir * pullFactor), shootFromData}
						end]]
					origins[1 + #origins] = shootFromData
				end
			end

			if Menu["Rage"]["HvH"]["Auto Peek"]["Toggle"]["Enabled"] and Menu["Rage"]["HvH"]["Auto Peek"]["Bind"]["Active"] then
				local wallPassed, positionHit = workspace:FindPartOnRayWithWhitelist(Ray.new(from, camera.CFrame.LookVector.unit * 21), {workspace.Map}, true)
				origins[1 + #origins] = {positionHit - camera.CFrame.LookVector.unit, "Auto Peek"}
			end

			return origins
		end

		function ragebot.getpoints(enemy)
			local pInfo = enemy.pInfo -- their player info
			local char = pInfo.character -- their char
			local plr = pInfo.player -- the roblox player

			local hitboxes, minimumDamage = ragebot.getweaponconfig(client.fgun) -- lets get the current weapons config
			if not hitboxes or not minimumDamage then return end -- smth missing

			local validinstances = {} -- what hitboxes are we considering
			local scan = {} -- where to are we shooting

			-- ok we have the origins moving on to the scanpoints
			for i, v in next, hitboxes do
				local point = findFirstChild(char, v) -- find this point on our enemy
				if point then 
					scan[1 + #scan] = {point, point.Position, "Center"} -- record that we will be shooting the center position of this hitbox
					validinstances[point.Name] = {point, point.Position} -- since we were scanning the center of this point, we have something to base the other points off
				end -- this point doesnt exist in their character
			end

			-- camera$resolve$
			if Menu["Rage"]["HvH"]["Resolve Positions"]["Toggle"]["Enabled"] then
				local camerapos = plr.CameraCF.Value.p
				if camerapos == camerapos and camerapos ~= emptyVec3 and pInfo.camcf ~= pInfo.lastcameracf and (camerapos - pInfo.rootpart.CFrame.p).Magnitude > 8 then -- if they have a valid camera pos
					scan[1 + #scan] = {scan[1][1], camerapos, "Resolved"} -- add the camerapos and associate it with the hitbox of the first scanpoint
					validinstances[scan[1][1].Name] = {scan[1][1], camerapos}
				end
			end

			-- extrapolate from a center of a hitbox to the position they will be if we were to shoot at them right now
		if Menu["Rage"]["Tracking"]["Extrapolation"]["Toggle"]["Enabled"] and pInfo.velocity.Magnitude > 0.01 then
        local extrapolatedparam = RaycastParams.new()
        extrapolatedparam.IgnoreWater = true
        extrapolatedparam.FilterType = Enum.RaycastFilterType.Whitelist

        extrapolatedparam.FilterDescendantsInstances = Menu["Rage"]["Tracking"]["Ignore walls"]["Toggle"]["Enabled"]
            and {} or {workspace.Map}

        local ping = game.Stats.PerformanceStats.Ping:GetValue() * 2
        local extrapolatebase = pInfo.velocity * ((Menu["Rage"]["Tracking"]["Extrapolation Tuning"]["Value"] + ping) / 1000)

        local steps = Menu["Rage"]["Tracking"]["Steps to Scan"]["Value"]
        local extrapolatedpoints = ragebot.hitgrouptohitbox(Menu["Rage"]["Tracking"]["Extrapolation Points"]["Value"])

        for step = 1, steps do
            local step_fraction = step / steps
            local extrapolateby = extrapolatebase * step_fraction

            for i, v in next, extrapolatedpoints do
                local correspondinginstance = validinstances[v]
                if correspondinginstance then
                    local instance, center = correspondinginstance[1], correspondinginstance[2]
                    local cast = workspaceRaycast(workspace, center, extrapolateby, extrapolatedparam)
                    scan[#scan + 1] = {instance, cast and cast.Position or center + extrapolateby, "Extrapolated", step}
                end
            end
        end
    end

			-- since we have backtracking and are able to shoot at where the enemy was previously, try to scan their previous positions
			if Menu["Rage"]["Tracking"]["Back Tracking"]["Toggle"]["Enabled"] then
				local btpoints = ragebot.hitgrouptohitbox(Menu["Rage"]["Tracking"]["Back Tracking Points"]["Value"])
				local enemybacktrack = ragebot and ragebot.backtracks and ragebot.backtracks[plr] and ragebot.backtracks[plr].backtrackParts
				if enemybacktrack then
					for i, v in next, btpoints do
						local correspondinginstance = validinstances[v]
						if correspondinginstance then 
							local instance = correspondinginstance[1]
							local center = correspondinginstance[2]

							local backtrackedtick = enemybacktrack[instance.Name == "HeadHB" and "Head" or instance.Name]
							if backtrackedtick and (backtrackedtick.Position - center).Magnitude > 0.1 and (backtrackedtick.Position - emptyVec3).Magnitude > 0.1 then -- located their backtrack point
								scan[1 + #scan] = {instance, backtrackedtick.Position, "Backtrack"}
							end
						end -- this doesnt have a valid centerpoint to base our thing off of
					end
				end
			end

			-- while the center of the hitbox is a reasonable spot to shoot at, shooting towards the edge of the hitbox could be useful
			if Menu["Rage"]["HvH"]["Multi Point"]["Toggle"]["Enabled"] then
				local maxPullFactor = Menu["Rage"]["HvH"]["Multi Point Scale"]["Value"] / 100
				local instensity = 4
				local multiPointScan = {}
				local mppoints = ragebot.hitgrouptohitbox(Menu["Rage"]["HvH"]["Multi Point Points"]["Value"]) -- what hitboxes do the hitgroups in the dropdown allow
				for i, v in next, mppoints do
					local correspondinginstance = validinstances[v]
					if correspondinginstance then 
						local instance = correspondinginstance[1]
						local center = correspondinginstance[2]

						local partcframe = instance.CFrame
						local partsize = instance.Size

						for i2, v2 in next, ragebot.multipointdirections do -- in each direction, add a scanpoint
							local d = v2[1]
							for scaled = instensity, 1, -1 do
								local percentScale = scaled / instensity
								local minScale = maxPullFactor * (scaled - 1) / instensity
								local scale = math.random(minScale * 1000, maxPullFactor * percentScale * 1000) / 1000
								multiPointScan[1 + #multiPointScan] = {instance, (partcframe * newCframe(partsize.X * 0.5 * scale * d.x, partsize.X * 0.5 * scale * d.y, partsize.X * 0.5 * scale * d.z)).p, "Multi Point"}
							end
						end
					end -- this doesnt have a valid centerpoint to base our thing off of
				end

				for i = 1, math.min(#scan, #multiPointScan) do
					local rand = #multiPointScan > 1 and math.random(#multiPointScan) or 1
					scan[1 + #scan] = multiPointScan[rand]
					multiPointScan[rand] = nil
				end
			end

			-- return the points we gathered
			return scan, minimumDamage
		end

		function ragebot.scan(enemy) -- calculates the highest damage point on a single target
			local pInfo = enemy.pInfo -- their player info
			local plr = pInfo.player -- the roblox player
			local char = plr.Character -- their char

			local origins = ragebot.getorigins(pInfo.currentPosition) -- where are we shooting from
			if not origins then return end -- how are you going to shoot if you DONT HAVE A POINT TO SHOOT FROM
			local points, minimumdamage = ragebot.getpoints(enemy) -- where are we shooting to
			if not points then return end -- ok we arent even like

			-- sorting of points for $$optimised$$
			local scanGroups = {}
			local hits = {} -- what can we actually hit

			local gun = client.fgun
			local ignored = { -- this is the stuff we dont want the autowall to attempt simulating
				camera, -- ignore our camera as our viewmodel is stored here and bullets arent going to pass thru it
				workspace.Map.Clips, -- the clips are to be ignored
				workspace.Map.SpawnPoints, -- spawnpoints are to be ignored
				localPlayer.Character, -- since the bullets are coming from us, ignore our own player model
				workspace.Debris, -- the debris is to be ignored
				workspace.Ray_Ignore, -- obvious
				char -- ignore their entire playermodel as the autowall is position based not hit based
			}

			-- lil bit of logic
			do
				local groups = math.min(#origins, 8)
				local pointsPerGroup = math.floor(Menu["Rage"]["HvH"]["Maximum Hitscanning Points"]["Value"] / groups)

				for originGroup = 1, groups do
					local scanOrigins = {}
					local scanPoints = {}

					local origin = #origins > 1 and math.random(#origins) or 1
					local o = origins[origin]

					for pointGroup = 1, math.min(#points, pointsPerGroup) do
						local point = #points > 1 and math.random(#points) or 1
						local mp = points[point]
						scanPoints[1 + #scanPoints] = mp
						table.remove(points, point)
					end

					scanOrigins[1 + #scanOrigins] = o

					table.remove(origins, origin)

					scanGroups[1 + #scanGroups] = {
						origins = scanOrigins,
						points = scanPoints
					}
				end
			end

			-- kevlar
			local haskevlar = findFirstChild(plr, "Kevlar")
			local hashelmet = haskevlar and findFirstChild(plr, "Helmet")
			local armorpiercing = gun.ArmorPenetration.Value

			-- damage drop off at range
			local rangemodifier = gun.RangeModifier.Value

			local weapondamage = gun.DMG.Value
			local pellets = gun.Bullets.Value
			local forcedHead = Menu["Rage"]["HvH"]["Force Headshots"]["Toggle"]["Enabled"]
			local weaponstat = { -- this one is just for the autowall
				maxPenetration = gun.Penetration.Value * 0.01, -- the equivalent of no penetration if the autowall is disabled
				maxWalls = (Menu["Rage"]["Aimbot"]["Auto Wall"]["Toggle"]["Enabled"] == false) and 0 or 4, -- if our autowall isnt enabled then just simulate one wall, itll fail anyway
			}

			for groupI, group in next, scanGroups do
				for i, origin in next, group.origins do
					local from, fromdata = origin[1], origin[2]
					for i2, point in next, group.points do
						local instance, to, todata = point[1], point[2], point[3]
						local ishead = forcedHead == true or instance.Name == "Head" or instance.Name == "FakeHead" or instance.Name == "HeadHB"
						local penetrable, damagemodifier, wallbang = ragebot.autowall(from, to, ignored, weaponstat) -- theres no simulations here, only headshots

						if penetrable then
							local damage = pellets * weapondamage * damagemodifier * (ishead and 4 or ragebot.hitmodifier[instance.Name]) * ragebot.kevlardamage(armorpiercing, haskevlar, hashelmet, ishead) * ragebot.distancedamagemodifier((from - char.HumanoidRootPart.Position).Magnitude, rangemodifier)
							if damage > minimumdamage then  
								hits[1 + #hits] = { -- record that we hit this
									to = {to, todata},
									from = {from, fromdata},
									instance = instance,
									damage = damage,
									wallbang = wallbang,
									damagemodifier = damagemodifier,
								}

							end
						end -- this point cannot be hit, continue to the next one
					end
				end
			end

			if #hits < 1 then
				return
			end

			if #hits > 1 then
				table.sort(hits, function(a, b) return a.damage > b.damage end) -- sort for highest damage
			end

			local result = hits[1]
			result.player = plr
			result.pInfo = pInfo

			local canPen, mod, wallbanged, norm, wallsPassed = ragebot.getwallspassed(result.from[1], result.to[1], ignored, weaponstat)

			result.walls = wallsPassed and wallsPassed or {}

			return result -- this is the highest damage point
		end

		function ragebot.knifebot()
			local from = localPlayer.Character.HumanoidRootPart.Position + newVector3(0, 2, 0) + localPlayer.Character.Humanoid.CameraOffset
			local enemies = {}
			for i, pInfo in next, (playerInfo.storage) do
				if pInfo.alive and pInfo.enemy and not (pInfo.protected or pInfo.god) then
					if Menu["Rage"]["Aimbot"]["Aimbot FOV"]["Value"] == 180 or (math.abs(math.deg(math.acos((camera.CFrame.LookVector):Dot(newCframe(camera.CFrame.p, pInfo.character.HumanoidRootPart.Position).LookVector))))) * 2 < Menu["Rage"]["Aimbot"]["Aimbot FOV"]["Value"] then
						enemies[1 + #enemies] = {player = pInfo.player, pInfo = pInfo}
					end
				end
			end
			if #enemies < 1 then return end -- no enemies
			if Menu["Rage"]["Aimbot"]["Knife Bot Type"]["Value"] == "Single Aura" then -- did u select single aura or multi aura?
				local results = {}
				for i, enemy in next, enemies do
					local to = enemy.pInfo.currentPosition
					if (to - from).Magnitude < Menu["Rage"]["Aimbot"]["Knife Bot Range"]["Value"] then
						local Param = RaycastParams.new()
						Param.FilterType = Enum.RaycastFilterType.Blacklist
						Param.IgnoreWater = true
						Param.FilterDescendantsInstances = { -- this is the stuff we dont want the autowall to attempt simulating
							camera, -- ignore our camera as our viewmodel is stored here and bullets arent going to pass thru it
							workspace.Map.Clips, -- the clips are to be ignored
							workspace.Map.SpawnPoints, -- spawnpoints are to be ignored
							localPlayer.Character, -- since the bullets are coming from us, ignore our own player model
							workspace.Debris, -- the debris is to be ignored
							workspace.Ray_Ignore, -- obvious
							enemy.player.Character -- ignore their entire playermodel as the autowall is position based not hit based
						}

						local enterresult = workspaceRaycast(workspace, from, to - from, Param)
						if not enterresult then
							results[1 + #results] = enemy
						end
					end -- nope!
				end

				if #results < 1 then return end
				if #results > 2 then
					table.sort(results, function(a, b)
						return (a.pInfo.currentPosition - from).Magnitude < (b.pInfo.currentPosition - from).Magnitude
					end)
				end

				local nearest = results[1]
				nearest.player = nearest.player
				nearest.instance = nearest.player.Character.HumanoidRootPart
				nearest.to = {nearest.pInfo.currentPosition, "Center"}
				nearest.from = {localPlayer.Character.HumanoidRootPart.Position + newVector3(0, 2, 0) + localPlayer.Character.Humanoid.CameraOffset, "Base"}
				nearest.position = nearest.pInfo.currentPosition
				nearest.damagemodifier = 1
				nearest.wallbang = false
				nearest.pInfo = nearest.pInfo
				nearest.damage = 33
				nearest.normal = emptyVec3
				nearest.walls = {}

				return nearest
			else -- we have selected multi aura
				-- ok so if they are in our range
				ragebot.currentindex = ragebot.currentindex + 1 -- okay lets move to the next idx in the enemies table (scan the next enemy)
				if ragebot.currentindex > #enemies then -- okay that idx is too high so go back to 1
					ragebot.currentindex = 1
				end
				local enemy = enemies[ragebot.currentindex]
				
				if not ((enemy.pInfo.character.HumanoidRootPart.Position - from).Magnitude < Menu["Rage"]["Aimbot"]["Knife Bot Range"]["Value"]) then return end 

				ragebot.currenttarget.player = enemy.player
				ragebot.currenttarget.instance = enemy.pInfo.character.HumanoidRootPart
				ragebot.currenttarget.position = enemy.pInfo.character.HumanoidRootPart.Position
				ragebot.currenttarget.modifier = 1
				ragebot.currenttarget.wallbang = false
				ragebot.currenttarget.pInfo = enemy.pInfo

				hitPart:FireServer(
					ragebot.currenttarget.instance, -- 1
					ragebot.currenttarget.position, -- 2
					client.fgun.Name,
					client.fgun.Range.Value,
					nil,
					nil,
					9,
					false,
					false,
					localPlayer.Character.HumanoidRootPart.Position + newVector3(0, 2, 0) + localPlayer.Character.Humanoid.CameraOffset,
					workspace.DistributedTime.Value,
					Vector3.zero,
					true,
					"r", -- 14
					nil, -- 15
					nil, -- 16
					nil,-- 17
					nil,-- 18
					nil,-- 19
					nil,-- 20
					nil,-- 21
					nil,-- 22
					nil,-- 23
					nil, -- 24
					nil,--25
					nil--26

				
					
				)
				return
			end		
		end
		
		
	function ragebot.think()
    local char = localPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local menuRage = Menu["Rage"]
    local menuMisc = Menu["Misc"]
    local aimbotMenu = menuRage["Aimbot"]
    local now = tick()

    local function resetTarget()
        local ct = ragebot.currenttarget
        ct.player, ct.instance, ct.position = nil, nil, nil
        ct.modifier, ct.wallbang, ct.origin, ct.pInfo = nil, nil, nil, nil
    end

    if not (hrp and aimbotMenu["Enabled"]["Toggle"]["Enabled"] and aimbotMenu["Enabled"]["Bind"]["Active"])
        or not client.fgun or client.fgun == "none"
        or menuMisc["Extra"]["Kill All"]["Toggle"]["Enabled"] then
        resetTarget()
        return
    end

    local gun = replicatedStorage.Weapons:FindFirstChild(client.fgun.Name)
    if aimbotMenu["Auto Shoot Type"]["Value"] == "Standard" then
        if now - ragebot.lastshot < gun.FireRate.Value or now - ragebot.lastreload < gun.ReloadTime.Value then
            return
        end
    end

    resetTarget()

    prepWaitUntil = prepWaitUntil or 0
    if workspace.Status.Preparation.Value and menuRage["HvH"]["Wait For Round Start"]["Toggle"]["Enabled"] then
        if prepWaitUntil == 0 then
            local pingComp = menuRage["HvH"]["Ping Compensation"]["Value"] / 10
            local ping = game.Stats.PerformanceStats.Ping:GetValue() * pingComp / 1000
            prepWaitUntil = now + 6 - ping
        end
        if now < prepWaitUntil then
            return
        end
    else
        prepWaitUntil = 0
    end

    local enemies = {}
    local fov = aimbotMenu["Aimbot FOV"]["Value"]

    for _, pInfo in next, playerInfo.storage do
        if pInfo.alive and pInfo.enemy and not (pInfo.protected or pInfo.god) then
            local dir = (pInfo.character.HumanoidRootPart.Position - camera.CFrame.p).Unit
            local angle = math.deg(math.acos(camera.CFrame.LookVector:Dot(dir))) * 2
            if fov == 180 or angle < fov then
                enemies[#enemies + 1] = {player = pInfo.player, pInfo = pInfo}
            end
        end
    end

    if #enemies == 0 then return end

    local result
    if gun:FindFirstChild("Melee") and aimbotMenu["Knife Bot"]["Toggle"]["Enabled"] then
        result = ragebot.knifebot()
    else
        ragebot.currentindex = (ragebot.currentindex % #enemies) + 1
        result = ragebot.scan(enemies[ragebot.currentindex])
    end

    if not result then return end

    local ct = ragebot.currenttarget
    ct.player = result.player
    ct.instance = result.instance
    ct.position = result.to[1]
    ct.modifier = result.damagemodifier
    ct.wallbang = result.wallbang
    ct.origin = result.from[1]
    ct.pInfo = result.pInfo

    if not gun:FindFirstChild("Melee") and (result.damage < result.pInfo.humanoid.health or not aimbotMenu["Auto Shoot"]["Toggle"]["Enabled"]) then
        ragebot.currentindex = ragebot.currentindex - 1
    end

    ragebot.fire({
        origin = result.from[1],
        instance = result.instance,
        position = result.to[1],
        damageMultiplier = result.damagemodifier,
        wallbang = result.wallbang,
        normal = emptyVec3,
        damageInflicted = result.damage,
        type = result.to[2],
        origintype = result.from[2],
        walls = result.walls
    })

    if aimbotMenu["Auto Shoot"]["Toggle"]["Enabled"] then
        ragebot.lastshot = now

        local dtMode = aimbotMenu["Double Tap"]["Value"]
        local shiftTime = (dtMode == "Fast" and 10/64) or
                          (dtMode == "Faster" and 12/64) or
                          (dtMode == "Fastest" and 14/64)

        if shiftTime then
            ragebot.lastdt = ragebot.lastdt or 0
            if now - ragebot.lastdt > shiftTime * 2 then
                ragebot.lastdt = now
                ragebot.lastshot = now - shiftTime
            end
        end
    end
end

	runService.Heartbeat:Connect(function(d)
		--debug.profilebegin("ragebot think")
		ragebot.think(d)
		--debug.profileend()
	end)	
end

	do --ANCHOR Misc
		misc.oldmoney = 0
		misc.oldweaponstats = {}
		misc.lastchatmessage = tick()
		misc.lastupdate = tick()
		misc.hitsound = Instance.new("Sound", camera)
		misc.killsound = Instance.new("Sound", camera)
		misc.killsaylines = {Menu["Misc"]["Extra"]["Kill Say Message"]["Value"]}
		misc.ammomodded = false
		misc.olddamage = 0 -- i am not stormy (plays hit and kill sound when the total damage gets reset)
		misc.oldkills = 0
		misc.lastcheck = tick()
		misc.killFeed = {}
		misc.gunByIcon = {}

		local imagesLoaded = 0
		local constants = getconstants(require(replicatedStorage.GetIcon).getWeaponOfKiller)
		local totalImages = #constants
		local imagecache = {}
		for i = 2, #constants + 1 do
			coroutine.wrap(function()
				local gun = constants[i-1]
				local rbxassetid = constants[i]
				if gun == "C4" or replicatedStorage.Weapons:FindFirstChild(gun) then
					if rbxassetid and rbxassetid:find("rbxassetid") then
						misc.gunByIcon[rbxassetid] = gun
					end
				end
				imagesLoaded = imagesLoaded + 1
			end)()
		end

		repeat task.wait() until imagesLoaded == totalImages

			--[[misc.checkgoddedplrs = function()
				if tick() - misc.lastcheck > 0.05 then
					misc.lastcheck = tick()
					if Menu["Misc"]["Extra"]["Auto Martyrdom"]["Toggle"]["Enabled"] then
						for i, v in next, (players:GetPlayers()) do
							if v ~= localPlayer then
								local character = v.Character
								if character ~= nil and character:FindFirstChild("Humanoid") then
									if character:FindFirstChild("Hostage") or character.Humanoid.Health ~= character.Humanoid.Health then
										replicatedStorage.Events.PlaySound:FireServer(character, replicatedStorage.Hostage.Head)
									end
								end
							end
						end
					end
				end
			end
			runService.Heartbeat:Connect(misc.checkgoddedplrs)]]

		for i, v in next, (replicatedStorage.Weapons:GetChildren()) do
			local gun = v
			misc.oldweaponstats[gun.Name] = {}
			for i2, v2 in next, (gun:GetChildren()) do
				if (v2:IsA("NumberValue") or v2:IsA("IntValue") or v2:IsA("BoolValue")) and v2.Name ~= "MinDmg" then -- hehe int
					misc.oldweaponstats[gun.Name][v2.Name] = v2.Value
				end
			end
		end
misc.updateweaponstats = function()
    local currentgun = client.fgun
    if currentgun == "none" or not currentgun then return end 
    if misc.oldweaponstats[currentgun.Name] == nil or tick() - misc.lastupdate < 0.05 then return end
    misc.lastupdate = tick()

    -- Handle Weapon Modifications
    if Menu["Misc"]["Weapon Modifications"]["Enabled"]["Toggle"]["Enabled"] then
        for i, v in next, (misc.oldweaponstats[currentgun.Name]) do
            local stat = client.fgun:FindFirstChild(i)
            if stat then
                local statname = i
                if statname == "FireRate" then
                    stat.Value = Menu["Misc"]["Weapon Modifications"]["Fire Rate Scale"]["Value"] == 1200 and 0 or v / (Menu["Misc"]["Weapon Modifications"]["Fire Rate Scale"]["Value"]/100)
                elseif statname == "ReloadTime" then
                    stat.Value = Menu["Misc"]["Weapon Modifications"]["Instant Reload"]["Toggle"]["Enabled"] and 0.00001 or v
                elseif statname == "Auto" then
                    stat.Value = Menu["Misc"]["Weapon Modifications"]["Fully Automatic"]["Toggle"]["Enabled"] and true or v
                else
                    stat.Value = v
                end
            end
        end
    end


   
    -- Handle Infinite Ammo
    if Menu["Misc"]["Weapon Modifications"]["Infinite Ammo"]["Toggle"]["Enabled"] then
		game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoClip.Text = 'Astral'
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.AmmoGUI.AmmoReserve.Text = 'haxx'
        client.vars.ammocount = math.huge
        client.vars.primarystored = math.huge
        client.vars.ammocount2 = math.huge
        client.vars.secondarystored = math.huge
    else
        -- Restore old weapon stats if infinite ammo is disabled
        if misc.oldweaponstats[currentgun.Name] then
            for i, v in next, misc.oldweaponstats[currentgun.Name] do
                local stat = client.fgun:FindFirstChild(i)
                if stat and (stat:IsA("NumberValue") or stat:IsA("IntValue") or stat:IsA("BoolValue")) then
                    stat.Value = v
                end
            end
        end
    end
end

runService.Stepped:Connect(function() 
    --debug.profilebegin("modify weapons")
    misc.updateweaponstats()
    --debug.profileend()
end)

		misc.joinnewgame = function()
			UILibrary:EventLog("Joining a new game...", 5)
			local thing = httpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
			local jobid = thing.data[math.random(1, table.getn(thing.data))].id

			teleportService:TeleportToPlaceInstance(game.PlaceId, jobid)
		end
		Menu["Misc"]["Extra"]["Join A New Game"]["Button"].Pressed:Connect(misc.joinnewgame)
		runService.Heartbeat:Connect(function()
			if Menu["Misc"]["Extra"]["Infinite Money"]["Toggle"]["Enabled"] then
					game:GetService("Players").LocalPlayer.PlayerGui.GUI.Cash.Text = 'in debt 😭'
				task.wait(0.1)
				localPlayer.Cash.Value = 9000000000
			end
		end)

		function misc.updatemoney()
			if Menu["Misc"]["Extra"]["Infinite Money"]["Toggle"]["Enabled"] then
				misc.oldmoney = localPlayer.Cash.Value
				task.wait()
				localPlayer.Cash.Value = 9000000000
			else
				localPlayer.Cash.Value = misc.oldmoney
			end
		end
		Menu["Misc"]["Extra"]["Infinite Money"]["Toggle"].Changed:Connect(misc.updatemoney)

		function misc.hitplayer()
			if localPlayer.Additionals.TotalDamage.Value > misc.olddamage then
				if Menu["Misc"]["Extra"]["Hit Sound"]["Toggle"]["Enabled"] then
					misc.hitsound.SoundId = "rbxassetid://" .. Menu["Misc"]["Extra"]["Hit Sound ID"]["Value"]
					misc.hitsound.Volume = Menu["Misc"]["Extra"]["Hit Sound Volume"]["Value"] / 10
					misc.hitsound:Play()
				end
				local dmgdealt = localPlayer.Additionals.TotalDamage.Value - misc.olddamage
				if Menu["Visuals"]["Camera"]["Hit Marker"]["Toggle"]["Enabled"] then
					local upper = 4
					local lower = 8
					if Menu["Visuals"]["Camera"]["Hit Marker Type"].Value == "2D" then
						local transSignal = Library.Signal.new()
						for i = 1, 4 do
							local line = visuals.createDrawing("Line", {
								Color = Color3.new(1, 1, 1),
								Transparency = 1,
								Thickness = 1,-- what the fuck
								From = i == 1 and newVector2(viewportSize.x / 2 + upper, viewportSize.y / 2 + upper) or i == 2 and newVector2(viewportSize.x / 2 + upper, viewportSize.y / 2 - upper) or i == 3 and newVector2(viewportSize.x / 2 - upper, viewportSize.y / 2 - upper) or i == 4 and newVector2(viewportSize.x / 2 - upper, viewportSize.y / 2 + upper),
								To = i == 1 and newVector2(viewportSize.x / 2 + lower, viewportSize.y / 2 + lower) or i == 2 and newVector2(viewportSize.x / 2 + lower, viewportSize.y / 2 - lower) or i == 3 and newVector2(viewportSize.x / 2 - lower, viewportSize.y / 2 - lower) or i == 4 and newVector2(viewportSize.x / 2 - lower, viewportSize.y / 2 + lower),
								Visible = true
							})
							local loop; loop = runService.Stepped:Connect(function()
								line.Color = Menu["Visuals"]["Camera"]["Hit Marker"]["Color 1"]["Color"]
							end)
							transSignal:Connect(function(newTrans)
								if type(newTrans) == "number" then
									line.Transparency = newTrans
								else
									loop:Disconnect()
									loop = nil
									line:Remove()
									line = nil
								end
							end)
						end
						task.delay(1/2, function()
							for i = 1, 0, -1/10 do
								transSignal:Fire(i)
								task.wait(0.01)
							end
							transSignal:Fire("nigger")
							transSignal:Destroy()
							transSignal = nil
						end)
					else
						task.spawn(function()
							repeat
								
							until misc.lastHitpart
							local data = {}
							for i, v in next, (misc.lastHitpart) do
								data[i] = v
							end
							misc.lastHitpart = nil
							local posSignal = Library.Signal.new()
							local transSignal = Library.Signal.new()
							local step = runService.Stepped:Connect(function()
								local pos, onScreen = mathModule.worldToViewportPoint(data[2])
								if onScreen then
									posSignal:Fire(pos)
								else
									transSignal:Fire(0)
								end
							end)
							for i = 1, 4 do
								local line = visuals.createDrawing("Line", {
									Color = Color3.new(1, 1, 1),
									Transparency = 1,
									Thickness = 1,
									Visible = true,
								})
								posSignal:Connect(function(pos)
									line.From = i == 1 and newVector2(pos.x + upper, pos.y + upper) or i == 2 and newVector2(pos.x + upper, pos.y - upper) or i == 3 and newVector2(pos.x - upper, pos.y - upper) or i == 4 and newVector2(pos.x - upper, pos.y + upper)
									line.To = i == 1 and newVector2(pos.x + lower, pos.y + lower) or i == 2 and newVector2(pos.x + lower, pos.y - lower) or i == 3 and newVector2(pos.x - lower, pos.y - lower) or i == 4 and newVector2(pos.x - lower, pos.y + lower)
									line.Color = Menu["Visuals"]["Camera"]["Hit Marker"]["Color 1"]["Color"]
								end)
								transSignal:Connect(function(newTrans)
									if type(newTrans) == "number" then
										line.Transparency = newTrans
									else
										line:Remove()
										line = nil
									end
								end)
							end

							local damagedealt = dmgdealt
							local text = visuals.createDrawing("Text", {
								Color = data[1].Name:match("Head") and Color3.new(1, 1, 1) or Color3.new(1, 1, 1),
								Visible = true,
								Text = "dealt: "..tostring(damagedealt).. "dmg",
								Size = 13,
								Center = true,
								Outline = true,
								Font = 2
							})
							posSignal:Connect(function(pos)
								text.Position = newVector2(pos.x, pos.y - 20)
							end)
							transSignal:Connect(function(newTrans)
								if type(newTrans) == "number" then
									text.Transparency = newTrans
								else
									text:Remove()
									text = nil
								end
							end)
							task.delay(2, function()
								for i = 1, 0, -1/10 do
									transSignal:Fire(i)
									task.wait(0.01)
								end
								step:Disconnect()
								step = nil
								transSignal:Fire("nigger")
								transSignal:Destroy()
								transSignal = nil
								posSignal:Destroy()
								posSignal = nil
							end)
						end)
					end
				end
			end

			misc.olddamage = localPlayer.Additionals.TotalDamage.Value
		end
		localPlayer.Additionals.TotalDamage.Changed:Connect(misc.hitplayer) -- not cuteware, not doing this on hitpart

	--[[	misc.crosshairFix = runService.Stepped:Connect(function()
			for i, v in next, localPlayer.PlayerGui.GUI.Crosshairs.Crosshair:GetChildren() do
				if client.fgun ~= "none" and client.fgun:FindFirstChild("Scoped") and client.fgun:FindFirstChild("RifleThing") == nil then
					v.Visible = false
				else
					v.Visible = true
					if v.Name == "Dot" then
						if localPlayer.PlayerGui.GUI.CrosshairCustom.dot.Text == "OFF" then
							v.Visible = false
						end
					end
				end
			end
		end)]]

		function misc.getkillfeed()
			task.wait(((350 + game.Stats.PerformanceStats.Ping:GetValue()) * 2) / 1000) -- idk why
			misc.killFeed = {}
			for i, v in next, workspace.KillFeed:GetChildren() do
				misc.killFeed[i] = {
					position = tonumber(v.Name),
					killer = v.Killer.Value,
					victim = v.Victim.Value,
					weapon = v.Weapon.Value,
					headshot = v.Weapon.Headshot.Value,
					wallbang = v.Weapon.Wallbang.Value
				}
			end
			table.sort(misc.killFeed, function(a, b) return a.position > b.position end)
		end

		function misc.refreshkillsayfile()
			if isfile("bloxsense/kill_say.txt") then
				misc.killsaylines = {}
				for line in readfile("bloxsense/kill_say.txt"):gmatch("[^\n]+") do
					if line:match("%S") then
						table.insert(misc.killsaylines, line)
					end
				end
				misc.killsaylines = #misc.killsaylines > 0 and misc.killsaylines or {Menu["Misc"]["Extra"]["Kill Say Message"]["Value"]}
			end
		end

		Menu["Misc"]["Extra"]["Kill Say"]["Toggle"].Changed:Connect(misc.refreshkillsayfile)
		Menu["Misc"]["Extra"]["Kill Say Mode"]["Dropdown"].Changed:Connect(misc.refreshkillsayfile)


		function misc.killplayer()
			if localPlayer.Status.Kills.Value > misc.oldkills then
				if Menu["Misc"]["Extra"]["Kill Sound"]["Toggle"]["Enabled"] then
					misc.killsound.SoundId = "rbxassetid://" .. Menu["Misc"]["Extra"]["Kill Sound ID"]["Value"]
					misc.killsound.Volume = Menu["Misc"]["Extra"]["Kill Sound Volume"]["Value"] / 10
					misc.killsound:Play()
				end
				if Menu["Misc"]["Extra"]["Kill Say"]["Toggle"]["Enabled"] then
					misc.getkillfeed()
				
					for _, kill in next, misc.killFeed do
						if kill["killer"] == localPlayer.Name then
							local killInfo = {
								victim = kill["victim"],
								weapon = kill["weapon"]
							}
							local allowedAbbreviation = {
								["{victim}"] = killInfo["victim"],
								["{weapon}"] = misc.gunByIcon[killInfo["weapon"]]
							}

							local message = Menu["Misc"]["Extra"]["Kill Say Mode"]["Value"] == "Text Box" and Menu["Misc"]["Extra"]["Kill Say Message"]["Value"] or misc.killsaylines[math.random(1, #misc.killsaylines)]
							local message = message:gsub("{.-}", function(abbreviation)
								local lowerAbbreviation = string.lower(abbreviation)
								return allowedAbbreviation[lowerAbbreviation] or abbreviation
							end)
							playerChat:FireServer(message, false, false, true)
							break
						end
					end
				end
			end
			misc.oldkills = localPlayer.Status.Kills.Value
		end
		localPlayer.Status.Kills.Changed:Connect(misc.killplayer)
	end

	do --ANCHOR Movement
		function movement.collisionFilter(instance)
			return not instance.CanCollide
		end

		movement.basedir = -1

		function movement.step(delta)
			local localCharacter = localPlayer.Character
			local flightmode = (Menu["Misc"]["Tweaks"]["No Clip"]["Toggle"]["Enabled"] and Menu["Misc"]["Tweaks"]["No Clip"]["Bind"]["Active"]) or (Menu["Misc"]["Movement"]["Fly"]["Toggle"]["Enabled"] and Menu["Misc"]["Movement"]["Fly"]["Bind"]["Active"])
			if Menu["Misc"]["Tweaks"]["Custom Gravity"]["Toggle"]["Enabled"] then
				workspace.Gravity = Menu["Misc"]["Tweaks"]["Gravity Level"]["Value"]
			else
				workspace.Gravity = 80
			end
			if localCharacter then
				local humanoid = localCharacter:FindFirstChild("Humanoid")
				local humanoidRootPart = localCharacter:FindFirstChild("HumanoidRootPart")
				if humanoid and humanoidRootPart then
					if userInputService:IsKeyDown("Space") and Menu["Misc"]["Movement"]["Automatic Jump"]["Toggle"]["Enabled"] and humanoid.FloorMaterial ~= materials.Air and localPlayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
						humanoid.Jump = true
					end
					local moveDirection = emptyVec3
					local cfRel = flightmode and camera.CFrame or CFrame.lookAt(camera.CFrame.p, camera.CFrame.p + camera.CFrame.LookVector * xz)
					if userInputService:IsKeyDown("W") then
						moveDirection = moveDirection + cfRel.LookVector
					end
					if userInputService:IsKeyDown("S") then
						moveDirection = moveDirection - cfRel.LookVector
					end
					if userInputService:IsKeyDown("D") then
						moveDirection = moveDirection + cfRel.RightVector
					end
					if userInputService:IsKeyDown("A") then
						moveDirection = moveDirection - cfRel.RightVector
					end
					if userInputService:IsKeyDown("LeftShift") then
						moveDirection = moveDirection + cfRel.UpVector
					end
					if userInputService:IsKeyDown("LeftControl") then
						moveDirection = moveDirection - cfRel.UpVector
					end
					if (Menu["Misc"]["Movement"]["Fly"]["Toggle"]["Enabled"] and Menu["Misc"]["Movement"]["Fly"]["Bind"]["Active"]) then
						local speed = Menu["Misc"]["Movement"]["Fly Speed"]["Value"]
						humanoidRootPart.AssemblyLinearVelocity = moveDirection * speed
					elseif (Menu["Misc"]["Movement"]["Speed"]["Toggle"]["Enabled"] and Menu["Misc"]["Movement"]["Speed"]["Bind"]["Active"]) then
						local speed = Menu["Misc"]["Movement"]["Speed Factor"]["Value"]
						local mode = Menu["Misc"]["Movement"]["Speed Type"]["Value"]
						if flightmode then
							humanoidRootPart.AssemblyLinearVelocity = moveDirection * speed
						else
							if Menu["Misc"]["Movement"]["Circle Strafe"]["Toggle"]["Enabled"] and Menu["Misc"]["Movement"]["Circle Strafe"]["Bind"]["Active"] then
								local radius = Menu["Misc"]["Movement"]["Circle Strafe Radius"]["Value"]
								local direction
								if userInputService:IsKeyDown("D") then
									direction = 1
								end
								if userInputService:IsKeyDown("A") then
									direction = -1
								end

								if not direction then
									direction = movement.basedir
									movement.basedir = direction
								end

								if not misc.angle then
									misc.angle = 0
								end

								local myCframe = humanoidRootPart.CFrame
								local middleCircle = myCframe.p - newVector3(radius * math.cos(toRad * misc.angle), 0, radius * math.sin(toRad * misc.angle))
								local circumference = radius * 2 * pi
								local degreesPerSec = (speed / circumference) * 360
								local changeDegree = degreesPerSec * delta

								misc.angle = misc.angle + (changeDegree * movement.basedir)

								local moveTo = middleCircle + newVector3(radius * math.cos(toRad * misc.angle), 0, radius * math.sin(toRad * misc.angle))
								local moveIn = (moveTo - myCframe.p).unit
								local moveBy = moveIn * speed * delta
								local wallHit, positionOnWall, normalOnWall = workspace:FindPartOnRayWithWhitelist(Ray.new(myCframe.p, moveBy), {workspace.Map}, true)
								if not wallHit then
									humanoidRootPart.Position = moveTo
								else
									movement.basedir = movement.basedir * -1
								end

								return
							else
								moveDirection = newVector3(moveDirection.x, 0, moveDirection.z)
								moveDirection = mathModule.safeUnit(moveDirection) * speed
							end
							misc.angle = 0
							if mode == "Velocity" then
								humanoidRootPart.AssemblyLinearVelocity = newVector3(moveDirection.x, humanoidRootPart.AssemblyLinearVelocity.y, moveDirection.z)
							elseif mode == "CFrame" then
								local currentCf = humanoidRootPart.CFrame
								local nextCf = currentCf + (moveDirection * xz) * delta
								local wallPassed, pos, norm = workspace:FindPartOnRayWithWhitelist(Ray.new(currentCf.p, nextCf.p - currentCf.p), {workspace.Map}, true)
								if wallPassed then
									nextCf = nextCf - nextCf.p + pos + norm * 1.5
								end
								humanoidRootPart.CFrame = nextCf
							end
						end
					end
					if Menu["Misc"]["Tweaks"]["No Clip"]["Toggle"]["Enabled"] and Menu["Misc"]["Tweaks"]["No Clip"]["Bind"]["Active"] then
						for i,v in next, (localCharacter:GetChildren()) do
							if v:IsA("BasePart") and v.CanCollide == true then
								v.CanCollide = false -- pastedS
							end
						end
					else
						if ragebot.fakehrp then
							ragebot.fakehrp.CanCollide = true
						end
					end
					if Menu["Misc"]["Tweaks"]["Remove Crouch Cooldown"]["Toggle"]["Enabled"] then
						client.crouchcooldown = 0
					end
					if Menu["Misc"]["Tweaks"]["Edge Jump"]["Toggle"]["Enabled"] and Menu["Misc"]["Tweaks"]["Edge Jump"]["Bind"]["Active"] then
						if localPlayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall and localPlayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
							coroutine.wrap(function()
								runService.RenderStepped:Wait()
								if localPlayer.Character ~= nil and localPlayer.Character:FindFirstChild("Humanoid") and localPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and localPlayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
									localPlayer.Character.Humanoid:ChangeState("Jumping")
								end
							end)()
						end
					end
				end
			end
		end
	end -- HIIII INTEGER
	--nigger this code looks bad idk how to organize hooks
	--hold on

	do --ANCHOR Legitbot
		legitbot.aimassisttarget = { -- writing legitbotzz at 4 am$$$$$$$$
			player = nil,
			instance = nil,
			position = nil
		}
		legitbot.triggerbottarget = {
			player = nil,
			instance = nil,
			hit = tick(), -- for reaction time
			magnet = {
				active = false,
				player = nil,
				instance = nil,
				position = nil,
			}
		}
		legitbot.hitgroups = {
			["Head"] = {"HeadHB", "FakeHead"},
			["Body"] = {"UpperTorso", "LowerTorso"},
			["Arms"] = {"RightUpperArm", "RightLowerArm", "LeftUpperArm", "LeftLowerArm"},
			["Legs"] = {"RightUpperLeg", "RightLowerLeg", "LeftUpperLeg", "LeftLowerLeg"}
		}
		legitbot.triggergroups = {
			["Head"] = {"HeadHB", "FakeHead"},
			["Body"] = {"UpperTorso", "LowerTorso"},
			["Arms"] = {"RightUpperArm", "RightLowerArm", "RightHand", "LeftUpperArm", "LeftLowerArm", "LeftHand"},
			["Legs"] = {"RightUpperLeg", "RightLowerLeg", "RightFoot", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot"}
		}
		legitbot.weaponstats = {} -- so that u dont knife silent aim or some bullshit
		legitbot.weaponstats.gunrange = 1
		legitbot.weaponstats.penetration = 1
		-- i have no clue what the fuck i am doing (3:56 am, 3/6/2022, Invaded)
			--[[for reference: 
			legitbot.evaluatetarget({ -- if it wasnt for this i wouldve had to copy paste this func like 3 times (silent aim)
				fov = 0,
				deadzone = 0, 
				hitscanpoints = {"Head", "Body"}, 
				hitscanpriority = "Head", 
				ignoresmoke = false, 
				ignoreflash = false, 
				accuracy = 100,
				considerbacktrack = true
			})
			]]
		legitbot.evaluatetarget = function(Parameters) 
			local possibletargets = {}
			for i, v in next, (players:GetPlayers()) do
				if v ~= localPlayer then
					local pInfo = playerInfo.storage[v]
					if pInfo and pInfo.alive and pInfo.enemy and pInfo.character and pInfo.character:FindFirstChild("HumanoidRootPart") and not pInfo.protected then
						local angle = (math.abs(math.deg(math.acos((camera.CFrame.LookVector):Dot(newCframe(camera.CFrame.p, pInfo.character.HumanoidRootPart.Position).LookVector))))) * 2 -- cope!!!
						if angle < Parameters.fov and angle > Parameters.deadzone then
							possibletargets[1 + #possibletargets] = {v, pInfo, v.Character, angle}
						end
					end
				end
			end
			if #possibletargets < 1 then return end
			table.sort(possibletargets, function(a, b) return a[4] > b[4] end) -- okay so lets get a table of the people in fov and the closest to crosshair
			local currenttarget
			for i, v in next, (possibletargets) do
				if legitbot.aimassisttarget.player == nil then -- okay so we still dont have a valid target so lets scan the next person
					local player = v[1]
					local pInfo = v[2]
					local char = v[3]
					local potentialpoints = {}
					for i, v in next, (Parameters.hitscanpoints) do
						for i2, v2 in next, (legitbot.hitgroups[v]) do
							local point = char:FindFirstChild(v2)
							if ragebot.allPartsForBacktrack[point] then
								point = ragebot.allPartsForBacktrack[point] -- this is actually a backtrack, switch to the real one
							end
							if point then
								potentialpoints[1 + #potentialpoints] = point -- okay these are our hitscan points
								if Parameters.considerbacktrack == true then
									local btpart = point.Name
									if btpart == "HeadHB" then
										btpart = "Head"
									end
									if ragebot.backtracks[player].backtrackParts[btpart] then
										potentialpoints[1 + #potentialpoints] = ragebot.backtracks[player].backtrackParts[btpart]
									end
								end
							end
						end
					end
					local ignore = {
						workspace.Map
					}
					if Parameters.ignoresmoke == false then
						ignore[1 + #ignore] = workspace.Ray_Ignore
					end
					if localPlayer.PlayerGui.Blnd.Blind.BackgroundTransparency > 0.85 or Parameters.ignoreflash then
						local bestpoints = {}
						local priority = Parameters.hitscanpriority
						if Parameters.accuracy >= math.random(1, 100) then -- if accuracy chance is met lets try hitscan priority
							local currentpos, currentpart
							if priority == "Closest" then -- ok!
								local angles = {}
								for i, v in next, (potentialpoints) do -- lets get the closest to crosshair out of all of the hitscan points
									angles[1 + #angles] = {v, (math.abs(math.deg(math.acos((camera.CFrame.LookVector):Dot(newCframe(camera.CFrame.p, v.Position).LookVector))))) * 2}
								end
								table.sort(angles, function(a, b) 
									return a[2] > b[2]
								end)
								for i, v in next, (angles) do
									bestpoints[1 + #bestpoints] = v[1] -- ok so first idx of angles table is closest, so the closest will be scanned first
								end
							else
								for i2, v2 in next, (legitbot.hitgroups[priority]) do  -- ok so its just a simple change of priority here (scan hitscan priority first)
									local point = char:FindFirstChild(v2)
									bestpoints[1 + #bestpoints] = point
								end
							end				
						end
						local copy = {} -- i dont really feel like head aiming 100% of the time if the accuracy chance isnt met so lets randomize this table
						for i, v in next, (potentialpoints) do
							copy[1 + #copy] = v
						end
						local j, temp
						for i = #copy, 1, -1 do
							j = math.random(i)
							temp = copy[i]
							copy[i] = copy[j]
							copy[j] = temp
						end
						for i, v in next, (copy) do
							bestpoints[1 + #bestpoints] = v
						end
						for i, v in next, (bestpoints) do -- ok now that our points are sorted, lets do a visible check
							local ray = Ray.new(camera.CFrame.p, v.Position - camera.CFrame.p)
							local hit, pos = workspace:FindPartOnRayWithWhitelist(ray, ignore, false, true)
							if pos == v.Position then -- okay great, this point is visible, lets make currenttarget set to it
								return {player = player, instance = v, position = v.Position}
							end
						end
					end
				end
			end
		end
		legitbot.verifypoint = function(Parameters) -- {player, instance, position, fov, deadzone, ignoresmoke, ignoreflash}
			local currentplayer = Parameters.player
			local pInfo = playerInfo.storage[currentplayer]
			if pInfo ~= nil then
				local currentinstance = Parameters.instance
				local currentpos = Parameters.position
				if pInfo.alive and pInfo.enemy and (localPlayer.PlayerGui.Blnd.Blind.BackgroundTransparency > 0.85 or Parameters.ignoreflash) then
					local angle = (math.abs(math.deg(math.acos((camera.CFrame.LookVector):Dot(newCframe(camera.CFrame.p, currentinstance.Position).LookVector))))) * 2
					if angle < Parameters.fov and angle > Parameters.deadzone then -- ok they are still in fov
						local ignore = {
							workspace.Map
						}
						if Parameters.ignoresmoke == false then
							ignore[1 + #ignore] = workspace.Ray_Ignore
						end
						local targetpos = currentinstance.Position
						local ray = Ray.new(camera.CFrame.p, targetpos - camera.CFrame.p)
						local hit, pos = workspace:FindPartOnRayWithWhitelist(ray, ignore, false, true)
						if pos == targetpos then -- well that point isnt visible anymore so stop aiming there
							return currentinstance.Position -- update the currenttarget.pos or we will aim at the same point forever
						end
					end
				end
			end
		end

		legitbot.aimingTime = 0
		legitbot.previousDude = {
			dude = nil,
			lastAim = nil
		}
		legitbot.legitbotloop = runService.Stepped:Connect(function(delta)
			--debug.profilebegin("legit bot")
			if not client.fgun or client.fgun == "none" or not localPlayer.Character or (localPlayer.Character and not localPlayer.Character:FindFirstChild("Humanoid")) then -- hmm i wonder where ive seen this b4
				legitbot.aimassisttarget.player = nil
				legitbot.aimassisttarget.instance = nil
				legitbot.aimassisttarget.position = nil

				legitbot.triggerbottarget.player = nil
				legitbot.triggerbottarget.instance = nil
				legitbot.triggerbottarget.hit = nil

				legitbot.triggerbottarget.magnet.active = false
				legitbot.triggerbottarget.magnet.player = nil
				legitbot.triggerbottarget.magnet.instance = nil
				legitbot.triggerbottarget.magnet.hit = nil
			else
				legitbot.weaponstats.gunrange = client.fgun.Range.Value
				legitbot.weaponstats.penetration = client.fgun.Penetration.Value
				if client.fgun:FindFirstChild("Melee") then
					return
				end
				if Menu["Legit"]["Trigger Bot"]["Enabled"]["Toggle"]["Enabled"] and Menu["Legit"]["Trigger Bot"]["Enabled"]["Bind"]["Active"] then
					if legitbot.triggerbottarget.player ~= nil and legitbot.triggerbottarget.instance ~= nil then -- same procedure again
						if Menu["Legit"]["Trigger Bot"]["Reaction Time"]["Value"] == 0 or (tick() - legitbot.triggerbottarget.hit) > (Menu["Legit"]["Trigger Bot"]["Reaction Time"]["Value"] / 1000) then -- ok so we've waited for the reaction time, lets see if its still a valid point
							local currentplayer = legitbot.triggerbottarget.player
							local pInfo = playerInfo.storage[currentplayer]
							if pInfo ~= nil then
								local currentinstance = legitbot.triggerbottarget.instance
								local char = pInfo.character
								if pInfo.alive and pInfo.enemy then -- ok they are still alive
									local charchild = char:GetChildren()
									local possiblepoints = {}
									local plrReference = {}
									for i, v in next, (Menu["Legit"]["Trigger Bot"]["Trigger Bot Hitboxes"]["Value"]) do
										for i2, v2 in next, (legitbot.triggergroups[v]) do
											for i3, v3 in next, (charchild) do
												if v3 and ragebot.hitmodifier[v3.Name] ~= nil and v3.Name == v2 and ragebot.backtracks[currentplayer].backtrackParts[v3] == nil then
													possiblepoints[v3] = true
												end
											end
											for i3, v3 in next, (ragebot.backtracks[currentplayer].backtrackParts) do
												if i3.Name == v2 or (i3 == "Head" and v2 == "HeadHB") then
													possiblepoints[v3] = true
												end
											end
										end
									end
									local ignorelist = { -- dumbed down qual thing here
										localPlayer.Character, 
										workspace.Debris,
										camera,
										workspace.Map:WaitForChild("Clips"), 
										workspace.Map:WaitForChild("SpawnPoints"),
									}
									for i, v in next, (char:GetChildren()) do
										if possiblepoints[v] ~= true then -- so thats not a hitbox, lets ignore it
											ignorelist[1 + #ignorelist] = v
										end
									end
									-- okay lets see if our ray hits a selected hitbox
									local ray = Ray.new(camera.CFrame.p, camera.CFrame.LookVector.unit * 500) -- okay send a ray in the direction of my camera

									if Menu["Legit"]["Trigger Bot"]["Auto Wall"]["Toggle"]["Enabled"] then
										ignorelist[1 + #ignorelist] = workspace.Map
									end

									local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, ignorelist, false, true) -- lets see what it hits
									if possiblepoints[hit] == true then -- ok so its still a valid point
										local mayProceed = true
										if Menu["Legit"]["Trigger Bot"]["Auto Wall"]["Toggle"]["Enabled"] then
											mayProceed = false
											local extraignored = {
												findFirstChild(workspace.Map, "Clips"),
												findFirstChild(workspace.Map, "SpawnPoints"),
												camera,
												localPlayer.Character,
												findFirstChild(workspace, "Debris"),
												findFirstChild(workspace, "Ray_Ignore"),
											} -- ignoring every player model since that doesnt block bullets :sad:
											for i, v in next, players:GetPlayers() do
												if v.Character then
													extraignored[1 + #extraignored] = v.Character 
												end
											end

											local weaponstat = {
												maxPenetration = client.fgun.Penetration.Value * 0.01,
												maxWalls = 4
											}

											local awallhit, damagemodifier, wallbang = ragebot.autowall(camera.CFrame.p, pos, extraignored, weaponstat)
											if awallhit then 
												local gun = client.fgun
												local haskevlar = findFirstChild(currentplayer, "Kevlar")
												local hashelmet = haskevlar and findFirstChild(currentplayer, "Helmet")
												local armorpiercing = gun.ArmorPenetration.Value

												-- damage drop off at range
												local rangemodifier = gun.RangeModifier.Value

												local weapondamage = gun.DMG.Value
												local pellets = gun.Bullets.Value

												local ishead = hit.Name:match("Head")

												local damage = pellets * weapondamage * damagemodifier * (ishead and 4 or ragebot.hitmodifier[hit.Name]) * ragebot.kevlardamage(armorpiercing, haskevlar, hashelmet, ishead) * ragebot.distancedamagemodifier((camera.CFrame.p - char.HumanoidRootPart.Position).Magnitude, rangemodifier)

												if damage > Menu["Legit"]["Trigger Bot"]["Auto Wall Minimum Damage"]["Value"] or damage > pInfo.health then
													mayProceed = true
												end
											end
										end

										if not client.vars.DISABLED and mayProceed == true then
											client.firebullet()
											legitbot.triggerbottarget.clicked = true
											legitbot.triggerbottarget.player = nil
											legitbot.triggerbottarget.instance = nil
											legitbot.triggerbottarget.hit = nil
										end
									end
								end
							end
							legitbot.triggerbottarget.clicked = true
							legitbot.triggerbottarget.player = nil
							legitbot.triggerbottarget.instance = nil
							legitbot.triggerbottarget.hit = nil
						end
					else
						local validtarget
						local ignore = {
							localPlayer.Character, 
							workspace.Debris,
							camera, 
							workspace.Map:WaitForChild("Clips"), 
							workspace.Map:WaitForChild("SpawnPoints"),
						}
						local ray = Ray.new(camera.CFrame.p, camera.CFrame.LookVector.unit * 500) -- okay send a ray in the direction of my camera
						if Menu["Legit"]["Trigger Bot"]["Auto Wall"]["Toggle"]["Enabled"] then
							ignore[1 + #ignore] = workspace.Map
						end
						local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, ignore, false, true) -- lets see what it hits
						if hit then
							local playerhit = players:GetPlayerFromCharacter(hit.Parent)
							if playerhit ~= nil then -- okay so i hit SOMEONE
								local pInfo = playerInfo.storage[playerhit]
								if pInfo and pInfo.enemy then
									validtarget = {playerhit, pInfo}
								end
							end
							if validtarget ~= nil then -- okay so this is an enemy and they are on our crosshair
								local currentplayer = validtarget[1]
								local pInfo = validtarget[2]
								local char = pInfo.character
								if char ~= nil then -- this errored once so dn
									-- okay so now check if we are hitting a hitbox that is selected
									local charchild = char:GetChildren()
									local possiblepoints = {}
									for i, v in next, (Menu["Legit"]["Trigger Bot"]["Trigger Bot Hitboxes"]["Value"]) do
										for i2, v2 in next, (legitbot.triggergroups[v]) do
											for i3, v3 in next, (charchild) do
												if v3 and ragebot.hitmodifier[v3.Name] ~= nil and v3.Name == v2 and ragebot.backtracks[currentplayer].backtrackParts[v3] == nil then
													possiblepoints[v3] = true
												end
											end
											for i3, v3 in next, (ragebot.backtracks[currentplayer].backtrackParts) do
												if i3.Name == v2 or (i3 == "Head" and v2 == "HeadHB") then
													possiblepoints[v3] = true
												end
											end
										end
									end
									local ignorelist = { -- dumbed down qual thing here
										localPlayer.Character, 
										workspace.Debris,
										camera,
										workspace.Map:WaitForChild("Clips"), 
										workspace.Map:WaitForChild("SpawnPoints"),
									}
									for i, v in next, (char:GetChildren()) do
										if possiblepoints[v] ~= true then -- so thats not a hitbox, lets ignore it
											ignorelist[1 + #ignorelist] = v
										end
									end
									-- okay lets see if our ray hits a selected hitbox
									local ray = Ray.new(camera.CFrame.p, camera.CFrame.LookVector.unit * 500) -- okay send a ray in the direction of my camera
									if Menu["Legit"]["Trigger Bot"]["Auto Wall"]["Toggle"]["Enabled"] then
										ignorelist[1 + #ignorelist] = workspace.Map
									end

									local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, ignorelist, false, true) -- lets see what it hits
									if possiblepoints[hit] == true then -- ok so its still a valid point
										local mayProceed = true
										if Menu["Legit"]["Trigger Bot"]["Auto Wall"]["Toggle"]["Enabled"] then
											mayProceed = false
											local extraignored = {
												findFirstChild(workspace.Map, "Clips"),
												findFirstChild(workspace.Map, "SpawnPoints"),
												camera,
												localPlayer.Character,
												findFirstChild(workspace, "Debris"),
												findFirstChild(workspace, "Ray_Ignore"),
											} -- ignoring every player model since that doesnt block bullets :sad:
											for i, v in next, players:GetPlayers() do
												if v.Character then
													extraignored[1 + #extraignored] = v.Character 
												end
											end

											local weaponstat = {
												maxPenetration = client.fgun.Penetration.Value * 0.01,
												maxWalls = 4
											}

											local awallhit, damagemodifier, wallbang = ragebot.autowall(camera.CFrame.p, pos, extraignored, weaponstat)
											if awallhit then
												local gun = client.fgun
												local haskevlar = findFirstChild(currentplayer, "Kevlar")
												local hashelmet = haskevlar and findFirstChild(currentplayer, "Helmet")
												local armorpiercing = gun.ArmorPenetration.Value

												-- damage drop off at range
												local rangemodifier = gun.RangeModifier.Value

												local weapondamage = gun.DMG.Value
												local pellets = gun.Bullets.Value

												local isHead = hit.Name:match("Head")

												local damage = pellets * weapondamage * damagemodifier * (ishead and 4 or ragebot.hitmodifier[hit.Name]) * ragebot.kevlardamage(armorpiercing, haskevlar, hashelmet, ishead) * ragebot.distancedamagemodifier((camera.CFrame.p - char.HumanoidRootPart.Position).Magnitude, rangemodifier)

												if damage > Menu["Legit"]["Trigger Bot"]["Auto Wall Minimum Damage"]["Value"] or damage > pInfo.health then
													mayProceed = true
												end
											end
										end
										if mayProceed then -- would u look at that.... its a valid hitbox
											legitbot.triggerbottarget.player = currentplayer
											legitbot.triggerbottarget.instance = hit
											legitbot.triggerbottarget.hit = tick()
										end
									end
								end
							end
						end
					end
				end
				if legitbot.triggerbottarget.magnet.player then
					local result = legitbot.verifypoint({
						player = legitbot.triggerbottarget.magnet.player, 
						instance = legitbot.triggerbottarget.magnet.instance, 
						position = legitbot.triggerbottarget.magnet.instance.Position, 
						fov = Menu["Legit"]["Trigger Bot"]["Magnet FOV"]["Value"], 
						deadzone = 0, 
						ignoresmoke = Menu["Legit"]["Aim Assist"]["Aim Through Smoke"]["Toggle"]["Enabled"], 
						ignoreflash = Menu["Legit"]["Aim Assist"]["Aim Through Flash"]["Toggle"]["Enabled"]
					})
					if result then
						legitbot.triggerbottarget.magnet.position = result
					else
						legitbot.triggerbottarget.magnet.player = nil
						legitbot.triggerbottarget.magnet.instance = nil
						legitbot.triggerbottarget.magnet.position = nil
						legitbot.triggerbottarget.magnet.active = false
					end
				else
					legitbot.triggerbottarget.magnet.player = nil
					legitbot.triggerbottarget.magnet.instance = nil
					legitbot.triggerbottarget.magnet.position = nil
					legitbot.triggerbottarget.magnet.active = false

					local canSwitchToDude = not legitbot.previousDude.tick or (legitbot.previousDude.dude == legitbot.aimassisttarget.player or tick() - legitbot.previousDude.tick > (Menu["Legit"]["Aim Assist"]["Target Switch Delay"]["Value"] / 1000))
					local canLockOn = Menu["Legit"]["Aim Assist"]["Maximum Lock-On Time"]["Value"] == 8000 or legitbot.aimingTime < Menu["Legit"]["Aim Assist"]["Maximum Lock-On Time"]["Value"]
					if legitbot.aimassisttarget.player and canLockOn and canSwitchToDude then -- well, magnet was a no go so try the aim assist
						local result = legitbot.verifypoint({
							player = legitbot.aimassisttarget.player, 
							instance = legitbot.aimassisttarget.instance, 
							position = legitbot.aimassisttarget.instance.Position, 
							fov = Menu["Legit"]["Aim Assist"]["Aimbot FOV"]["Value"], 
							deadzone = Menu["Legit"]["Aim Assist"]["Deadzone FOV"]["Value"],
							ignoresmoke = Menu["Legit"]["Aim Assist"]["Aim Through Smoke"]["Toggle"]["Enabled"], 
							ignoreflash = Menu["Legit"]["Aim Assist"]["Aim Through Flash"]["Toggle"]["Enabled"]
						})
						if result ~= nil then
							legitbot.aimassisttarget.position = result
						else -- that point is no longer viable
							legitbot.aimingTime = 0
							legitbot.aimassisttarget.player = nil
							legitbot.aimassisttarget.instance = nil
							legitbot.aimassisttarget.position = nil
						end
					else
						legitbot.aimingTime = 0
						legitbot.aimassisttarget.player = nil
						legitbot.aimassisttarget.instance = nil
						legitbot.aimassisttarget.position = nil
					end
				end	
				
				-- so the points have been verified lets move our mouse accordingle
				if legitbot.aimassisttarget.player ~= nil or legitbot.triggerbottarget.magnet.player ~= nil then -- ok so there is a current point that can be aimed at
					local aimposition, Speed
					if legitbot.triggerbottarget.magnet.player ~= nil then -- ok so there is a magnet target
						Speed = Menu["Legit"]["Trigger Bot"]["Magnet Speed"]["Value"]
						aimposition = legitbot.triggerbottarget.magnet.position
					else -- nvm we dont
						local activation = Menu["Legit"]["Aim Assist"]["Aimbot Key"]["Value"]
						Speed = Menu["Legit"]["Aim Assist"]["Speed"]["Value"]
						if ((activation == "Mouse 1" and userInputService:IsMouseButtonPressed(0)) or (activation == "Mouse 2" and userInputService:IsMouseButtonPressed(1)) or activation == "Always") and Menu.closed == true and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") and (not Menu["Legit"]["Aim Assist"]["Require Mouse Movement"]["Toggle"]["Enabled"] or userInputService:GetMouseDelta().Magnitude > 0.01) then
							aimposition = legitbot.aimassisttarget.position
						end
					end
					if aimposition ~= nil then
						local randomisation = Menu["Legit"]["Aim Assist"]["Randomization"]["Value"]
						aimposition = aimposition + newVector3(math.noise(tick() * 0.1, 100) * randomisation, math.noise(tick() * 0.1, 200) * randomisation, math.noise(tick() * 0.1, 300) * randomisation)

						local angle = (math.abs(math.deg(math.acos((camera.CFrame.LookVector):Dot(newCframe(camera.CFrame.p, aimposition).LookVector))))) * 2
						local speedtype = Menu["Legit"]["Aim Assist"]["Speed Type"]["Value"]
						if speedtype == "Exponential" then
							Speed = Speed / 500
						else
							Speed = (Speed / angle) / 100
						end
						local recoilY, recoilP, recoilZ = client.revert:toEulerAnglesXYZ()
						recoilP = recoilP * 2 * Menu["Legit"]["Aim Assist"]["Recoil Compesation Pitch"]["Value"] / 100
						recoilY = recoilY * 2 * Menu["Legit"]["Aim Assist"]["Recoil Compesation Yaw"]["Value"] / 100
						camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.p, aimposition) * CFrame.Angles(recoilY, recoilP, 0), Speed)
						if legitbot.triggerbottarget.magnet.player == nil then
							legitbot.aimingTime = legitbot.aimingTime + delta
							legitbot.previousDude.dude = legitbot.aimassisttarget.player
							legitbot.previousDude.tick = tick()
						end
					end
					return
				end
				if Menu["Legit"]["Aim Assist"]["Enabled"]["Toggle"]["Enabled"] then
					if Menu["Legit"]["Trigger Bot"]["Enabled"]["Bind"]["Active"] and Menu["Legit"]["Trigger Bot"]["Magnet Triggerbot"]["Toggle"]["Enabled"] then
						legitbot.aimassisttarget.player = nil
						legitbot.aimassisttarget.instance = nil
						legitbot.aimassisttarget.position = nil
						legitbot.aimingTime = 0

						local result = legitbot.evaluatetarget({ -- if it wasnt for this i wouldve had to copy paste this func like 3 times (silent aim)
							fov = Menu["Legit"]["Trigger Bot"]["Magnet FOV"]["Value"], 
							deadzone = 0, 
							hitscanpoints = {Menu["Legit"]["Trigger Bot"]["Magnet Priority"]["Value"]}, 
							hitscanpriority = Menu["Legit"]["Trigger Bot"]["Magnet Priority"]["Value"], 
							ignoresmoke = Menu["Legit"]["Aim Assist"]["Aim Through Smoke"]["Toggle"]["Enabled"], 
							ignoreflash = Menu["Legit"]["Aim Assist"]["Aim Through Flash"]["Toggle"]["Enabled"],
							accuracy = 100,
							considerbacktrack = Menu["Legit"]["Aim Assist"]["Aim At Backtrack"]["Toggle"]["Enabled"]
						})
						if result ~= nil then
							legitbot.triggerbottarget.magnet.player = result.player
							legitbot.triggerbottarget.magnet.instance = result.instance
							legitbot.triggerbottarget.magnet.position = result.position
							legitbot.triggerbottarget.magnet.active = true
						else
							legitbot.triggerbottarget.magnet.player = nil
							legitbot.triggerbottarget.magnet.instance = nil
							legitbot.triggerbottarget.magnet.position = nil
							legitbot.triggerbottarget.magnet.active = false
						end
					else
						local result = legitbot.evaluatetarget({ -- if it wasnt for this i wouldve had to copy paste this func like 3 times (silent aim)
							fov = Menu["Legit"]["Aim Assist"]["Aimbot FOV"]["Value"], 
							deadzone = Menu["Legit"]["Aim Assist"]["Deadzone FOV"]["Value"], 
							hitscanpoints = Menu["Legit"]["Aim Assist"]["Hitscan Points"]["Value"], 
							hitscanpriority = Menu["Legit"]["Aim Assist"]["Hitscan Priority"]["Value"], 
							ignoresmoke = Menu["Legit"]["Aim Assist"]["Aim Through Smoke"]["Toggle"]["Enabled"], 
							ignoreflash = Menu["Legit"]["Aim Assist"]["Aim Through Flash"]["Toggle"]["Enabled"],
							accuracy = Menu["Legit"]["Aim Assist"]["Accuracy"]["Value"],
							considerbacktrack = Menu["Legit"]["Aim Assist"]["Aim At Backtrack"]["Toggle"]["Enabled"]
						})
						if result ~= nil then
							legitbot.aimassisttarget.player = result.player
							legitbot.aimassisttarget.instance = result.instance
							legitbot.aimassisttarget.position = result.position
							legitbot.aimingTime = 0

							legitbot.triggerbottarget.magnet.player = nil
							legitbot.triggerbottarget.magnet.instance = nil
							legitbot.triggerbottarget.magnet.position = nil
							legitbot.triggerbottarget.magnet.active = false
						else
							legitbot.aimassisttarget.player = nil
							legitbot.aimassisttarget.instance = nil
							legitbot.aimassisttarget.position = nil
							legitbot.aimingTime = 0
						end											
					end
				else
					legitbot.aimassisttarget.player = nil
					legitbot.aimassisttarget.instance = nil
					legitbot.aimassisttarget.position = nil
					legitbot.aimingTime = 0

					legitbot.triggerbottarget.magnet.player = nil
					legitbot.triggerbottarget.magnet.instance = nil
					legitbot.triggerbottarget.magnet.position = nil
					legitbot.triggerbottarget.magnet.active = false
				end
			end
			--debug.profileend()
		end)
	end

	do -- ANCHOR hooks n shitter
		local localPing = game.Stats.PerformanceStats.Ping:GetValue()

		runService.Stepped:Connect(function()
			localPing = game.Stats.PerformanceStats.Ping:GetValue()
		end)

		-- inventory unlocker bullshit
		local allSkins = {}

		for i, v in next, game:GetService("StarterGui").Client.Rarities:GetChildren() do
			if v.Name ~= "Banana_Stock" then
				allSkins[1 + #allSkins] = {v.Name}
			end
		end

		local inventorySelections = {}
		local legitInventory = table.clone(client.CurrentInventory)

		Menu["Misc"]["Exploits"]["Unlock Inventory"]["Toggle"].Changed:Connect(function()
			if Menu["Misc"]["Exploits"]["Unlock Inventory"]["Toggle"]["Enabled"] then
				client.CurrentInventory = allSkins
			else
				client.CurrentInventory = legitInventory
			end
			local TClone, CTClone = localPlayer.SkinFolder.TFolder:Clone(), localPlayer.SkinFolder.CTFolder:Clone()
			localPlayer.SkinFolder.TFolder:Destroy()
			localPlayer.SkinFolder.CTFolder:Destroy()
			TClone.Parent = localPlayer.SkinFolder
			CTClone.Parent = localPlayer.SkinFolder
		end)

		local CurrentKnives = {
			"Bayonet",
			"Huntsman Knife",
			"Falchion Knife",
			"Karambit",
			"Gut Knife",
			"Butterfly Knife",
			"M9 Bayonet",
			"Banana",
			"Flip Knife",
			"Sickle",
			"Bearded Axe",
			"Cleaver"
		}
		local CurrentGloves = {
			"Sports Glove",
			"Strapped Glove",
			"Fingerless Glove",
			"Handwraps"
		}

		local equipHook = client.equipitem
		client.equipitem = function(invennum, team)
			if Menu["Misc"]["Exploits"]["Unlock Inventory"]["Toggle"]["Enabled"] then
				local item2equip = client.CurrentInventory[invennum]
				local physicalitem = item2equip[1]
				local splitter = string.split(physicalitem, "_")

				local weapon = splitter[1]
				local isKnife
				for i = 1, #CurrentKnives do
					if CurrentKnives[i] == weapon then
						isKnife = true
					end
				end

				local weapon = splitter[1]
				local isGlove
				for i = 1, #CurrentGloves do
					if CurrentGloves[i] == weapon then
						isGlove = true
					end
				end

				inventorySelections[1 + #inventorySelections] = {
					args = {invennum, team},
					item2equip = item2equip,
					physicalitem = physicalitem,
					splitter = splitter,
					weapon = splitter[1],
					skin = splitter[2],
					isKnife = isKnife,
					isGlove = isGlove
				}

				local seenItems = {}
				for i = #inventorySelections, 1, -1 do
					local entry = inventorySelections[i]
					local physicalItem = entry.weapon

					if seenItems[physicalItem] then
						if entry.skin ~= inventorySelections[seenItems[physicalItem]].skin then
							inventorySelections[seenItems[physicalItem]].skin = entry.skin
						end

						table.remove(inventorySelections, i)
					else
						seenItems[physicalItem] = i
					end
				end

				local knifeSeen
				for i = #inventorySelections, 1, -1 do
					local entry = inventorySelections[i]
					local isKnife = entry.isKnife

					if isKnife and knifeSeen then
						table.remove(inventorySelections, i)
					end

					if isKnife then
						knifeSeen = true
					end
				end

				local gloveSeen
				for i = #inventorySelections, 1, -1 do
					local entry = inventorySelections[i]
					local isGlove = entry.isGlove

					if isGlove and gloveSeen then
						table.remove(inventorySelections, i)
					end

					if isGlove then
						gloveSeen = true
					end
				end
			end

			return equipHook(invennum, team)
		end

		Menu["Misc"]["Exploits"]["Inventory Data"] = {}
		Menu["Misc"]["Exploits"]["Inventory Data"].Value = {}
		Menu["Misc"]["Exploits"]["Inventory Data"].Save = function()
			return {["Value"] = inventorySelections}
		end

		local inventoryProxy = Menu["Misc"]["Exploits"]["Inventory Data"]
		Menu["Misc"]["Exploits"]["Inventory Data"] = setmetatable({}, {
			__index = function(self, i)
				return inventoryProxy[i]
			end,
			__newindex = function(self, i, v)
				if i == "Value" and #v > 0 then
					coroutine.wrap(function()
						task.wait()
						if Menu["Misc"]["Exploits"]["Unlock Inventory"]["Toggle"]["Enabled"] then
							local oldPageGen = client.GeneratePage
							client.GeneratePage = function() end
							for d, a in next, v do
								equipHook(unpack(a.args))
							end
							client.GeneratePage = oldPageGen
						end
					end)()
					inventorySelections = v
				end
				inventoryProxy[i] = v
			end
		})

		local isUnlocked

		local fakeSkinOwner = {
			SkinFolder = {
				["CTFolder"] = {
				},
				["TFolder"] = {
				},	
				["Funds"] = {Value = 1/0}
			},
			Status = {
				Team = {
					Value = "T"
				}
			}
		}

		local lastClimbStatus = false
		local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
			local args = {...}
			local method = getnamecallmethod()
			if method == "FireServer" then
				if args[1] == localPlayer.UserId then
					if Menu["Misc"]["Exploits"]["Unlock Inventory"]["Toggle"]["Enabled"] then
						return
					end
				elseif string.len(tostring(self)) == 38 then
					if Menu["Misc"]["Exploits"]["Unlock Inventory"]["Toggle"]["Enabled"] then
						if not isUnlocked then
							isUnlocked = true
							for i,v in pairs(allSkins) do
								local doSkip
								for i2,v2 in pairs(args[1]) do
									if v[1] == v2[1] then
										doSkip = true
									end
								end
								if not doSkip then
									table.insert(args[1], v)
								end
							end
						end
						return
					end
				elseif self.Name == "DataEvent" and args[1][4] then
					if Menu["Misc"]["Exploits"]["Unlock Inventory"]["Toggle"]["Enabled"] then
						local currentModel = string.split(args[1][4][1], "_")[1]
						local currentSkin = string.split(args[1][4][1], "_")[2]
						if args[1][2] == "Both" then
							localPlayer["SkinFolder"]["CTFolder"][args[1][3]].Value = currentSkin
							localPlayer["SkinFolder"]["TFolder"][args[1][3]].Value = currentSkin
							fakeSkinOwner["SkinFolder"]["CTFolder"][currentModel] = {Value = currentSkin}
							fakeSkinOwner["SkinFolder"]["TFolder"][currentModel] = {Value = currentSkin}
						else
							localPlayer["SkinFolder"][args[1][2] .. "Folder"][currentModel].Value = currentSkin
							fakeSkinOwner["SkinFolder"][args[1][2] .. "Folder"][currentModel] = {Value = currentSkin}
						end
					end
				elseif self.Name == controlTurn.Name then
					args[1] = ragebot.lastpitchangle
					return oldNamecall(self, table.unpack(args,1,select("#",...)))
				elseif self.Name == "ApplyGun" then
					--if Menu["Misc"]["Exploits"]["Unlock Inventory"]["Toggle"]["Enabled"] and Menu["Misc"]["Exploits"]["Replicate Skins"]["Toggle"]["Enabled"] then
					--	fakeSkinOwner.Status.Team.Value = tostring(localPlayer.Team) == "Terrorists" and "T" or "CT"
						--args[2] = fakeSkinOwner
						
					--    return oldNamecall(self, table.unpack(args,1,select("#",...)))
					--end
				elseif self.Name == "Drop" then
					--if Menu["Misc"]["Exploits"]["Block Weapon Dropping On Death"]["Toggle"]["Enabled"] and (localPlayer.Character == nil or localPlayer.Character.Humanoid.Health <= 0) then
					--	return
					--end
					
					--return oldNamecall(self, table.unpack(args,1,select("#",...)))
				elseif self.Name == replicateCamera.Name then
					args[1] = ragebot.lastcameracf
					return oldNamecall(self, table.unpack(args,1,select("#",...)))
				elseif self.Name == "UpdatePing" and Menu["Misc"]["Exploits"]["Ping Spoofer"]["Toggle"]["Enabled"] then
					args[1] = math.random(math.min(Menu["Misc"]["Exploits"]["Minimum Ping"]["Value"], Menu["Misc"]["Exploits"]["Maximum Ping"]["Value"]), Menu["Misc"]["Exploits"]["Maximum Ping"]["Value"])/1000
					return oldNamecall(self, table.unpack(args,1,select("#",...)))
				elseif self.Name == "BURNME" and Menu["Misc"]["Extra"]["Bypass Molotov Damage"]["Toggle"]["Enabled"] then 
					return
				elseif self.Name == "PlayerChatted" then
					--args[3] = (args[3] == "Spectator" and Menu["Misc"]["Exploits"]["Chat While Dead"]["Toggle"]["Enabled"]) and "Innocent" or args[3]
					--args[4] = not (not args[4] or (Menu["Misc"]["Exploits"]["Chat While Dead"]["Toggle"]["Enabled"]))
					--args[5] = Menu["Misc"]["Exploits"]["Uncensored Chat"]["Toggle"]["Enabled"] and false or true
				elseif self.Name == fallDamage.Name and Menu["Misc"]["Tweaks"]["Bypass Fall Damage"]["Toggle"]["Enabled"] and args[1] == args[1] then
					return
				elseif self.Name == hitPart.Name and not Menu["Misc"]["Extra"]["Kill All"]["Toggle"]["Enabled"] then
					local x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26 = ...
					local dude = ragebot.currenttarget.player
					if ragebot.currenttarget.player ~= nil and Menu["Rage"]["Aimbot"]["Auto Shoot"]["Toggle"]["Enabled"] == false then
						x1 = ragebot.currenttarget.instance
						x2 = ragebot.currenttarget.position
						x7 = ragebot.currenttarget.modifier
						x9 = ragebot.currenttarget.wallbang
						x14 = "r"
						ragebot.currenttarget.player = nil -- breaks the first check so i dont do this shit like 4 times
					end

					if Menu["Misc"]["Weapon Modifications"]["Enabled"]["Toggle"]["Enabled"] then
						if Menu["Misc"]["Weapon Modifications"]["Infinity Damage"]["Toggle"]["Enabled"] then
						x7 = math.huge
					end
				end

					local ya = x14 and ragebot.currenttarget.position or Vector3.new(((x2.X / 13 - 1325) / 4) + 74312, ((x2.Y + 4201432) / 4) - 3183421, (x2.Z / 2 + 581357) / 41)
					local f = {...}
					f[2] = ya

					if Menu["Rage"]["Tracking"]["Back Tracking"]["Toggle"]["Enabled"] then -- ok its a backtrack part
						local v = {
							real = ragebot.allPartsForBacktrack[args[1]]
						}
						if ragebot.allPartsForBacktrack[args[1]] then
							x1 = v.real
							x2 = Vector3.new(((v.real.Position.x - 74312) * 4 + 1325) * 13, (v.real.Position.y + 3183421) * 4 - 4201432, (v.real.Position.z * 41 - 581357) * 2)
						end    
					end

					task.spawn(function() -- unstable or sm idk
						local hitplayer = players:GetPlayerFromCharacter(x1.Parent)
						if hitplayer and playerInfo.storage[hitplayer].enemy then
							misc.lastHitpart = f -- okay this looks really cringe but try to do misc.lastHitpart = args
							if Menu["Visuals"]["Hits"]["Hit Chams"]["Toggle"]["Enabled"] then
								visuals.createHitChams(hitplayer.Character)
							end
						end
					end)

					if Menu["Visuals"]["Bullets"]["Bullet Tracers"]["Toggle"]["Enabled"] then -- nearly done"
						task.spawn(visuals.bulletTracer, x14 and args[10] or nil, ya) -- can u like dn
					end

					if x14 == "r" then
						if Menu["Rage"]["HvH"]["Prediction"]["Toggle"]["Enabled"] then
							if Menu["Rage"]["HvH"]["Prediction Type"]["Value"] == "Exploit" then
								x2 = {X = math.sqrt(-1), Y = math.sqrt(-1), Z = math.sqrt(-1)}
							else
								local pInfo = playerInfo.storage[dude]
								if pInfo and pInfo.velocity.Magnitude > 1 and #pInfo.updates > 2 then
									local configPing = Menu["Rage"]["HvH"]["Multiplier"]["Value"]
									local simPing = configPing > 0 and configPing or localPing
									local simVel = pInfo.velocity
									x2 = pInfo.updates[1].position + (simVel * simPing / 1000) + (simVel * 1/60)
								end
								x2 = Vector3.new(((x2.x - 74312) * 4 + 1325) * 13, (x2.y + 3183421) * 4 - 4201432, (x2.z * 41 - 581357) * 2)
							end
						else
							x2 = Vector3.new(((x2.x - 74312) * 4 + 1325) * 13, (x2.y + 3183421) * 4 - 4201432, (x2.z * 41 - 581357) * 2)
						end

						x14 = nil
						return oldNamecall(self, x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26)
					end
					if Menu["Misc"]["Exploits"]["Shot players become mush"]["Toggle"]["Enabled"] then
						x1 = x1.Parent.FindFirstChild(x1.Parent, "Head") or x1
						x7 = 1
						x3 = "AWP"
						oldNamecall(self, x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26)
						x3 = "Multimeter"
						oldNamecall(self, x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26)
						return
					end
					return oldNamecall(self, x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26)
				end
			elseif method == "Kick" and self == localPlayer then 
				return coroutine.yield()
			elseif method == "FindPartOnRayWithIgnoreList" then -- for bullet redirection in the legitbotz
				local passed = false
				for i, v in next, args[2] do
					if v.ClassName == "Accessory" then
						passed = true
					end
				end
				if passed then
					if Menu["Misc"]["Weapon Modifications"]["Enabled"]["Toggle"]["Enabled"] and Menu["Misc"]["Weapon Modifications"]["No Spread"]["Toggle"]["Enabled"] then
						args[1] = Ray.new(camera.CFrame.p, camera.CFrame.LookVector * client.gun.Range.Value)
					end
					if Menu["Legit"]["Bullet Redirection"]["Silent Aim"]["Toggle"]["Enabled"] and Menu["Legit"]["Bullet Redirection"]["Hit Chance"]["Value"] > math.random(0, 100) then -- ok is the chance met?
						if legitbot.triggerbottarget.magnet.active == true and legitbot.triggerbottarget.magnet.player ~= nil and legitbot.triggerbottarget.magnet.instance ~= nil and (math.abs(math.deg(math.acos((camera.CFrame.LookVector):Dot(newCframe(camera.CFrame.p, legitbot.triggerbottarget.magnet.player.Character.HumanoidRootPart.Position).LookVector))))) * 2 < Menu["Legit"]["Bullet Redirection"]["Silent Aim FOV"]["Value"] then
							args[1] = Ray.new(camera.CFrame.p, (legitbot.triggerbottarget.magnet.position - camera.CFrame.p).unit * legitbot.weaponstats.gunrange * 0.0694)
						elseif legitbot.aimassisttarget.player ~= nil and legitbot.aimassisttarget.instance ~= nil and legitbot.aimassisttarget.player ~= nil and (math.abs(math.deg(math.acos((camera.CFrame.LookVector):Dot(newCframe(camera.CFrame.p, legitbot.aimassisttarget.player.Character.HumanoidRootPart.Position).LookVector))))) * 2 < Menu["Legit"]["Bullet Redirection"]["Silent Aim FOV"]["Value"] then -- ok so the aim assist is trying to pull my crosshair to a certain part, if its in fov then silent aim at it too
							args[1] = Ray.new(camera.CFrame.p, (legitbot.aimassisttarget.position - camera.CFrame.p).unit * legitbot.weaponstats.gunrange * 0.0694)			
						else
							local extraignored = {
								findFirstChild(workspace.Map, "Clips"),
								findFirstChild(workspace.Map, "SpawnPoints"),
								camera,
								localPlayer.Character,
								findFirstChild(workspace, "Debris"),
								findFirstChild(workspace, "Ray_Ignore"),
							} -- ignoring every player model since that doesnt block bullets :sad:

							for i, v in next, players:GetPlayers() do
								if v.Character then
									extraignored[1 + #extraignored] = v.Character 
								end
							end

							local weaponstat = { -- this one is just for the autowall
								maxPenetration = legitbot.weaponstats.penetration * 0.01, -- the equivalent of no penetration if the autowall is disabled
								maxWalls = 4, -- if our autowall isnt enabled then just simulate one wall, itll fail anyway
							}

							local possibletargets = {}
							for i, v in next, (playerInfo.storage) do
								local pInfo = v
								if pInfo and pInfo.alive and pInfo.enemy and not pInfo.protected then
									local angle = (math.abs(math.deg(math.acos((camera.CFrame.LookVector):Dot(newCframe(camera.CFrame.p, pInfo.character.HumanoidRootPart.Position).LookVector))))) * 2 -- cope!!!
									if angle < Menu["Legit"]["Bullet Redirection"]["Silent Aim FOV"]["Value"] then
										possibletargets[1 + #possibletargets] = {pInfo.player, pInfo, pInfo.player.Character, angle}
									end
								end
							end
							table.sort(possibletargets, function(a, b) return a[4] < b[4] end)
							local currenttarget
							for i, v in next, (possibletargets) do
								local player = v[1]
								local pInfo = v[2]
								local char = v[3]
								local potentialpoints = {}
								for i2, v2 in next, (Menu["Legit"]["Bullet Redirection"]["Hitscan Points"]["Value"]) do
									for i3, v3 in next, (legitbot.hitgroups[v2]) do
										local point = char:FindFirstChild(v3)
										if ragebot.allPartsForBacktrack[point] then
											point = ragebot.allPartsForBacktrack[point] -- this is actually a backtrack, switch to the real one
										end
										if point then
											potentialpoints[1 + #potentialpoints] = point -- okay these are our hitscan points
										end
									end
								end
								local ignore = {workspace.Map}
								if not Menu["Legit"]["Bullet Redirection"]["Aim Through Smoke"]["Toggle"]["Enabled"] then
									ignore[1 + #ignore] = workspace.Ray_Ignore
								end

								if localPlayer.PlayerGui.Blnd.Blind.BackgroundTransparency > 0.85 or Menu["Legit"]["Bullet Redirection"]["Aim Through Flash"]["Toggle"]["Enabled"] then
									local bestpoints = {}
									if Menu["Legit"]["Bullet Redirection"]["Accuracy"]["Value"] >= math.random(1, 100) then
										local priority = Menu["Legit"]["Bullet Redirection"]["Hitscan Priority"]["Value"]
										local currentpos, currentpart
										if priority == "Closest" then
											local angles = {}
											for i2, v2 in next, (potentialpoints) do
												local point = v2
												if point then
													angles[1 + #angles] = {point, (math.abs(math.deg(math.acos((camera.CFrame.LookVector):Dot(newCframe(camera.CFrame.p, point.Position).LookVector))))) * 2}
												end
											end
											table.sort(angles, function(a, b) 
												return a[2] < b[2]
											end)
											for i2, v2 in next, (angles) do
												bestpoints[1 + #bestpoints] = v2[1]
											end
										else
											for i2, v2 in next, (legitbot.hitgroups[Menu["Legit"]["Bullet Redirection"]["Hitscan Priority"]["Value"]]) do
												local point = char:FindFirstChild(v2)
												bestpoints[1 + #bestpoints] = point
											end
										end
									end
									local copy = {}
									for i2, v2 in next, (potentialpoints) do
										local point = char:FindFirstChild(v2)
										if point then
											copy[1 + #copy] = point
										end
									end
									local j, temp
									for f = #copy, 1, -1 do
										j = math.random(f)
										temp = copy[f]
										copy[i] = copy[j]
										copy[j] = temp
									end
									for i2, v2 in next, (copy) do
										bestpoints[1 + #bestpoints] = v2
									end
									for i2, v2 in next, (bestpoints) do
										if v2 ~= nil then
											local ray = Ray.new(camera.CFrame.p, v2.Position - camera.CFrame.p)
											local hit, pos = workspace:FindPartOnRayWithWhitelist(ray, ignore)

											if hit and Menu["Legit"]["Bullet Redirection"]["Auto Wall"]["Toggle"]["Enabled"] then
												local penetrable, damagemodifier, wallbang = ragebot.autowall(camera.CFrame.p, v2.Position, extraignored, weaponstat) -- theres no simulations here, only headshots
												if penetrable then
													hit = nil
												end
											end

											if not hit then
												local silentaimpoint = v2.Position
												args[1] = Ray.new(camera.CFrame.p, (silentaimpoint - camera.CFrame.p).unit * legitbot.weaponstats.gunrange * 0.0694)

												local enterParam = RaycastParams.new()
												enterParam.FilterType = Enum.RaycastFilterType.Blacklist
												enterParam.IgnoreWater = true
												enterParam.FilterDescendantsInstances = args[2]
												local resultOfDepressionAndLonliness = workspaceRaycast(workspace, args[1].Origin, args[1].Direction, enterParam)
												return resultOfDepressionAndLonliness and resultOfDepressionAndLonliness.Instance or nil, resultOfDepressionAndLonliness and resultOfDepressionAndLonliness.Position or (args[1].Origin + args[1].Direction), resultOfDepressionAndLonliness and resultOfDepressionAndLonliness.Normal or emptyVec3, resultOfDepressionAndLonliness and resultOfDepressionAndLonliness.Material or nil
											end
										end
									end
								end
							end	
						end
					end
					-- vaderrrr :c what is this emo shit doing here :sad:
					local enterParam = RaycastParams.new()
					enterParam.FilterType = Enum.RaycastFilterType.Blacklist
					enterParam.IgnoreWater = true
					enterParam.FilterDescendantsInstances = args[2]
					local resultOfDepressionAndLonliness = workspaceRaycast(workspace, args[1].Origin, args[1].Direction, enterParam)
					return resultOfDepressionAndLonliness and resultOfDepressionAndLonliness.Instance or nil, resultOfDepressionAndLonliness and resultOfDepressionAndLonliness.Position or (args[1].Origin + args[1].Direction), resultOfDepressionAndLonliness and resultOfDepressionAndLonliness.Normal or emptyVec3, resultOfDepressionAndLonliness and resultOfDepressionAndLonliness.Material or nil										
				end
			elseif method == "SetPrimaryPartCFrame" then
				if self.Name:find("Arms") and localPlayer.Character then
					if Menu["Visuals"]["Camera"]["Disable Weapon Swaying"]["Toggle"]["Enabled"] then
						args[1] = camera.CFrame
					end
					if Menu["Visuals"]["Viewmodel"]["Offset Viewmodel"]["Toggle"]["Enabled"] then
						args[1] = args[1] * newCframe(toRad * Menu["Visuals"]["Viewmodel"]["X Axis"]["Value"], toRad * Menu["Visuals"]["Viewmodel"]["Y Axis"]["Value"], toRad * Menu["Visuals"]["Viewmodel"]["Z Axis"]["Value"]) * CFrame.Angles(toRad * Menu["Visuals"]["Viewmodel"]["Pitch"]["Value"], toRad * Menu["Visuals"]["Viewmodel"]["Yaw"]["Value"], toRad * Menu["Visuals"]["Viewmodel"]["Roll"]["Value"])
					end
					if Menu["Rage"]["Aimbot"]["Rotate Viewmodel"]["Toggle"]["Enabled"] and ragebot.currenttarget.position then
						args[1] = CFrame.lookAt(args[1].p, ragebot.currenttarget.position)
					end
					if Menu["Visuals"]["Camera"]["Third Person"]["Toggle"]["Enabled"] and Menu["Visuals"]["Camera"]["Third Person"]["Bind"]["Active"] then
						args[1] = args[1] * newCframe(10000, 10000, 10000)
					end
					return oldNamecall(self, args[1])
				end
			elseif method == "LoadAnimation" then
				if (Menu["Misc"]["Movement"]["Automatic Jump"]["Toggle"]["Enabled"] and (Menu["Misc"]["Movement"]["Speed"]["Toggle"]["Enabled"] and Menu["Misc"]["Movement"]["Speed"]["Bind"]["Active"])) or Menu["Rage"]["Anti Aim"]["Slide Walk"]["Toggle"]["Enabled"] then
					if string.match(args[1].Name, "Jump") then
						args[1] = ragebot.fakeanimation
						return oldNamecall(self, args[1])
					end
				end
			elseif method == "InvokeServer" then
				if self.Name == "Filter" and Menu["Misc"]["Extra"]["Uncensor Chat"]["Toggle"]["Enabled"] then
					return args[1]
				elseif self.Name == "Hugh" then
					if Menu["Misc"]["Exploits"]["Unlock Inventory"]["Toggle"]["Enabled"] then
						return
					end
				end
			elseif method == "inverse" then
				camRecoilAngle = self
			end
			
			return oldNamecall(self, ...)
		end)
	end


	do --ANCHOR fixes
		local oldBulletHole = client.createbullethole
		client.createbullethole = function(part, pos, bloodsplatter)
			if pos ~= pos then
				pos = emptyVec3
			end
			if Menu["Misc"]["Extra"]["Remove Bullet Holes"]["Toggle"]["Enabled"] then
				bloodsplatter = false
			end
			return oldBulletHole(part, pos, bloodsplatter)
		end
		local oldSplatter = client.splatterBlood 
		client.splatterBlood = function(origin, humanoid, dmg, startpos, pos)
			if Menu["Misc"]["Extra"]["Remove Hit Effects"]["Toggle"] then
				return
			end
			return oldSplatter(origin, humanoid, dmg, startpos, pos)
		end



		workspace.Debris.ChildAdded:Connect(function(child)
			if child.Name == "Bullet" and Menu["Misc"]["Extra"]["Remove Bullet Holes"]["Toggle"]["Enabled"] then
				task.spawn(child.Destroy, child)
			end
		end)

		for i,v in next, workspace.Debris:GetChildren() do
			if v.Name == "Bullet" and Menu["Misc"]["Extra"]["Remove Bullet Holes"]["Toggle"]["Enabled"] then
				v:Destroy()
			end
		end

		Menu["Misc"]["Extra"]["Remove Bullet Holes"]["Toggle"].Changed:Connect(function(bool)
			if bool then
				for i,v in next, workspace.Debris:GetChildren() do
					if v.Name == "Bullet" and Menu["Misc"]["Extra"]["Remove Bullet Holes"]["Toggle"]["Enabled"] then
						v:Destroy()
					end
				end
			end
		end)

		do
			local old = client.firebullet
			client.firebullet = function(...)
				if Menu.closed then
					return old(...)
				end
			end
		end
	end
	-- how about
	-- dn
	-- ?

	--ANCHOR Exploits
	do
		-- Killall
		exploits.killAll = {}
		exploits.crashmessages = {
			"🖥️🖥️🖥️ SERVER LOCKED 🔒🔒🔒",
			"🖥️🖥️🖥️ SERVER LOCKED BY BLOXSENSE 🔒🔒🔒",
			"☁️☁️☁️ SERVER SMOKED ☁️☁️☁️",
			"☁️☁️☁️ SERVER SMOKED BY BLOXSENSE ☁️☁️☁️",
			"🖥️🖥️🖥️ SERVER CLOSED 🔒🔒🔒",
			"👋👋👋 GOODBYE SERVER 👋👋👋",
			"👋👋👋 GOODBYE 👋👋👋",
			"🚨🚨🚨 SERVER GONE 🚨🚨🚨",
			"🚨🚨🚨 SERVER LOCKED 🚨🚨🚨",
			"🖥️🖥️ SERVER SMOKED 🖥️🖥️",
			"🖥️🖥️ SERVER SMOKED BY BLOXSENSE 🖥️🖥️",
			"😤😤😤 SERVER GONE 😤😤😤",
			"⚠️🚨 RIP SERVER 🚨⚠️",
			"🤤🤤 Ahh~ Its so Hard~  Its time to pleasure  Master~ 😭😭",
			"🤤🤤 Its time to pleasure  Master~",
			"🤤🤤 Time to milk master~ UwU~ 😝😝",
			"🤤🤤 Do you like this Master?~ 🤤🤤",
			"🚨⚠️🚨 SERVER CLOSED FOR MAINTENANCE 🚨⚠️🚨",
			"SERVER CLOSED BY BLOXSENSE",
			"🌱🌱 TIME TO TOUCH GRASS 🌱🌱",
			"Master gives me milk all day you wanna come with me?~ 😉😉",
			"🚨⚠️ SERVER CLOSED UNTIL FURTHER NOTICE ⚠️🚨",
			"🔒🔒🔒🔒 SERVER LOCKED 🔒🔒🔒🔒",
			"😭😭 NOOO DONT CRASH THE SERVER 😭😭",
			"⚠️ SERVER CLOSED ⚠️",
			"☁️☁️ SERVER JUST WENT UP IN SMOKE ☁️☁️",
			"*POOF* SERVER GONE *POOF*",
			"ඞ ඞ ඞ ඞ ඞ ඞ ඞ",
		}
		
		--[[function exploits.crashserver() -- 30 seconds
			local last = tick()
			if localPlayer.Status.Alive.Value then
				Library.UI:EventLog("Attempting to crash the server...", 32)
				runService.Stepped:Connect(function()
					for i, v in next, (playerInfo.storage) do
						local pInfo = v
						if pInfo.Alive then
							if pInfo.character:FindFirstChild("Gun"):FindFirstChild("Mag") then
								for i = 1, 15 do
									replicatedStorage.Events.DropMag:FireServer(pInfo.character.Gun.Mag)
								end
							end
						end
					end
					if localPlayer.Character:FindFirstChild("Gun"):FindFirstChild("Mag") then
						for i = 1, 15 do
							replicatedStorage.Events.DropMag:FireServer(localPlayer.Character.Gun.Mag)
						end
					end
				end)	
			end
		end]]
		--Menu["Misc"]["Exploits"]["Crash Server"]["Button"].Pressed:Connect(exploits.crashserver)
		
		--[[function exploits.crashserver() -- 30 seconds
			local coon = tick()
			runService.Stepped:Connect(function()
				local dudes = {}
				for i, v in next, players:GetPlayers() do
					if v ~= localPlayer and v.Character then
						dudes[1 + #dudes] = v
					end
				end

				if #dudes > 1 then
					for i = 1, 2 do
						local a = dudes[math.random(#dudes)].Character.Head.Position
						local b = dudes[math.random(#dudes)].Character.Head.Position
						game.ReplicatedStorage.Events.Trail:FireServer(a, b - a, {})
					end
				end
			end)
		end
		Menu["Misc"]["Exploits"]["Crash Server"]["Button"].Pressed:Connect(exploits.crashserver)]]

		runService.Stepped:Connect(function()
			if Menu["Misc"]["Extra"]["Kill All"]["Toggle"]["Enabled"] then
				for i, v in next, players:GetPlayers() do
					if v ~= localPlayer then
						local pInfo = playerInfo.storage[v]
						if pInfo and pInfo.alive and pInfo.head and localPlayer.Character and pInfo.enemy then 
							alive = true
						else
							alive = false
						end

						local fullpower = Menu["Misc"]["Extra"]["Kill All Type"]["Value"] == "HvH"
						if alive == true then
							local args = {

							}
							if fullpower then -- ??? helps???
								for i = 1, 200 do
									args[1 + #args] = "`"
									task.wait(0.78)
								end
							end
							game.ReplicatedStorage.Events.UpdatePing:FireServer(-0)
							hitPart:FireServer(
								v.Character.HumanoidRootPart,
								{X = 0/0, Y = 0/0, Z = 0/0},
								"G3SG1",	
								0,
								localPlayer.Character:FindFirstChild("Gun"),
								nil,
								4,
								false,
								false,
								newVector3(),
								0,
								newVector3(),
								true,
													nil, -- 14
						nil, -- 15
						nil, -- 16
						nil,-- 17
						nil,-- 18
						nil,-- 19
						nil,-- 20
						nil,-- 21
						nil,-- 22
						nil,-- 23
						nil,-- 24
	nil,--25
	nil--26
							)

							if Menu["Misc"]["Exploits"]["Shot players become mush"]["Toggle"]["Enabled"] then
								hitPart:FireServer(
									v.Character.HumanoidRootPart,
									{X = 0/0, Y = 0/0, Z = 0/0},
									"Multimeter",
									0,
									localPlayer.Character:FindFirstChild("Gun"),
									nil,
									4,
									false,
									false,
									Vector3.new(),
									0,
									Vector3.new(),
									true,
													nil, -- 14
						nil, -- 15
						nil, -- 16
						nil,-- 17
						nil,-- 18
						nil,-- 19
						nil,-- 20
						nil,-- 21
						nil,-- 22
						nil,-- 23
						nil, -- 24
	nil, --25
	nil -- 26
								)
							end
						end
					end
				end
			end
		end)
		runService.Stepped:Connect(function()
	if workspace.Status.Preparation.Value and Menu["Rage"]["Hitpart"]["Wait For Round Start"]["Toggle"]["Enabled"] then
		return
	end
	if Menu["Rage"]["Hitpart"]["Loop Kill"]["Toggle"]["Enabled"] then
		for i = 1, 100 do
			local targetPlayer = game:GetService("Players")[Menu["Rage"]["Hitpart"]["Player in Focus"]["Value"]]
			local target = targetPlayer.Character.HumanoidRootPart

			hitPart:FireServer(
				target,  
				{X = 0/0, Y = 0/0, Z = 0/0}, 
				not Menu["Rage"]["Settings"]["Custom Gun Icon"]["Toggle"]["Enabled"] and client.fgun.Name or Menu["Rage"]["Hitpart"]["Gun You Want To Change"]["Value"], -- 3,
				0,
				localPlayer.Character:FindFirstChild("Gun"),
				nil,
				math.huge,
				false,
				false,
				Vector3.new(),
				0,
				Vector3.new(),
				true,
				nil, -- 14
				nil, -- 15
				nil, -- 16
				nil, -- 17
				nil, -- 18
				nil, -- 19
				nil, -- 20
				nil, -- 21
				nil, -- 22
				nil, -- 23
				nil, -- 24
				nil, -- 25
				nil  -- 26
			)
			task.wait(0.6)
		end
	end
end)


		--[[function exploits.plantc4()
			if workspace.Map.Gamemode.Value == "defusal" and not workspace:FindFirstChild("C4") and localPlayer.Status.Alive.Value then
				UILibrary:EventLog("Planting the bomb...", 5)
				ragebot.manualhrp = true
				local connection = runService.Stepped:Connect(function()
					ragebot.realhrp.CFrame = workspace.Map.SpawnPoints.C4Plant.CFrame + newVector3(0, 1, 0)
					ragebot.realhrp.Velocity = emptyVec3
				end)
				task.wait(0.25)
				local plantedcf = Menu["Misc"]["Exploits"]["Plant Position"]["Value"] == "Void" and CFrame.new(0/0, 0/0, 0/0) or Menu["Misc"]["Exploits"]["Plant Position"]["Value"] == "Bombsite" and workspace.Map.SpawnPoints.C4Plant.CFrame or Menu["Misc"]["Exploits"]["Plant Position"]["Value"] == "Glitch" and ""
				replicatedStorage.Events.PlantC4:FireServer(plantedcf, "B")
				task.wait(0.25)
				ragebot.manualhrp = false
				connection:Disconnect()
			else
				UILibrary:EventLog("Cannot plant at this time", 5)
			end
		end
		Menu["Misc"]["Exploits"]["Instant Plant"]["Button"].Pressed:Connect(exploits.plantc4)

		function exploits.defusec4()
			if workspace.Map.Gamemode.Value == "defusal" and workspace:FindFirstChild("C4") and localPlayer.Status.Alive.Value and (workspace.C4.Handle.CFrame.p - localPlayer.Character.HumanoidRootPart.Position).Magnitude < 290 then 
				UILibrary:EventLog("Defusing...", 5)
				ragebot.manualhrp = true
				local connection = runService.Stepped:Connect(function()
					ragebot.realhrp.CFrame = workspace.C4.Handle.CFrame + newVector3(0, 1, 0)
					ragebot.realhrp.Velocity = emptyVec3
				end)
				task.wait(0.25)
				localPlayer.Backpack.PressDefuse:FireServer(workspace.C4)
				task.wait()
				localPlayer.Backpack.Defuse:FireServer(workspace.C4)
				task.wait(0.25)
				ragebot.manualhrp = false
				connection:Disconnect()
			else
				UILibrary:EventLog("Cannot defuse at this time", 5)
			end
		end
		Menu["Misc"]["Exploits"]["Instant Defuse"]["Button"].Pressed:Connect(exploits.defusec4)]]

		-- Fake Equip
			--[[function exploits.updateFakeEquip()
				-- !
				local isActive = Menu["Misc"]["Exploits"]["Fake Equip"]["Toggle"]["Enabled"]
				if isActive and localPlayer.Character then
					-- Set fake gun (WHY DOES INTERGER DEFINE SHIT AFTER FFS)
					local slot = Menu["Misc"]["Exploits"]["Fake Slot"]["Value"]
					local fakeGunName = (slot == "C4" and "C4") or (slot == "Primary" and getupvalue(client.usethatgun, 13)) or (slot == "Secondary" and getupvalue(client.usethatgun, 14)) or (slot == "Melee" and getupvalue(client.usethatgun, 15)) -- sadly im pretty sure this upvalue shit is the most reliable way to get the gun
					local fakeGun = findFirstChild(replicatedStorage.Weapons, fakeGunName)

					-- Check if its ya
					if fakeGun then
						replicatedStorage.Events.ApplyGun:FireServer(fakeGun, localPlayer)
					end
				end
			end
			Menu["Misc"]["Exploits"]["Fake Equip"]["Toggle"].Changed:Connect(exploits.updateFakeEquip)
			Menu["Misc"]["Exploits"]["Fake Slot"]["Dropdown"].Changed:Connect(exploits.updateFakeEquip)
		function exploits.god()
			if localPlayer and localPlayer.Character then
				if Menu["Misc"]["Exploits"]["God Mode Type"]["Value"] == "Hostage" then
					if localPlayer.Character:FindFirstChild("Hostage") then
						UILibrary:EventLog("You are already godded", 5)
					else
						local real = replicatedStorage.Weapons:FindFirstChild(client.fgun.Name)
						local fake = getprops(real)
						for i, v in next, real:GetChildren() do
							fake[v.Name] = v
						end
						fake.Model = replicatedStorage.Hostage.Hostage -- basically ur telling the game ur a hostage
						replicatedStorage.Events.ApplyGun:FireServer(tostring(fake), localPlayer, "this is funny")
						replicatedStorage.Events.ApplyGun:FireServer(tostring(real), localPlayer, "this is funny")
						repeat
							task.wait()
						until localPlayer.Character:FindFirstChild("Hostage")
						UILibrary:EventLog("You are godded and can kill others", 5)
					end
				else
					if localPlayer.Character.Humanoid.Health >= 0 then
						replicatedStorage.Events.FallDamage:FireServer(0/0)
						UILibrary:EventLog("You are godded but cannot kill others", 5)
					else
						UILibrary:EventLog("You are already godded", 5)
					end
				end
			else
				UILibrary:EventLog("You are not alive", 5)
			end	
		end
		Menu["Misc"]["Exploits"]["God Mode"]["Button"].Pressed:Connect(exploits.god)

		function exploits.cloneInstance(original: Instance): boolean
			-- Check if we can do it
			if localPlayer.Character and client.fgun then
				-- WOW! IPhone!!! WOW!!!!!
				local fakeGun = {}
				for i, v in next, client.fgun:GetChildren() do
					fakeGun[v.Name] = v
				end
				fakeGun.Model = original

				-- Fire the remote jeffery
				replicatedStorage.Events.ApplyGun:FireServer(fakeGun)
				return true
			end

			-- Faliure
			UILibrary:EventLog("Unable to grab player", 5)
			return false
		end
		function exploits.grabCharacter(character: Model): boolean
			if Menu["Misc"]["Exploits"]["Action"]["Value"] == "Hold" then
				-- Check if we are alive niggaaaaaaaaaaaa
				if localPlayer.Character and localPlayer.Character:FindFirstChild("Gun") then
					-- Don't want to mistake this for the real fake
					localPlayer.Character.Gun:Destroy()
					UILibrary:EventLog("Grabbed " .. character.Name, 5)
				else
					-- Do it
					UILibrary:EventLog("Unable to grab " .. character.Name, 5)
					return
				end
			end

			-- Check if it is able to be grabbered
			if character and character:FindFirstChild("UpperTorso") and exploits.cloneInstance(character.Head) then
				-- Cloned their UpperTorso!
				localPlayer.Character:WaitForChild("Gun"):WaitForChild("GunWeld")
				replicatedStorage.Events.DropMag:FireServer(localPlayer.Character.Gun)
				task.wait(((50 + game.Stats.PerformanceStats.Ping:GetValue()) * 2) / 1000)
				exploits.cloneInstance(workspace.Ray_Ignore)
				localPlayer.Character.Gun:Destroy()
				replicatedStorage.Events.ApplyGun:FireServer(client.fgun, localPlayer)
			end

			if Menu["Misc"]["Exploits"]["Action"]["Value"] == "Bring" then
				UILibrary:EventLog("Attempted to grab " .. character.Name, 5)
				return
			end

			-- Faliure
			return
		end
		local function grabCallback()
			-- El bruhino
			local playerName = Menu["Misc"]["Exploits"]["Player in Focus"]["Value"]
			local player = players:FindFirstChild(playerName)
			if player and player ~= localPlayer then
				if player.Character and player.Character:FindFirstChild("UpperTorso") then
					-- Grab that nn
					exploits.grabCharacter(player.Character)
				else
					UILibrary:EventLog(player.Name .. " is not alive at this time", 5)
				end
			else
				UILibrary:EventLog("Cannot grab yourself", 5)	
			end
		end

		Menu["Misc"]["Exploits"]["Apply action to focused player"]["Button"].Pressed:Connect(function()
			local action = Menu["Misc"]["Exploits"]["Action"]["Value"]
			local player = players:FindFirstChild(Menu["Misc"]["Exploits"]["Player in Focus"]["Value"])
			if player.Character and player.Character:FindFirstChild("Humanoid") then
				if action == "Hold" or action == "Bring" then
					grabCallback()
				elseif action == "Silent Kill" then
					replicatedStorage.Events.PlaySound:FireServer(player.Character, replicatedStorage.Hostage.Head)
				elseif action == "Desync" then
					replicatedStorage.Events.PlaySound:FireServer(player.Character, player.Character.PrimaryPart) 
				end
			else
				UILibrary:EventLog(player.Name .. " is not alive at this time", 5)
			end
		end)

		Menu["Misc"]["Exploits"]["Apply action to all players"]["Button"].Pressed:Connect(function()
			local action = Menu["Misc"]["Exploits"]["Action"]["Value"]
			local targets = {}
			for i, v in next, (players:GetPlayers()) do
				if v ~= localPlayer and v.Character and v.Character:FindFirstChild("UpperTorso") then
					targets[1 + #targets] = v
				end
			end
			for i, v in next, (targets) do
				if action == "Hold" or action == "Bring" then
					exploits.grabCharacter(v.Character)
					task.wait(((50 + game.Stats.PerformanceStats.Ping:GetValue()) * 2) / 1000) -- MAXIMUM SPEED!!!
				elseif action == "Silent Kill" then
					replicatedStorage.Events.PlaySound:FireServer(v.Character, replicatedStorage.Hostage.Head)
				elseif action == "Desync" then
					replicatedStorage.Events.PlaySound:FireServer(v.Character, v.Character.PrimaryPart)
				end
			end
		end)

		function exploits.blockvision()
			if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
				for i, v in next, (players:GetPlayers()) do
					if v ~= localPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
						local char = v.Character

						for i2, v2 in next, (char:GetChildren()) do
							if ragebot.hitmodifier[v2.Name] then
								replicatedStorage.Events.DropMag:FireServer(v2)
							end
						end
					end
				end
			end
		end

		function exploits.kickeveryone()
			local ragdollpiece
			for i, v in next, (players:GetPlayers()) do
				if v:FindFirstChild("Ragdoll") and v.Ragdoll:FindFirstChild("Head") then
					ragdollpiece = v.Ragdoll.Head
					break
				end
			end
			if ragdollpiece then
				for i, v in next, (players:GetPlayers()) do
					if v ~= localPlayer then
						if v.Character and v.Character:FindFirstChild("Humanoid") then
							replicatedStorage.Events.PlaySound:FireServer(v.Character, ragdollpiece)
						end
					end
				end
				replicatedStorage.Events.PlaySound:FireServer(game.StarterPlayer.StarterCharacter, ragdollpiece)
				repeat
					task.wait()
				until game.StarterPlayer.StarterCharacter:FindFirstChild("Head")
				UILibrary:EventLog("The next time someone will spawn, they will be kicked", 5)
			else
				UILibrary:EventLog("Cannot kick everyone at this time", 5)
			end
		end
		Menu["Misc"]["Exploits"]["Kick all players"]["Button"].Pressed:Connect(exploits.kickeveryone)		]]
	end

	--ANCHOR settings
	do
		menusettings.oldaccent = MenuParameters.UIcolors.Accent
		function menusettings.rgbtohsv(Color)
			local color = Color3.new(Color.R, Color.G, Color.B)
			local h, s, v = color:ToHSV()
			return h, s, v
		end

		function menusettings.updatecheattext()
			if Menu["Settings"]["Menu Settings"]["Custom Menu Name"]["Toggle"]["Enabled"] == true then
				Library.UI.CheatNameText.Text = Menu["Settings"]["Menu Settings"]["Custom Menu Name Text"]["Value"]
				Library.UI.Setwatermarkcheatname(Menu["Settings"]["Menu Settings"]["Custom Menu Name Text"]["Value"])
			else
				Library.UI.Setwatermarkcheatname(MenuParameters.CheatName)
				Library.UI.CheatNameText.Text = MenuParameters.CheatName
			end
		end
		Menu["Settings"]["Menu Settings"]["Custom Menu Name"]["Toggle"].Changed:Connect(menusettings.updatecheattext)
		Menu["Settings"]["Menu Settings"]["Custom Menu Name Text"].Changed:Connect(menusettings.updatecheattext)

		function menusettings.updatecheataccent()
			local newcolor = menusettings.oldaccent
			if Menu["Settings"]["Menu Settings"]["Menu Accent"]["Toggle"]["Enabled"] then
				newcolor = Menu["Settings"]["Menu Settings"]["Menu Accent"]["Color 1"]["Color"]
			end
			MenuParameters.UIcolors.Accent = newcolor
			for cf, c in next, (Library.Accents) do
				if c:IsA("UIGradient") then
					local Hue, Sat, Val = menusettings.rgbtohsv(newcolor)
					local color = newcolor
					c.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromHSV(Hue, Sat, Val)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(math.clamp(color.R * 255 - 40, 0, 255), math.clamp(color.G * 255 - 40, 0, 255), math.clamp(color.B * 255 - 40, 0, 255)))
					})
				elseif c:IsA("TextButton") and c.TextColor3 ~= MenuParameters.UIcolors.FullWhite then
					c.TextColor3 = newcolor
				else
					if c.BackgroundColor3 ~= MenuParameters.UIcolors.ColorD then
						c.BackgroundColor3 = newcolor
					end
				end	
			end
		end

		Menu["Settings"]["Menu Settings"]["Menu Accent"]["Toggle"].Changed:Connect(menusettings.updatecheataccent)
		Menu["Settings"]["Menu Settings"]["Menu Accent"]["Color 1"].Changed:Connect(menusettings.updatecheataccent)
	end

	cameraTasks.onCameraAdded()

	local LogService = game:GetService("LogService")
	LogService.MessageOut:Connect(function(message, messageType)
		if messageType == Enum.MessageType.MessageError and message:match("kicked") then
			runService.Stepped:Connect(function()
				game:GetService("GuiService"):ClearError()
			end)
			Library.UI:EventLog("You were kicked from the game for: " .. message, 15)
		end
	end)

	env.Hack.mathModule = mathModule
	env.Hack.timer = timer
	env.Hack.trajectory = trajectory
	env.Hack.ragebot = ragebot
	env.Hack.legitbot = legitbot
	env.Hack.misc = misc
	env.Hack.visuals = visuals
	env.Hack.movement = movement
	env.Hack.playerInfo = playerInfo
	env.Hack.raycastUtils = raycastUtils

	-- weird shit smei asked me to mak
	Library.UI:EventLog(string.format("Loaded in %s second(s)!", tostring(mathModule.truncateNumber(os.clock() - cheatLoadingStartTick, 3))), 5)
	UILibrary:Initialize()
	Library.UI:EventLog("Press INSERT or DELETE to open / close the Menu!", 5)
	Menu["Settings"]["Menu Settings"]["Watermark"]["Toggle"]["Enabled"] = true
	Menu["Settings"]["Menu Settings"]["Keybinds"]["Toggle"]["Enabled"] = false

	writefile("bloxsense/bloxsense_configs/" .. "off" .. ".cfg", UILibrary:SaveConfiguration()); 
	Menu["Settings"]["Configurations"]["Configs"].UpdateValues(getconfigs())
    
