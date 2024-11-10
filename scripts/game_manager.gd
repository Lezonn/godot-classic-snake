extends Node

@onready var score: Label = $Score
@onready var slime: Node2D = %Slime

var score_point = 0

func _on_timer_timeout() -> void:
	# Create slime at random location
	const SLIME = preload("res://scenes/slime.tscn")
	var new_slime = SLIME.instantiate()
	new_slime.global_position.x = randf_range(50, 1200)
	new_slime.global_position.y = randf_range(50, 850)
	new_slime.connect("slime_collected", add_score)
	slime.add_child(new_slime)

func add_score() -> void:
	score_point += 1
	score.text = "Score: " + str(score_point)
