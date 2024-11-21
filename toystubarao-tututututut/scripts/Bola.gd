extends Area2D
@onready var personagem: CharacterBody2D = $"../../../../Personagem"
@onready var RayLeft: RayCast2D = $"../../../../Personagem/RayLeft2"
@onready var RayRight: RayCast2D = $"../../../../Personagem/RayRight2"

func _on_body_entered(body: Node2D) -> void:
	print("die")
	if RayLeft.is_colliding():
		personagem.die(Vector2(1000,-1000))
	if RayRight.is_colliding():
		personagem.die(Vector2(-1000,-1000))


func Search(node):
	var pick_Principal = get_parent().get_parent().get_parent().get_parent()
	var persona = pick_Principal.get_node(node)
	print(get_parent().get_parent().get_parent().get_parent().name)
	return persona
