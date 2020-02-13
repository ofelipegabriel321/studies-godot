extends Area2D

signal hit
export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):	
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		# caso ele esteja olhando para baixoa antes de ir pro lado agora
		# ele vai olhar para cima
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

# warning-ignore:unused_argument
func _on_Player_area_entered(area):
	hide() # o personagem desaparece quando ocorre o hit
	emit_signal("hit")
	# desativar a colisão do jogador para que não acione o sinal
	# hit mais de uma vez.
	$CollisionShape2D.set_deferred("disabled", true)
