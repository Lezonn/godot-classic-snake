extends Area2D

@onready var player: Node2D = $".."

func _on_area_entered(area: Area2D) -> void:
	player.body_collision()
