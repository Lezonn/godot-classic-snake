extends Area2D

signal slime_collected

@onready var player: Node2D = $"../../Player"

func _on_area_entered(area: Area2D) -> void:
	player.add_new_body_segment()
	slime_collected.emit()
	queue_free()
