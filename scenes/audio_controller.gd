class_name AudioController
extends Node

@onready var asp_music: AudioStreamPlayer = %ASP_Music


@export_group("Music")
@export var main_menu : AudioStream
@export var level_music : AudioStream

@export_group("Sound")
@export var bomb_beep : AudioStream
@export var bomb_explosion : AudioStream

func play_menu_music() -> void:
	asp_music.stream = main_menu
	asp_music.play() 

func play_level_music() -> void:
	asp_music.stream = level_music
	asp_music.play()
