#   Significa que esse script terá todas as funcionalidades da classe
# KinematicBody2D:
extends KinematicBody2D
#   Aqui é necessário criar a classe, pois esse script não está diretamente
# ligado a uma cena. No caso para ele poder ser usado no Player e Enemy:
class_name Actor

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0

var velocity: = Vector2.ZERO

#   Vale como o _process(), mas no caso do _physics, ele se constitui de
# qualquer coisa que envolver física: que vai colidir, detectar o chão,
# detectar as paredes, etc.
func _physics_process(delta: float) -> void:
	#   delta é o tempo passado desde o ultimo frame (última execução do
	# _physics_process(). Vamos usar ele para a velocidade do personagem ser
	# a mesma independente do FPS. o velocity representa quantos pixels você se
	# move nas diferções.
	velocity.y += gravity * delta
	#   Como pusemos a velocity como uma variável global ao invés de ser algo
	# bem definido na função, precisamos atualizar seu valor.
	#   move_and_slide(): Função do KinematicBody2D, faz o personagem se mover:
	velocity = move_and_slide(velocity)
