extends Node3D


@export var score := 0
@export var times_fired := 0


func _on_cannon_launched() -> void:
	times_fired += 1


func _on_target_hit() -> void:
	score += 1
