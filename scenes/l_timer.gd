class_name  BlockTimer
extends Label

@export var target_Block : CharacterBody2D
@export var level_controller : LevelController

var start_move_timer : int

@export var move_timer : int :
	set(value):
		move_timer = value
		text = str(move_timer)

func _ready() -> void:
	target_Block.input_pickable = false
	text = str(move_timer)
	start_move_timer = move_timer
	
	level_controller.block_moved.connect(on_block_moved)

func on_block_moved() -> void :
	if (move_timer == 0):
		return
	
	move_timer -= 1
	if (move_timer == 0) :
		target_Block.input_pickable = true

func on_reset() -> void :
	move_timer = start_move_timer
