extends PanelContainer
class_name MoveController

@onready var moves_int: Label = %Moves_Int

func set_move_counter(moves : int ) -> void :
	moves_int.text = str(moves)
