extends "res://src/Actors/Actor.gd"

func _ready() -> void:
	# A partir disso o physics não executa até o Enemy entra na tela:
	set_physics_process(false)
	_velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	_velocity.y = gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func _on_StompDetector_body_entered(body: Node) -> void:
	#   Comparando a posição y do corpo que está entrando no nosso StompDetector
	# com o StompDetector.
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").set_deferred("disabled", true)
	queue_free()
