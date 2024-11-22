extends CanvasLayer  # O CanvasLayer é utilizado para criar camadas que ficam acima dos elementos da cena principal.

# Referências aos nós usados no script.
@onready var personagem = $"../Personagem"  # Referência ao personagem, que é um nó no cenário.
@onready var color_rect = $ColorRect  # Referência ao ColorRect que será usado para a transição de cena.

# Função para alterar a cena.
# Cena: determina se a transição é para mudar de cena (true) ou apenas mudar a posição do personagem (false).
# Path: caminho do arquivo da cena para carregar.
# Posição x e y: coordenadas para onde o personagem será movido, se não for para mudar a cena.
# Delay: tempo de espera antes da transição (padrão é 1 segundo).
func change_scene(cena, path, posicao_x, posicao_y, delay = 1):
	# Cria o tween para animar a transição de cena.
	var scene_transition = get_tree().create_tween()  # Cria um tween (animação de propriedade).
	# A propriedade "Progress" do ColorRect será animada para o valor 4.0, criando a transição.
	scene_transition.tween_property(color_rect, "Progress", 4.0, 1)
	await scene_transition.finished  # Aguarda até que a animação de transição termine.
	
	if cena == true:
		# Se for para mudar a cena, carrega o arquivo de cena especificado pelo caminho.
		assert(get_tree().change_scene_to_file(path) == OK)
	if cena == false:
		# Caso contrário, move o personagem para a posição especificada.
		personagem.position.x = posicao_x
		personagem.position.y = posicao_y
		des_transition()  # Chama a função para desativar a transição (mostrar a cena normal).

# Função para desativar a transição, retornando a tela de transição para o estado original.
func des_transition():
	# Cria um tween para animar o retorno da transição.
	var show_transition = get_tree().create_tween()
	# A animação vai retornar a propriedade "Progress" para 0.0, criando um efeito de desvanecimento.
	show_transition.tween_property(color_rect, "Progress", 0.0, 1).from(4.0)  # De 4.0 para 0.0 (faz a transição "desaparecer").

# Função para simplesmente aplicar a transição (sem mudança de cena).
func transition(delay: float = 1):
	# Cria um tween para aplicar a transição.
	var transition = get_tree().create_tween()
	# A propriedade "Progress" do ColorRect será animada para 4.0, criando o efeito de transição.
	transition.tween_property(color_rect, "Progress", 4.0, 1)
	await transition.finished  # Aguarda até que a animação termine.
	pass  # Passa sem fazer nada, já que a transição já foi aplicada.
