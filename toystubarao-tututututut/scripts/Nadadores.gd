extends CharacterBody2D
signal Cutscene



func _on_area_de_cutscene_body_entered(body: Node2D) -> void:
	emit_signal("Cutscene")
