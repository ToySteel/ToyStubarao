extends Node2D
@onready var sprite = $"../Personagem/Sprite2D2"



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
