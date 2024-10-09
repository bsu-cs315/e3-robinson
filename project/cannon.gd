extends Node3D


signal launched_ball(ball: Ball)
@export var launch_angle := -TAU/8
@export var angle_change_rate := TAU/8
@export var power := 800.0
@export var power_change_rate := 100
@export var swivel := -TAU/8
@export var swivel_change_rate := TAU/8
var _launched := false

@onready var cannon_shaft: CSGCylinder3D = $CSGCylinder3D
@onready var angle_label: Label = $Camera3D/AngleLabel
@onready var power_label: Label = $Camera3D/PowerLabel


func _physics_process(delta: float) -> void:
	var angle_axis := Input.get_axis("angle_down", "angle_up")
	launch_angle += angle_axis * angle_change_rate * delta
	global_rotation.x += angle_axis * angle_change_rate * delta
	
	launch_angle = clampf(launch_angle, deg_to_rad(0), deg_to_rad(90))
	global_rotation.x = clampf(launch_angle, deg_to_rad(0), deg_to_rad(90))
	
	var power_axis := Input.get_axis("power_down", "power_up")
	power += power_axis * power_change_rate * delta
	
	power = clampf(power, 0, 100)
	
	var swivel_axis := Input.get_axis("turn_right", "turn_left")
	swivel += swivel_axis * swivel_change_rate * delta
	global_rotation.y += swivel_axis * swivel_change_rate * delta
	
	angle_label.text = "Angle: %.d" % rad_to_deg(launch_angle)
	power_label.text = "Power: %.d" % power
