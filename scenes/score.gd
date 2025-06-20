extends Label
var score = 0 

func _ready() -> void:
	text = "Score 9"

func _on_ammo_hit_increase_score() -> void:
	score += 1
	text = score + 1
	print(score)


func _on_ammo_body_entered(body: Node2D) -> void:
	print("dit werkt oooooooooooooooook")
