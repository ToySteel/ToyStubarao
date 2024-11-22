extends Node2D

# Inicialização dos nós da cena usando @onready
@onready var personagem = $Personagem  # Referência ao personagem
@onready var camera = $Camera  # Referência à câmera
@onready var transition = $transition  # Referência ao controlador de transições
@onready var ainma_ao_do_mundo: AnimationPlayer = $"AINMAÇAO DO MUNDO"  # Referência à animação do mundo
@onready var nadador_1: CharacterBody2D = $"Nadador 1"  # Referência ao nadador 1
@onready var utilitarios: Node2D = $Utilitarios  # Referência aos utilitários da cena (onde está a lava, etc.)

# Variáveis exportadas para o editor, onde podemos configurar o diálogo a ser exibido
@export var dialogue_start: String = "start"  # Ponto de partida do diálogo
@export var dialogue_resource: DialogueResource  # Recurso de diálogo

# Definição de sinais para comunicação entre nós
signal Pos_conversa  # Sinal de interação de conversa

# Função chamada quando a cena é inicializada
func _ready():

	scene_restart()
	# Faz o personagem seguir a câmera
	personagem.follow_camera(camera)
	# Inicia a transição de cena
	transition.des_transition()
	# Atualiza a referência global da câmera
	Globals.camera = camera
	
	# Se o gelo estiver ativado, o nadador realiza uma animação e depois começa um diálogo
	if Globals.Gelo:
		nadador_1.nadano = true  # Ativa a animação de natação do nadador
		personagem.em_dialgo = true  # Ativa o estado de diálogo do personagem
		ainma_ao_do_mundo.set_current_animation("nadano 0")  # Reproduz a animação de natação
		await ainma_ao_do_mundo.animation_finished  # Espera a animação terminar
		nadador_1.nadano = false  # Desativa a animação de natação do nadador
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, "mergulhador_1_Magma_throth")  # Exibe o diálogo
	
	# Exibe a posição do checkpoint atual para debug
	print(get_node(Globals.Checkpoints))

# Função chamada quando a conversa termina
func _on_pos_conversa() -> void:
	# Desativa o estado de diálogo do personagem
	personagem.em_dialgo = false

# Função para reiniciar a cena e reposicionar o personagem no checkpoint atual
func scene_restart():
	# Obtém o nome do checkpoint atual
	var Checkpoint_singleton = Globals.Checkpoints
	# Acessa o nó do checkpoint atual na cena
	var checkpoint_atual = get_node(Checkpoint_singleton)
	# Exibe informações do checkpoint atual para debug
	print(checkpoint_atual)
	print(checkpoint_atual.global_position)
	print(personagem.global_position)
	
	# Verifica qual checkpoint foi ativado e desativa as áreas de lava correspondentes
	if Checkpoint_singleton != "0":
		if Checkpoint_singleton == "1":
			desativar_lava("1")
		if Checkpoint_singleton == "2":
			desativar_lava("1")
			desativar_lava("2")
		if Checkpoint_singleton == "3":
			desativar_lava("1")
			desativar_lava("2")
			desativar_lava("3")
		if Checkpoint_singleton == "4":
			desativar_lava("1")
			desativar_lava("2")
			desativar_lava("3")
			desativar_lava("4")

# Função para desativar a lava com base no número do checkpoint
func desativar_lava(number: String):
	# Acessa o nó de utilitário (onde a lava está localizada) e tenta desativar a lava
	var lava_atual = utilitarios.get_node(number)
	# Aqui, você pode desativar a lava de várias maneiras, por exemplo, ocultando o nó
	lava_atual.visible = false  # Desativa a lava tornando-a invisível
