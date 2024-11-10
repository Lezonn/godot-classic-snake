extends Node

@onready var game_over: CanvasLayer = $GameOver
@onready var timer: Timer = $GameOver/Timer
@onready var restart_text: Label = $GameOver/ColorRect/RestartText

func _process(delta: float) -> void:
	restart_text.text = "Restarting in " + str(timer.wait_time) + " second . ."

func _on_player_head_collide_with_body() -> void:
	get_tree().paused = true
	game_over.visible = true
	timer.start()

func _on_timer_timeout() -> void:
	timer.stop()
	timer.wait_time = 5
	get_tree().paused = false
	get_tree().reload_current_scene()
