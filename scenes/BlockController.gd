class_name Block
extends CharacterBody2D

@export_enum("X","Y") var movement_direction : String = "X"
const GRID_SIZE : int = 128

var dragging := false
var last_mouse_pos : Vector2
var start_pos : Vector2
var level_controller : LevelController

var drag_start_pos : Vector2

signal block_moved

func _ready() -> void:
	start_pos = position
	
	# get Level Controller | two parents up
	var levelController: Node = get_parent().get_parent()
	assert(levelController is LevelController, "ParentParent is no LevelController")
	level_controller = levelController as LevelController
	
	level_controller.register_block(self)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouse):
		if (event.is_action_pressed("DragBlock")):
			dragging = true
			last_mouse_pos = get_global_mouse_position()
			drag_start_pos = position
		elif (event.is_action_released("DragBlock")):
			release_block()

func release_block() -> void:
	dragging = false
	last_mouse_pos = Vector2(-1,-1)
	snap_to_position()
	
	if (drag_start_pos != position):
		block_moved.emit()

func _physics_process(_delta: float) -> void:
	if (not dragging):
		return
	
	if (dragging and not Input.is_action_pressed("DragBlock")):
		release_block()
		return
	
	if (last_mouse_pos == Vector2(-1,-1)):
		last_mouse_pos = get_global_mouse_position()
		return
	
	var new_mouse_pos = get_global_mouse_position()
	
	var offset : Vector2 = new_mouse_pos - last_mouse_pos
	var axis_offset : Vector2
	
	
	if (movement_direction == "X"):
		axis_offset = Vector2(offset.x, 0)
		
		
	elif (movement_direction == "Y"):
		axis_offset = Vector2(0, offset.y)
	
	move_and_collide(axis_offset)
	
	last_mouse_pos = new_mouse_pos

func snap_to_position() -> void:
	var x : float = round(position.x / GRID_SIZE) * GRID_SIZE
	var y : float = round(position.y / GRID_SIZE) * GRID_SIZE
	
	position = Vector2(x,y)
	pass

func reset() -> void:
	position = start_pos
