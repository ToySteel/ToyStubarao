extends Node2D
#onready var's

func _ready() -> void:
	var array = [1, 2, 3]
	array += [4]
	print(array)
#var's
var from_world
var Missoes = 0 
var Texto_missoes
var transmissor = "false"
var chave_hollow_path = false
var Game_point = "Start"
var camera = null
var Gelo = true
var Checkpoints: String = "0"
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
	if Missoes == 3:
		Texto_missoes = "Fale Com a mulher holograma[OK]
		Va ate o fundo da caverna[OK]
		Va atraz de uma das luzes[OK]
		Proucure o mergulhador
		"
	if Missoes == 4:
		Texto_missoes = "Fale Com a mulher holograma[OK]
		Va ate o fundo da caverna[OK]
		Va atraz de uma das luzes[OK]
		Proucure o mergulhador[ERRO]
		Ehh... Esta trancado, e nao sei onde esta a chave
		Mas aquele mato um pouco atraz estava muito suspeito
		"
	if Missoes == 5:
		Texto_missoes = "Fale Com a mulher holograma[OK]
		Va ate o fundo da caverna[OK]
		Va atraz de uma das luzes[OK]
		Entre na caverna e proucure uma chave para abrir a porta
		"
	if Missoes == 6:
		Texto_missoes = "Fale Com a mulher holograma[OK]
		Va ate o fundo da caverna[OK]
		Va atraz de uma das luzes[OK]
		Entre na caverna e proucure uma chave para abrir a porta[OK]
		Proucure o mergulhador
		"
	if Missoes == 7:
		Texto_missoes = "Va ate Magma Throth
		"
	if Input.is_action_just_pressed("ui_end"):
		from_world = "Hollow_path"
		Game_point = "Hollow_Path_Pos"
		

######################################################
