extends Path2D
@onready var Bola1: PathFollow2D = get_node("Bola1")
@onready var Bola2: PathFollow2D = get_node("Bola2")
@onready var Bola3: PathFollow2D = get_node("Bola3")
var girando:bool = true
@export var velocity: float = 3.5

func _process(delta: float) -> void:
	if Bola1 != null:
		Bolas_girando(Bola1, "1") == OK
	if Bola2 != null:
		Bolas_girando(Bola2, "2") == OK
	if Bola3 != null:
		Bolas_girando(Bola3, "3") == OK
func Bolas_girando(Bola: PathFollow2D, numeraçao: String):
	if girando:
		var bolas_girando: Tween = get_tree().create_tween()
		bolas_girando.tween_property(Bola, "progress_ratio", -1, velocity).from(get_Bola(Bola))
	else:
		var Bola_em_questao: Area2D = get_node("Bola" + numeraçao).get_node("Bola")
		var colisao_bola: CollisionShape2D = Bola_em_questao.get_node("colision")
		var animaçao_bola: AnimatedSprite2D = Bola_em_questao.get_node("Fireball")
		colisao_bola.disabled = true
		animaçao_bola.visible = false
		Bola_em_questao.visible = false
func get_Bola(cu: PathFollow2D):
	var bola: float = cu.get("progress_ratio")
	return bola
func desativar():
	girando = false
