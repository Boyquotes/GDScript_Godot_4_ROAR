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

# NOTE: Below is from our last game - it will be modified soon for new game

# "LogicCore.gd"
extends Node2D

var Version = "Pre-Alpha"

const ChildMode				= 0
const TeenMode				= 1
const AdultMode				= 2
const TurboMode				= 3

var GameMode = AdultMode

var AllowComputerPlayers = 1

var PieceOverlap = false

var GameSpeed = 30

var SecretCode = []
var SecretCodeCombined = 0

var Level

var PieceData = []

var Playfield = []
var PlayfieldMoveAI = []

var Piece = [];

var PieceBagIndex = []
var PieceBag = []
var PieceSelectedAlready = []

var NextPiece = []

const Current			= 0
const Next				= 1
const DropShadow		= 2
const Temp				= 3
const Fallen			= 4

var PieceRotation = []
var PiecePlayfieldX = []
var PiecePlayfieldY = []

const CollisionNotTrue			= 0
const CollisionWithPlayfield	= 1
const CollisionWithPiece		= 3

var PieceDropTimer = []
var TimeToDropPiece = []

const GameOver 					= -1
const NewPieceDropping 			= 0
const PieceFalling 				= 1
const FlashingCompletedLines 	= 2
const ClearingCompletedLines 	= 3
const ClearingPlayfield 		= 4
var PlayerStatus = []

var PAUSEgame = false
var PauseWasJustPressed = false

var PieceDropStartHeight = []

var PieceBagFirstUse = []

var PieceMovementDelay = []

var PieceRotatedOne = []
var PieceRotatedTwo = []

var PieceRotatedUp = []

var FlashCompletedLinesTimer
var ClearCompletedLinesTimer

var PlayfieldAlpha
var PlayfieldAlphaDir

var BoardFlip

var Score = []
var ScoreChanged

var DropBonus = []

var DrawEverything
var PieceMoved

var AndroidMovePieceDownDelay = []
var AndroidMovePieceDownPressed = []
var AndroidMovePieceLeftDelay = []
var AndroidMovePieceRightDelay = []

var PlayerInput = []

var PlayersCanJoinIn

var Player

var MovePieceCollision = []
var MovePieceHeight = []
var MoveTrappedHoles = []
var MoveOneBlockCavernHoles = []
var MovePlayfieldBoxEdges = []
var MoveCompletedLines = []

var MoveBumpiness = []

var MoveTotalHeight = []

var BestMoveX = []
var BestRotation = []
var MovedToBestMove = []

var MaxRotationArray = []

var CPUPlayerMovementSkip = []

const CPUForcedFree			= 0
const CPUForcedLeft			= 1
const CPUForcedRight		= 2
var CPUPlayerForcedDirection = []
var CPUPlayerForcedMinX = []
var CPUPlayerForcedMaxX = []

var CPUPieceTestX = []
var CPURotationTest = []
var CPUComputedBestMove = []

var pTXStep = []
var bestValue = []

var TotalLines
var LevelCleared

var GameWon

var AddRandomBlocksToBottomTimer

var PlayfieldBackup = []

var StillPlaying

var ScoreOneText
var ScoreTwoText
var ScoreThreeText
var LinesLeftText

var MouseTouchRotateDir

var PieceInPlayfieldMemory = []

var PieceLandedResetAI = false

var CurrentProcessedAIPlayer

var PlayfieldNew = []

var MousePlayerStarted

var SkipComputerPlayerMove = []

var HumanPlayerOneHeight
var HumanPlayerOneHeightOld

var SkipOLD

var ComputerPlayersTotalLevelClears
var ComputerPlayersTotalGamesPlayed
var ComputerPlayersAverageLevelClearsText

#----------------------------------------------------------------------------------------
func InitializePieceData():
	var _warnErase = PieceData.resize(8)
	for piece in range(8):
		PieceData[piece] = []
		PieceData[piece].resize(5)
		for rotations in range(5):
			PieceData[piece][rotations] = []
			PieceData[piece][rotations].resize(17)

	for piece in range(8):
		for rotations in range(5):
			for box in range(17):
				PieceData[piece][rotations][box] = 0

	# RED "S" Piece
	PieceData [1] [1] [10] = 1 # 01 02 03 04
	PieceData [1] [1] [11] = 1 # 05 06 07 08
	PieceData [1] [1] [13] = 1 # 09 [] [] 12
	PieceData [1] [1] [14] = 1 # [] [] 15 16

	PieceData [1] [2] [ 5] = 1
	PieceData [1] [2] [ 9] = 1
	PieceData [1] [2] [10] = 1
	PieceData [1] [2] [14] = 1

	PieceData [1] [3] [10] = 1
	PieceData [1] [3] [11] = 1
	PieceData [1] [3] [13] = 1
	PieceData [1] [3] [14] = 1

	PieceData [1] [4] [ 5] = 1
	PieceData [1] [4] [ 9] = 1
	PieceData [1] [4] [10] = 1
	PieceData [1] [4] [14] = 1

	# ORANGE "Z" Piece
	PieceData [2] [1] [ 9] = 1
	PieceData [2] [1] [10] = 1
	PieceData [2] [1] [14] = 1
	PieceData [2] [1] [15] = 1

	PieceData [2] [2] [ 6] = 1
	PieceData [2] [2] [ 9] = 1
	PieceData [2] [2] [10] = 1
	PieceData [2] [2] [13] = 1

	PieceData [2] [3] [ 9] = 1
	PieceData [2] [3] [10] = 1
	PieceData [2] [3] [14] = 1
	PieceData [2] [3] [15] = 1

	PieceData [2] [4] [ 6] = 1
	PieceData [2] [4] [ 9] = 1
	PieceData [2] [4] [10] = 1
	PieceData [2] [4] [13] = 1

	# AQUA "T" Piece
	PieceData [3] [1] [ 9] = 1
	PieceData [3] [1] [10] = 1
	PieceData [3] [1] [11] = 1
	PieceData [3] [1] [14] = 1

	PieceData [3] [2] [ 6] = 1
	PieceData [3] [2] [ 9] = 1
	PieceData [3] [2] [10] = 1
	PieceData [3] [2] [14] = 1

	PieceData [3] [3] [ 6] = 1
	PieceData [3] [3] [ 9] = 1
	PieceData [3] [3] [10] = 1
	PieceData [3] [3] [11] = 1

	PieceData [3] [4] [ 6] = 1
	PieceData [3] [4] [10] = 1
	PieceData [3] [4] [11] = 1
	PieceData [3] [4] [14] = 1

	# YELLOW "L" Piece
	PieceData [4] [1] [ 9] = 1
	PieceData [4] [1] [10] = 1
	PieceData [4] [1] [11] = 1
	PieceData [4] [1] [13] = 1

	PieceData [4] [2] [ 5] = 1
	PieceData [4] [2] [ 6] = 1
	PieceData [4] [2] [10] = 1
	PieceData [4] [2] [14] = 1

	PieceData [4] [3] [ 7] = 1
	PieceData [4] [3] [ 9] = 1
	PieceData [4] [3] [10] = 1
	PieceData [4] [3] [11] = 1

	PieceData [4] [4] [ 6] = 1
	PieceData [4] [4] [10] = 1
	PieceData [4] [4] [14] = 1
	PieceData [4] [4] [15] = 1

	# GREEN "Backwards L" Piece
	PieceData [5] [1] [ 9] = 1
	PieceData [5] [1] [10] = 1
	PieceData [5] [1] [11] = 1
	PieceData [5] [1] [15] = 1

	PieceData [5] [2] [ 6] = 1
	PieceData [5] [2] [10] = 1
	PieceData [5] [2] [13] = 1
	PieceData [5] [2] [14] = 1

	PieceData [5] [3] [ 5] = 1
	PieceData [5] [3] [ 9] = 1
	PieceData [5] [3] [10] = 1
	PieceData [5] [3] [11] = 1

	PieceData [5] [4] [ 6] = 1
	PieceData [5] [4] [ 7] = 1
	PieceData [5] [4] [10] = 1
	PieceData [5] [4] [14] = 1

	# BLUE "Box" Piece
	PieceData [6] [1] [10] = 1
	PieceData [6] [1] [11] = 1
	PieceData [6] [1] [14] = 1
	PieceData [6] [1] [15] = 1

	PieceData [6] [2] [10] = 1
	PieceData [6] [2] [11] = 1
	PieceData [6] [2] [14] = 1
	PieceData [6] [2] [15] = 1

	PieceData [6] [3] [10] = 1
	PieceData [6] [3] [11] = 1
	PieceData [6] [3] [14] = 1
	PieceData [6] [3] [15] = 1

	PieceData [6] [4] [10] = 1
	PieceData [6] [4] [11] = 1
	PieceData [6] [4] [14] = 1
	PieceData [6] [4] [15] = 1

	# PURPLE "Line" Piece
	PieceData [7] [1] [ 9] = 1
	PieceData [7] [1] [10] = 1
	PieceData [7] [1] [11] = 1
	PieceData [7] [1] [12] = 1

	PieceData [7] [2] [ 2] = 1
	PieceData [7] [2] [ 6] = 1
	PieceData [7] [2] [10] = 1
	PieceData [7] [2] [14] = 1

	PieceData [7] [3] [ 9] = 1
	PieceData [7] [3] [10] = 1
	PieceData [7] [3] [11] = 1
	PieceData [7] [3] [12] = 1

	PieceData [7] [4] [ 2] = 1
	PieceData [7] [4] [ 6] = 1
	PieceData [7] [4] [10] = 1
	PieceData [7] [4] [14] = 1

	pass

#----------------------------------------------------------------------------------------
func ClearNewPlayfieldsWithCollisionDetection():
	for player in range(3):
		for y in range(26):
			for x in range(15):
				PlayfieldNew[player][x][y] = 255 # Collision detection value

		for y in range(2, 5, 1):
			for x in range(5, 9, 1):
				PlayfieldNew[player][x][y] = 0

		for y in range(5, 24, 1):
			for x in range(2, 12, 1):
				PlayfieldNew[player][x][y] = 0

	pass

#----------------------------------------------------------------------------------------
func ClearPlayfieldWithCollisionDetection():
	for x in range(0, 35):
		for y in range(0, 26):
			Playfield[x][y] = 255

	for x in range(2, 32):
		for y in range(4, 24):
			Playfield[x][y] = 0

	for x in range(5, 9):
		for y in range(0, 4):
			Playfield[x][y] = 0

	for x in range(15, 19):
		for y in range(0, 4):
			Playfield[x][y] = 0

	for x in range(25, 29):
		for y in range(0, 4):
			Playfield[x][y] = 0

	if (LogicCore.SecretCodeCombined == 8888):
		for x in range(2, 31):
			for y in range(9, 24):
				Playfield[x][y] = 30 + ( (randi() % 7) + 1 )

	pass

#----------------------------------------------------------------------------------------
func FillPieceBag(player):
	var done = false

	PieceBagIndex[player] = 1
	for index in range (0, 8):
		PieceBag[player][0][index] = -1
		PieceSelectedAlready[player][index] = false

	if PieceBagFirstUse[player] == true:
		PieceBagFirstUse[player] = false

		PieceBag[player][0][1] = ( (randi() % 7) + 1 )
		Piece[player] = PieceBag[player][0][1]
		PieceSelectedAlready[player][ PieceBag[player][0][1] ] = true
	else:
		PieceBag[player][0][1] = PieceBag[player][0][8]
		Piece[player] = PieceBag[player][0][1]
		PieceSelectedAlready[player][ PieceBag[player][0][1] ] = true

	while done == false:
		for x in range(2, 8):
			var randomPieceToTry = ( (randi() % 7) + 1 )
			while PieceSelectedAlready[player][randomPieceToTry] == true:
				randomPieceToTry = ( (randi() % 7) + 1 )

			PieceBag[player][0][x] = randomPieceToTry
			PieceSelectedAlready[player][randomPieceToTry] = true

			if x == 7:
				done = true
				x = 777

	PieceBag[player][0][8] = ( (randi() % 7) + 1 )

	if (SecretCodeCombined == 2778 or SecretCodeCombined == 8888):
		Piece[0] = 7
		NextPiece[0] = 7
		for index in range(0, 9):
			PieceBag[0][0][index] = 7
			PieceBag[0][1][index] = 7
		Piece[1] = 7
		NextPiece[1] = 7
		for index in range(0, 9):
			PieceBag[1][0][index] = 7
			PieceBag[1][1][index] = 7
		Piece[2] = 7
		NextPiece[2] = 7
		for index in range(0, 9):
			PieceBag[2][0][index] = 7
			PieceBag[2][1][index] = 7

	pass

#----------------------------------------------------------------------------------------
func ReadHumanPlayerOneHeight():
	var PiecePlayfieldMinX
	PiecePlayfieldMinX = 12 - 2

	var PiecePlayfieldMaxX
	PiecePlayfieldMaxX = (12+10)

	HumanPlayerOneHeight = 23
	for posX in range(PiecePlayfieldMinX, PiecePlayfieldMaxX):
		for posYtwo in range(23, 5, -1):
			if ( (Playfield[posX][posYtwo] > 29 && Playfield[posX][posYtwo] < 39) ):
				HumanPlayerOneHeight = posYtwo

	pass

#----------------------------------------------------------------------------------------
func SetupForNewGame():
	ClearNewPlayfieldsWithCollisionDetection()
	ClearPlayfieldWithCollisionDetection()

	PieceLandedResetAI = false

	for player in range(0, 3):
		PieceBagFirstUse[player] = true
		FillPieceBag(player)
		NextPiece[player] = PieceBag[player][0][2]

		PieceRotation[player] = 1

		PieceDropTimer[player] = 0
		TimeToDropPiece[player] = 47

		PieceRotatedOne[player] = false
		PieceRotatedTwo[player] = false

		PieceRotatedUp[player] = false

		Score[player] = 0

		DropBonus[player] = 0

		AndroidMovePieceDownDelay[player] = 0
		AndroidMovePieceDownPressed[player] = false
		AndroidMovePieceLeftDelay[player] = 0
		AndroidMovePieceRightDelay[player] = 0

		BestMoveX[player] = -1
		BestRotation[player] = -1
		MovedToBestMove[player] = false

		PieceMovementDelay[player] = 0

		CPUPlayerMovementSkip[player] = 0

		CPUPlayerForcedDirection[player] = CPUForcedFree
		CPUPlayerForcedMinX[player] = 0
		CPUPlayerForcedMaxX[player] = 31

		CPUPieceTestX[player] = 0
		CPURotationTest[player] = 1
		CPUComputedBestMove[player] = false

		pTXStep[player] = 1

		CPUPieceTestX[player] = 0

		bestValue[player] = 99999

		CPUPieceTestX[player] = PiecePlayfieldX[player]

		PieceInPlayfieldMemory[player] = false

		SkipComputerPlayerMove[player] = 0

	ScoreChanged = true

	PieceOverlap = false

	Level = 1

	PiecePlayfieldX[0] = 5
	PiecePlayfieldY[0] = 0

	PiecePlayfieldX[1] = 15
	PiecePlayfieldY[1] = 0

	PiecePlayfieldX[2] = 25
	PiecePlayfieldY[2] = 0

	for index in range (0, 9):
		VisualsCore.PlayfieldSpriteCurrentIndex[index] = 0

	for index in range (0, 8):
		VisualsCore.PieceSpriteCurrentIndex[index] = 0

	PlayerStatus[0] = GameOver
	PlayerStatus[1] = NewPieceDropping
	PlayerStatus[2] = GameOver

	PAUSEgame = false

	VisualsCore.KeyboardControlsAlphaTimer = 1.0

	FlashCompletedLinesTimer = 0
	ClearCompletedLinesTimer = 0

	PlayfieldAlpha = 1
	PlayfieldAlphaDir = 0

	BoardFlip = 0

	DrawEverything = 1
	PieceMoved = 1

	for index in range(0, 4):
		InterfaceCore.Icons.IconAnimationTimer[index] = -1

	PlayersCanJoinIn = true

	if (AllowComputerPlayers == 2):
		PlayerStatus[0] = NewPieceDropping
		PlayerStatus[1] = NewPieceDropping
		PlayerStatus[2] = NewPieceDropping
		PlayerInput[0] = InputCore.InputCPU
		PlayerInput[1] = InputCore.InputCPU
		PlayerInput[2] = InputCore.InputCPU
		PlayersCanJoinIn = false
	elif (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		PlayerInput[0] = InputCore.InputNone
		PlayerInput[1] = InputCore.InputKeyboard
		PlayerInput[2] = InputCore.InputNone
	else:
		PlayerInput[0] = InputCore.InputNone
		PlayerInput[1] = InputCore.InputTouchOne
		PlayerInput[2] = InputCore.InputNone

	TotalLines = 0
	LevelCleared = false

	GameWon = false

	AddRandomBlocksToBottomTimer = 0

	StillPlaying = true

	if (SecretCodeCombined == 6161):
		PlayerStatus[0] = NewPieceDropping
		PlayerStatus[1] = NewPieceDropping
		PlayerStatus[2] = NewPieceDropping
		PlayerInput[0] = InputCore.InputJoyOne
		PlayerInput[1] = InputCore.InputKeyboard
		PlayerInput[2] = InputCore.InputMouse

		PlayersCanJoinIn = false

		Score[0] = 1257465
		Score[1] = 1166456
		Score[2] = 1299665

		Level = 8

		Piece[0] = 7
		PieceRotation[0] = 2
		Piece[1] = 7
		Piece[2] = 7

		for x in range(2, 31):
			for y in range(20, 24):
				Playfield[x][y] = 30 + ( (randi() % 7) + 1 )

		for y in range(20, 24):
			Playfield[6][y] = 0

		for y in range(20, 24):
			Playfield[6+7][y] = 0
	elif (SecretCodeCombined == 2778):
		for x in range(4, 30):
			for y in range(20, 24):
				Playfield[x][y] = 30 + ( (randi() % 7) + 1 )

	for pIndex in range(0, 3):
		if (PlayerStatus[pIndex] == NewPieceDropping):
			AddCurrentPieceToPlayfieldMemory(pIndex, Temp)

	CurrentProcessedAIPlayer = 0

	MousePlayerStarted = false

	if (SecretCodeCombined == 3777):
		for x in range(3, 32):
			for y in range(20-4, 24):
				Playfield[x][y] = 30 + ( (randi() % 7) + 1 )

		for x in range(3, 12):
			for y in range(20-4, 24):
				PlayfieldNew[0][x][y] = 30 + ( (randi() % 7) + 1 )

		for x in range(2, 12):
			for y in range(20-4, 24):
				PlayfieldNew[1][x][y] = 30 + ( (randi() % 7) + 1 )

		for x in range(2, 12):
			for y in range(20-4, 24):
				PlayfieldNew[2][x][y] = 30 + ( (randi() % 7) + 1 )

	HumanPlayerOneHeight = 23
	HumanPlayerOneHeightOld = 23

	SkipOLD = 3

	if (ScreensCore.OperatingSys == ScreensCore.OSHTMLFive):
		if (InputCore.HTML5input == InputCore.InputMouse):
			PlayerInput[1] = InputCore.InputMouse
			MousePlayerStarted = true
			PlayersCanJoinIn = false

			PlayerStatus[0] = NewPieceDropping
			PlayerStatus[2] = NewPieceDropping
			PlayerInput[0] = InputCore.InputCPU
			PlayerInput[2] = InputCore.InputCPU

	if (SecretCodeCombined == 8889):
		PlayerStatus[0] = NewPieceDropping
		PlayerStatus[1] = NewPieceDropping
		PlayerStatus[2] = NewPieceDropping
		PlayerInput[0] = InputCore.InputCPU
		PlayerInput[1] = InputCore.InputCPU
		PlayerInput[2] = InputCore.InputCPU

	pass

#----------------------------------------------------------------------------------------
func PieceCollisionCPU(player):
	var box = 1
	var returnValue = CollisionNotTrue

	var adjustedPiecePlayfieldX = PiecePlayfieldX[player]
	if (player == 0):  adjustedPiecePlayfieldX -= 0
	elif (player == 1):  adjustedPiecePlayfieldX -= 10
	elif (player == 2):  adjustedPiecePlayfieldX -= 20

	var finalPlayfieldX
	for y in range(0, 4):
		for x in range(0, 4):
			finalPlayfieldX = (adjustedPiecePlayfieldX + x)
			if ( (PlayfieldNew[player][finalPlayfieldX][ PiecePlayfieldY[player] + y ] == 255)
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0) ):
				returnValue = CollisionWithPlayfield

			box+=1

	box = 1

	for y in range(0, 4):
		for x in range(0, 4):
			if (   (  ( (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] > 0)
			&& (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] < 40) )
			|| (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] == 255)
			|| (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] == 99999)  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPlayfield

			box+=1

	return(returnValue)

	pass

#----------------------------------------------------------------------------------------
func PieceCollisionNew(player):
	var box = 1
	var returnValue = CollisionNotTrue

	for y in range(0, 4):
		for x in range(0, 4):
			if (   (  ( (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] > 0)
			&& (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] < 40) )
			|| (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] == 255)
			|| (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] == 99999)  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPlayfield

			box+=1

	box = 1
	if (returnValue == CollisionWithPlayfield):
		return(returnValue)

	for y in range(0, 4):
		for x in range(0, 4):
			if (   (  ( (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] > 1000)
			&& (Playfield[ PiecePlayfieldX[player] + x ][ PiecePlayfieldY[player] + y ] < 1010) )  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPiece

			box+=1

	return(returnValue)

#----------------------------------------------------------------------------------------
func PieceCollision(player):
	var box = 1
	var returnValue = CollisionNotTrue

	var adjustedPiecePlayfieldX = PiecePlayfieldX[player]
	if (player == 0):  adjustedPiecePlayfieldX -= 0
	if (player == 1):  adjustedPiecePlayfieldX -= 10
	if (player == 2):  adjustedPiecePlayfieldX -= 20

	for y in range(0, 4):
		for x in range(0, 4):
			if (   (  ( (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] > 0)
			&& (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] < 40) )
			|| (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] == 255)
			|| (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] == 99999)  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPlayfield

			box+=1

	box = 1
	if (returnValue == CollisionWithPlayfield):
		return(returnValue)

	return(returnValue)

#----------------------------------------------------------------------------------------
func PieceCollisionDown(player):
	var box = 1
	var returnValue = CollisionNotTrue

	var adjustedPiecePlayfieldX = PiecePlayfieldX[player]
	if (player == 0):  adjustedPiecePlayfieldX -= 0
	if (player == 1):  adjustedPiecePlayfieldX -= 10
	if (player == 2):  adjustedPiecePlayfieldX -= 20

	for y in range(1, 5):
		for x in range(0, 4):
			if (   (  ( (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] > 0)
			&& (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] < 40) )
			|| (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] == 255)
			|| (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] == 99999)  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPlayfield

			box+=1

	box = 1
	if (returnValue == CollisionWithPlayfield):
		return(returnValue)

	return(returnValue)

#----------------------------------------------------------------------------------------
func PieceCollisionLeft(player):
	var box = 1
	var returnValue = CollisionNotTrue

	var adjustedPiecePlayfieldX = PiecePlayfieldX[player]
	if (player == 0):  adjustedPiecePlayfieldX -= 0
	if (player == 1):  adjustedPiecePlayfieldX -= 10
	if (player == 2):  adjustedPiecePlayfieldX -= 20

	for y in range(0, 4):
		for x in range(-1, 3):
			if (   (  ( (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] > 0)
			&& (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] < 40) )
			|| (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] == 255)
			|| (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] == 99999)  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPlayfield

			box+=1

	box = 1
	if (returnValue == CollisionWithPlayfield):
		return(returnValue)

	return(returnValue)

#----------------------------------------------------------------------------------------
func PieceCollisionRight(player):
	var box = 1
	var returnValue = CollisionNotTrue

	var adjustedPiecePlayfieldX = PiecePlayfieldX[player]
	if (player == 0):  adjustedPiecePlayfieldX -= 0
	if (player == 1):  adjustedPiecePlayfieldX -= 10
	if (player == 2):  adjustedPiecePlayfieldX -= 20

	for y in range(0, 4):
		for x in range(1, 5):
			if (   (  ( (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] > 0)
			&& (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] < 40) )
			|| (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] == 255)
			|| (PlayfieldNew[player][ adjustedPiecePlayfieldX + x ][ PiecePlayfieldY[player] + y ] == 99999)  )
			&& (PieceData [Piece[player]] [PieceRotation[player]] [box] > 0)   ):
				returnValue = CollisionWithPlayfield

			box+=1

	box = 1
	if (returnValue == CollisionWithPlayfield):
		return(returnValue)

	return(returnValue)

#----------------------------------------------------------------------------------------
func CheckForCompletedLines(player):
	var numberOfCompletedLines = 0

	DrawEverything = 1

	AddCurrentPieceToPlayfieldMemory(player, Fallen)

	if player == 0:  PiecePlayfieldX[player] = 5
	elif player == 1:  PiecePlayfieldX[player] = 15
	elif player == 2:  PiecePlayfieldX[player] = 25
	PiecePlayfieldY[player] = 0

	for y in range(4, 24):
		var boxTotal = 0

		for x in range (2, 32):
			if (Playfield[x][y] > 30 && Playfield[x][y] < 40):
				boxTotal+=1

		if (boxTotal == 30):

			numberOfCompletedLines+=1

	if (numberOfCompletedLines > 0):
		if (numberOfCompletedLines == 1):
			Score[player] += (40 * (Level+1))
			if (SecretCodeCombined != 2778):  TotalLines+=1
		elif (numberOfCompletedLines == 2):
			Score[player] += (100 * (Level+1))
			if (SecretCodeCombined != 2778):  TotalLines+=2
		elif (numberOfCompletedLines == 3):
			Score[player] += (300 * (Level+1))
			if (SecretCodeCombined != 2778):  TotalLines+=3
		elif (numberOfCompletedLines == 4):
			Score[player] += (1200 * (Level+1))
			if (SecretCodeCombined != 2778):  TotalLines+=4
			AudioCore.PlayEffect(6)
		ScoreChanged = true

		for y in range(4, 24):
			for x in range(2, 32):
				PlayfieldBackup[x][y] = Playfield[x][y]

		PlayerStatus[player] = FlashingCompletedLines
		FlashCompletedLinesTimer = 0
	else:
		SetupNewPiece(player)

	pass

#----------------------------------------------------------------------------------------
func FlashCompletedLines(player):
	var _numberOfCompletedLines = 0

	if (FlashCompletedLinesTimer < 21):
		FlashCompletedLinesTimer+=1

	for y in range (4, 24):
		var boxTotal = 0

		for x in range (2, 32):
			if (Playfield[x][y] > 30 && Playfield[x][y] < 40):
				boxTotal+=1
			elif (Playfield[x][y] == 99999):
				boxTotal+=1

		if (boxTotal == 30):
			DrawEverything = 1
			_numberOfCompletedLines+=1

			if (FlashCompletedLinesTimer % 2 == 0):
				for xTwo in range (2, 32):
					Playfield[xTwo][y] = 99999
			else:
				for yThree in range(4, 24):
					for xThree in range(2, 32):
						Playfield[xThree][yThree] = PlayfieldBackup[xThree][yThree]

	if FlashCompletedLinesTimer == 21:
		PlayerStatus[player] = ClearingCompletedLines
		ClearCompletedLinesTimer = 0

	pass

#----------------------------------------------------------------------------------------
func ClearCompletedLines(player):
	var thereWasACompletedLine = false

	for pIndex in range(0, 3):
		if (PlayerStatus[pIndex] == PieceFalling):
			if (player != pIndex):
				DeleteCurrentPieceFromPlayfieldMemory(pIndex, Temp)

	for y in range (4, 24):
		var boxTotal = 0

		for x in range (2, 32):
			if (Playfield[x][y] > 30 && Playfield[x][y] < 40):
				boxTotal+=1

		if boxTotal == 30:
			thereWasACompletedLine = true

			DrawEverything = 1

			if ClearCompletedLinesTimer < 40:
				ClearCompletedLinesTimer+=1

			if ClearCompletedLinesTimer % 10 == 0:
				for yTwo in range (y, 5, -1):
					for xTwo in range (2, 32):
						if (Playfield[xTwo][yTwo-1] < 1000 or Playfield[xTwo][yTwo-1] > 1009):  Playfield[xTwo][yTwo] = Playfield[xTwo][yTwo-1]

				for playerIndex in range(3):
					for yTwo in range(y, 5, -1):
						for xTwo in range(2, 12):
							if (PlayfieldNew[playerIndex][xTwo][yTwo-1] < 1000 or PlayfieldNew[playerIndex][xTwo][yTwo-1] > 1009):  PlayfieldNew[playerIndex][xTwo][yTwo] = PlayfieldNew[playerIndex][xTwo][yTwo-1]

				for xTwo in range (2, 32):
					Playfield[xTwo][4] = 0

				for playerIndex in range(3):
					for x in range(2, 12):
						PlayfieldNew[playerIndex][x][4] = 0

				AudioCore.PlayEffect(5)

	if thereWasACompletedLine == false:
		DrawEverything = 1
		SetupNewPiece(player)
		PlayerStatus[player] = NewPieceDropping

	pass

#----------------------------------------------------------------------------------------
func MovePieceDown(player, _force):
	if (InputCore.DelayAllUserInput > -1):
		return

	PieceMoved = 1

	PiecePlayfieldY[player]+=1

	if PieceCollision(player) == CollisionWithPlayfield:
		if (PlayersCanJoinIn == true && AllowComputerPlayers < 2):
			var iconIndex = 4
			if (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
				iconIndex = 8

			PlayersCanJoinIn = false
			InterfaceCore.Icons.IconScreenX[iconIndex+1] = -9999
			InterfaceCore.Icons.IconScreenY[iconIndex+1] = -9999

			if (AllowComputerPlayers > 0):
				PlayerInput[0] = InputCore.InputCPU
				PlayerStatus[0] = NewPieceDropping

				if (PlayerStatus[2] == GameOver):
					PlayerInput[2] = InputCore.InputCPU
					PlayerStatus[2] = NewPieceDropping

		PiecePlayfieldY[player]-=1

		AudioCore.PlayEffect(4)

		Score[player]+=DropBonus[player]
		ScoreChanged = true
		DropBonus[player] = 0

		if PlayerStatus[player] == NewPieceDropping:
			AddCurrentPieceToPlayfieldMemory(player, Current)
			PlayerStatus[player] = GameOver
		else:
			CheckForCompletedLines(player)
	pass

#----------------------------------------------------------------------------------------
func MovePieceLeft(player):
	PieceMoved = 1

	if PlayerStatus[player] == NewPieceDropping:  return

	if (PlayerInput[player] == InputCore.InputCPU):
		PiecePlayfieldX[player]-=1

		if (PieceCollisionCPU(player) == CollisionWithPlayfield):
			PiecePlayfieldX[player]+=1
	elif (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		if PieceMovementDelay[player] > -6:
			PieceMovementDelay[player]-=1

		if (PieceMovementDelay[player] == -1 || PieceMovementDelay[player] < -5):
			PiecePlayfieldX[player]-=1

		if (PieceCollision(player) == CollisionWithPlayfield):
			PiecePlayfieldX[player]+=1
	elif (PlayerInput[player] != InputCore.InputCPU):
		if (AndroidMovePieceLeftDelay[player] == 1 || AndroidMovePieceLeftDelay[player] == 1+5 || AndroidMovePieceLeftDelay[player] == 6+4 || AndroidMovePieceLeftDelay[player] == 10+3 || AndroidMovePieceLeftDelay[player] > 10+4):
			PiecePlayfieldX[player]-=1

		if (PieceCollision(player) == CollisionWithPlayfield || PieceCollision(player) == CollisionWithPiece):
			PiecePlayfieldX[player]+=1

	pass

#----------------------------------------------------------------------------------------
func MovePieceRight(player):
	PieceMoved = 1

	if PlayerStatus[player] == NewPieceDropping:  return

	if (PlayerInput[player] == InputCore.InputCPU):
		PiecePlayfieldX[player]+=1

		if (PieceCollisionCPU(player) == CollisionWithPlayfield):
			PiecePlayfieldX[player]-=1
	elif (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		if PieceMovementDelay[player] < 6:
			PieceMovementDelay[player]+=1

		if (PieceMovementDelay[player] == 1 || PieceMovementDelay[player] > 5):
			PiecePlayfieldX[player]+=1

		if (PieceCollision(player) == CollisionWithPlayfield):
			PiecePlayfieldX[player]-=1
	elif (PlayerInput[player] != InputCore.InputCPU):
		if (AndroidMovePieceRightDelay[player] == 1 || AndroidMovePieceRightDelay[player] == 1+5 || AndroidMovePieceRightDelay[player] == 6+4 || AndroidMovePieceRightDelay[player] == 10+3 || AndroidMovePieceRightDelay[player] > 10+4):
			PiecePlayfieldX[player]+=1

		if (PieceCollision(player) == CollisionWithPlayfield || PieceCollision(player) == CollisionWithPiece):
			PiecePlayfieldX[player]-=1

	pass

#----------------------------------------------------------------------------------------
func RotatePieceCounterClockwise(player):
	if PlayerStatus[player] == NewPieceDropping:  return

	if PieceRotation[player] > 1:
		PieceRotation[player]-=1
	else:
		PieceRotation[player] = 4

	if PieceCollision(player) == CollisionNotTrue:
		AudioCore.PlayEffect(2)
		PieceMoved = 1
		return(true)
	else:
		if PieceRotation[player] < 4:
			PieceRotation[player]+=1
		else:
			PieceRotation[player] = 1

		if (MouseTouchRotateDir == 0):  MouseTouchRotateDir = 1
		else:  MouseTouchRotateDir = 0

	return(false)

#----------------------------------------------------------------------------------------
func RotatePieceClockwise(player):
	if PlayerStatus[player] == NewPieceDropping:  return

	if PieceRotation[player] < 4:
		PieceRotation[player]+=1
	else:
		PieceRotation[player] = 1

	if PieceCollision(player) == CollisionNotTrue:
		AudioCore.PlayEffect(2)
		PieceMoved = 1
		return(true)
	else:
		if PieceRotation[player] > 1:
			PieceRotation[player]-=1
		else:
			PieceRotation[player] = 4

		if (MouseTouchRotateDir == 0):  MouseTouchRotateDir = 1
		else:  MouseTouchRotateDir = 0

	return(false)

#----------------------------------------------------------------------------------------
func SetupNewPiece(player):
	AndroidMovePieceDownDelay[player] = 0
	AndroidMovePieceDownPressed[player] = false
	AndroidMovePieceLeftDelay[player] = 0
	AndroidMovePieceRightDelay[player] = 0

	PieceRotation[player] = 1

	if player == 0:
		PiecePlayfieldX[player] = 5
	elif player == 1:
		PiecePlayfieldX[player] = 15
	elif player == 2:
		PiecePlayfieldX[player] = 25

	PiecePlayfieldY[player] = 0

	if PieceBagIndex[player] < 7:
		PieceBagIndex[player]+=1
		Piece[player] = (PieceBag[player][0][ PieceBagIndex[player] ])
		NextPiece[player] = PieceBag[player][0][ PieceBagIndex[player] + 1 ]
	elif PieceBagIndex[player] == 7:
		FillPieceBag(player)
		Piece[player] = PieceBag[player][0][1]
		NextPiece[player] = PieceBag[player][0][2]
		PieceBagIndex[player] = 1

	PlayerStatus[player] = NewPieceDropping

	PieceDropTimer[player] = 0

	PieceRotatedOne[player] = false
	PieceRotatedTwo[player] = false

	PieceRotatedUp[player] = false

	BestMoveX[player] = -1
	BestRotation[player] = -1
	MovedToBestMove[player] = false

	CPUPlayerMovementSkip[player] = 0

	CPUPlayerForcedDirection[player] = CPUForcedFree
	CPUPlayerForcedMinX[player] = 0
	CPUPlayerForcedMaxX[player] = 31

	CPUPieceTestX[player] = 0
	CPURotationTest[player] = 1
	CPUComputedBestMove[player] = false

	pTXStep[player] = 1

	CPUPieceTestX[player] = 0

	bestValue[player] = 99999

	BestMoveX[player] = -1
	BestRotation[player] = -1

	CPUPieceTestX[player] = PiecePlayfieldX[player]

	PieceLandedResetAI = true

	AddCurrentPieceToPlayfieldMemory(player, Temp)

	SkipComputerPlayerMove[player] = 0

	pass

#----------------------------------------------------------------------------------------
func SetupForNewLevel():
	if (Level == 1 or SecretCodeCombined == 6161):
		return

	ClearNewPlayfieldsWithCollisionDetection()
	ClearPlayfieldWithCollisionDetection()

	PieceLandedResetAI = false

	for player in range(0, 3):
		PieceBagFirstUse[player] = true
		FillPieceBag(player)
		NextPiece[player] = PieceBag[player][0][2]

		PieceRotation[player] = 1

		PieceDropTimer[player] = 0
		TimeToDropPiece[player] = 47

		PieceRotatedOne[player] = false
		PieceRotatedTwo[player] = false

		PieceRotatedUp[player] = false

		DropBonus[player] = 0

		AndroidMovePieceDownDelay[player] = 0
		AndroidMovePieceDownPressed[player] = false
		AndroidMovePieceLeftDelay[player] = 0
		AndroidMovePieceRightDelay[player] = 0

		BestMoveX[player] = -1
		BestRotation[player] = -1
		MovedToBestMove[player] = false

		PieceMovementDelay[player] = 0

		CPUPlayerMovementSkip[player] = 0

		CPUPlayerForcedDirection[player] = CPUForcedFree
		CPUPlayerForcedMinX[player] = 0
		CPUPlayerForcedMaxX[player] = 31

		CPUPieceTestX[player] = 0
		CPURotationTest[player] = 1
		CPUComputedBestMove[player] = false

		pTXStep[player] = 1

		CPUPieceTestX[player] = 0

		bestValue[player] = 99999

		CPUPieceTestX[player] = PiecePlayfieldX[player]

		PieceInPlayfieldMemory[player] = false

		SkipComputerPlayerMove[player] = 0

		PlayerStatus[player] = NewPieceDropping

	ScoreChanged = true

	PiecePlayfieldX[0] = 5
	PiecePlayfieldY[0] = 0

	PiecePlayfieldX[1] = 15
	PiecePlayfieldY[1] = 0

	PiecePlayfieldX[2] = 25
	PiecePlayfieldY[2] = 0

	for index in range (0, 9):
		VisualsCore.PlayfieldSpriteCurrentIndex[index] = 0

	for index in range (0, 8):
		VisualsCore.PieceSpriteCurrentIndex[index] = 0

	PAUSEgame = false

	VisualsCore.KeyboardControlsAlphaTimer = 0.0

	FlashCompletedLinesTimer = 0
	ClearCompletedLinesTimer = 0

	PlayfieldAlpha = 1
	PlayfieldAlphaDir = 0

	BoardFlip = 0

	DrawEverything = 1

	for index in range(0, 4):
		InterfaceCore.Icons.IconAnimationTimer[index] = -1

	PlayersCanJoinIn = false

	TotalLines = 0
	LevelCleared = false

	AddRandomBlocksToBottomTimer = 0

	pass

#----------------------------------------------------------------------------------------
func AddCurrentPieceToPlayfieldMemoryNew(player, pieceValue):
	if (pieceValue == Temp):
		if (PieceInPlayfieldMemory[player] == true):  return(false)

	var value

	var tempPiece = Piece[player]
	var tempX = PiecePlayfieldX[player]
	var tempY = PiecePlayfieldY[player]
	var tempRot = PieceRotation[player]

	var adjustedPiecePlayfieldX = PiecePlayfieldX[player]
	if (player == 0):  adjustedPiecePlayfieldX -= 0
	if (player == 1):  adjustedPiecePlayfieldX -= 10
	if (player == 2):  adjustedPiecePlayfieldX -= 20

	if (pieceValue == Fallen):
		value = (Piece[player] + 30)
	elif (pieceValue) == Temp:
		value = (Piece[player] + 1000)
	elif (pieceValue == Next):
		value = (NextPiece[player] + 10)

		DrawEverything = 1
		Piece[player] = NextPiece[player]
		PieceRotation[player] = 1

		if player == 0:
			PiecePlayfieldX[player] = 5
		elif player == 1:
			PiecePlayfieldX[player] = 15
		elif player == 2:
			PiecePlayfieldX[player] = 25

		PiecePlayfieldY[player] = 0
	elif (pieceValue == DropShadow && PlayerStatus[player] == PieceFalling):
		value = 2000
		for y in range(PiecePlayfieldY[player], 23):
			PiecePlayfieldY[player] = y
			if PieceCollision(player) != CollisionNotTrue:
				if (y - tempY) > 4:
					PiecePlayfieldY[player] = y-1
					break
				else:
					Piece[player] = tempPiece
					PiecePlayfieldX[player] = tempX
					PiecePlayfieldY[player] = tempY
					PieceRotation[player] = tempRot
					return

	if PieceData [Piece[player]] [PieceRotation[player]] [ 1] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 2] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 3] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 4] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [ 5] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 6] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 7] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 8] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+1] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [ 9] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [10] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [11] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [12] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+2] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [13] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [14] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [15] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [16] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+3] = value

	Piece[player] = tempPiece
	PiecePlayfieldX[player] = tempX
	PiecePlayfieldY[player] = tempY
	PieceRotation[player] = tempRot

	if (pieceValue == Temp):
		PieceInPlayfieldMemory[player] = true

	return(true)

#----------------------------------------------------------------------------------------
func DeleteCurrentPieceFromPlayfieldMemoryNew(player, pieceValue):
	if (pieceValue == Temp):
		if (PieceInPlayfieldMemory[player] == false):  return(false)

	var tempPiece = Piece[player]
	var tempX = PiecePlayfieldX[player]
	var tempY = PiecePlayfieldY[player]
	var tempRot = PieceRotation[player]

	var adjustedPiecePlayfieldX = PiecePlayfieldX[player]
	if (player == 0):  adjustedPiecePlayfieldX -= 0
	if (player == 1):  adjustedPiecePlayfieldX -= 10
	if (player == 2):  adjustedPiecePlayfieldX -= 20

	if (pieceValue == Next):
		DrawEverything = 1
		Piece[player] = NextPiece[player]
		PieceRotation[player] = 1

		if player == 0:
			PiecePlayfieldX[player] = 5
		elif player == 1:
			PiecePlayfieldX[player] = 15
		elif player == 2:
			PiecePlayfieldX[player] = 25

		PiecePlayfieldY[player] = 0
	elif (pieceValue == DropShadow && PlayerStatus[player] == PieceFalling):
		for y in range(PiecePlayfieldY[player], 23):
			PiecePlayfieldY[player] = y
			if PieceCollision(player) != CollisionNotTrue:
				if (y - tempY) > 4:
					PiecePlayfieldY[player] = y-1
					break
				else:
					Piece[player] = tempPiece
					PiecePlayfieldX[player] = tempX
					PiecePlayfieldY[player] = tempY
					PieceRotation[player] = tempRot
					return

	if PieceData [Piece[player]] [PieceRotation[player]] [ 1] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 2] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 3] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 4] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [ 5] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 6] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 7] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 8] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+1] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [ 9] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [10] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [11] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [12] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+2] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [13] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [14] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [15] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [16] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+3] = 0

	Piece[player] = tempPiece
	PiecePlayfieldX[player] = tempX
	PiecePlayfieldY[player] = tempY
	PieceRotation[player] = tempRot

	if (pieceValue == Temp):
		PieceInPlayfieldMemory[player] = false

	return(true)

#----------------------------------------------------------------------------------------
func AddCurrentPieceToPlayfieldMemory(player, pieceValue):
	if (pieceValue == Temp):
		if (PieceInPlayfieldMemory[player] == true):  return(false)

	var value

	var tempPiece = Piece[player]
	var tempX = PiecePlayfieldX[player]
	var tempY = PiecePlayfieldY[player]
	var tempRot = PieceRotation[player]

	var adjustedPiecePlayfieldX = PiecePlayfieldX[player]
#	if (player == 0):  adjustedPiecePlayfieldX -= 0
	if (player == 1):  adjustedPiecePlayfieldX -= 10
	elif (player == 2):  adjustedPiecePlayfieldX -= 20

	if (pieceValue == Fallen):
		value = (Piece[player] + 30)
	elif (pieceValue) == Temp:
		value = (Piece[player] + 1000)
	elif (pieceValue == Next):
		value = (NextPiece[player] + 10)

		DrawEverything = 1
		Piece[player] = NextPiece[player]
		PieceRotation[player] = 1

		if player == 0:
			PiecePlayfieldX[player] = 5
		elif player == 1:
			PiecePlayfieldX[player] = 15
		elif player == 2:
			PiecePlayfieldX[player] = 25

		PiecePlayfieldY[player] = 0
	elif (pieceValue == DropShadow && PlayerStatus[player] == PieceFalling):
		value = 2000
		for y in range(PiecePlayfieldY[player], 23):
			PiecePlayfieldY[player] = y
			if PieceCollision(player) != CollisionNotTrue:
				if (y - tempY) > 4:
					PiecePlayfieldY[player] = y-1
					break
				else:
					Piece[player] = tempPiece
					PiecePlayfieldX[player] = tempX
					PiecePlayfieldY[player] = tempY
					PieceRotation[player] = tempRot
					return

	if PieceData [Piece[player]] [PieceRotation[player]] [ 1] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 2] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 3] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 4] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [ 5] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 6] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 7] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 8] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+1] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [ 9] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [10] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [11] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [12] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+2] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [13] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [14] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [15] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [16] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+3] = value


	if PieceData [Piece[player]] [PieceRotation[player]] [ 1] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 2] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+1][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 3] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+2][PiecePlayfieldY[player]] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 4] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+3][PiecePlayfieldY[player]] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [ 5] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 6] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+1][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 7] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+2][PiecePlayfieldY[player]+1] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [ 8] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+3][PiecePlayfieldY[player]+1] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [ 9] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [10] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+1][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [11] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+2][PiecePlayfieldY[player]+2] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [12] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+3][PiecePlayfieldY[player]+2] = value

	if PieceData [Piece[player]] [PieceRotation[player]] [13] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [14] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+1][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [15] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+2][PiecePlayfieldY[player]+3] = value
	if PieceData [Piece[player]] [PieceRotation[player]] [16] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+3][PiecePlayfieldY[player]+3] = value

	Piece[player] = tempPiece
	PiecePlayfieldX[player] = tempX
	PiecePlayfieldY[player] = tempY
	PieceRotation[player] = tempRot

	if (pieceValue == Temp):
		PieceInPlayfieldMemory[player] = true

	return(true)

#----------------------------------------------------------------------------------------
func DeleteCurrentPieceFromPlayfieldMemory(player, pieceValue):
	var tempPiece = Piece[player]
	var tempX = PiecePlayfieldX[player]
	var tempY = PiecePlayfieldY[player]
	var tempRot = PieceRotation[player]

	var adjustedPiecePlayfieldX = PiecePlayfieldX[player]
	if (player == 0):  adjustedPiecePlayfieldX -= 0
	if (player == 1):  adjustedPiecePlayfieldX -= 10
	if (player == 2):  adjustedPiecePlayfieldX -= 20

	if (pieceValue == Next):
		DrawEverything = 1
		Piece[player] = NextPiece[player]
		PieceRotation[player] = 1

		if player == 0:
			PiecePlayfieldX[player] = 5
		elif player == 1:
			PiecePlayfieldX[player] = 15
		elif player == 2:
			PiecePlayfieldX[player] = 25

		PiecePlayfieldY[player] = 0
	elif (pieceValue == DropShadow && PlayerStatus[player] == PieceFalling):
		for y in range(PiecePlayfieldY[player], 23):
			PiecePlayfieldY[player] = y
			if PieceCollision(player) != CollisionNotTrue:
				if (y - tempY) > 4:
					PiecePlayfieldY[player] = y-1
					break
				else:
					Piece[player] = tempPiece
					PiecePlayfieldX[player] = tempX
					PiecePlayfieldY[player] = tempY
					PieceRotation[player] = tempRot
					return

	if PieceData [Piece[player]] [PieceRotation[player]] [ 1] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 2] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 3] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 4] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [ 5] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 6] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 7] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 8] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+1] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [ 9] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [10] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [11] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [12] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+2] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [13] == 1:
		Playfield[PiecePlayfieldX[player]][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [14] == 1:
		Playfield[PiecePlayfieldX[player]+1][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [15] == 1:
		Playfield[PiecePlayfieldX[player]+2][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [16] == 1:
		Playfield[PiecePlayfieldX[player]+3][PiecePlayfieldY[player]+3] = 0


	if PieceData [Piece[player]] [PieceRotation[player]] [ 1] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 2] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+1][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 3] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+2][PiecePlayfieldY[player]] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 4] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+3][PiecePlayfieldY[player]] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [ 5] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 6] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+1][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 7] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+2][PiecePlayfieldY[player]+1] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [ 8] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+3][PiecePlayfieldY[player]+1] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [ 9] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [10] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+1][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [11] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+2][PiecePlayfieldY[player]+2] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [12] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+3][PiecePlayfieldY[player]+2] = 0

	if PieceData [Piece[player]] [PieceRotation[player]] [13] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [14] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+1][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [15] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+2][PiecePlayfieldY[player]+3] = 0
	if PieceData [Piece[player]] [PieceRotation[player]] [16] == 1:
		PlayfieldNew[player][adjustedPiecePlayfieldX+3][PiecePlayfieldY[player]+3] = 0

	Piece[player] = tempPiece
	PiecePlayfieldX[player] = tempX
	PiecePlayfieldY[player] = tempY
	PieceRotation[player] = tempRot

	if (pieceValue == Temp):
		PieceInPlayfieldMemory[player] = false

	return(true)

#----------------------------------------------------------------------------------------
func AddRandomBlocksToBottom():
	if (SecretCodeCombined == 8888):  return

	DrawEverything = 1
	PieceMoved = 1

	var thereWillBeNoDownwardCollisions = true
	if (PlayerStatus[0] == PieceFalling):
		if (PieceCollisionDown(0) != CollisionNotTrue):
			thereWillBeNoDownwardCollisions = false
	if (PlayerStatus[1] == PieceFalling):
		if (PieceCollisionDown(1) != CollisionNotTrue):
			thereWillBeNoDownwardCollisions = false
	if (PlayerStatus[2] == PieceFalling):
		if (PieceCollisionDown(2) != CollisionNotTrue):
			thereWillBeNoDownwardCollisions = false

	if (thereWillBeNoDownwardCollisions == false):
		return

	for y in range(4, 24):
		for x in range(2, 32):
			Playfield[x][y] = Playfield[x][y+1]

	var boxCount = 0
	for x in range(2, 32):
		if (boxCount < 29):
			var randomBox= (  ( randi() % 8 )  )
			if (randomBox > 0):
				Playfield[x][23] = (randomBox + 30)
			else:
				Playfield[x][23] = 0
		else:
			Playfield[x][23] = 0

		if (Playfield[x][23] > 0):
			boxCount+=1

	AudioCore.PlayEffect(7)

	pass

#----------------------------------------------------------------------------------------
func CheckForNewPlayers():
	if (PlayersCanJoinIn == true):
		if (InputCore.JoyButtonOne[InputCore.InputKeyboard] == InputCore.Pressed):
			if (PlayerInput[0] != InputCore.InputKeyboard && PlayerInput[1] != InputCore.InputKeyboard && PlayerInput[2] != InputCore.InputKeyboard):
				if (PlayerInput[2] == InputCore.InputNone):
					PlayerStatus[2] = NewPieceDropping
					PlayerInput[2] = InputCore.InputKeyboard
				elif (PlayerInput[0] == InputCore.InputNone):
					PlayerStatus[0] = NewPieceDropping
					PlayerInput[0] = InputCore.InputKeyboard
		elif (InputCore.JoyButtonOne[InputCore.InputJoyOne] == InputCore.Pressed):
			if (PlayerInput[0] != InputCore.InputJoyOne && PlayerInput[1] != InputCore.InputJoyOne && PlayerInput[2] != InputCore.InputJoyOne):
				if (PlayerInput[2] == InputCore.InputNone):
					PlayerStatus[2] = NewPieceDropping
					PlayerInput[2] = InputCore.InputJoyOne
				elif (PlayerInput[0] == InputCore.InputNone):
					PlayerStatus[0] = NewPieceDropping
					PlayerInput[0] = InputCore.InputJoyOne
		elif (InputCore.JoyButtonOne[InputCore.InputJoyTwo] == InputCore.Pressed):
			if (PlayerInput[0] != InputCore.InputJoyTwo && PlayerInput[1] != InputCore.InputJoyTwo && PlayerInput[2] != InputCore.InputJoyTwo):
				if (PlayerInput[2] == InputCore.InputNone):
					PlayerStatus[2] = NewPieceDropping
					PlayerInput[2] = InputCore.InputJoyTwo
				elif (PlayerInput[0] == InputCore.InputNone):
					PlayerStatus[0] = NewPieceDropping
					PlayerInput[0] = InputCore.InputJoyTwo
		elif (InputCore.JoyButtonOne[InputCore.InputJoyThree] == InputCore.Pressed):
			if (PlayerInput[0] != InputCore.InputJoyThree && PlayerInput[1] != InputCore.InputJoyThree && PlayerInput[2] != InputCore.InputJoyThree):
				if (PlayerInput[2] == InputCore.InputNone):
					PlayerStatus[2] = NewPieceDropping
					PlayerInput[2] = InputCore.InputJoyThree
				elif (PlayerInput[0] == InputCore.InputNone):
					PlayerStatus[0] = NewPieceDropping
					PlayerInput[0] = InputCore.InputJoyThree

		if (PlayerInput[0] != InputCore.InputNone):
			VisualsCore.DrawSprite(137, (VisualsCore.ScreenWidth/2.0)+260, (VisualsCore.ScreenHeight/2.0)+9999, 1.0, 1.0, 0, 1.0, 1.0, 1.0, 1.0)

		if (PlayerInput[2] != InputCore.InputNone):
			VisualsCore.DrawSprite(138, (VisualsCore.ScreenWidth/2.0)+260, (VisualsCore.ScreenHeight/2.0)+9999, 1.0, 1.0, 0, 1.0, 1.0, 1.0, 1.0)

		if (PlayerStatus[0] != GameOver && PlayerStatus[1] != GameOver && PlayerStatus[2] != GameOver):
			PlayersCanJoinIn = false

	pass

#----------------------------------------------------------------------------------------
func ProcessPieceFall(player):
	if (player > -1 and player < 3):	
		if PieceDropTimer[player] > TimeToDropPiece[player]:
			if PieceCollisionDown(player) != CollisionWithPiece:
				if (InputCore.JoystickDirection[PlayerInput[player]] != InputCore.JoyDown):
					AudioCore.PlayEffect(3)

				MovePieceDown(player, false)
				PieceDropTimer[player] = 0
	pass

#----------------------------------------------------------------------------------------
func GetHumanPlayersKeyboardAndGameControllersMoves(player):
	if (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		if (InputCore.JoystickDirection[PlayerInput[player]] == InputCore.JoyLeft):
			MovePieceLeft(player)
		elif (InputCore.JoystickDirection[PlayerInput[player]] == InputCore.JoyRight):
			MovePieceRight(player)
		else:
			PieceMovementDelay[player] = 0

		if (InputCore.JoystickDirection[PlayerInput[player]] == InputCore.JoyUp):
			if PieceRotatedUp[player] == false:
				var _warnErase = RotatePieceClockwise(player)
				PieceRotatedUp[player] = true
		else:
			PieceRotatedUp[player] = false

		if (InputCore.JoystickDirection[PlayerInput[player]] == InputCore.JoyDown):
			PieceDropTimer[player] = (1 + TimeToDropPiece[player])
			DropBonus[player]+=1
		else:
			DropBonus[player] = 0

		if InputCore.JoyButtonOne[PlayerInput[player]] == InputCore.Pressed:
			if PieceRotatedOne[player] == false:
				var _warnErase = RotatePieceCounterClockwise(player)
				PieceRotatedOne[player] = true
		else:
			PieceRotatedOne[player] = false

		if InputCore.JoyButtonTwo[PlayerInput[player]] == InputCore.Pressed:
			if PieceRotatedTwo[player] == false:
				var _warnErase = RotatePieceClockwise(player)
				PieceRotatedTwo[player] = true
		else:
			PieceRotatedTwo[player] = false

	pass

#----------------------------------------------------------------------------------------
func GetHumanPlayerMouseMoves(player):
	if (ScreensCore.OperatingSys != ScreensCore.OSAndroid):
		if PieceDropTimer[player] > TimeToDropPiece[player]:
			if PieceCollisionDown(player) != CollisionWithPiece:
				if DropBonus[player] == 0:
					AudioCore.PlayEffect(3)

				MovePieceDown(player, false)
				PieceDropTimer[player] = 0

		if InterfaceCore.ThisIconWasPressed(0, player) == true:
			AndroidMovePieceLeftDelay[player]+=1
			MovePieceLeft(player)
			AndroidMovePieceRightDelay[player] = 0
		elif InterfaceCore.ThisIconWasPressed(1, player) == true:
			AndroidMovePieceRightDelay[player]+=1
			MovePieceRight(player)
			AndroidMovePieceLeftDelay[player] = 0
		else:
			AndroidMovePieceLeftDelay[player] = 0
			AndroidMovePieceRightDelay[player] = 0
			PieceMovementDelay[player] = 0

		if InterfaceCore.ThisIconWasPressed(2, player) == true:
			if PieceCollisionDown(player) != CollisionWithPiece:
				AndroidMovePieceDownDelay[player]+=1
				if (AndroidMovePieceDownDelay[player] == 1 || AndroidMovePieceDownDelay[player] == 6 || AndroidMovePieceDownDelay[player] == 10 || AndroidMovePieceDownDelay[player] == 13 || AndroidMovePieceDownDelay[player] == 15 || AndroidMovePieceDownDelay[player] > 16):
					PieceDropTimer[player] = 0
					DropBonus[player]+=1
					MovePieceDown(player, false)
					AndroidMovePieceDownPressed[player] = true
		else:
			DropBonus[player] = 0
			AndroidMovePieceDownDelay[player] = 0
			AndroidMovePieceDownPressed[player] = false

		if InterfaceCore.ThisIconWasPressed(3, player) == true:
			if PieceRotatedOne[player] == false:
				var _warnErase
				if (MouseTouchRotateDir == 0):
					_warnErase = RotatePieceClockwise(player)
				elif (MouseTouchRotateDir == 1):
					_warnErase = RotatePieceCounterClockwise(player)

				PieceRotatedOne[player] = true
		else:
			PieceRotatedOne[player] = false

	pass

#----------------------------------------------------------------------------------------
func GetHumanPlayerTouchOneMoves(player):
	if (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
		if InterfaceCore.ThisIconWasPressed(0, player) == true:
			AndroidMovePieceLeftDelay[player]+=1
			MovePieceLeft(player)
			AndroidMovePieceRightDelay[player] = 0
		elif InterfaceCore.ThisIconWasPressed(1, player) == true:
			AndroidMovePieceRightDelay[player]+=1
			MovePieceRight(player)
			AndroidMovePieceLeftDelay[player] = 0
		else:
			AndroidMovePieceLeftDelay[player] = 0
			AndroidMovePieceRightDelay[player] = 0
			PieceMovementDelay[player] = 0

		if InterfaceCore.ThisIconWasPressed(2, player) == true:
			if PieceCollisionDown(player) != CollisionWithPiece:
				AndroidMovePieceDownDelay[player]+=1
				if (AndroidMovePieceDownDelay[player] == 1 || AndroidMovePieceDownDelay[player] == 6 || AndroidMovePieceDownDelay[player] == 10 || AndroidMovePieceDownDelay[player] == 13 || AndroidMovePieceDownDelay[player] == 15 || AndroidMovePieceDownDelay[player] > 16):
					PieceDropTimer[player] = 0
					DropBonus[player]+=1
					MovePieceDown(player, false)
					AndroidMovePieceDownPressed[player] = true
		else:
			DropBonus[player] = 0
			AndroidMovePieceDownDelay[player] = 0
			AndroidMovePieceDownPressed[player] = false

		if InterfaceCore.ThisIconWasPressed(3, player) == true:
			if PieceRotatedOne[player] == false:
				var _warnErase = RotatePieceClockwise(player)
				PieceRotatedOne[player] = true
		else:
			PieceRotatedOne[player] = false

	pass

#----------------------------------------------------------------------------------------
func GetHumanPlayerTouchTwoMoves(player):
	if (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
		if InterfaceCore.ThisIconWasPressed(4, player) == true:
			AndroidMovePieceLeftDelay[player]+=1
			MovePieceLeft(player)
			AndroidMovePieceRightDelay[player] = 0
		elif InterfaceCore.ThisIconWasPressed(5, player) == true:
			AndroidMovePieceRightDelay[player]+=1
			MovePieceRight(player)
			AndroidMovePieceLeftDelay[player] = 0
		else:
			AndroidMovePieceLeftDelay[player] = 0
			AndroidMovePieceRightDelay[player] = 0
			PieceMovementDelay[player] = 0

		if InterfaceCore.ThisIconWasPressed(6, player) == true:
			if PieceCollisionDown(player) != CollisionWithPiece:
				AndroidMovePieceDownDelay[player]+=1
				if (AndroidMovePieceDownDelay[player] == 1 || AndroidMovePieceDownDelay[player] == 6 || AndroidMovePieceDownDelay[player] == 10 || AndroidMovePieceDownDelay[player] == 13 || AndroidMovePieceDownDelay[player] == 15 || AndroidMovePieceDownDelay[player] > 16):
					PieceDropTimer[player] = 0
					DropBonus[player]+=1
					MovePieceDown(player, false)
					AndroidMovePieceDownPressed[player] = true
		else:
			DropBonus[player] = 0
			AndroidMovePieceDownDelay[player] = 0
			AndroidMovePieceDownPressed[player] = false

		if InterfaceCore.ThisIconWasPressed(7, player) == true:
			if PieceRotatedOne[player] == false:
				var _warnErase = RotatePieceClockwise(player)
				PieceRotatedOne[player] = true
		else:
			PieceRotatedOne[player] = false

	pass

#----------------------------------------------------------------------------------------
# /\/\________.__  _____  __    ________   _____    _________.__       .__     __ /\/\
# )/)/  _____/|__|/ ____\/  |_  \_____  \_/ ____\  /   _____/|__| ____ |  |___/  |)/)/
#   /   \  ___|  \   __\\   __\  /   |   \   __\   \_____  \ |  |/ ___\|  |  \   __\
#   \    \_\  \  ||  |   |  |   /    |    \  |     /        \|  / /_/  >   Y  \  |
#    \______  /__||__|   |__|   \_______  /__|    /_______  /|__\___  /|___|  /__|
#           \/                          \/                \/   /_____/      \/v2.0
#
# Cooperative Puzzle Artificial Intelligence A.I. By "Yiyuan Lee", "JeZxLee", & "flairetic"
#
# Not 100% - 75 Out Of 100 - "C"

func ComputeComputerPlayerMove(player):
	var useNewAI = false#true#false

	if (CPUComputedBestMove[player] == false):
		if (PiecePlayfieldY[player] < 5):  return

		var PiecePlayfieldMinX
		if (player == 0):  PiecePlayfieldMinX = 2 - 2
		if (player == 1):  PiecePlayfieldMinX = 12 - 2
		if (player == 2):  PiecePlayfieldMinX = 22 - 2

		var PiecePlayfieldMaxX
		if (player == 0):  PiecePlayfieldMaxX = (2+10)
		if (player == 1):  PiecePlayfieldMaxX = (12+10)
		if (player == 2):  PiecePlayfieldMaxX = (22+10)

		var TEMP_BreakFromDoubleForLoop

		var TEMP_PieceRotation
		var TEMP_PiecePlayfieldX
		var TEMP_PiecePlayfieldY

		for posX in range (0, 32):
			for rot in range (1, MaxRotationArray[Piece[player]]+1):
				MoveTotalHeight[player][posX][rot] = 0.0
				MoveCompletedLines[player][posX][rot] = 0.0
				MoveTrappedHoles[player][posX][rot] = 0.0
				MoveBumpiness[player][posX][rot] = 0.0

				MovePieceHeight[player][posX][rot] = 0.0
				MoveOneBlockCavernHoles[player][posX][rot] = 0.0
				MovePlayfieldBoxEdges[player][posX][rot] = 0.0

				MovePieceCollision[player][posX][rot] = true

#-- Compute, prioritize, & store all player moves ------------------------------
#       Below Source Code By JeZxLee
		TEMP_BreakFromDoubleForLoop = false
		for NewCPUPieceTestX in range (PiecePlayfieldMinX, PiecePlayfieldMaxX):
			if (TEMP_BreakFromDoubleForLoop == false):
				for NewCPURotationTest in range (1, MaxRotationArray[Piece[player]]+1):
					if (TEMP_BreakFromDoubleForLoop == false):
						TEMP_PieceRotation = PieceRotation[player]
						TEMP_PiecePlayfieldX = PiecePlayfieldX[player]
						TEMP_PiecePlayfieldY = PiecePlayfieldY[player]

						PiecePlayfieldX[player] = NewCPUPieceTestX
						PieceRotation[player] = NewCPURotationTest

						MovePieceCollision[player][NewCPUPieceTestX][NewCPURotationTest] = false
						if (PieceCollisionCPU(player) == CollisionNotTrue):
							var TEMP_BreakFromForLoop = false
							for posY in range(PiecePlayfieldY[player], 23):
								if (TEMP_BreakFromForLoop == false):
									PiecePlayfieldY[player] = posY
									if ( PieceCollisionCPU(player) == CollisionWithPlayfield ):
										PiecePlayfieldY[player]-=1

										MovePieceHeight[player][NewCPUPieceTestX][NewCPURotationTest] = (32-PiecePlayfieldY[player])

										TEMP_BreakFromForLoop = true

										if (PieceCollisionCPU(player) == CollisionNotTrue):
											AddCurrentPieceToPlayfieldMemory(player, Temp)

										var realHeight
										var lastBoxHeight
										MoveTotalHeight[player][NewCPUPieceTestX][NewCPURotationTest] = 0
										for posX in range(2, 12):
											realHeight = 0
											lastBoxHeight = 0
											for posYtwo in range(23, 5, -1):
												realHeight+=1
												if ( (PlayfieldNew[player][posX][posYtwo] > 30 && PlayfieldNew[player][posX][posYtwo] < 40) || (PlayfieldNew[player][posX][posYtwo] > 1000 && PlayfieldNew[player][posX][posYtwo] < 1010) ):
													lastBoxHeight = realHeight

											MoveTotalHeight[player][NewCPUPieceTestX][NewCPURotationTest]+=lastBoxHeight

										MoveCompletedLines[player][NewCPUPieceTestX][NewCPURotationTest] = 0
										for y in range(4, 24):
											var boxTotal = 0
											for x in range(2, 32):
												if ( (Playfield[x][y] > 30 && Playfield[x][y] < 40) || (Playfield[x][y] > 1000 && Playfield[x][y] < 1010) ):
													boxTotal+=1

											if (boxTotal == 30):
												MoveCompletedLines[player][NewCPUPieceTestX][NewCPURotationTest]+=1

										MoveTrappedHoles[player][NewCPUPieceTestX][NewCPURotationTest] = 0
										for posX in range(2, 12):
											for posYtwo in range(23, 6, -1):
												if (  (PlayfieldNew[player][posX][posYtwo] == 0) && ( (PlayfieldNew[player][posX][posYtwo-1] > 30 && PlayfieldNew[player][posX][posYtwo-1] < 40) || (PlayfieldNew[player][posX][posYtwo-1] > 1000 && PlayfieldNew[player][posX][posYtwo-1] < 1010) )  ):
													MoveTrappedHoles[player][NewCPUPieceTestX][NewCPURotationTest]+=1

										var columnOne = 0
										var columnTwo = 0
										MoveBumpiness[player][NewCPUPieceTestX][NewCPURotationTest] = 0
										for posX in range(2, 12-1):
											realHeight = 0
											lastBoxHeight = 0
											for posYtwo in range(23, 5, -1):
												realHeight+=1
												if ( (PlayfieldNew[player][posX][posYtwo] > 30 && PlayfieldNew[player][posX][posYtwo] < 40) || (PlayfieldNew[player][posX][posYtwo] > 1000 && PlayfieldNew[player][posX][posYtwo] < 1010) ):
													lastBoxHeight = realHeight

											columnOne = lastBoxHeight

											realHeight = 0
											lastBoxHeight = 0
											for posYtwo in range(23, 5, -1):
												realHeight+=1
												if ( (PlayfieldNew[player][posX+1][posYtwo] > 30 && PlayfieldNew[player][posX+1][posYtwo] < 40) || (PlayfieldNew[player][posX+1][posYtwo] > 1000 && PlayfieldNew[player][posX+1][posYtwo] < 1010) ):
													lastBoxHeight = realHeight

											columnTwo = lastBoxHeight

											if (columnOne < columnTwo):  MoveBumpiness[player][NewCPUPieceTestX][NewCPURotationTest]+= (columnTwo-columnOne)
											elif (columnOne > columnTwo):  MoveBumpiness[player][NewCPUPieceTestX][NewCPURotationTest]+= (columnOne-columnTwo)

										MoveOneBlockCavernHoles[player][NewCPUPieceTestX][NewCPURotationTest] = 0
										for posYfour in range(5, 23):
											for posX in range(2, 12):
												if (PlayfieldNew[player][posX][posYfour] == 0 && PlayfieldNew[player][(posX-1)][posYfour] != 0 && PlayfieldNew[player][(posX+1)][posYfour] != 0):
													MoveOneBlockCavernHoles[player][NewCPUPieceTestX][NewCPURotationTest]+=1

										MovePlayfieldBoxEdges[player][NewCPUPieceTestX][NewCPURotationTest] = 0
										for posYthree in range(5, 23):
											for posX in range(2, 12):
												if ( (PlayfieldNew[player][posX][posYthree] > 30 && PlayfieldNew[player][posX][posYthree] < 40) || (PlayfieldNew[player][posX][posYthree] > 1000 && PlayfieldNew[player][posX][posYthree] < 1010) || PlayfieldNew[player][posX][posYthree] == 255 ):
													if (PlayfieldNew[player][posX][(posYthree-1)] == 0):
														MovePlayfieldBoxEdges[player][NewCPUPieceTestX][NewCPURotationTest]+=1

													if (PlayfieldNew[player][posX][(posYthree+1)] == 0):
														MovePlayfieldBoxEdges[player][NewCPUPieceTestX][NewCPURotationTest]+=1

													if (PlayfieldNew[player][(posX-1)][posYthree] == 0):
														MovePlayfieldBoxEdges[player][NewCPUPieceTestX][NewCPURotationTest]+=1

													if (PlayfieldNew[player][(posX+1)][posYthree] == 0):
														MovePlayfieldBoxEdges[player][NewCPUPieceTestX][NewCPURotationTest]+=1

										DeleteCurrentPieceFromPlayfieldMemory(player, Temp)

										PieceRotation[player] = TEMP_PieceRotation
										PiecePlayfieldX[player] = TEMP_PiecePlayfieldX
										PiecePlayfieldY[player] = TEMP_PiecePlayfieldY
						else:
							CPUComputedBestMove[player] = false

							MovePieceCollision[player][NewCPUPieceTestX][NewCPURotationTest] = true
							PieceRotation[player] = TEMP_PieceRotation
							PiecePlayfieldX[player] = TEMP_PiecePlayfieldX
							PiecePlayfieldY[player] = TEMP_PiecePlayfieldY

#-- Choose best move & rotation in either left or right direction ----------------------------------
#       Below A.I. Algorithm By JeZxLee
		if (useNewAI == false):
			var TEMP_BestValue = 9999999.0
			for posX in range (PiecePlayfieldMinX, PiecePlayfieldMaxX):
				for rot in range (1, MaxRotationArray[Piece[player]]+1):
					if (MovePieceCollision[player][posX][rot] == false):
						var testValue

						testValue = ( (1.0*MovePieceHeight[player][posX][rot])
									+(-1.0*MoveCompletedLines[player][posX][rot])
									+(3.0*MoveTrappedHoles[player][posX][rot])
									+(1.0*MoveOneBlockCavernHoles[player][posX][rot])
									+(1.0*MovePlayfieldBoxEdges[player][posX][rot]) )

#						if (player == 0):
#							print("Player="+str(player)+" /posX="+str(posX)+" /rot="+str(rot)+" /Height="+str(MovePieceHeight[player][posX][rot])+" /CompLines="+str(MoveCompletedLines[player][posX][rot])+" /Trapped="+str(MoveTrappedHoles[player][posX][rot])+" /Caverns="+str(MoveOneBlockCavernHoles[player][posX][rot])+" /Edges="+str(MovePlayfieldBoxEdges[player][posX][rot])+" /testValue="+str(testValue))

						if (testValue <= TEMP_BestValue):
							TEMP_BestValue = testValue
							BestMoveX[player] = posX
							BestRotation[player] = rot

#			print("BestMoveX="+str(BestMoveX[player])+" /BestRotation="+str(BestRotation[player]))

			CPUComputedBestMove[player] = true
			MovedToBestMove[player] = false
#       Below A.I. Algorithm (C)opyright 2013 By Yiyuan Lee
#       https://codemyroad.wordpress.com/2013/04/14/tetris-ai-the-near-perfect-player/
		elif (useNewAI == true):
			var TEMP_BestValue = -9999999.0
			for posX in range (PiecePlayfieldMinX, PiecePlayfieldMaxX):
				for rot in range (1, MaxRotationArray[Piece[player]]+1):
					if (MovePieceCollision[player][posX][rot] == false):
						var testValue

						testValue = ( (-0.510066*MoveTotalHeight[player][posX][rot])
						+(0.760666*MoveCompletedLines[player][posX][rot])
						+(-0.35663*MoveTrappedHoles[player][posX][rot])
						+(-0.184483*MoveBumpiness[player][posX][rot]) )

#						if (player == 0):
#							print("Player="+str(player)+" /posX="+str(posX)+" /rot="+str(rot)+" /TotalHeight="+str(MoveTotalHeight[player][posX][rot])+" /CompLines="+str(MoveCompletedLines[player][posX][rot])+" /Trapped="+str(MoveTrappedHoles[player][posX][rot])+" /Bumpiness="+str(MoveBumpiness[player][posX][rot])+" /testValue="+str(testValue))

						if (testValue >= TEMP_BestValue):
							TEMP_BestValue = testValue
							BestMoveX[player] = posX
							BestRotation[player] = rot

#			print("BestMoveX="+str(BestMoveX[player])+" /BestRotation="+str(BestRotation[player]))

			CPUComputedBestMove[player] = true
			MovedToBestMove[player] = false

#-- Rotate & move falling piece to best ------------------------------------------------------------
	elif (CPUComputedBestMove[player] == true):
		if (MovedToBestMove[player] == false):
			if (PieceRotation[player] < BestRotation[player]):
				var _warnErase = RotatePieceClockwise(player)
			elif (PieceRotation[player] > BestRotation[player]):
				var _warnErase = RotatePieceCounterClockwise(player)
			else:
				if (BestMoveX[player] < PiecePlayfieldX[player]):
					MovePieceLeft(player)
				elif (BestMoveX[player] > PiecePlayfieldX[player]):
					MovePieceRight(player)
				else:
					MovedToBestMove[player] = true
		elif (MovedToBestMove[player] == true):
			var skip = 3
			if (HumanPlayerOneHeight < 10):  skip = 0
			elif (HumanPlayerOneHeight < 15):  skip = 1
			elif (HumanPlayerOneHeight < 20):  skip = 2
			else:  skip = 3

			if (SkipComputerPlayerMove[player] >= skip):
				SkipComputerPlayerMove[player] = 0
				MovePieceDown(player, true)
			else:  SkipComputerPlayerMove[player]+=1

	pass

# Cooperative Puzzle Artificial Intelligence A.I. By "Yiyuan Lee", "JeZxLee", & "flairetic"

#   /\/\________.__  _____  __    ________   _____    _________.__       .__     __ /\/\
#   )/)/  _____/|__|/ ____\/  |_  \_____  \_/ ____\  /   _____/|__| ____ |  |___/  |)/)/
#     /   \  ___|  \   __\\   __\  /   |   \   __\   \_____  \ |  |/ ___\|  |  \   __\
#     \    \_\  \  ||  |   |  |   /    |    \  |     /        \|  / /_/  >   Y  \  |
#      \______  /__||__|   |__|   \_______  /__|    /_______  /|__\___  /|___|  /__|
#             \/                          \/                \/   /_____/      \/v2.0
#

#----------------------------------------------------------------------------------------
func AddIncompleteLineToBottom(player):
	if (player == 2):
		var allPiecesAreFalling = true
		if (PlayerStatus[0] != PieceFalling && PlayerStatus[0] != GameOver):
			allPiecesAreFalling = false
		if (PlayerStatus[1] != PieceFalling && PlayerStatus[1] != GameOver):
			allPiecesAreFalling = false
		if (PlayerStatus[2] != PieceFalling && PlayerStatus[2] != GameOver):
			allPiecesAreFalling = false

		if (allPiecesAreFalling == true):
			AddRandomBlocksToBottomTimer+=1

			var timeForCrisis = 375+(100*2)
			if (ScreensCore.OperatingSys == ScreensCore.OSAndroid):
				timeForCrisis+=175

			if (AddRandomBlocksToBottomTimer > timeForCrisis):
				AddRandomBlocksToBottom()
				AddRandomBlocksToBottomTimer = 0

	pass

#----------------------------------------------------------------------------------------
func CheckForLevelAdvance():
	if (TotalLines > 9):
		TotalLines = 0
		InputCore.DelayAllUserInput = 25
		ScreensCore.ScreenFadeStatus = ScreensCore.FadingToBlack
		ScreensCore.ScreenToDisplayNext = ScreensCore.CutSceneScreen
		Level+=1
		ScreensCore.CutSceneScene = 1
		VisualsCore.SetFramesPerSecond(30)

		LevelCleared = true

		if (Level < 10):
			AudioCore.PlayMusic(Level, true)
		elif (Level == 10):
			InputCore.DelayAllUserInput = 100
			StillPlaying = false
			GameWon = true
			VisualsCore.SetFramesPerSecond(30)

			ScreensCore.ScreenFadeStatus = ScreensCore.FadingToBlack
			ScreensCore.ScreenToDisplayNext = ScreensCore.WonGameScreen

			SecretCode[0] = 5
			SecretCode[1] = 4
			SecretCode[2] = 3
			SecretCode[3] = 1
			SecretCodeCombined = (SecretCode[0]*1000)+(SecretCode[1]*100)+(SecretCode[2]*10)+(SecretCode[3]*1)

	pass

#----------------------------------------------------------------------------------------
func CheckForGameOver():
	if ( (PlayerInput[0] != InputCore.InputNone and PlayerStatus[0] == GameOver) or (PlayerInput[1] != InputCore.InputNone and PlayerStatus[1] == GameOver) or (PlayerInput[2] != InputCore.InputNone and PlayerStatus[2] == GameOver) ):
		VisualsCore.SetFramesPerSecond(30)

		AudioCore.PlayMusic(0, true)

		StillPlaying = false

		ScreensCore.ScreenFadeStatus = ScreensCore.FadingToBlack

	pass

#----------------------------------------------------------------------------------------
func AddToPlayfieldAllPlayerPiecesAndDropShadows():
	if PlayerStatus[1] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(1, Temp)
	if PlayerStatus[2] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(2, Temp)
	if PlayerStatus[0] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(0, DropShadow)

	if (PlayerStatus[1] == PieceFalling):  DeleteCurrentPieceFromPlayfieldMemory(1, Temp)
	if (PlayerStatus[2] == PieceFalling):  DeleteCurrentPieceFromPlayfieldMemory(2, Temp)

	if PlayerStatus[0] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(0, Temp)
	if PlayerStatus[2] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(2, Temp)
	if PlayerStatus[1] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(1, DropShadow)

	if (PlayerStatus[0] == PieceFalling):  DeleteCurrentPieceFromPlayfieldMemory(0, Temp)
	if (PlayerStatus[2] == PieceFalling):  DeleteCurrentPieceFromPlayfieldMemory(2, Temp)

	if PlayerStatus[0] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(0, Temp)
	if PlayerStatus[1] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(1, Temp)
	if PlayerStatus[2] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(2, DropShadow)

	if (PlayerStatus[0] == PieceFalling):  DeleteCurrentPieceFromPlayfieldMemory(0, Temp)
	if (PlayerStatus[1] == PieceFalling):  DeleteCurrentPieceFromPlayfieldMemory(1, Temp)

	for player in range(0, 3):
		if (PlayerStatus[player] == PieceFalling):
			AddCurrentPieceToPlayfieldMemory(player, Temp)

	pass

#----------------------------------------------------------------------------------------
func DeleteFromPlayfieldAllPlayerPiecesAndDropShadows():
	for player in range(0, 3):
		if PlayerStatus[player] == PieceFalling:
			DeleteCurrentPieceFromPlayfieldMemory(player, Temp)

	if PlayerStatus[1] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(1, Temp)
	if PlayerStatus[2] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(2, Temp)
	if PlayerStatus[0] == PieceFalling:
		DeleteCurrentPieceFromPlayfieldMemory(0, DropShadow)

	if PlayerStatus[1] == PieceFalling:  DeleteCurrentPieceFromPlayfieldMemory(1, Temp)
	if PlayerStatus[2] == PieceFalling:  DeleteCurrentPieceFromPlayfieldMemory(2, Temp)

	if PlayerStatus[0] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(0, Temp)
	if PlayerStatus[2] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(2, Temp)
	if PlayerStatus[1] == PieceFalling:
		DeleteCurrentPieceFromPlayfieldMemory(1, DropShadow)

	if PlayerStatus[0] == PieceFalling: DeleteCurrentPieceFromPlayfieldMemory(0, Temp)
	if PlayerStatus[2] == PieceFalling:  DeleteCurrentPieceFromPlayfieldMemory(2, Temp)

	if PlayerStatus[0] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(0, Temp)
	if PlayerStatus[1] == PieceFalling:
		AddCurrentPieceToPlayfieldMemory(1, Temp)
	if PlayerStatus[2] == PieceFalling:
		DeleteCurrentPieceFromPlayfieldMemory(2, DropShadow)

	if PlayerStatus[0] == PieceFalling:  DeleteCurrentPieceFromPlayfieldMemory(0, Temp)
	if PlayerStatus[1] == PieceFalling:  DeleteCurrentPieceFromPlayfieldMemory(1, Temp)

	pass

#----------------------------------------------------------------------------------------
func DoAnyPlayersHaveCompletedLine():
	var returnValue = false
	if (PlayerStatus[0] == FlashingCompletedLines || PlayerStatus[0] == ClearingCompletedLines):
		returnValue = true
	if (PlayerStatus[1] == FlashingCompletedLines || PlayerStatus[1] == ClearingCompletedLines):
		returnValue = true
	if (PlayerStatus[2] == FlashingCompletedLines || PlayerStatus[2] == ClearingCompletedLines):
		returnValue = true

	return(returnValue)

#----------------------------------------------------------------------------------------
func ThereAreCompletedLines():
	var returnValue = false

	for y in range(4, 24):
		var boxTotal = 0

		for x in range (2, 32):
			if (Playfield[x][y] > 30 && Playfield[x][y] < 40):
				boxTotal+=1
			elif (Playfield[x][y] == 99999):
				boxTotal+=1

		if (boxTotal == 30):  returnValue = true

	return(returnValue)

#----------------------------------------------------------------------------------------
func RunPuzzleGameCore():
	if PAUSEgame == false:
		CheckForNewPlayers()
		CheckForLevelAdvance()
		CheckForGameOver()

		ReadHumanPlayerOneHeight()

		if (LogicCore.SecretCodeCombined == 2778 or LogicCore.SecretCodeCombined == 2779 or LogicCore.SecretCodeCombined == 1234):
			PlayerStatus[0] = GameOver
			PlayerStatus[2] = GameOver

		if (InputCore.HTML5input == InputCore.InputMouse):  PlayerInput[1] = InputCore.InputMouse

		for player in range(0, 3):
			Player = player

			if (DoAnyPlayersHaveCompletedLine() == false and ThereAreCompletedLines() == false):
				for pIndex in range(0, 3):
					if (PlayerStatus[pIndex] == PieceFalling or PlayerStatus[pIndex] == NewPieceDropping):
						if (player != pIndex):
							AddCurrentPieceToPlayfieldMemory(pIndex, Temp)

			if PlayerStatus[player] != GameOver:
#				if SecretCodeCombined != 8888 && SecretCodeCombined != 8889 && SecretCodeCombined != 3777:
				PieceDropTimer[player]+=1

				if (PlayerStatus[player] == NewPieceDropping):
					DrawEverything = 1
					PieceMoved = 1

					DeleteCurrentPieceFromPlayfieldMemory(player, Temp)
					if PiecePlayfieldY[player] < PieceDropStartHeight[ Piece[player] ]:
						if (PieceCollisionDown(player) == CollisionNotTrue):
							MovePieceDown(player, true)

						if (PieceCollisionDown(player) == CollisionWithPlayfield):
							PlayerStatus[player] = GameOver
						else:
							AddCurrentPieceToPlayfieldMemory(player, Temp)
					else:
						AddCurrentPieceToPlayfieldMemory(player, Next)
						PlayerStatus[player] = PieceFalling
				elif PlayerStatus[player] == PieceFalling:
					if (PlayerInput[player] == InputCore.InputCPU and PiecePlayfieldY[player] < 5):  PieceDropTimer[player] = TimeToDropPiece[player]+1

					var processMovement = true
					for p in range(3):
						if (PlayerStatus[p] != GameOver && PlayerStatus[p] != NewPieceDropping && PlayerStatus[p] != PieceFalling):  processMovement = false
						
					if (processMovement == true):
						ProcessPieceFall(player)

						if (PlayerInput[player] == InputCore.InputKeyboard || PlayerInput[player] == InputCore.InputJoyOne || PlayerInput[player] == InputCore.InputJoyTwo || PlayerInput[player] == InputCore.InputJoyThree):
							GetHumanPlayersKeyboardAndGameControllersMoves(player)
						elif (PlayerInput[player] == InputCore.InputMouse):
							GetHumanPlayerMouseMoves(player)
						elif (PlayerInput[player] == InputCore.InputTouchOne):
							GetHumanPlayerTouchOneMoves(player)
						elif (PlayerInput[player] == InputCore.InputTouchTwo):
							GetHumanPlayerTouchTwoMoves(player)
						elif (PlayerInput[player] == InputCore.InputCPU && AllowComputerPlayers > 0):
							ComputeComputerPlayerMove(player)
				else:
					if (PlayerStatus[player] == FlashingCompletedLines):
						FlashCompletedLines(player)
					elif (PlayerStatus[player] == ClearingCompletedLines):
						ClearCompletedLines(player)

			for pIndex in range(0, 3):
				if (PlayerStatus[pIndex] == PieceFalling):
					if (player != pIndex):
						DeleteCurrentPieceFromPlayfieldMemory(pIndex, Temp)

	pass

#----------------------------------------------------------------------------------------
func _ready():
	SecretCode.append(0)
	SecretCode.append(0)
	SecretCode.append(0)
	SecretCode.append(0)

	LogicCore.SecretCodeCombined = 0000

	InitializePieceData()

	var _warnErase = PlayfieldNew.resize(3)
	for player in range(3):
		PlayfieldNew[player] = []
		PlayfieldNew[player].resize(15)
		for x in range(15):
			PlayfieldNew[player][x] = []
			PlayfieldNew[player][x].resize(26)
			for y in range(26):
				PlayfieldNew[player][x][y] = []

	_warnErase = Playfield.resize(35)
	for x in range(35):
		Playfield[x] = []
		Playfield[x].resize(26)
		for y in range(26):
			Playfield[x][y] = []

	_warnErase = PlayfieldMoveAI.resize(35)
	for x in range(35):
		PlayfieldMoveAI[x] = []
		PlayfieldMoveAI[x].resize(26)
		for y in range(26):
			PlayfieldMoveAI[x][y] = []

	_warnErase = PieceBagIndex.resize(3)

	_warnErase = PieceBag.resize(3)
	for player in range(3):
		PieceBag[player] = []
		PieceBag[player].resize(2)
		for bag in range(2):
			PieceBag[player][bag] = []
			PieceBag[player][bag].resize(9)

	_warnErase = PieceSelectedAlready.resize(3)
	for player in range(3):
		PieceSelectedAlready[player] = []
		_warnErase = PieceSelectedAlready[player].resize(9)

	_warnErase = Piece.resize(3)

	_warnErase = NextPiece.resize(3)

	_warnErase = PieceRotation.resize(3)
	_warnErase = PiecePlayfieldX.resize(3)
	_warnErase = PiecePlayfieldY.resize(3)

	_warnErase = PieceDropTimer.resize(3)
	_warnErase = TimeToDropPiece.resize(3)

	_warnErase = PlayerStatus.resize(3)

	_warnErase = PieceDropStartHeight.resize(8)
	PieceDropStartHeight[0] = 0
	PieceDropStartHeight[1] = 4
	PieceDropStartHeight[2] = 4
	PieceDropStartHeight[3] = 4
	PieceDropStartHeight[4] = 4
	PieceDropStartHeight[5] = 4
	PieceDropStartHeight[6] = 3
	PieceDropStartHeight[7] = 5

	_warnErase = PieceBagFirstUse.resize(3)

	_warnErase = PieceMovementDelay.resize(3)

	_warnErase = PieceRotatedOne.resize(3)
	_warnErase = PieceRotatedTwo.resize(3)

	_warnErase = PieceRotatedUp.resize(3)

	_warnErase = Score.resize(3)
	Score[0] = 0
	Score[1] = 0
	Score[2] = 0

	Level = 1

	_warnErase = DropBonus.resize(3)

	_warnErase = AndroidMovePieceDownDelay.resize(3)
	_warnErase = AndroidMovePieceDownPressed.resize(3)
	_warnErase = AndroidMovePieceLeftDelay.resize(3)
	_warnErase = AndroidMovePieceRightDelay.resize(3)

	_warnErase = PlayerInput.resize(3)

	_warnErase = MovePieceCollision.resize(3)
	for player in range(3):
		MovePieceCollision[player] = []
		_warnErase = MovePieceCollision[player].resize(35)
		for x in range(35):
			MovePieceCollision[player][x] = []
			_warnErase = MovePieceCollision[player][x].resize(26)

	_warnErase = MovePieceHeight.resize(3)
	for player in range(3):
		MovePieceHeight[player] = []
		_warnErase = MovePieceHeight[player].resize(35)
		for x in range(35):
			MovePieceHeight[player][x] = []
			_warnErase = MovePieceHeight[player][x].resize(26)

	_warnErase = MoveTrappedHoles.resize(3)
	for player in range(3):
		MoveTrappedHoles[player] = []
		MoveTrappedHoles[player].resize(35)
		for x in range(35):
			MoveTrappedHoles[player][x] = []
			MoveTrappedHoles[player][x].resize(26)

	_warnErase = MoveOneBlockCavernHoles.resize(3)
	for player in range(3):
		MoveOneBlockCavernHoles[player] = []
		MoveOneBlockCavernHoles[player].resize(35)
		for x in range(35):
			MoveOneBlockCavernHoles[player][x] = []
			MoveOneBlockCavernHoles[player][x].resize(26)

	_warnErase = MovePlayfieldBoxEdges.resize(3)
	for player in range(3):
		MovePlayfieldBoxEdges[player] = []
		_warnErase = MovePlayfieldBoxEdges[player].resize(35)
		for x in range(35):
			MovePlayfieldBoxEdges[player][x] = []
			_warnErase = MovePlayfieldBoxEdges[player][x].resize(26)

	_warnErase = MoveCompletedLines.resize(3)
	for player in range(3):
		MoveCompletedLines[player] = []
		_warnErase = MoveCompletedLines[player].resize(35)
		for x in range(35):
			MoveCompletedLines[player][x] = []
			_warnErase = MoveCompletedLines[player][x].resize(26)

	_warnErase = MoveBumpiness.resize(3)
	for player in range(3):
		MoveBumpiness[player] = []
		_warnErase = MoveBumpiness[player].resize(35)
		for x in range(35):
			MoveBumpiness[player][x] = []
			_warnErase = MoveBumpiness[player][x].resize(26)

	_warnErase = MoveTotalHeight.resize(3)
	for player in range(3):
		MoveTotalHeight[player] = []
		_warnErase = MoveTotalHeight[player].resize(35)
		for x in range(35):
			MoveTotalHeight[player][x] = []
			_warnErase = MoveTotalHeight[player][x].resize(26)

	_warnErase = BestMoveX.resize(3)
	_warnErase = BestRotation.resize(3)
	_warnErase = MovedToBestMove.resize(3)

	_warnErase = MaxRotationArray.resize(8)
	MaxRotationArray[0] = 0
	MaxRotationArray[1] = 2
	MaxRotationArray[2] = 2
	MaxRotationArray[3] = 4
	MaxRotationArray[4] = 4
	MaxRotationArray[5] = 4
	MaxRotationArray[6] = 1
	MaxRotationArray[7] = 2

	_warnErase = CPUPlayerMovementSkip.resize(3)

	_warnErase = CPUPlayerForcedDirection.resize(3)
	CPUPlayerForcedDirection[0] = CPUForcedFree
	CPUPlayerForcedDirection[1] = CPUForcedFree
	CPUPlayerForcedDirection[2] = CPUForcedFree

	_warnErase = CPUPlayerForcedMinX.resize(3)
	_warnErase = CPUPlayerForcedMaxX.resize(3)
	CPUPlayerForcedMinX[0] = 0
	CPUPlayerForcedMaxX[0] = 31
	CPUPlayerForcedMinX[1] = 0
	CPUPlayerForcedMaxX[1] = 31
	CPUPlayerForcedMinX[2] = 0
	CPUPlayerForcedMaxX[2] = 31

	_warnErase = CPUPieceTestX.resize(3)
	_warnErase = CPURotationTest.resize(3)
	_warnErase = CPUComputedBestMove.resize(3)

	_warnErase = pTXStep.resize(3)
	_warnErase = bestValue.resize(3)

	_warnErase = PlayfieldBackup.resize(35)
	for x in range(35):
		PlayfieldBackup[x] = []
		_warnErase = PlayfieldBackup[x].resize(26)
		for y in range(26):
			PlayfieldBackup[x][y] = []

	GameWon = false

	MouseTouchRotateDir = 0

	_warnErase = PieceInPlayfieldMemory.resize(3)

	_warnErase = SkipComputerPlayerMove.resize(3)

	pass

#----------------------------------------------------------------------------------------
func _process(_delta):

	pass
