extends Node2D

@export var bird_prefab : PackedScene
@export var cable_node: Area2D 

func _on_timer_timeout() -> void:
	var bird = bird_prefab.instantiate()
	bird.cable_node = cable_node  
	add_child(bird)
