extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("bird"):
		body._on_high_voltage_cable_hit()
