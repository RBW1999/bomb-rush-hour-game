class_name LevelEndUIController
extends PanelContainer

signal next_level
signal restart_level


func _on_b_restart_pressed() -> void:
	restart_level.emit()


func _on_b_next_pressed() -> void:
	next_level.emit()
