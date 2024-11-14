extends Node2D
#onready var's


#var's
var from_world
var Missoes = 0 
var Texto_missoes
var transmissor = "false"
var chave_hollow_path = false
var Game_point = "Start"
var camera = null
#func _ready() -> void:

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
	if Input.is_action_just_pressed("ui_end"):
		from_world = "Hollow_path"
		Game_point = "Hollow_Path_Pos"
		

######################################################
