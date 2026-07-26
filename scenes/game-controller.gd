extends Node2D
@onready var main_menu: Control = %MainMenu
@onready var grid_container: GridContainer = %GridContainer
const LEVEL_SELECT_BUTTON = preload("uid://bg0mogicmyxf3")

@onready var music_controller: AudioController = %MusicController
@export var levels : Array[PackedScene]

var level_idx := 0
var loaded_level : LevelController

func _ready() -> void :
	create_level_select_buttons()
	music_controller.play_menu_music()

func on_next_level() -> void :
	level_idx += 1
	
	# load main menu if no more levels exist
	if (level_idx >= levels.size()):
		main_menu.visible = true
		loaded_level.queue_free()
		music_controller.play_menu_music()
		return
	
	load_level(level_idx)

func load_level(idx : int) -> void :
	
	unload_current_level()
	
	# load new level
	loaded_level = levels[idx].instantiate()
	add_child(loaded_level)
	loaded_level.next_level.connect(on_next_level)
	loaded_level.main_menu.connect(on_return_to_main_menu)
	
	music_controller.play_level_music()

func on_return_to_main_menu() -> void:
	main_menu.visible = true
	music_controller.play_menu_music()
	unload_current_level()

func unload_current_level() -> void:
	if (loaded_level != null) :
		loaded_level.next_level.disconnect(on_next_level)
		loaded_level.main_menu.disconnect(on_return_to_main_menu)
		loaded_level.queue_free()


func _on_b_start_pressed() -> void:
	main_menu.visible = false
	level_idx = 0
	
	load_level(level_idx)

func create_level_select_buttons() -> void :
	for n in range(levels.size()) :
		var new_button = LEVEL_SELECT_BUTTON.instantiate() as LevelSelectButton
		grid_container.add_child(new_button)
		new_button.level_idx = n
		new_button.level_selected.connect(load_level)
		
