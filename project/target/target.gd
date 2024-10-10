extends Node3D


signal hit
var _hit = false

@onready var color: CSGCylinder3D = $CSGCylinder3D


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("balls") and _hit == false:
		color.material.albedo_color = Color.GREEN
		_hit = true
		hit_sound()
		hit.emit()


func hit_sound():
	var audio_stream_player := AudioStreamPlayer.new()
	audio_stream_player.stream = load("res://target/hit_sound.wav")
	audio_stream_player.volume_db = linear_to_db(.2)
	get_parent().add_child(audio_stream_player)
	audio_stream_player.play()
	audio_stream_player.finished.connect(func():
		audio_stream_player.queue_free()
	)
