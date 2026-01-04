class_name Car
extends CharacterBody2D

## Manages the speed of the car. The higher it is, the faster the car is.
@export var acceleration_factor: float = 2.0
## Manages the break speed of the car. The higher it is, the faster the car deccelerates from a velocity higher than 0.
@export var break_speed: float = 2.0
##
@export var max_speed: float = 100.0
## Manages the turn speed of the car. The higher it is, the faster the car can turn.
@export var turn_speed = 2

var rotation_direction_input := 0
# Declares a variable that holds an integer and that can have three values:
#  -1 -  LEFT (float)
#   0  -  ZERO (no direction) (float)
#   1  -  RIGHT (float)

var velocity_input := 0
# Declares a variable that holds an integer and that can have three values:
#  -1  -  LEFT (float)
#   0  -  ZERO (no direction) (float)
#   1  -  RIGHT (float)

var rotated_velocity_vector: Vector2

func _process(delta: float) -> void:
	velocity_input = Input.get_axis("ui_up", "ui_down")
	rotation_direction_input = Input.get_axis("ui_left", "ui_right")
	# Handles the inputs and assigns them a value:
	#
	# Up = -1
	# Down = 1
	#
	# Left = -1
	# Right = 1
	
	rotation += rotation_direction_input * turn_speed * delta
	# Handles the rotation.
	
	if rotated_velocity_vector.y + velocity_input * acceleration_factor * delta * 10 < max_speed or rotated_velocity_vector.y + velocity_input * acceleration_factor * delta * 10 > max_speed:
		rotated_velocity_vector.y += velocity_input * acceleration_factor * delta * 10
		# Recursively adds to the rotated velocity vector of the car.
	print(rotated_velocity_vector)
	
	rotated_velocity_vector.rotated(deg_to_rad(rotation))
	# Rotates the rotated velocity vector of the player.
	
	velocity = rotated_velocity_vector.rotated(rotation)
	# Assigns the rotated 'rotated_velocity_vector' to the actual velocity
	
	move_and_slide()
	# A simple built-in function into Godot that handles movement passively (no parameters required).
