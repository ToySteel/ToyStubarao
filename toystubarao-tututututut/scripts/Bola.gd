extends Area2D

# Carrega o nó 'CharacterBody2D' do personagem assim que o nó é carregado.
@onready var personagem: CharacterBody2D = $"../../../../Personagem"

# Carrega o nó 'RayCast2D' que representa o raio para a esquerda do personagem.
@onready var RayLeft: RayCast2D = $"../../../../Personagem/RayLeft2"

# Carrega o nó 'RayCast2D' que representa o raio para a direita do personagem.
@onready var RayRight: RayCast2D = $"../../../../Personagem/RayRight2"

# Função chamada quando um corpo (body) entra na área deste objeto.
func _on_body_entered(body: Node2D) -> void:
	# Imprime "die" no console, indicando que o personagem deve morrer.
	print("die")
	
	# Verifica se o raio esquerdo está colidindo com algo.
	if RayLeft.is_colliding():
		# Se houver colisão com o raio esquerdo, chama a função 'die' no personagem,
		# empurrando-o para a direita e para cima.
		personagem.die(Vector2(1000, -1000))
	
	# Verifica se o raio direito está colidindo com algo.
	if RayRight.is_colliding():
		# Se houver colisão com o raio direito, chama a função 'die' no personagem,
		# empurrando-o para a esquerda e para cima.
		personagem.die(Vector2(-1000, -1000))

# Função que procura um nó específico na cena.
func Search(node):
	# Navega para o nó principal, subindo quatro níveis na hierarquia de nós.
	var pick_Principal = get_parent().get_parent().get_parent().get_parent()
	
	# Obtém o nó solicitado (usando o caminho fornecido pelo argumento 'node').
	var persona = pick_Principal.get_node(node)
	
	# Imprime o nome do nó principal no console.
	print(get_parent().get_parent().get_parent().get_parent().name)
	
	# Retorna o nó encontrado.
	return persona
