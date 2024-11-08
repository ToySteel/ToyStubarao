extends CanvasLayer
#onready var'S
@onready var personagem = $"../Personagem"
@onready var color_rect = $ColorRect
#funcao da transiçao
func change_scene( cena, path, posiçao_x, posiçao_y, delay = 1):
	var scene_transition = get_tree().create_tween()
	scene_transition.tween_property(color_rect, "Progress", 4.0, 1)
	await scene_transition.finished
	if cena == true:
		assert(get_tree().change_scene_to_file(path) == OK)
	if cena == false:
		personagem.position.x = posiçao_x
		personagem.position.y = posiçao_y
		des_transition()
#desativador de transiçao
func des_transition():
	var show_transition = get_tree().create_tween()
	show_transition.tween_property(color_rect, "Progress", 0.0, 1).from(4.0)
