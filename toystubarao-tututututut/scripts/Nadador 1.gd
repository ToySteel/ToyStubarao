extends CharacterBody2D  # Herda de CharacterBody2D para controle de movimento de personagem

# Sinal que será emitido quando a cutscene começar
signal Cutscene

# Variáveis exportadas para o editor
@export var dialogue_start: String = "start"  # Ponto de início do diálogo
@export var dialogue_resource: DialogueResource  # Recurso de diálogo que será usado

# Referências aos componentes da animação
@onready var animation_player: AnimationPlayer = $AnimationPlayer  # Controlador de animações
var nadano = false  # Flag que indica se o personagem está nadando

# Referências adicionais para animações
@onready var anima_ao_do_mundo = $"../animaçao do mundo"  # Referência à animação global do mundo
@onready var anima_ao_do_mundo_2 = $"../ANIMAÇAO DO MUNDO"  # Outra referência à animação global do mundo (pode ser redundante)

# Função chamada quando o nó entra na cena (não faz nada neste caso, mas está pronta para ser estendida)
func _ready() -> void:
	pass

# Função chamada a cada frame. 'delta' é o tempo que passou desde o último frame
func _process(delta):
	# Se o personagem está nadando, define a animação para "nadano", caso contrário, volta para "Idle"
	if nadano:
		animation_player.set_current_animation("nadano")
	else:
		animation_player.set_current_animation("Idle")

# Função chamada quando o corpo entra na área de cutscene (detecção de colisão)
func _on_area_de_cutscene_2_body_entered(body: Node2D) -> void:
	# Se o ponto do jogo não for "Hollow_Path_Pos", emite um sinal de cutscene e mostra o diálogo
	if Globals.Game_point != "Hollow_Path_Pos":
		emit_signal("Cutscene")  # Emite o sinal de cutscene
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)  # Exibe o diálogo

# Função chamada para iniciar a animação de natação (provavelmente acionada em algum ponto do jogo)
func _on_hollow_path_cutscene_2() -> void:
	# Define a animação de natação do personagem
	animation_player.set_current_animation("nadano")

# Função chamada quando o sinal de "Fim_de_conversa_2" é emitido, para mostrar um diálogo pós-cutscene
func _on_main_world_fim_de_conversa_2():
	# Exibe o diálogo após a cutscene
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, "comunicacao_pos_hollow_path")
