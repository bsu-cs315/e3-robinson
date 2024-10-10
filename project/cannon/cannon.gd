extends Node3D


signal launched
var launch_angle := -TAU/8
var angle_change_rate := TAU/8
var power := 50.0
var power_change_rate := 10
var swivel := -TAU/8
var swivel_change_rate := TAU/8
var _launched := false

@onready var angle_label: Label = $AngleLabel
@onready var power_label: Label = $PowerLabel
@onready var reload_label: Label = $ReloadLabel
@onready var spawn_point: Marker3D = $CSGCylinder3D/SpawnPoint


func _physics_process(delta: float) -> void:
	var angle_axis := Input.get_axis("angle_down", "angle_up")
	launch_angle += angle_axis * angle_change_rate * delta
	global_rotation.x += angle_axis * angle_change_rate * delta
	
	launch_angle = clampf(launch_angle, deg_to_rad(0), deg_to_rad(90))
	global_rotation.x = clampf(launch_angle, deg_to_rad(0), deg_to_rad(90))
	
	var power_axis := Input.get_axis("power_down", "power_up")
	power += power_axis * power_change_rate * delta
	
	power = clampf(power, 0, 50)
	
	var swivel_axis := Input.get_axis("turn_right", "turn_left")
	swivel += swivel_axis * swivel_change_rate * delta
	global_rotation.y += swivel_axis * swivel_change_rate * delta
	
	angle_label.text = "Angle: %.d" % rad_to_deg(launch_angle)
	power_label.text = "Power: %.d" % power
	
	if Input.is_action_just_pressed("launch") and _launched == false:
		_launched = true
		reload_label.show()
		launch_sound()
		var impulse := self.get_global_transform().basis.z
		var ball: RigidBody3D = preload("res://ball/ball.tscn").instantiate()
		get_parent().add_child(ball)
		launched.emit()
		ball.global_position = spawn_point.global_position
		ball.apply_impulse(-1 * impulse * power)
		await get_tree().create_timer(3).timeout
		reload_label.hide()
		ball.queue_free()
		_launched = false


func launch_sound():
	var audio_stream_player := AudioStreamPlayer.new()
	audio_stream_player.stream = load("res://cannon/launch_sound.mp3")
	audio_stream_player.volume_db = linear_to_db(.2)
	get_parent().add_child(audio_stream_player)
	audio_stream_player.play()
	audio_stream_player.finished.connect(func():
		audio_stream_player.queue_free()
	)
