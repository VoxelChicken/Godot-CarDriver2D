## The Car class has a script attached to it that can move something roughly resembling an actual car.[br]
## The way you use it is to simply attach a mesh or sprite to the car and give it a collider and there you go![br]
## If you have any questions or something is broken, go to the GitHub repository for this project and start a discussion in the 'Issues' tab.[br][br]
## This is the GitHub link, copy this into the browser if any problems were to occur:[br][br]
## https://github.com/VoxelChicken/Godot-CarDriver2D[br][br]
## (Note: Keep in mind though, that this is an open-source project made by VoxelChicken, and won't be updated regularly, but rather, at random.)
class_name Car
extends CharacterBody2D

#region exported class variables
## Manages the speed of the car. The higher it is, the faster the car is.
@export var acceleration_factor: float = 1.0
## Manages the break speed of the car. The higher it is, the faster the car decelerates from a velocity higher than 0.
@export var break_speed: float = 1.0
## Holds the maximum speed of the car. Remember - as of now, max speed is always slightly overshot because the code isn't as clean yet, but that will likely change in the future.
@export var max_speed: float = 300.0
## Manages the maximum turn strength of the car. The current turn strength of the car is highest at the speed 300 (or also, because of Godot's inverted y axis, it's -300).		
@export var turn_strength: float = 2.0
## This number is the velocity at which the car turns the best. At default, the best turning speed for the car is 300. This, of course, can be changed.
@export var most_ideal_turn_speed: float = 300.0
#endregion exported variables

#region NOT exported class variables
## The rotated velocity vector of the car. Since the normal ]velocity vector is solely based on the global Vector2. It also can't be in the [code]process function[/code], because it doesn't work when constantly gets redeclared.
var rotated_velocity_vector: Vector2
#endregion NOT exported class variables

func _process(delta: float) -> void:
	#region function variables (get renewed after each frame)
	var rotation_direction_input := 0
	# Declares a variable that holds an integer and that can have three values:
	#   -1  -  LEFT (float)
	#   0  -  ZERO (no direction) (float)
	#   1  -  RIGHT (float)
	
	var velocity_input := 0
	# Declares a variable that holds an integer and that can have three values:
	#   -1 -  LEFT (float) [br]
	#   0  -  ZERO (no direction) (float)
	#   1  -  RIGHT (float)
	
	var current_turn_strength: float
	# Declares a variable that makes the car turn better the closer it is to the ideal turning speed
	# (there is one exception though - and that is no velocity at all. When the car is stationary, it obviously can't turn, but if the velocity is positive (alias the car is moving backwards), it can move.)
	#endregion function variables (get renewed after each frame) 
	
	#region input handling
	velocity_input = Input.get_axis("accelerate", "decelerate")
	rotation_direction_input = Input.get_axis("turn_left", "turn_right")
	# Handles the inputs and assigns them a value:
	#
	# Up = -1
	# Down = 1
	#
	# Left = -1
	# Right = 1
	#endregion input handling
	
	#region rotation
	#region rotation (none) while stationary
	if rotated_velocity_vector.y == 0:
		current_turn_strength = 0
	#endregion rotation (none) while stationary
	# For clarification: rotated_velocity_vector.y is NEGATIVE when the car is moving FORWARD, while rotated_velocity_vector.y is POSITIVE when the car is moving BACKWARD. That's why there's a '-' (minus) in front of the rotated_velocity_vector.y in the following if conditionals.
	# (Additionally, rotated_velocity_vector.x isn't being used, since that would mean that the car is also moving sideways, and that's called drifting, but that hasn't been implemented here though.)
	#region rotation while moving forward
	elif -rotated_velocity_vector.y > 0 and -rotated_velocity_vector.y <= most_ideal_turn_speed:
		current_turn_strength = turn_strength * (-rotated_velocity_vector.y / most_ideal_turn_speed)
		
	elif -rotated_velocity_vector.y > most_ideal_turn_speed:
		current_turn_strength = turn_strength - ((-rotated_velocity_vector.y - most_ideal_turn_speed) / max_speed)
	#endregion rotation while moving forward
	
	#region rotation while moving backward
	elif -rotated_velocity_vector.y < 0 and -rotated_velocity_vector.y >= -most_ideal_turn_speed:
		current_turn_strength = turn_strength * (-rotated_velocity_vector.y / most_ideal_turn_speed)
		
	elif -rotated_velocity_vector.y > -most_ideal_turn_speed:
		current_turn_strength = turn_strength - ((rotated_velocity_vector.y - most_ideal_turn_speed) / max_speed)
	#endregion rotation while moving backward
	
	rotation += rotation_direction_input * current_turn_strength * delta
	# Handles the rotation during the input - the if conditionals above weren't enough to handle the rotation itself.
	#endregion rotation
	
	#region vector math
	rotated_velocity_vector.y += velocity_input * acceleration_factor * delta * 60
	# Recursively adds to the rotated velocity vector of the car.
	
	rotated_velocity_vector.rotated(deg_to_rad(rotation))
	# Rotates the rotated velocity vector of the player.
	
	velocity = rotated_velocity_vector.rotated(rotation)
	# Assigns the rotated 'rotated_velocity_vector' to the actual velocity
	#endregion vector math
	
	#region breaks
	if -rotated_velocity_vector.y > 0 and velocity_input == 1: # Checks if the car is currently breaking ( [breaking] = [is moving forward and player is holding the deccelerate key] )
		rotated_velocity_vector.y += break_speed / 2 # Deccelerates quickly.
	if -rotated_velocity_vector.y < 0 and velocity_input == -1: # Checks if the car is currently breaking ( [breaking] = [is moving backward and player is holding the accelerate key] )
		rotated_velocity_vector.y -= break_speed / 2 # Deccelerates quickly.
	#endregion breaks
	
	#region speedlimit
	if rotated_velocity_vector.y < -max_speed: # Checks if the speed is greater than (max speed * -1).
		rotated_velocity_vector.y = -max_speed # Sets the speed to the max speed
		
	if rotated_velocity_vector.y > max_speed / 2: # Checks if the reverse speed is greater than (max speed / 2).
		rotated_velocity_vector.y = max_speed / 2 # Sets the speed to (max speed / 2)
	#endregion speedlimit

	move_and_slide()
	# A simple built-in function into Godot that handles movement passively (no parameters required).
	
