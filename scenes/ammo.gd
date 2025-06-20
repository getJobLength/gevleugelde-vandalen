extends Area2D

signal hit

const SPEED = 600
const START_POS = Vector2(100000, 1000000)
var velocity = Vector2.ZERO

func _ready():
	position = START_POS

func initialize(target: Vector2):
	look_at(target)
	velocity = (target - global_position).normalized() * SPEED

func _physics_process(delta):
	global_position += velocity * delta
	
	if not get_viewport_rect().has_point(global_position):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("bird"):
		body.hit_by_bullet()
		queue_free()
