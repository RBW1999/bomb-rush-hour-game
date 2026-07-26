class_name LevelSelectButton
extends Button

signal level_selected(idx : int)

var level_idx : int = 0 :
	get():
		return level_idx
	set(value):
		level_idx = value
		text = str(level_idx + 1)

func _on_pressed() -> void:
	level_selected.emit(level_idx)
