class_name LevelController
extends Node2D

@onready var level_end: LevelEndUIController = %LevelEnd
@onready var move_countdown: MoveController = %MoveCountdown

@export var level_moves : int 
@export var win_conditions : Array[WinCondition]

var remaining_moves : int :
	get():
		return remaining_moves
	set(value):
		remaining_moves = value
		move_countdown.set_move_counter(remaining_moves)

var blocks : Array[Block]

func _ready() -> void:
	level_end.restart_level.connect(on_restart_level)
	move_countdown.set_move_counter(level_moves)
	
	remaining_moves = level_moves

func on_restart_level() -> void:
	move_countdown.set_move_counter(level_moves)
	remaining_moves = level_moves
	
	for block : Block in blocks:
		block.reset()
	
	for win_c : WinCondition in win_conditions:
		win_c.done = false
	
	level_end.visible = false

func register_block(block : Block) -> void:
	blocks.append(block)
	block.block_moved.connect(on_block_moved)

func check_all_win_conditions() -> bool:
	var all_conditions_done := true
	
	for win_c in win_conditions:
		all_conditions_done = all_conditions_done and win_c.done
	
	return all_conditions_done

func on_block_moved() -> void:
	remaining_moves -= 1
	
	if (check_all_win_conditions()):
		level_end.visible = true
		level_end.set_data(true, remaining_moves)
		return
	
	elif (remaining_moves == 0):
		# end level
		level_end.visible = true
		level_end.set_data(false, remaining_moves)
