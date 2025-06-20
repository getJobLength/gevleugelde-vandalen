extends Node2D

@export var ammo_scene: PackedScene
@export var shoot_cooldown := 0.3
var can_shoot := true

func _process(_delta):
	# Pijp volgt horizontaal de muis (alleen x)
	var mouse_pos = get_viewport().get_mouse_position()
	position.x = mouse_pos.x
	
	var global_mouse = get_viewport().get_mouse_position()
	var direction = (global_mouse - global_position).normalized()
	rotation = direction.angle()

	# Roteer richting muis (optioneel, voor visueel effect)
	look_at(mouse_pos)

	if Input.is_action_pressed("Shoot") and can_shoot:
		shoot(mouse_pos)

func shoot(target_pos: Vector2):
	can_shoot = false
	var bullet = ammo_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = $Marker2D.global_position
	bullet.initialize(target_pos)
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true

func _ready():
	position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y)
