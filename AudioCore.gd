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

# "AudioCore.gd"
extends Node2D

var MusicVolume
var EffectsVolume

var MusicPlayer
var MusicTotal = 1
var MusicCurrentlyPlaying = -1

var EffectPlayer = []
var EffectsTotal = 2

#----------------------------------------------------------------------------------------
func ConvertLinearToDB(volume):
	var returnValue = log(volume) * 8.6858896380650365530225783783321
	return(returnValue)

#----------------------------------------------------------------------------------------
func _ready():
	MusicVolume = 0.5
	EffectsVolume = 0.5

	MusicPlayer = AudioStreamPlayer.new()
	add_child(MusicPlayer)

	for index in range(0, EffectsTotal):
		EffectPlayer.append(AudioStreamPlayer.new())
		if index == 0:  EffectPlayer[index].stream = load("res://media/sound/MenuMove.ogg")
		elif index == 1:  EffectPlayer[index].stream = load("res://media/sound/MenuClick.ogg")

		add_child(EffectPlayer[index])
		EffectPlayer[index].set_volume_db(ConvertLinearToDB(EffectsVolume))
		EffectPlayer[index].stream.set_loop(false)
	pass

#----------------------------------------------------------------------------------------
func SetMusicAndEffectsVolume(musicVolume, effectsVolume):
	MusicPlayer.set_volume_db(ConvertLinearToDB(musicVolume))

	for index in range(0, EffectsTotal):
		EffectPlayer[index].set_volume_db(ConvertLinearToDB(effectsVolume))
	pass

#----------------------------------------------------------------------------------------
func PlayMusic(index, loop):
	if index < 0 || index > (MusicTotal-1):  return

	if MusicCurrentlyPlaying > -1:
		MusicPlayer.stop()
	
	MusicCurrentlyPlaying = index

	if index == 0:  MusicPlayer.stream = load("res://media/music/Title/yt5s.com - CZ Tunes - Platoon Title Remix - C64 Music (#C64Music #C64Remix) (128 kbps).mp3")

	MusicPlayer.set_volume_db(ConvertLinearToDB(MusicVolume))
	MusicPlayer.stream.set_loop(loop)
	MusicPlayer.play(0.0)

	pass

#----------------------------------------------------------------------------------------
func PlayEffect(index):
	if index < 0 || index > (EffectsTotal-1):  return

	EffectPlayer[index].set_volume_db(ConvertLinearToDB(EffectsVolume))
	EffectPlayer[index].stream.set_loop(false)
	EffectPlayer[index].play(0.0)

	pass

#----------------------------------------------------------------------------------------
func _process(_delta):

	pass
