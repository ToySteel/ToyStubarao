extends Node2D

# Variáveis @onready: são inicializadas quando os nós são carregados na cena
@onready var anim = $"Area Navio/AnimationPlayer" as AnimationPlayer  # Animação do navio
@onready var Bau = $"Area Navio/Bau/Sprite2D" as Sprite2D  # Baú no navio
@onready var bolha = $"Area Navio/bolha" as Area2D  # Bolha interativa
@onready var personagem = $Personagem as CharacterBody2D  # Referência para o personagem
@onready var transition = $transition as CanvasLayer  # Transição de tela
@onready var anima_mundo = $"animaçao do mundo" as AnimationPlayer  # Animação do mundo
@onready var light_occluder_2d = $Mato/LightOccluder2D as LightOccluder2D  # Luz no mato
@onready var porta = $porta as StaticBody2D  # Porta no cenário
@onready var anima_porta = $porta/AnimatedSprite2D as AnimatedSprite2D  # Animação da porta
@onready var ligh_porta = $porta/LightOccluder2D as LightOccluder2D  # Luz da porta
@onready var camera = $Camera2D as Camera2D  # Câmera principal
@onready var anima_world = $"animaçao do mundo" as AnimationPlayer  # Animação do mundo
@onready var marker_2d_2: Marker2D = $Marker2D2  # Marcador 2D para referência de posição

# Variáveis exportadas: podem ser configuradas no editor
@export var path = "res://Tcns/Main_world.tscn"  # Caminho para a cena principal
@export var dialogue_start: String = "start"  # Ponto inicial do diálogo
@export var dialogue_resource: DialogueResource  # Recurso de diálogo

# Variáveis locais
var cutscene = false  # Flag para indicar se a cutscene está ativa

# Sinais (signals) para comunicação entre nós
signal Inicio_de_conversa_luz
signal cutscene2

# Função chamada quando o nó entra na cena
func _ready() -> void:
	if Globals.Missoes <= 2:
		Globals.Missoes = 3  # Atualiza a missão para 3 caso seja inferior
	if cutscene == false:  # Se ainda não há cutscene em andamento
		personagem.follow_camera(camera)  # Faz o personagem seguir a câmera
		transition.des_transition()  # Desfaz a transição, preparando a nova cena
		Globals.Game_point = "Hollow_Path_entered"  # Marca o ponto de entrada da fase
		personagem.global_position = marker_2d_2.global_position  # Coloca o personagem na posição do marcador

# Função chamada a cada frame, mas não faz nada
func _process(delta: float) -> void:
	pass

# Interações com o baú (adquire chave e avança missão)
func _on_bau_body_entered(body: Node2D) -> void:
	Bau.frame = 1  # Altera o frame do baú para indicar que foi aberto
	Globals.chave_hollow_path = true  # Marca que a chave foi adquirida
	if Globals.Missoes <= 5:
		Globals.Missoes = 6  # Avança para a missão 6

# Interação com a bolha (inicia animação e destrói bolha)
func _on_bolha_body_entered(body: Node2D) -> void:
	anim.set_current_animation("Bolha estoura")  # Inicia a animação da bolha estourando
	bolha.queue_free()  # Remove o nó da bolha da cena

# Transições de cena (mudança de fase)
func _on_caverna_body_entered(body):
	transition.change_scene(false ,path, 1778, 2107)  # Altera para a cena "Main_world.tscn" com coordenadas específicas
func _on_saida_da_caverna_body_entered(body):
	transition.change_scene(false ,path, 13918, 2531)  # Muda para outra parte do cenário com novas coordenadas

# Interação com o mato (inicia animação e modifica visibilidade da luz)
func _on_mato_body_entered(body: Node2D) -> void:
	light_occluder_2d.visible = false  # Torna a luz invisível
	anima_mundo.set_current_animation("mato sumindo")  # Inicia a animação de sumiço do mato
	if Globals.Missoes <= 4:
		Globals.Missoes = 5  # Avança para a missão 5
func _on_mato_body_exited(body: Node2D) -> void:
	anima_mundo.set_current_animation("mato aparecendo")  # Inicia animação de aparecimento do mato
	await anima_mundo.animation_finished  # Aguarda o fim da animação
	light_occluder_2d.visible = true  # Torna a luz visível novamente

# Interação com a porta (verifica missão e destrava a porta)
func _on_actionable_body_entered(body):
	if Globals.Missoes <= 3:
		Globals.Missoes = 4  # Avança para a missão 4
	if Globals.chave_hollow_path == true:  # Se a chave foi adquirida
		ligh_porta.visible = false  # Torna a luz da porta invisível
		if Globals.Missoes <= 5:
			Globals.Missoes = 6  # Avança para a missão 6
		anima_porta.play("porta explodindo")  # Inicia animação de explosão da porta
		await anima_porta.animation_finished  # Aguarda o fim da animação
		porta.queue_free()  # Remove a porta da cena

# Cutscene: inicia animação e posiciona personagem
func _on_nadador_1_cutscene() -> void:
	anima_world.set_current_animation("piscano")  # Inicia animação do nadador
	personagem.global_position = $Marker2D.global_position  # Coloca o personagem na posição do marcador
	personagem.rotation = 0  # Reseta a rotação do personagem
	personagem.em_dialgo = true  # Marca que o personagem está em um diálogo

# Início de conversa e animação
func _on_inicio_de_conversa_luz() -> void:
	anima_world.set_current_animation("conversa_luz")  # Inicia animação de conversa com luz
	await anima_world.animation_finished  # Aguarda o fim da animação
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)  # Inicia o diálogo
	anima_world.set_current_animation("conversando")  # Inicia animação de conversa

# Inicia segunda cutscene
func _on_cutscene_2() -> void:
	cutscene = true  # Marca que a cutscene está ativa
	anima_world.set_current_animation("ANDAR")  # Inicia animação de caminhada
	$Timer.start()  # Inicia o temporizador

# Finaliza a cutscene e faz transição de cena
func _on_timer_timeout() -> void:
	Globals.from_world = name  # Marca o nome da cena atual
	Globals.Game_point = "Hollow_Path_Pos"  # Marca o ponto de transição
	transition.change_scene(true ,path, "no", "no")  # Transição para a cena principal
