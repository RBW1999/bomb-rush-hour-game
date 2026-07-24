class_name LevelController
extends Node2D

@onready var level_end: LevelEndUIController = %LevelEnd

var win_conditions : Array[Node]
var blocks : Array[Block]
# TODO var timer

func _ready() -> void:
	level_end.restart_level.connect(on_restart_level)

func on_restart_level() -> void:
	for block : Block in blocks:
		block.reset()

func register_block(block : Block) -> void:
	blocks.append(block)
	block.block_moved.connect(on_block_moved)

func on_block_moved() -> void:
	pass ## TODO increase count down
