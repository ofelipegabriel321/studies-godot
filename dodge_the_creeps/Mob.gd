extends RigidBody2D

export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.
var mob_types = ["walk", "swim", "fly"]

func _ready():
	# randi() % n é a maneira padrão de obter um inteiro aleatório entre 0 e n-1.
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _on_Visibility_screen_exited():
	queue_free()
