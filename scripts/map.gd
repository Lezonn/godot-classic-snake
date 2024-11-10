extends Node

@onready var bottom_border: Area2D = $BottomBorder
@onready var right_border: Area2D = $RightBorder
@onready var top_border: Area2D = $TopBorder
@onready var left_border: Area2D = $LeftBorder

func _on_bottom_border_area_entered(area: Area2D) -> void:
	print("bottom")
	area.global_position.y = top_border.global_position.y + 50

func _on_right_border_area_entered(area: Area2D) -> void:
	print("right")
	area.global_position.x = left_border.global_position.x + 50

func _on_top_border_area_entered(area: Area2D) -> void:
	print("top")
	area.global_position.y = bottom_border.global_position.y - 50

func _on_left_border_area_entered(area: Area2D) -> void:
	print("left")
	area.global_position.x = right_border.global_position.x  - 50
