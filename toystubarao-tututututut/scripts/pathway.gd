extends Area2D  # A classe Area2D é usada para detectar colisões com outros objetos no jogo

# Referência ao nó de transição da cena
@onready var transition = get_parent().get_node("transition")

# Caminho dinâmico para o arquivo de cena baseado no nome do nó
@onready var path = "res://Tcns/" + name + ".tscn"  # Constrói o caminho para a cena a ser carregada

# Função chamada quando um corpo entra na área de detecção (provavelmente o personagem)
func _on_body_entered(body):
	# Verifica se o caminho da cena não está vazio
	if path != "":
		if !Globals.from_world == get_parent().name + "DP":
			Globals.from_world = get_parent().name
		
		# Chama a função de transição de cena, passando o caminho da nova cena
		transition.change_scene(true, path, "no", "no")


func _on_magma_throth_pombas_2() -> void:
	Globals.from_world = get_parent().name + "DP"
