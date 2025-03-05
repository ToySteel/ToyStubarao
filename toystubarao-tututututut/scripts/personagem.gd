extends CharacterBody2D  # Herda de CharacterBody2D, que é adequado para objetos que têm físicas e movimentos.

# Onready var's - Variáveis para referenciar nós específicos da cena.
@onready var actionable_finder = $ActionableFinder  # A referência ao nó responsável por encontrar áreas acionáveis (por exemplo, interações).
@onready var player = $nadador  # Referência ao personagem (nadador).
@export var speed = 100  # Velocidade de movimento do personagem.
@export var rotation_speed = 1.7
@export var nadano:bool = false  # Velocidade de rotação do personagem.
@onready var anim = $"Animation personagem"  # Referência ao nó de animações do personagem.
@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D  # Referência ao nó de transformação remota, usado para seguir a câmera.
@onready var camera: Camera2D = $"../Camera"  # Referência à câmera que segue o personagem.
@onready var RayLeft: RayCast2D = $RayLeft  # Raycast à esquerda, usado para detectar colisões ou limites.
@onready var RayRight: RayCast2D = $RayRight  # Raycast à direita, usado para detectar colisões ou limites.
@onready var ainma_ao_do_mundo: AnimationPlayer = $"../AINMAÇAO DO MUNDO"
var state = "idle"
# Variáveis para controlar o estado e o movimento do personagem.
var rotation_direction = 0  # Direção da rotação.
var direçao = true  # Direção do personagem (possivelmente controlando o sentido do movimento).
var em_dialgo = false  # Flag que indica se o personagem está em um diálogo.
var knockback_vector := Vector2.ZERO  # Vetor de "knockback" (empurrão), usado quando o personagem é atingido.
@export var transiçao: bool = false  # Flag para indicar se a transição deve ocorrer.

# Função para obter o input do jogador (movimento e direção).
func get_input():
	rotation_direction = Input.get_axis("ui_left", "ui_right")  # Obtém o valor do movimento horizontal (esquerda/direita).
	velocity = transform.x * Input.get_axis("ui_down", "ui_up") * speed  # Calcula a velocidade baseada nos inputs verticais (cima/baixo).

# Função de física chamada a cada quadro para mover e rotacionar o personagem.
func _physics_process(delta):
	if knockback_vector != Vector2.ZERO:  # Se houver um vetor de knockback (quando o personagem for atingido), aplica-o.
		velocity = knockback_vector
	stade()
	# Impede o movimento do personagem quando ele estiver em um diálogo.
	if em_dialgo == false:
		 #Inicia interações (diálogos) quando o jogador pressiona a tecla de ação.
		if Input.is_action_just_pressed("ui_accept"):
			var actionables = actionable_finder.get_overlapping_areas()  # Encontra áreas acionáveis ao redor do personagem.
			if actionables.size() > 0:
				actionables[0].action()  # Executa a ação no primeiro item acionável encontrado.
				return  # Interrompe o movimento após a ação.

		# Obtém o input de movimento.
		get_input()
		
		# Rotaciona o personagem com base na direção do movimento.
		rotation += rotation_direction * rotation_speed * delta 
		
		# Modifica a direção do personagem (espelhando o personagem com base no movimento).
		if Input.is_action_pressed("ui_up"):
			player.scale.x = 1
			$Colisao.scale.x = 1
			$LightOccluder2D.scale.x = 1
		if Input.is_action_pressed("ui_down"):
			player.scale.x = -1
			$Colisao.scale.x = -1
			$LightOccluder2D.scale.x = -1
		
		# Atualiza o estado da animação do personagem.
		
		move_and_slide()  # Aplica o movimento físico do personagem.

# Função para controlar o estado das animações do personagem (idle, nadando, etc.).
func stade():
	if em_dialgo == false:
		if Input.is_action_just_pressed("ui_up"):  # Quando o jogador pressiona a tecla "cima", começa a animação de nadando.
			anim.set_current_animation("Nadano")
		if Input.is_action_just_pressed("ui_down"):  # Quando o jogador pressiona a tecla "baixo", começa a animação de nadando.
			anim.set_current_animation("Nadano")
	if anim.current_animation != "Morte":
		if Input.is_action_just_released("ui_up"):  # Quando o jogador solta a tecla "cima", retorna à animação idle.
			anim.set_current_animation("idle")
		if Input.is_action_just_released("ui_down"):  # Quando o jogador solta a tecla "baixo", retorna à animação idle.
			anim.set_current_animation("idle")
	if nadano:
		anim.set_current_animation("Nadano")
	else:
		anim.set_current_animation("Idle")

# Funções de interação com áreas de diálogo ou cutscenes.
func _on_static_body_2d_holograma_conversas():  # Quando o personagem entra em uma área de conversa, ativa o diálogo.
	em_dialgo = true

func _on_main_world_fim_de_conversa() -> void:  # Quando a conversa termina, marca o fim do diálogo e aumenta a missão.
	em_dialgo = false
	Globals.Missoes += 1

func _on_cutscene_area_cutscene():  # Quando entra em uma área de cutscene, muda a animação.
	anim.set_current_animation("Cima ou baixo")
	position.x == 3527
	position.y == 12382
	em_dialgo = true

func _on_cutscene_area_fim_de_cutscene():  # Quando a cutscene termina, marca o fim do diálogo e aumenta a missão.
	em_dialgo = false
	Globals.Missoes += 1

func _on_nadador_1_cutscene() -> void:  # Mudança de animação ao entrar em uma cutscene específica.
	anim.set_current_animation("idle")
	$nadador.frame = 2

# Função para fazer o personagem seguir a câmera.
func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform_2d.remote_path = camera_path  # A transformação remota permite que a posição da câmera seja seguida.

# Função chamada durante uma cutscene.
func _on_hollow_path_cutscene_2() -> void:
	# Inverte a direção do personagem (espelha o personagem).
	player.scale.x = -1
	$Colisao.scale.x = -1
	$LightOccluder2D.scale.x = -1
	anim.set_current_animation("Nadano")  # Inicia a animação de nadando.

# Função chamada quando o personagem morre.
func die(knockback_force := Vector2.ZERO, duration := 0.25):
	if knockback_force != Vector2.ZERO:
		em_dialgo = true
		rotation = 0  # Zera a rotação ao morrer.
		camera.Shake_camera(100, 0.8, 40)  # Faz a câmera tremer para dar impacto.
		#knockback_vector = knockback_force  # Aplica o efeito de "knockback".
		var knockback_tween: Tween = get_tree().create_tween()
		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)  # Remove o efeito de knockback após o tempo definido.
		camera.Shake_camera(100, 0.2, 60)
		anim.set_current_animation("Morte")  # Executa a animação de morte.
		camera.Shake_camera(100, 0.8, 80)
		await anim.animation_finished  # Aguarda a animação de morte terminar.
		var transition = get_parent().get_node("transition")  # Obtém o nó de transição.
		transition.transition()  # Faz a transição de cena.
		camera.Shake_camera(100, 0.8, 60)
		await transition.transition()  # Aguarda a transição de cena terminar.
		if Globals.Checkpoints != null:  # Se houver checkpoints definidos, o personagem reaparece no último checkpoint.
			self.global_position = get_parent().get_node(Globals.Checkpoints).global_position
		recreate()  # Reinicia o estado do personagem.
		if Globals.Checkpoints == "5":
			$"../AINMAÇAO DO MUNDO".set_current_animation("nadano 0")
			await $"../AINMAÇAO DO MUNDO".animation_finished
			$"../AINMAÇAO DO MUNDO".set_current_animation("corra")
		transition.des_transition() 
		print("died") # Desativa a transição de cena.
# Função chamada quando o personagem morre ao colidir com um raio.
func died():
	if RayLeft.is_colliding():  # Se colidir com o raio à esquerda, chama a função de morte com uma força de knockback.
		die(Vector2(1000,-1000))
	if RayRight.is_colliding():  # Se colidir com o raio à direita, chama a função de morte com uma força de knockback invertida.
		die(Vector2(-1000,-1000))

# Função que reinicia o estado do personagem após a morte.
func recreate():
	em_dialgo = false
	anim.set_current_animation("idle")
	scale = Vector2(5,5)  # Retorna à animação idle após a morte.
