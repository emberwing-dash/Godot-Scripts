extends Node

signal set_cam_rotation(_cam_rotation : float)

@onready var cam_yaw = $CamYaw
@onready var cam_pitch = $CamYaw/CamPitch
@onready var camera_3d = $CamYaw/CamPitch/SpringArm3D/Camera3D


var yaw : float = 0
var pitch : float = 0

var yaw_sen : float = 0.07
var pitch_sen : float = 0.07

var yaw_acc : float = 15
var pitch_acc : float = 15

var pitch_max : float = 30
var pitch_min : float = -55

var tween : Tween

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		yaw+= -event.relative.x * yaw_sen
		pitch+= event.relative.y * pitch_sen
		
func _physics_process(delta):
	pitch = clamp(pitch, pitch_min, pitch_max)
	
	cam_yaw.rotation_degrees.y = lerp(cam_yaw.rotation_degrees.y, yaw, yaw_acc * delta)
	cam_pitch.rotation_degrees.x = lerp(cam_pitch.rotation_degrees.x, pitch, pitch_acc * delta)
	
	set_cam_rotation.emit(cam_yaw.rotation.y)
	
func _on_set_movement_state(_movement_state : MovementState):
	if tween:
		tween.kill()
		
	tween = create_tween()
	tween.tween_property(camera_3d, "fov", _movement_state.camera_fov, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
