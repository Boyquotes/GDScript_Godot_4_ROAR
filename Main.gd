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

# ------------------------------------------------------------------------------------------------
#                       Cross-Platform / M.I.T. Open-Source / Freeware
#              "Grand National GNX" v3 Godot Engine 4.x 2D Video Game Framework
# ------------------------------------------------------------------------------------------------
#                              ,----..                                                     
#       ,-.----.              /   /   \             ,---,               ,-.----.           
#       \    /  \            /   .     :           '  .' \              \    /  \          
#       ;   :    \          .   /   ;.  \         /  ;    '.            ;   :    \         
#       |   | .\ :         .   ;   /  ` ;        :  :       \           |   | .\ :         
#       .   : |: |         ;   |  ; \ ; |        :  |   /\   \          .   : |: |         
#       |   |  \ :         |   :  | ; | '        |  :  ' ;.   :         |   |  \ :         
#       |   : .  /         .   |  ' ' ' :        |  |  ;/  \   \        |   : .  /         
#       ;   | |  \         '   ;  \; /  |        '  :  | \  \ ,'        ;   | |  \         
#       |   | ;\  \         \   \  ',  /         |  |  '  '--'          |   | ;\  \        
#       :   ' | \.'  ___     ;   :    /    ___   |  :  :          ___   :   ' | \.'  ___   
#       :   : :-'   /  .\     \   \ .'    /  .\  |  | ,'         /  .\  :   : :-'   /  .\  
#       |   |.'     \  ; |     `---`      \  ; | `--''           \  ; | |   |.'     \  ; | 
#       `---'        `--"                  `--"                   `--"  `---'        `--"  
#                                                           TM
#                                 "R.O.A.R.: Raid On A River"
#
#                                    Pre-Alpha Design Phase
#
#          HTML5 Enabled Desktop/Laptop Internet Browsers & Android Smartphones/Tablets
#
#                        (C)opyright 2023 - Team "www.BetaMaxHeroes.org"
# ------------------------------------------------------------------------------------------------

extends Node2D

#----------------------------------------------------------------------------------------
func _ready():
	VisualsCore.SetFramesPerSecond(30)

	if (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
		VisualsCore.KeepAspectRatio = 0
	else:
		VisualsCore.KeepAspectRatio = 1

	DataCore.LoadOptionsAndHighScores()

	VisualsCore.SetFullScreenMode()

	randomize()

	LogicCore.SecretCodeCombined = 2777
	LogicCore.SecretCode[0] = 2
	LogicCore.SecretCode[1] = 7
	LogicCore.SecretCode[2] = 7
	LogicCore.SecretCode[3] = 7

	pass

#----------------------------------------------------------------------------------------
func _physics_process(_delta):

	ScreensCore.ProcessScreenToDisplay()

	pass

# A 110% By Team "BetaMax Heroes"!
