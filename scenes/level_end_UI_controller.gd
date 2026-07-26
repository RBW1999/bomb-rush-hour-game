class_name LevelEndUIController
extends PanelContainer

signal next_level
signal restart_level
signal main_menu

@onready var l_lost: Label = %L_Lost
@onready var l_won: Label = %L_Won
@onready var l_moves_left: Label = %L_MovesLeft

@onready var asp_sfx_bomb_explosion: AudioStreamPlayer = %ASP_SFX_BombExplosion

func set_data(won : bool, moves_remaining : int) -> void :
	l_lost.visible = false
	l_won.visible = false
	
	if (won):
		l_won.visible = true
	else:
		l_lost.visible = true
		asp_sfx_bomb_explosion.play()
	
	l_moves_left.text = "Moves left: " + str(moves_remaining)


func _on_b_restart_pressed() -> void:
	restart_level.emit()


func _on_b_next_pressed() -> void:
	next_level.emit()


func _on_b_menu_pressed() -> void:
	main_menu.emit()
