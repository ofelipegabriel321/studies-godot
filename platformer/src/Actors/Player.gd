extends Actor

export var stomp_impulse: = 1000.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body: Node) -> void:
	die()

#   Vale como o _process(), mas no caso do _physics, ele se constitui de
# qualquer coisa que envolver física: que vai colidir, detectar o chão,
# detectar as paredes, etc.
#   delta é o tempo passado desde o ultimo frame (última execução do
# _physics_process(). Vamos usar ele para a velocidade do personagem ser
# a mesma independente do FPS. o  representa quantos pixels você se
# move nas diferções.
func _physics_process(delta: float) -> void:
	# is_action_just_released() significa que a pessoa acabou de soltar a tecla.
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	#   Como pusemos a  como uma variável global ao invés de ser algo
	# bem definido na função, precisamos atualizar seu valor.
	#   move_and_slide(): Função do KinematicBody2D, faz o personagem se mover:
	#   floor_normal é um parâmetro para o move_and_slide() que representa um
	# vetor perpendicular ao chão, que aponta para longe dele. Isso é necessário
	# para o gogot saber o que é chão, para ele retornar o boolean que esperamos
	# em is_on_floor()
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	#   Input é uma classe do Godot que permite checar a entrada.
	#   get_action_strength() retorna um valor decimal, que representa o tanto
	# que está sendo pressionado no input (no caso abaixo, em um analógico
	# totalmente para a direita, será retornado o valor 1, e o analógico não
	# estando direcionado nem um pouco, retorna 0). Aqui, a direita vai
	# significar o valor 1 no eixo x e a esquerda como o valor -1 no eixo x.
	# O  está declarado no pai.
	return Vector2 (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_pressed("jump") and is_on_floor() else 0.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out = linear_velocity
	out.y = -impulse
	return out

func die() -> void:
	PlayerData.deaths += 1
	queue_free()
