extends Node3D


signal hit
var _hit = false

@onready var color: CSGCylinder3D = $CSGCylinder3D


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("balls") and _hit == false:
		color.material.albedo_color = Color.GREEN
		_hit = true
		hit.emit()
