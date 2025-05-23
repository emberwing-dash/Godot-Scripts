extends CharacterBody3D

signal set_movement_state(_movement_state: MovementState)
signal set_movement_direction(_movement_direction: Vector3)

@export var movement_states : Dictionary
var movement_direction : Vector3

func _ready():
	set_movement_state.emit(movement_states["stand"])

func _input(event):
	if event.is_action("movement"):
		movement_direction.x = Input.get_action_strength("left") - Input.get_action_strength("right")
		movement_direction.z = Input.get_action_strength("forward") - Input.get_action_strength("back")
		
		if is_movement_ongoing():
			if Input.is_action_pressed("sprint"):
				set_movement_state.emit(movement_states["sprint"])
			else:
				if Input.is_action_pressed("walk"):
					set_movement_state.emit(movement_states["walk"])
				else:
					set_movement_state.emit(movement_states["run"])
		else:
			set_movement_state.emit(movement_states["stand"])
			
func _physics_process(delta):
	if is_movement_ongoing():
		set_movement_direction.emit(movement_direction)
		
func is_movement_ongoing():
	return abs(movement_direction.x) > 0 or abs(movement_direction.z) > 0
