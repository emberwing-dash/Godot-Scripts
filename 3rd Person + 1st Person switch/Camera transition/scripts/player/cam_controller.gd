extends Node

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
