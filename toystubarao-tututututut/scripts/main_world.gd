extends Node2D

# Inicialização dos nós da cena usando @onready
@onready var camera_2d: Camera2D = $Camera  # Referência à câmera 2D
@onready var personagem = get_node("Personagem")  # Referência ao personagem
@onready var barreira_cutscene: StaticBody2D = $"barreira cutscene"  # Referência à barreira da cutscene
@onready var static_body_2d_2: StaticBody2D = $StaticBody2D2  # Outro corpo estático na cena
@onready var luz_1: Sprite2D = $"Luz 1"  # Referência à primeira luz
@onready var luz_2: Sprite2D = $"Luz 2"  # Referência à segunda luz
@onready var luz_3: Sprite2D = $"Luz 3"  # Referência à terceira luz
@onready var anima_ao_do_mundo: AnimationPlayer = $"ANIMAÇAO DO MUNDO"  # Referência ao AnimationPlayer
@onready var cutscene_area: Area2D = $"Cutscene Area"  # Referência à área da cutscene
@onready var nadador_1: CharacterBody2D = $"Nadador 1"  # Referência ao personagem "nadador 1"
@onready var transition: CanvasLayer = $transition
@onready var nadador_2: CharacterBody2D = $"Nadador 2"
@onready var nadador_3: CharacterBody2D = $"Nadador 3"


# Variáveis exportadas para o editor
@export var dialogue_resource: DialogueResource  # Recurso de diálogo
@export var dialogue_start: String = "start"  # Ponto de partida do diálogo

# Sinais que serão emitidos durante a execução do jogo
signal Fim_de_conversa
signal Fim_de_conversa_2
signal LUZ
signal Inicio_de_conversa_luz
signal Hollow_Path_Pos
signal Magma_throth_Pos
signal OFIM
signal acabou
# Função chamada quando o nó entra na árvore de cena
func _ready():
	# Se o jogo vem de um ponto específico, o personagem é reposicionado na cena
	if Globals.from_world != null:
		personagem.global_position = get_node(Globals.from_world + "Pos").global_position
	
	# Faz o personagem seguir a câmera
	$Personagem.follow_camera(camera_2d)

	personagem.rotation = 0
	personagem.scale = Vector2(5,5)
	personagem.nadano = false
	nadador_1.rotation = 0
	nadador_1.scale = Vector2(5,5)
	nadador_1.nadano = false
	nadador_2.rotation = 0
	nadador_2.scale = Vector2(5,5)
	nadador_2.nadano = false
	nadador_3.rotation = 0
	nadador_3.scale = Vector2(5,5)
	nadador_3.nadano = false
	# Verifica o ponto do jogo e realiza as ações correspondentes
	if Globals.Game_point == "Start":
		personagem.position = Vector2(403, 531) # Nenhuma ação para o ponto inicial (aqui você pode adicionar algo caso necessário)
	
	if Globals.Game_point == "Hollow_Path_entered":
		# Quando o ponto do jogo é "Hollow_Path_entered", remove os objetos da cena relacionados à cutscene
		barreira_cutscene.queue_free()  # Remove a barreira
		static_body_2d_2.queue_free()  # Remove o corpo estático 2
		luz_1.queue_free()  # Remove a luz 1
		luz_2.queue_free()  # Remove a luz 2
		luz_3.queue_free()  # Remove a luz 3
		cutscene_area.queue_free()
		  # Remove a área da cutscene
	
	if Globals.Game_point == "Hollow_Path_Pos":
		# Quando o ponto do jogo é "Hollow_Path_Pos", remove os objetos da cena relacionados à cutscene
		barreira_cutscene.queue_free()
		static_body_2d_2.queue_free()
		luz_1.queue_free()
		luz_2.queue_free()
		luz_3.queue_free()
		cutscene_area.queue_free()
		emit_signal("Hollow_Path_Pos")
	if Globals.Game_point == "Magma_throthPos":
		barreira_cutscene.queue_free()
		static_body_2d_2.queue_free()
		luz_1.queue_free()
		luz_2.queue_free()
		luz_3.queue_free()
		cutscene_area.queue_free()
		emit_signal("Magma_throth_Pos")
		  # Emite um sinal indicando que o ponto "Hollow_Path_Pos" foi alcançado

# Função chamada a cada frame. 'delta' é o tempo que passou desde o último frame.
func _process(delta):
	pass  # Nenhuma ação necessária a cada frame, mas este método pode ser útil para futuros ajustes

# Função chamada quando o sinal "Hollow_Path_Pos" é emitido
func _on_hollow_path_pos() -> void:
	# Ativa o estado de diálogo do personagem
	personagem.em_dialgo = true
	
	# Inicia a animação de natação do nadador
	nadador_1.nadano = true
	anima_ao_do_mundo.set_current_animation("nadaçoes")  # Reproduz a animação de natação
	await anima_ao_do_mundo.animation_finished  # Aguarda a animação terminar
	
	# Desativa a animação de natação do nadador
	nadador_1.nadano = false
	Globals.Game_point = "Hollow_Path_Pos"
	Globals.Gelo = true
	# Reproduz outra animação quando o nadador interage com a pedra
	anima_ao_do_mundo.set_current_animation("Pedra_hollow_path_cai")  # Reproduz a animação da pedra caindo
	await anima_ao_do_mundo.animation_finished  # Aguarda a animação terminar
	
	# Agita a câmera para dar um efeito de impacto
	Globals.camera.Shake_camera(100)
	
	# Emite o sinal "Fim_de_conversa_2" indicando que a conversa ou animação terminou
	emit_signal("Fim_de_conversa_2")
#####################################################################

func _on_area_2d_body_entered(body: Node2D) -> void:
	$"TileMap/bloqueado".collision_enabled = false
	anima_ao_do_mundo.set_current_animation("apagano")


func _on_magma_throth_pos() -> void:
	personagem.em_dialgo = true
	anima_ao_do_mundo.set_current_animation("Magma")
	await anima_ao_do_mundo.animation_finished
	print("sla")
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, "Quase_fim")
	personagem.em_dialgo = false
func _on_profundidade_cabo() -> void:
	if Globals.Game_point == "Magma_throthPos":
		personagem.position = Vector2(3458,14575)
		personagem.em_dialgo = true
		anima_ao_do_mundo.set_current_animation("FIM")
		await anima_ao_do_mundo.animation_finished
		anima_ao_do_mundo.set_current_animation("verde vem")
		await anima_ao_do_mundo.animation_finished
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, "AGRSIM")
		await anima_ao_do_mundo.animation_finished


func _on_acabou() -> void:
	anima_ao_do_mundo.set_current_animation("O Fim")
	transition.transition()
