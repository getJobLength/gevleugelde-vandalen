extends CharacterBody2D

#const START_POS = Vector2(100, 400)
const SCALE_SPEED = 0.04
const FLY_SPEED = 80
const FALL_SPEED = 250
const SCREEN_BOUNDS = Rect2(Vector2(-500, -390), Vector2(975, 648))

var direction = Vector2(1, -1).normalized()
var is_falling = false
var on_cable = false
var hit = false

@export var cable_node: Area2D

func _ready():
	reset()
	add_to_group("bird")

func reset():
	scale = Vector2(0.10, 0.10)
	is_falling = false
	on_cable = false
	velocity = Vector2.ZERO

	var random_sign_x = 100 if randf() > 0.5 else -100
	var random_sign_y = RandomNumberGenerator.new().randf_range(0, -170)
	direction = Vector2(random_sign_x, random_sign_y).normalized()

func _on_high_voltage_cable_hit():
	print("[INFO] Bird touched cable")
	if is_falling:
		is_falling = false
		on_cable = true
		velocity = Vector2.ZERO
		direction = Vector2.ZERO  
		scale = Vector2(0.50, 0.50) 
		#position = Vector2(get_position_delta().x, get_position_delta().y)
		$AnimatedSprite2D.set_frame(1)

func hit_by_bullet():
	print("[INFO] Bird is hit by bullet")
	hit = true
	is_falling = false
	on_cable = false
	velocity = Vector2.ZERO
	position.y -= 20
	scale = scale
	var screen_center_x = SCREEN_BOUNDS.position.x + SCREEN_BOUNDS.size.x / 2

	if global_position.x < screen_center_x:
		direction = Vector2(-1, -0.25).normalized() * 3  # Vlieg naar linksboven
		$AnimatedSprite2D.flip_h = false
	else:
		direction = Vector2(1, -0.25).normalized() * 3   # Vlieg naar rechtsboven
		$AnimatedSprite2D.flip_h = true
	


func _physics_process(delta):	
	if get_position_delta().x > 1000 && hit || get_position_delta().x < -5 && hit: 
		queue_free()
		print("[INFO] Bird removed because he was not in screen at position: ")
		print(get_position_delta())
		
	if on_cable:
		return #damage emitten of func do_damage

	if not on_cable and position.y <= SCREEN_BOUNDS.position.y:
		is_falling = true

	if is_falling:
		velocity.y += FALL_SPEED * delta
		position.y += velocity.y * delta
		if scale < Vector2(0.50, 0.50):
			scale += Vector2(SCALE_SPEED, SCALE_SPEED) * 1.5
	else:
		position += direction * FLY_SPEED * delta
		scale += Vector2(SCALE_SPEED, SCALE_SPEED) * delta

		if position.x <= SCREEN_BOUNDS.position.x && !hit:
			position.x = SCREEN_BOUNDS.position.x
			direction.x = abs(direction.x)
			$AnimatedSprite2D.flip_h = true
		elif position.x >= SCREEN_BOUNDS.position.x + SCREEN_BOUNDS.size.x && !hit:
			position.x = SCREEN_BOUNDS.position.x + SCREEN_BOUNDS.size.x
			direction.x = -abs(direction.x)
			$AnimatedSprite2D.flip_h = false
			
	if scale >= Vector2(0.50, 0.50):
		scale = Vector2(0.50, 0.50)
