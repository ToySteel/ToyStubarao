extends Area2D

@onready var timer_ativo: Timer = $"Timer ativo"
@onready var timer_desativo: Timer = $"Timer desativo"
@onready var anim: AnimatedSprite2D = $aniamtion
@onready var personagem: CharacterBody2D = $"../../Personagem"
@onready var colisao: CollisionShape2D = $colision
@onready var RayLeft: RayCast2D = $"../../Personagem/RayLeft2"
@onready var RayRight: RayCast2D = $"../../Personagem/RayRight2"
@onready var camera: Camera2D = $"../../Camera"
@onready var remecheno: Area2D = $remecheno


@export var Jorravel: bool = true
@export var timer_time: float = 1

var state: String = "Jorrando"

func _ready():
	timer_desativo.start()

func _process(delta):
	_state()


 
func _state():
	if anim.name != state:
		anim.play(state)

func desativar():
	#await anim.animation_looped
	monitoring = false
	if state != "Desligado":
		state = "Desligado"
	$PointLight2D.color = Color(0.498, 0.921, 1)
	Jorravel = false
	$Luz.visible = false


func _on_timer_ativo_timeout():
	if Jorravel:
		monitoring = true
		timer_desativo.start()
		await anim.animation_looped
		if remecheno.get_overlapping_bodies():
			camera.Shake_camera(100, 0.2,20)
		state = "Jorrando"
		$Luz.visible = true
func _on_timer_desativo_timeout():
	if Jorravel:
		monitoring = false
		timer_ativo.start()
		await anim.animation_looped
		state = "Ligado"
		$Luz.visible = false

func _on_body_entered(body: Node2D) -> void:
	print("die")
	if RayLeft.is_colliding():
		personagem.die(Vector2(1000,-1000))
	if RayRight.is_colliding():
		personagem.die(Vector2(-1000,-1000))
