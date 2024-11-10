extends Node2D

signal head_collide_with_body

@onready var snake_head: Area2D = $SnakeHead
@onready var snake_body: Area2D = $SnakeBody

const SNAKE_BODY = preload("res://scenes/snake_body.tscn")
const MOVEMENT = {
	"LEFT": Vector2.LEFT,
	"RIGHT": Vector2.RIGHT,
	"UP": Vector2.UP,
	"DOWN": Vector2.DOWN,
}

const SPEED = 300
const BODY_DISTANCE = 12      # Size of each segment for consistent spacing

var direction = Vector2.RIGHT
var position_history = []     # Keeps track of the head's past positions
var body_segments = []        # Array of snake body segments

func _ready() -> void:
	body_segments.append(snake_body)

func _physics_process(delta: float) -> void:
	# Handle snake head movement
	direction = get_player_direction()
	snake_head.position += delta * SPEED * direction
	position_history.insert(0, snake_head.position)
	
	if position_history.size() > body_segments.size() * BODY_DISTANCE + 1:
		position_history.pop_back()
	
	update_body_position()

func update_body_position():
	for i in range(body_segments.size()):
		var segment = body_segments[i]
		var target_position_index = (i + 1) * BODY_DISTANCE
		
		if target_position_index < position_history.size():
			# Smoothly interpolate toward the target position
			segment.position = position_history[target_position_index]

func get_player_direction() -> Vector2:
	var dir = direction
	
	if Input.is_action_just_pressed("move_down") and direction != MOVEMENT["UP"]:
		dir = MOVEMENT["DOWN"]
	elif Input.is_action_just_pressed("move_up") and direction != MOVEMENT["DOWN"]:
		dir = MOVEMENT["UP"]
	elif Input.is_action_just_pressed("move_left") and direction != MOVEMENT["RIGHT"]:
		dir = MOVEMENT["LEFT"]
	elif Input.is_action_just_pressed("move_right") and direction != MOVEMENT["LEFT"]:
		dir = MOVEMENT["RIGHT"]
		
	return dir

func add_new_body_segment() -> void:
	var body_length = body_segments.size()
	var body = SNAKE_BODY.instantiate()
	body.position = body_segments[body_length - 1].position
	body_segments.append(body)
	call_deferred("add_child", body)

func body_collision() -> void:
	head_collide_with_body.emit()
