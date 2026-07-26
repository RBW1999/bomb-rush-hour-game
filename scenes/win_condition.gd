class_name WinCondition
extends Area2D

@export var target : CharacterBody2D
# signal win_condition_update(win_condition: WinCondition, done : bool)

var done := false :
	get():
		return done
	set(value):
		done = value
		# win_condition_update.emit(self, done)

func _ready() -> void:
	assert(target != null)


func _on_body_entered(body: Node2D) -> void:
	if(body == target):
		done = true


func _on_body_exited(body: Node2D) -> void:
	if(body == target):
		done = false
