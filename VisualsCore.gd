# Copyright 2023 Team "www.BetaMaxHeroes.org"

# Permission is hereby granted, free of charge, to any person obtaining a copy of this software
# and associated documentation files (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
# BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# "VisualsCore.gd"
extends Node2D

var DEBUG = true

var FramesPerSecondArrayIndex = 0
var FramesPerSecondArray = []
var FramesPerSecondAverage = 0
var FramesPerSecondLastSecondTick = Time.get_ticks_msec()
var FramesPerSecondFrames = 0

class FPSClass:
	var TextImage = []
	var TextIndex = []
	var TextScreenX = []
	var TextScreenY = []
	var TextHorizontalJustification = []
	var TextSize = []
	var TextScaleX = []
	var TextScaleY = []
	var TextRotation = []
	var TextColorRed  = []
	var TextColorGreen = []
	var TextColorBlue = []
	var TextColorAlpha = []
	var TextOutlineRed = []
	var TextOutlineGreen = []
	var TextOutlineBlue = []
var FramesPerSecondText = FPSClass.new()

var ScreenWidth = 480
var ScreenHeight = 270

class SpriteClass:
	var ci_rid = []
	var SpriteImage = []
	var SpriteImageWidth = []
	var SpriteImageHeight = []
	var SpriteActive = []
	var SpriteScreenX = []
	var SpriteScreenY = []
	var SpriteScaleX = []
	var SpriteScaleY = []
	var SpriteRotation = []
	var SpriteColorRed = []
	var SpriteColorGreen = []
	var SpriteColorBlue = []
	var SpriteColorAlpha = []
var Sprites = SpriteClass.new()

var FontTTF = []

var TextIsUsed = []

var TextCurrentIndex;

class TextClass:
	var TextImage = []
	var TextIndex = []
	var TextScreenX = []
	var TextScreenY = []
	var TextHorizontalJustification = []
	var TextSize = []
	var TextScaleX = []
	var TextScaleY = []
	var TextRotation = []
	var TextColorRed  = []
	var TextColorGreen = []
	var TextColorBlue = []
	var TextColorAlpha = []
	var TextOutlineRed = []
	var TextOutlineGreen = []
	var TextOutlineBlue = []
var Texts = TextClass.new()

class AboutText:
	var AboutTextsText = []
	var AboutTextsBlue = []
var AboutTexts = AboutText.new()

var AboutTextsStartIndex
var AboutTextsEndIndex

var PieceSpriteCurrentIndex = []
var PlayfieldSpriteCurrentIndex = []

var KeyboardControlsAlphaTimer;

var KeepAspectRatio
var FullScreenMode

#----------------------------------------------------------------------------------------
func _ready():
	for _index in range(0, 10):
		FramesPerSecondArray.append(0)

	for _index in range(0, 20001):
		Sprites.ci_rid.append(-1)
		Sprites.ci_rid[_index] = RenderingServer.canvas_item_create()
		RenderingServer.canvas_item_set_parent(Sprites.ci_rid[_index], get_canvas_item())
		Sprites.SpriteImage.append(-1)
		Sprites.SpriteImageWidth.append(0)
		Sprites.SpriteImageHeight.append(0)
		Sprites.SpriteActive.append(false)
		Sprites.SpriteScreenX.append(-99999)
		Sprites.SpriteScreenY.append(-99999)
		Sprites.SpriteScaleX.append(1.0)
		Sprites.SpriteScaleY.append(1.0)
		Sprites.SpriteRotation.append(0)
		Sprites.SpriteColorRed.append(1.0)
		Sprites.SpriteColorGreen.append(1.0)
		Sprites.SpriteColorBlue.append(1.0)
		Sprites.SpriteColorAlpha.append(1.0)

	for _index in range(0, 1000):
		TextIsUsed.append(false)

	Sprites.SpriteImage[0] = load("res://media/images/backgrounds/FadingBlackBG.png")
	Sprites.SpriteActive[0] = true

	Sprites.SpriteImage[1] = load("res://media/images/backgrounds/FadingBlackBG.png")
	Sprites.SpriteActive[1] = true

	Sprites.SpriteImage[2] = load("res://media/images/backgrounds/FadingBlackBG.png")
	Sprites.SpriteActive[2] = true


	Sprites.SpriteImage[5] = load("res://media/images/logos/GodotLogo.png")
	Sprites.SpriteActive[5] = true

	Sprites.SpriteImage[7] = load("res://media/images/logos/BetaMaxHeroes_Logo.png")
	Sprites.SpriteActive[7] = true

	Sprites.SpriteImage[10] = load("res://media/images/backgrounds/TitleBG.png")
	Sprites.SpriteActive[10] = true
#
	Sprites.SpriteImage[15] = load("res://media/images/gui/Floppy_Disk.png")
	Sprites.SpriteActive[15] = true

	Sprites.SpriteImage[21] = load("res://media/images/logos/Logo.png")
	Sprites.SpriteActive[21] = true

	Sprites.SpriteImage[22] = load("res://media/images/logos/Logo.png")
	Sprites.SpriteActive[22] = true
#
	Sprites.SpriteImage[23] = load("res://media/images/backgrounds/TS1.png")
	Sprites.SpriteActive[23] = true

	for index in range(30, 40):
		Sprites.SpriteImage[index] = load("res://media/images/gui/ScreenLine.png")
		Sprites.SpriteActive[index] = true
#
	for index in range(40, 50):
		Sprites.SpriteImage[index] = load("res://media/images/gui/Button.png")
		Sprites.SpriteActive[index] = true
#
	Sprites.SpriteImage[50] = load("res://media/images/gui/ButtonSelectorLeft.png")
	Sprites.SpriteActive[50] = true
	Sprites.SpriteImage[51] = load("res://media/images/gui/ButtonSelectorRight.png")
	Sprites.SpriteActive[51] = true
#
	Sprites.SpriteImage[60] = load("res://media/images/gui/SelectorLine.png")
	Sprites.SpriteActive[60] = true

	for index in range(80, 100, 2):
		Sprites.SpriteImage[index] = load("res://media/images/gui/ButtonSelectorLeft.png")
		Sprites.SpriteActive[index] = true
		Sprites.SpriteImage[index+1] = load("res://media/images/gui/ButtonSelectorRight.png")
		Sprites.SpriteActive[index+1] = true

	Sprites.SpriteImage[180] = load("res://media/images/gui/Keyboard.png")
	Sprites.SpriteActive[180] = true
	Sprites.SpriteImage[181] = load("res://media/images/gui/MouseTouch.png")
	Sprites.SpriteActive[181] = true

	for index in range(0, 100):
		Sprites.SpriteImage[200+index] = load("res://media/images/gui/NameInputButton2.png")
		Sprites.SpriteActive[200+index] = true

	var _warnErase = PlayfieldSpriteCurrentIndex.resize(9)
	for index in range (0, 8):
		PlayfieldSpriteCurrentIndex[index] = 0

	_warnErase = PieceSpriteCurrentIndex.resize(9)
	for index in range (0, 9):
		PieceSpriteCurrentIndex[index] = 0

	for index in range(0, 20001):
		if Sprites.SpriteActive[index] == true:
			var sprite_size = Sprites.SpriteImage[index].get_size()
			Sprites.SpriteImageWidth[index] = sprite_size.x
			Sprites.SpriteImageHeight[index] = sprite_size.y
			RenderingServer.canvas_item_add_texture_rect(Sprites.ci_rid[index], Rect2(Vector2.ZERO, sprite_size), Sprites.SpriteImage[index])
			var xform = Transform2D().translated(Vector2(-99999 - sprite_size.x / 2.0, -99999 - sprite_size.y / 2.0))
			RenderingServer.canvas_item_set_transform(Sprites.ci_rid[index], xform)

			if (index == 0):
				RenderingServer.canvas_item_set_draw_index(Sprites.ci_rid[index], 500)
			elif (index == 1):
				RenderingServer.canvas_item_set_draw_index(Sprites.ci_rid[index], -24)
			elif (index == 2):
				RenderingServer.canvas_item_set_draw_index(Sprites.ci_rid[index], 10)
			elif (index > 4 && index < 8):
				RenderingServer.canvas_item_set_draw_index(Sprites.ci_rid[index], -25)
			elif (index > 9 && index < 12):
				RenderingServer.canvas_item_set_draw_index(Sprites.ci_rid[index], -25)
			elif (index > 39 && index < 52):
				RenderingServer.canvas_item_set_draw_index(Sprites.ci_rid[index], 0)
			elif (index == 60):
				RenderingServer.canvas_item_set_draw_index(Sprites.ci_rid[index], 250)
			elif (index > 79 && index < 100):
				RenderingServer.canvas_item_set_draw_index(Sprites.ci_rid[index], 251)

	FontTTF.append(-1)
	FontTTF[0] = load("res://media/fonts/game_over.ttf")#SectorMono-Normal.otf")
	FontTTF.append(-1)
	FontTTF[1] = load("res://media/fonts/Font_02.ttf")
	TextCurrentIndex = 0

	AboutTextsStartIndex = 0
	AboutTextsEndIndex = 0

	DrawSprite(0, VisualsCore.ScreenWidth/2.0, VisualsCore.ScreenHeight/2.0, 1.0, 1.0, 0, 1.0, 1.0, 1.0, 1.0)
	FramesPerSecondText.TextImage.append(RichTextLabel.new())
	add_child(FramesPerSecondText.TextImage[0])
	var fontToUseIndex = 1
	var fontSize = 12

	FramesPerSecondText.TextImage[0].text = "30/30"
	FramesPerSecondText.TextImage[0].set_use_bbcode(false)

	FramesPerSecondText.TextImage[0].clip_contents = false
	FramesPerSecondText.TextImage[0].add_theme_font_override("normal_font", FontTTF[fontToUseIndex])
	FramesPerSecondText.TextImage[0].add_theme_font_size_override("normal_font_size", fontSize)
	FramesPerSecondText.TextImage[0].add_theme_color_override("default_color", Color(1.0, 1.0, 1.0, 1.0))
	FramesPerSecondText.TextImage[0].add_theme_constant_override("outline_size", 8.0)
	FramesPerSecondText.TextImage[0].add_theme_color_override("font_outline_color", Color(0.2, 0.2, 0.2, 1.0))

	var textHeight = FramesPerSecondText.TextImage[0].get_theme_font("normal_font").get_string_size(FramesPerSecondText.TextImage[0].text).y

	FramesPerSecondText.TextImage[0].global_position.x = -5
	FramesPerSecondText.TextImage[0].global_position.y = VisualsCore.ScreenHeight - 20.0
	FramesPerSecondText.TextImage[0].set_size(Vector2(VisualsCore.ScreenWidth, VisualsCore.ScreenHeight), false)
#	FramesPerSecondText.TextImage[0].pivot_offset = Vector2((VisualsCore.ScreenWidth / 2.0), (textHeight / 2.0))
	FramesPerSecondText.TextImage[0].scale = Vector2(1.0, 1.0)
	FramesPerSecondText.TextImage[0].rotation = 0.0

	FullScreenMode = false

	pass

#----------------------------------------------------------------------------------------
func SetFramesPerSecond(fps):
#	Engine.max_fps = fps
	Engine.physics_ticks_per_second = fps

	pass

#----------------------------------------------------------------------------------------
func SetFullScreenMode():
	if (FullScreenMode == true):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN, 0)
	elif (FullScreenMode == false):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED, 0)

	pass

#----------------------------------------------------------------------------------------
# Godot Version 3.5 To 4.0 Beta 2+ Conversion By: "flairetic":
func SetScreenStretchMode():
	var window = get_tree().root 
	window.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
	if (VisualsCore.KeepAspectRatio == 1):
		window.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP_WIDTH
	elif (VisualsCore.KeepAspectRatio == 0):
		window.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_IGNORE

	pass
#                             Godot Version 3.5 To 4.0 Beta 2+ Conversion By: "flairetic"
#----------------------------------------------------------------------------------------
func MoveAllActiveSpritesOffScreen():
	for index in range(1, 20001):
		if Sprites.SpriteActive[index] == true:
			var sprite_size = Sprites.SpriteImage[index].get_size()
			RenderingServer.canvas_item_set_transform(Sprites.ci_rid[index], Transform2D().translated(Vector2(-99999 - sprite_size.x / 2.0, -99999 - sprite_size.y / 2.0)))

	pass

#----------------------------------------------------------------------------------------
func DrawSprite(index, x, y, scaleX, scaleY, rotation, red, green, blue, alpha):
	var sprite_size = Sprites.SpriteImage[index].get_size()
	sprite_size.x = sprite_size.x * scaleX
	sprite_size.y = sprite_size.y * scaleY
	var rot = rotation * (180/PI)
	RenderingServer.canvas_item_set_transform(Sprites.ci_rid[index], Transform2D(rot, Vector2(scaleX, scaleY), 0.0, Vector2(x - (sprite_size.x / 2.0), y - (sprite_size.y / 2.0))))
	RenderingServer.canvas_item_set_modulate(Sprites.ci_rid[index], Color(red, green, blue, alpha))

	Sprites.SpriteActive[index] = true
	Sprites.SpriteScreenX[index] = x
	Sprites.SpriteScreenY[index] = y
	Sprites.SpriteScaleX[index] = scaleX
	Sprites.SpriteScaleY[index] = scaleY
	Sprites.SpriteRotation[index] = rotation
	Sprites.SpriteColorRed[index] = red
	Sprites.SpriteColorGreen[index] = green
	Sprites.SpriteColorBlue[index] = blue
	Sprites.SpriteColorAlpha[index] = alpha

	pass

#----------------------------------------------------------------------------------------
func DeleteAllTexts():
	var size = (TextCurrentIndex - 1)

	for index in range(size, 9, -1):
		if (TextIsUsed[index] == true):
			remove_child(Texts.TextImage[index])

	for _index in range(0, TextCurrentIndex):
		TextIsUsed[_index] = false

	TextCurrentIndex = 10

	pass

#----------------------------------------------------------------------------------------
func DrawnTextChangeScaleRotation(index, scaleX, scaleY, rotations):
	Texts.TextImage[index].scale = Vector2(scaleX, scaleY)
	Texts.TextImage[index].rotation = rotations

	pass

#----------------------------------------------------------------------------------------
# Godot Version 3.5 To 4.0 Beta 2+ Conversion By: "flairetic"(Not 100%-I'll finish it):
func DrawText(index, text, x, y, horizontalJustification, fontSize, scaleX, scaleY, rotations, red, green, blue, alpha, outlineRed, outlineGreen, outlineBlue):
	if ( index > (TextCurrentIndex-1) ):
		Texts.TextImage.append(RichTextLabel.new())
		add_child(Texts.TextImage[index])

		TextIsUsed[index] = true

	# Below needs work
	var newTextDrawingOffsetY = 0
	var fontToUseIndex = 0
	if fontSize == 25:
		fontSize = 25-9+31
		fontToUseIndex = 0
		newTextDrawingOffsetY = 15.0
	elif fontSize == 26:
		fontSize = 26-3
		fontToUseIndex = 0
	elif fontSize == 27:
		fontSize = 26+10
		fontToUseIndex = 0
	elif fontSize == 60:
		fontToUseIndex = 0
		newTextDrawingOffsetY = 36.0
	elif fontSize == 35:
		fontToUseIndex = 0
	elif fontSize == 12:
		fontToUseIndex = 0
	elif fontSize == 22:
		fontSize = 22-9+31
		fontToUseIndex = 0
	elif fontSize == 34:
		fontToUseIndex = 1
		fontSize = 35
	elif fontSize == 23:
		fontToUseIndex = 1
		fontSize = 26-14
	elif fontSize == 13:
		fontToUseIndex = 1
		fontSize = 13
	elif fontSize == 100:
		fontToUseIndex = 0
		fontSize = 65
		newTextDrawingOffsetY = 80.0
	elif fontSize == 57:
		fontToUseIndex = 0
		fontSize = 40+3
	elif fontSize == 113:
		fontToUseIndex = 1
		fontSize = 40

	elif fontSize == 1012:
		fontSize = 25-9+15-3
		fontToUseIndex = 0
		newTextDrawingOffsetY = 15.0
	elif fontSize == 1013:
		fontSize = 25-9+15
		fontToUseIndex = 0
		newTextDrawingOffsetY = 15.0

	elif fontSize == 10000:
		fontSize = 150
		fontToUseIndex = 0
	elif fontSize == 10001:
		fontSize = 50
		fontToUseIndex = 0

	elif fontSize == 9999:
		fontSize = 15
		fontToUseIndex = 1

	var xValue = x

	if horizontalJustification == 0:
		Texts.TextImage[index].text = text
		Texts.TextImage[index].set_use_bbcode(false)
	elif horizontalJustification == 1:
		Texts.TextImage[index].text = "[center]"+text+"[/center]"
		Texts.TextImage[index].set_use_bbcode(true)
	elif horizontalJustification == 2:
		Texts.TextImage[index].text = "[right]"+text+"[/right]"
		Texts.TextImage[index].set_use_bbcode(true)
	elif horizontalJustification == 4:
		Texts.TextImage[index].text = text
		Texts.TextImage[index].set_use_bbcode(false)

		var textWidth = Texts.TextImage[index].get_theme_font("normal_font").get_string_size(Texts.TextImage[index].text).x
		xValue = x - (textWidth/2)

	Texts.TextImage[index].clip_contents = false
	Texts.TextImage[index].add_theme_font_override("normal_font", FontTTF[fontToUseIndex])
	Texts.TextImage[index].add_theme_font_size_override("normal_font_size", fontSize)
	Texts.TextImage[index].add_theme_color_override("default_color", Color(red, green, blue, alpha))
	Texts.TextImage[index].add_theme_constant_override("outline_size", 8.0)
	Texts.TextImage[index].add_theme_color_override("font_outline_color", Color(outlineRed, outlineGreen, outlineBlue, alpha)) 

	var textHeight = Texts.TextImage[index].get_theme_font("normal_font").get_string_size(Texts.TextImage[index].text).y

	Texts.TextImage[index].global_position.x = xValue#x
	Texts.TextImage[index].global_position.y = (y - newTextDrawingOffsetY)
	Texts.TextImage[index].set_size(Vector2(VisualsCore.ScreenWidth, VisualsCore.ScreenHeight), false)
	Texts.TextImage[index].pivot_offset = Vector2((VisualsCore.ScreenWidth / 2.0), (textHeight / 2.0))
	Texts.TextImage[index].scale = Vector2(scaleX, scaleY)
	Texts.TextImage[index].rotation = rotations

	Texts.TextIndex.append(index)
	Texts.TextScreenX.append(x)
	Texts.TextScreenY.append(y)
	Texts.TextHorizontalJustification.append(horizontalJustification)
	Texts.TextSize.append(fontSize)
	Texts.TextScaleX.append(scaleX)
	Texts.TextScaleY.append(scaleY)
	Texts.TextRotation.append(rotations)
	Texts.TextColorRed.append(red)
	Texts.TextColorGreen.append(green)
	Texts.TextColorBlue.append(blue)
	Texts.TextColorAlpha.append(alpha)
	Texts.TextOutlineRed.append(outlineRed)
	Texts.TextOutlineGreen.append(outlineGreen)
	Texts.TextOutlineBlue.append(outlineBlue)

	TextCurrentIndex+=1

	return(TextCurrentIndex-1)

#    Godot Version 3.5 To 4.0 Beta 2+ Conversion By: "flairetic"(Not 100%-I'll finish it)
#----------------------------------------------------------------------------------------
func AddAboutScreenText(text, blue):
	AboutTexts.AboutTextsText.append(text)
	AboutTexts.AboutTextsBlue.append(blue)

	AboutTextsEndIndex+=1

	pass

#----------------------------------------------------------------------------------------
func LoadAboutScreenTexts():
	AboutTextsStartIndex = 10
	AboutTextsEndIndex = AboutTextsStartIndex

	AddAboutScreenText("TM", 0.0)

	AddAboutScreenText(" ", 0.0)

	if (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		AddAboutScreenText("''R.O.A.R.: Raid On A River™''", 0.0)
	elif (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
		AddAboutScreenText("''T-Story 110%™''", 0.0)

	AddAboutScreenText("Copyright 2023 By:", 1.0)
	AddAboutScreenText("Team ''BetaMax Heroes''", 1.0)
	AddAboutScreenText("[www.BetaMaxHeroes.org]", 1.0)

	AddAboutScreenText("Original Concept By:", 0.0)
	AddAboutScreenText("Activision", 1.0)

	AddAboutScreenText("Video Game Made Possible By Our Mentors:", 0.0)
	AddAboutScreenText("Garry Kitchen", 1.0)
	AddAboutScreenText("Andre' LaMothe", 1.0)

	AddAboutScreenText("Made With 100% FREE:", 0.0)
	AddAboutScreenText("''Godot Game Engine''", 1.0)
	AddAboutScreenText(DataCore.GODOT_VERSION, 1.0)
	AddAboutScreenText("[www.GodotEngine.org]", 1.0)

	AddAboutScreenText("''Godot Game Engine'' Recommended By:", 0.0)
	AddAboutScreenText("''Yuri S.''", 1.0)

	AddAboutScreenText("Game Built On:", 0.0)
	AddAboutScreenText("Genuine ''Linux Mint 21.1 Cinnamon 64Bit'' Linux OS", 1.0)
	AddAboutScreenText("[www.LinuxMint.com]", 1.0)
	AddAboutScreenText("Real Programmers Use Linux!", 1.0)

	AddAboutScreenText("Project Produced By:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("Project Directed By:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("Godot 4.x 2-D Game Engine Framework:", 0.0)
	AddAboutScreenText("The ''Grand National GNX'' v3 Engine By:", 1.0)
	AddAboutScreenText("''JeZxLee''", 1.0)
	AddAboutScreenText("''flairetic''", 1.0)

	AddAboutScreenText("Graphics Core(Texts/Sprites) Ported & Turbocharged By:", 0.0)
	AddAboutScreenText("''flairetic''", 1.0)

	AddAboutScreenText("Engine Framework Performance Tested With:", 0.0)
	AddAboutScreenText("'' BES – Battle Encoder Shirase' ''", 1.0)
	AddAboutScreenText("[https://mion.yosei.fi/BES/]", 1.0)

	AddAboutScreenText("Lead Game Designer:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("Lead Game Programmer:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("Lead Game Tester:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("100% Arcade Perfect To Home Conversion By:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)
	AddAboutScreenText("[Original Atari 400/800 Version]", 1.0)

	AddAboutScreenText("Support Game Programmers:", 0.0)
	AddAboutScreenText("''flairetic''", 1.0)
	AddAboutScreenText("''EvanR''", 1.0)
	AddAboutScreenText("''Daotheman''", 1.0)
	AddAboutScreenText("''theweirdn8''", 1.0)
	AddAboutScreenText("''mattmatteh''", 1.0)

	AddAboutScreenText("Lead Graphic Artist:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("Support Graphic Artist:", 0.0)
	AddAboutScreenText("''Oshi Bobo''", 1.0)

	AddAboutScreenText("Music Soundtrack By:", 0.0)
	AddAboutScreenText("''YouTube Music''", 1.0)
	AddAboutScreenText("[www.YouTube.com]", 1.0)

	AddAboutScreenText("Title Music:", 0.0)
	AddAboutScreenText("Commodore 64 ''Platoon'' Title Screen Music Cover By:", 1.0)
	AddAboutScreenText("''CZ Tunes''", 1.0)
	AddAboutScreenText("(Original Music By: Jonathan Dunn)", 1.0)
	AddAboutScreenText("Music promoted by https://YouTube.com", 1.0)

	AddAboutScreenText("Music Soundtrack Compiled & Edited By:", 0.0)
	AddAboutScreenText("''D.J. Fading Twilight''", 1.0)

	AddAboutScreenText("Sound Effects Compiled & Edited By:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("''Neo's Kiss'' Graphical User Interface By:", 0.0)
	AddAboutScreenText("''JeZxLee''", 1.0)

	AddAboutScreenText("PNG Graphics Edited In:", 0.0)
	AddAboutScreenText("''PixelNEO''", 1.0)
	AddAboutScreenText("[https://VisualNEO.com/product/pixelneo]", 1.0)
	AddAboutScreenText("- Free Linux Alternative: ''Krita'' -", 1.0)

	AddAboutScreenText("PNG Graphics Optimized Using:", 0.0)
	AddAboutScreenText("''TinyPNG''", 1.0)
	AddAboutScreenText("[www.TinyPNG.com]", 1.0)

	AddAboutScreenText("OGG Audio Edited In:", 0.0)
	AddAboutScreenText("''GoldWave''", 1.0)
	AddAboutScreenText("[www.GoldWave.com]", 1.0)
	AddAboutScreenText("- Free Linux Alternative: ''Audacity'' -", 1.0)

	AddAboutScreenText("OGG Audio Optimized Using:", 0.0)
	AddAboutScreenText("''OGGResizer''", 1.0)
	AddAboutScreenText("[www.SkyShape.com]", 1.0)

	AddAboutScreenText("''R.O.A.R.'' Title Logo Created In:", 0.0)
	AddAboutScreenText("Genuine Microsoft Office 365 Publisher", 1.0)
	AddAboutScreenText("[www.Office.com]", 1.0)

	AddAboutScreenText("Game Created On A:", 0.0)
	AddAboutScreenText("Hyper-Custom ''JeZxLee'' Pro-Built Desktop", 1.0)

	AddAboutScreenText("Desktop Code Name: ''Megatron''", 1.0)
	AddAboutScreenText("Build Date: June 11th, 2022", 1.0)
	AddAboutScreenText("Genuine ''Linux Mint 21.1 Cinnamon 64Bit'' Linux OS", 1.0)
	AddAboutScreenText("Silverstone Tek ATX Mid Tower Case", 1.0)
	AddAboutScreenText("EVGA Supernova 650 GT 80 Plus Gold 650W Power Supply", 1.0)
	AddAboutScreenText("ASUS AM4 TUF Gaming X570-Plus [Wi-Fi] Motherboard", 1.0)
	AddAboutScreenText("AMD Ryzen 7 5800X[4.7GHz Turbo] 8-Core CPU", 1.0)
	AddAboutScreenText("Noctua NH-U12S chromax.Black 120mm CPU Cooler", 1.0)
	AddAboutScreenText("Corsair Vengeance LPX 32GB DDR4 3200MHz RAM Memory", 1.0)
	AddAboutScreenText("MSI Gaming nVidia GeForce RTX 3060 12GB GDDR6 OC GPU", 1.0)
	AddAboutScreenText("SAMSUNG 980 PRO 2TB PCIe NVMe Gen 4 M.2 Drive", 1.0)
	AddAboutScreenText("Seagate FireCuda 4TB 3.5 Inch Hard Drive", 1.0)

	AddAboutScreenText("Game Tested On A:", 0.0)
	AddAboutScreenText("SFF Thin Client Desktop", 1.0)
	AddAboutScreenText("Desktop Code Name: ''Bumblebee''", 1.0)
	AddAboutScreenText("Genuine Windows 11 Pro 64Bit OS", 1.0)
	AddAboutScreenText("Proprietary SFF Case", 1.0)
	AddAboutScreenText("Proprietary 65W Power Supply", 1.0)
	AddAboutScreenText("Proprietary AMD Motherboard", 1.0)
	AddAboutScreenText("AMD Ryzen 5 5600U[4.2Ghz Turbo] 6-Core CPU", 1.0)
	AddAboutScreenText("Proprietary CPU Cooler", 1.0)
	AddAboutScreenText("Crucial 32GB DDR4L 3200MHz RAM Memory", 1.0)
	AddAboutScreenText("AMD Radeon RX Vega 7 8GB DDR4L GPU", 1.0)
	AddAboutScreenText("500GB PCIe NVMe Gen 3 M.2 Drive", 1.0)

	AddAboutScreenText("HTML5 Version Tested On:", 0.0)
	AddAboutScreenText("Mozilla Firefox", 1.0)
	AddAboutScreenText("Google Chrome", 1.0)
	AddAboutScreenText("Opera", 1.0)
	AddAboutScreenText("Microsoft Edge", 1.0)
	AddAboutScreenText("[?Working?]Apple macOS Safari[?Working?]", 1.0)

	AddAboutScreenText("Android Version Tested On:", 0.0)
	AddAboutScreenText("Samsung® Galaxy S23 Ultra Smartphone", 1.0)
	AddAboutScreenText("Teclast® TPAD Tablet", 1.0)

	AddAboutScreenText("Big Thank You To People Who Helped Us:", 0.0)
	AddAboutScreenText("''Yuri S.''", 1.0)
	AddAboutScreenText("''TwistedTwigleg''", 1.0)
	AddAboutScreenText("''Megalomaniak''", 1.0)
	AddAboutScreenText("''SIsilicon28''", 1.0)
	AddAboutScreenText("''vimino''", 1.0)
	AddAboutScreenText("( : ''PurpleConditioner'' : )", 1.0)
	AddAboutScreenText("''Kequc''", 1.0)
	AddAboutScreenText("''qeed''", 1.0)
	AddAboutScreenText("''Calinou''", 1.0)
	AddAboutScreenText("''Sosasees''", 1.0)
	AddAboutScreenText("''ArRay_''", 1.0)
	AddAboutScreenText("''blast007''", 1.0)
	AddAboutScreenText("''fogobogo''", 1.0)
	AddAboutScreenText("''CYBEREALITY''", 1.0)
	AddAboutScreenText("''Perodactyl''", 1.0)
	AddAboutScreenText("''floatcomplex''", 1.0)
	AddAboutScreenText("''DaveTheCoder''", 1.0)
	AddAboutScreenText("''Dominus''", 1.0)
	AddAboutScreenText("''lawnjelly''", 1.0)
	AddAboutScreenText("''EvanR''", 1.0)
	AddAboutScreenText("''Zelta''", 1.0)
	AddAboutScreenText("''slidercrank''", 1.0)
	AddAboutScreenText("''epicspaces''", 1.0)
	AddAboutScreenText("''powersnap55''", 1.0)
	AddAboutScreenText("''cybereality''", 1.0)
	AddAboutScreenText("''Unforgiven''", 1.0)
	AddAboutScreenText("''Neil Kenneth David''", 1.0)
	AddAboutScreenText("''gioele''", 1.0)
	AddAboutScreenText("''TatBou''", 1.0)
	AddAboutScreenText("''fire7side''", 1.0)
	AddAboutScreenText("''YaroslavFox''", 1.0)
	AddAboutScreenText("''Erich_L''", 1.0)
	AddAboutScreenText("''Zoinkers''", 1.0)
	AddAboutScreenText("''Sanne''", 1.0)
	AddAboutScreenText("''circuitbone''", 1.0)
	AddAboutScreenText("''duane''", 1.0)	
	AddAboutScreenText("''Pixophir''", 1.0)
	AddAboutScreenText("''Zireael''", 1.0)
	AddAboutScreenText("''Kojack''", 1.0)
	AddAboutScreenText("''akien-mga''", 1.0)
	AddAboutScreenText("''Valedict''", 1.0)
	AddAboutScreenText("''Aliencodex''", 1.0)
	AddAboutScreenText("''leonardus''", 1.0)
	AddAboutScreenText("''Donitz''", 1.0)
	AddAboutScreenText("''furrykef''", 1.0)
	AddAboutScreenText("''Remi Verschelde''", 1.0)
	AddAboutScreenText("''Xananax''", 1.0)
	AddAboutScreenText("''Adam Scott''", 1.0)
	AddAboutScreenText("''sslcon[m]''", 1.0)
	AddAboutScreenText("''TheRookie''", 1.0)
	AddAboutScreenText("''CuffLimbs''", 1.0)
	AddAboutScreenText("''zleap''", 1.0)
	AddAboutScreenText("''Z-cat''", 1.0)

	AddAboutScreenText(" ", 1.0)
	AddAboutScreenText("''You!''", 1.0)

	AddAboutScreenText("A 110% By Team ''BetaMax Heroes''!", 0.0)
	AddAboutScreenText(" ", 1.0)

	DrawText(AboutTextsStartIndex, AboutTexts.AboutTextsText[AboutTextsStartIndex], ((ScreenWidth/2.0)+100.0), ScreenHeight+25, 0, 25, 1.0, 1.0, 0, 1.0, 1.0, AboutTexts.AboutTextsBlue[AboutTextsStartIndex-10], 0.0, 0.0, 0.0, 0.0)

	var screenY = ScreenHeight+5
	for index in range(AboutTextsStartIndex+1, AboutTextsEndIndex):
		if (AboutTexts.AboutTextsBlue[index-10] == 1.0 && AboutTexts.AboutTextsBlue[index-1-10] == 0.0):
			screenY+=30
		elif (AboutTexts.AboutTextsBlue[index-10] == 1.0 && AboutTexts.AboutTextsBlue[index-1-10] == 1.0):
			screenY+=30
		else:
			screenY+=80

		var fontSize = 9999

		DrawText(index, AboutTexts.AboutTextsText[index-10], 0, screenY, 1, fontSize, 1.0, 1.0, 0, 1.0, 1.0, AboutTexts.AboutTextsBlue[index-10], 1.0, 0.0, 0.0, 0.0)

	Texts.TextImage[AboutTextsEndIndex-2].global_position.y+=(ScreenHeight/2.0)
	Texts.TextImage[AboutTextsEndIndex-1].global_position.y+=(ScreenHeight/2.0)

	pass
