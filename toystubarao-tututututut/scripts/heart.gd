extends Area2D

# Variáveis OnReady: são inicializadas assim que o nó entra na cena
@onready var animation = $animation  # Referência para o nó de animação
@onready var colision = $colision  # Referência para o nó de colisão
@onready var Luz: PointLight2D = $PointLight2D  # Referência para a luz do ponto
@onready var dangers = $"../../dangers"  # Referência para o nó de perigos

# Variáveis do estado e controle
var state = "Normal"  # Estado inicial da animação
@export var AND = "Normal"  # Estado exportado, pode ser configurado no editor

# Função chamada a cada frame, 'delta' é o tempo desde o último frame
func _process(delta):
	_state()  # Verifica a animação atual a cada frame

# Função que verifica a animação atual
func _state():
	if animation.name != state:  # Se a animação atual não for o estado desejado
		animation.play(state)  # Reproduz a animação do estado atual

# Função que é chamada quando um corpo entra na área (detecção de colisão)
func _on_body_entered(body):
	body_entered(body)  # Chama a função para lidar com o corpo que entrou

# Função para lidar com o corpo que entrou na área
func body_entered(body = null):
	if Globals.Gelo:  # Verifica se a variável Gelo está ativa (verdadeira)
		Globals.Checkpoints = name  # Define o checkpoint atual para o nome da área
		lava_adjacente()  # Chama a função para verificar se há lava adjacente
		state = "ice"  # Altera o estado para "ice" (gelo)
		Luz.color = Color(0.498, 0.921, 1)  # Altera a cor da luz para azul claro (gelo)
		
		# Chama a função lava_adjacente para verificar e desativar a lava adjacente
		print(lava_adjacente())  # Imprime a lava adjacente no console (para depuração)
		if lava_adjacente() != null:  # Se houver lava adjacente
			lava_adjacente().desativar() == OK  # Desativa a lava adjacente (se a função retornar OK)

		# Verifica qual o valor de "AND" para desativar certas áreas perigosas
		if AND == "Cu_na_terra":  # Se o valor for "Cu_na_terra"
			$"../L3_3".desativar()  # Desativa as áreas de perigo L3_3 e L4_3
			$"../L4_3".desativar()
		if AND == "Butao_na_terra":  # Se o valor for "Butao_na_terra"
			$"../L5_4".desativar()  # Desativa as áreas de perigo L5_4, L6_4, L7_4, L8_4 e L9_4
			$"../L6_4".desativar()
			$"../L7_4".desativar()
			$"../L8_4".desativar()
			$"../L9_4".desativar()

	return  # Retorna do método (finaliza a execução da função)

# Função para verificar se há lava adjacente à área atual
func lava_adjacente():
	var lava = get_parent().get_node("L" + name)  # Busca por um nó de lava baseado no nome da área
	return lava  # Retorna o nó de lava encontrado
