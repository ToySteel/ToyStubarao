extends Area2D

# Variável exportada para o editor que contém o recurso de diálogo, armazenando os dados do diálogo a serem exibidos.
@export var dialogue_resource: DialogueResource

# Variável exportada para o editor que define o ponto de partida do diálogo, geralmente identificada por uma chave ou string.
@export var dialogue_start: String = "start"

# Função que é chamada para executar uma ação específica, neste caso, mostrar um balão de diálogo.
func action() -> void:
	# Chama o método 'show_example_dialogue_balloon' do gerenciador de diálogos (DialogueManager),
	# passando o recurso de diálogo e a chave de início para exibir o balão de diálogo apropriado.
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
