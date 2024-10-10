extends Node3D


@export var score := 0
@export var shots_fired := 0

@onready var score_label: Label = $Cannon/ScoreLabel
@onready var shots_fired_label: Label = $Cannon/ShotsFired

func _process(_delta: float) -> void:
	score_label.text = "Score: %.d" % score
	shots_fired_label.text = "Shots: %.d" % shots_fired
	if score == 3:
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://title_screen/title_screen.tscn")


func _on_cannon_launched() -> void:
	shots_fired += 1


func _on_target_hit() -> void:
	score += 1
