## The Car class has a script attached to it that can move something roughly resembling an actual car.[br]
## The way you use it is to simply attach a mesh or sprite to the car and give it a collider and there you go![br]
## If you have any questions or something is broken, go to the GitHub repository for this project and start a discusion in the 'Issues' tab.[br][br]
## This is the GitHub link, copy this into the browser if any problems were to occur:[br][br]
## https://github.com/VoxelChicken/Godot-CarDriver2D[br][br]
## (Note: Keep in mind though, that this is an open-source project made by VoxelChicken, and won't be updated regularly, but rather, at random.)
class_name Car
extends CharacterBody2D

## Manages the speed of the car. The higher it is, the faster the car is.
@export var acceleration_factor: float = 2.0
## Manages the break speed of the car. The higher it is, the faster the car decelerates from a velocity higher than 0.
@export var break_speed: float = 1.0
## Holds the maximum speed of the car. Remember - as of now, max speed is always slightly overshot because the code isn't as clean yet, but that will likely change in the future.
@export var max_speed: float = 100.0
## Manages the turn speed of the car. The higher it is, the faster the car can turn.
@export var turn_speed: float = 2.0

## Declares a variable that holds an integer and that can have three values: [br][br]
##  [code]-1[/code] -  LEFT (float) [br]
##   [code]0[/code]  -  ZERO (no direction) (float) [br]
##   [code]1[/code]  -  RIGHT (float)
var rotation_direction_input := 0

## Declares a variable that holds an integer and that can have three values: [br][br]
##  [code]-1[/code]  -  LEFT (float) [br]
##   [code]0[/code]  -  ZERO (no direction) (float) [br]
##   [code]1[/code]  -  RIGHT (float)
var velocity_input := 0

## The rotated velocity vector of the car. Since the normal ]velocity vector is solely based on the global Vector2
var rotated_velocity_vector: Vector2

func _process(delta: float) -> void:
	velocity_input = Input.get_axis("accelerate", "decelerate")
	rotation_direction_input = Input.get_axis("turn_left", "turn_right")
	# Handles the inputs and assigns them a value:
	#
	# Up = -1
	# Down = 1
	#
	# Left = -1
	# Right = 1
	
	if rotated_velocity_vector.y != 0: # Checks if the car isn't stationary, since a car that turns and is stationary doesn't really make sense.
		rotation += rotation_direction_input * turn_speed * delta
		# Handles the rotation.
	
	rotated_velocity_vector.y += velocity_input * acceleration_factor * delta * 10
	# Recursively adds to the rotated velocity vector of the car.
	
	rotated_velocity_vector.rotated(deg_to_rad(rotation))
	# Rotates the rotated velocity vector of the player.
	
	velocity = rotated_velocity_vector.rotated(rotation)
	# Assigns the rotated 'rotated_velocity_vector' to the actual velocity
	
	print(rotated_velocity_vector)
	
	if rotated_velocity_vector.y < 0 and velocity_input == 1: # Checks if the car is currently breaking ( [breaking] = [is moving forward and player is holding the deccelerate key] )
		rotated_velocity_vector.y += break_speed / 2 # Deccelerates quickly.
	
	if rotated_velocity_vector.y < -max_speed: # Checks if the speed is greater than (max speed * -1).
		rotated_velocity_vector.y = -max_speed # Sets the speed to the max speed
		
	if rotated_velocity_vector.y > max_speed / 2: # Checks if the reverse speed is greater than (max speed / 2).
		rotated_velocity_vector.y = max_speed / 2 # Sets the speed to (max speed / 2)
	
	move_and_slide()
	# A simple built-in function into Godot that handles movement passively (no parameters required).
	
	# Todo: Make the turning correlated to the current speed of the car, so that the car only turns slightly when the car is moved by a little bit, or that when the car is too fast, the car doesn't turn well.
