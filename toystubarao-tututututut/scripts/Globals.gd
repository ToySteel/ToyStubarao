extends Node2D
#onready var's
@onready var sprite = $Personagem/Sprite2D2
@onready var transition = $transition
@export var path = ""
@onready var personagem = $Personagem
#var's
var from_world = null
var Missoes = 0 
var Texto_missoes
var transmissor = "false"
signal Fim_de_conversa
signal LUZ
#Missoes
func _process(delta):
	if Missoes == 0:
		Texto_missoes ="Fale Com a mulher holograma"
	if Missoes == 1:
		Texto_missoes = "Fale Com a mulher holograma[OK]
		Va ate o fundo da caverna
		"
	if Missoes == 2:
		Texto_missoes = "Fale Com a mulher holograma[OK]
		Va ate o fundo da caverna[OK]
		Va atraz de uma das luzes
		"


func _on_fim_de_conversa():
	print("asssssssssssssss")
#######################################################
#transiçoes
func _on_hollow_path_body_entered(body: Node2D) -> void:
	Globals.from_world = get_parent().name
	transition.change_scene(true ,path, 15087, 1004)
########################################################
func _ready() -> void:
	if from_world != null:
		personagem.global_position = get_node(Globals.from_world)
