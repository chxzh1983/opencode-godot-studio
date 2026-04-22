extends CharacterBody2D

class_name Player

@export var speed: float = 200.0
@export var jump_force: float = -400.0

var _gravity: float = 980.0
var _is_jumping: bool = false

func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta

	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

	if direction > 0:
		scale.x = 1
	elif direction < 0:
		scale.x = -1

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		_is_jumping = true

	move_and_slide()

	if is_on_floor():
		_is_jumping = false
