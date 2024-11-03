extends Node2D

var transmissor = "false"
@onready var sprite = $Personagem/Sprite2D2
signal Fim_de_conversa

var Missoes = 0 
var Texto_missoes



func _process(delta):
	#if Input.is_action_just_pressed("ui_accept"):
		#Missoes += 1
	if Missoes == 0:
		Texto_missoes ="Fale Com a mulher holograma"
	if Missoes == 1:
		Texto_missoes = "Fale Com a mulher holograma[OK]
		Va ate o fundo da caverna
		"
	













#################################################
func _on_area_2d_body_entered(body):
	sprite.modulate = Color(0.596, 0.596, 0.596, 0.145)
func _on_area_2d_3_body_entered(body):
	sprite.modulate = Color(0.498, 0.498, 0.498, 0.224)
func _on_area_2d_5_body_entered(body):
	sprite.modulate = Color(0.388, 0.388, 0.388, 0.224)
func _on_area_2d_7_body_entered(body):
	sprite.modulate = Color(0.278, 0.278, 0.278, 0.224)
func _on_area_2d_9_body_entered(body):
		sprite.modulate = Color(0.168, 0.168, 0.168, 0.224)
func _on_area_2d_10_body_entered(body):
		sprite.modulate = Color(0.113-55, 0.113-55, 0.113-55, 0.224)
####################################################

func _on_fim_de_conversa():
	print("asssssssssssssss")
