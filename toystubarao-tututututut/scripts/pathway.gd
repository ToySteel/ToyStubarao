extends Area2D
@onready var transition = get_parent().get_node("transition")
@onready var path = "res://Tcns/" + name + ".tscn"

func _on_body_entered(body):
	if path != "":
		Globals.from_world = get_parent().name
		transition.change_scene(true ,path, "no", "no")
