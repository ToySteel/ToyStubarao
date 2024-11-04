extends Node2D
@onready var sprite = $"../Personagem/Sprite2D2"
@onready var point_light_2d: PointLight2D = $"../Personagem/PointLight2D"



#################################################
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	sprite.modulate = Color(0.118, 0.522, 0.847, 0.176)
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


func _on_escuridao_sala_body_entered(body: Node2D) -> void:
	sprite.modulate = Color(0.118, 0.522, 0.847, 0.176)
	point_light_2d.visible = true

func _on_claridade_sala_body_entered(body: Node2D) -> void:
	sprite.modulate = Color(0.118, 0.522, 0.847, 0.176)
	point_light_2d.visible = false
func _on_claridade_caverna_body_entered(body: Node2D) -> void:
	sprite.modulate = Color(0.118, 0.522, 0.847, 0.176)
	point_light_2d.visible = false

func _on_escuridao_caverna_body_entered(body: Node2D) -> void:
	sprite.modulate = Color(0.118, 0.522, 0.847, 0.176)
	point_light_2d.visible = true
