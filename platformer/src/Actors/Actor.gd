#   Significa que esse script terá todas as funcionalidades da classe
# KinematicBody2D:
extends KinematicBody2D
#   Aqui é necessário criar a classe, pois esse script não está diretamente
# ligado a uma cena. No caso para ele poder ser usado no Player e Enemy:
class_name Actor

const FLOOR_NORMAL: = Vector2.UP

# Rapidez aplicada para andar e pular.
export var speed: = Vector2(300.0, 1000.0)
# Gravidade aplicada sempre.
export var gravity: = 4000.0
# Velocidade, padrão 0, que representa que o personagem está parado
var _velocity: = Vector2.ZERO
