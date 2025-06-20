extends Node

var game_running: bool
var game_stopped: bool

@export var bird_scene: PackedScene
@export var bird_spawn_interval := 2.5  

var bird_spawn_timer := 0.0


func _ready(): 
	new_game()
	
func new_game(): 
	game_running = false
	game_stopped = false

func start_game(): 
	game_running = true
	
func spawn_bird():
	if bird_scene:
		var bird = bird_scene.instantiate()
		add_child(bird)


func _process(delta):
	if game_running and not game_stopped:
		bird_spawn_timer += delta
		if bird_spawn_timer >= bird_spawn_interval:
			bird_spawn_timer = 0
			spawn_bird()
