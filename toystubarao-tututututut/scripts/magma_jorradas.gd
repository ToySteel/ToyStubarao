extends Area2D

# Variáveis @onready: inicializam quando os nós são carregados na cena
@onready var timer_ativo: Timer = $"Timer ativo"  # Temporizador para ativação
@onready var timer_desativo: Timer = $"Timer desativo"  # Temporizador para desativação
@onready var anim: AnimatedSprite2D = $aniamtion  # Animação para o sprite
@onready var personagem: CharacterBody2D = $"../../Personagem"  # Referência ao personagem
@onready var colisao: CollisionShape2D = $colision  # Colisão
@onready var RayLeft: RayCast2D = $"../../Personagem/RayLeft2"  # RayCast à esquerda do personagem
@onready var RayRight: RayCast2D = $"../../Personagem/RayRight2"  # RayCast à direita do personagem
@onready var camera: Camera2D = $"../../Camera"  # Referência à câmera
@onready var remecheno: Area2D = $remecheno  # Área de efeito (possivelmente um efeito de jorro)

# Variáveis exportadas: podem ser configuradas no editor
@export var Jorravel: bool = true  # Flag que indica se o jorro está ativado
@export var timer_time: float = 1  # Tempo para os temporizadores

# Variáveis internas
var state: String = "Jorrando"  # Estado inicial do jorro

# Função chamada quando o nó entra na cena
func _ready():

	timer_desativo.start()  # Inicia o temporizador de desativação

# Função chamada a cada frame
func _process(delta):
	_state()  # Verifica o estado da animação e atualiza se necessário

# Função que verifica e atualiza o estado da animação
func _state():
	if anim.name != state:  # Se o nome da animação não corresponde ao estado
		anim.play(state)  # Inicia a animação correspondente ao estado

# Função para desativar o jorro
func desativar():
	monitoring = false  # Para o monitoramento
	if state != "Desligado":  # Se o estado não for "Desligado"
		state = "Desligado"  # Muda para o estado "Desligado"
		$PointLight2D.color = Color(0.498, 0.921, 1)  # Altera a cor da luz
	Jorravel = false  # Desativa o jorro
	$Luz.visible = false  # Torna a luz invisível

# Função chamada quando o temporizador de ativação expira
func _on_timer_ativo_timeout():
	if Jorravel:  # Se o jorro estiver ativado
		monitoring = true  # Começa o monitoramento
		timer_desativo.start()  # Reinicia o temporizador de desativação
		await anim.animation_looped  # Aguarda o loop da animação
		if remecheno.get_overlapping_bodies():  # Se algum corpo está sobrepondo a área de efeito
			camera.Shake_camera(100, 0.2,20)  # Sacode a câmera
		state = "Jorrando"  # Muda o estado para "Jorrando"
		$Luz.visible = true  # Torna a luz visível

# Função chamada quando o temporizador de desativação expira
func _on_timer_desativo_timeout():
	if Jorravel:  # Se o jorro estiver ativado
		monitoring = false  # Para o monitoramento
		timer_ativo.start()  # Reinicia o temporizador de ativação
		await anim.animation_looped  # Aguarda o loop da animação
		state = "Ligado"  # Muda o estado para "Ligado"
		$Luz.visible = false  # Torna a luz invisível

# Função chamada quando o personagem entra em uma área específica
func _on_body_entered(body: Node2D) -> void:
	print("die")  # Exibe "die" no console quando o corpo entra na área
	if RayLeft.is_colliding():  # Se o RayCast à esquerda colidir
		personagem.die(Vector2(200,-200))  # Mata o personagem (direciona-o para fora da tela)
	if RayRight.is_colliding():  # Se o RayCast à direita colidir
		personagem.die(Vector2(-200,-200))  # Mata o personagem (direciona-o para fora da tela)
