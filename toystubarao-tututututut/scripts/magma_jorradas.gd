extends Area2D

@onready var timer_ativo: Timer = $"Timer ativo"
@onready var timer_desativo: Timer = $"Timer desativo"
@onready var anim: AnimatedSprite2D = $aniamtion
@onready var colision: CollisionShape2D = $colision

@export var Jorravel: bool = true
@export var timer_time: float = 1

var state: String = "Jorrando"

func _ready():
	timer_desativo.start()

func _process(delta):
	_state()
func _on_body_entered(body):
	Globals.Morte()
 
func _state():
	if anim.name != state:
		anim.play(state)
 
func desativar():
	#await anim.animation_looped
	colision.disabled = true
	state = "Desligado"
	$PointLight2D.color = Color(0.498, 0.921, 1)
	Jorravel = false
	$Luz.visible = false

func _on_timer_ativo_timeout():
	if Jorravel:
		await anim.animation_looped
		state = "Jorrando"
		colision.disabled = false
		timer_desativo.start()
		$Luz.visible = true
func _on_timer_desativo_timeout():
	if Jorravel:
		await anim.animation_looped
		state = "Ligado"
		colision.disabled = true
		timer_ativo.start()
		$Luz.visible = false
		
