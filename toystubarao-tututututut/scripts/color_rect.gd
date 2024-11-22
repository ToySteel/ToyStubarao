extends ColorRect

# Define o parâmetro que queremos modificar no shader.
# 'Progress' será usado para controlar um parâmetro de shader.
var Progress = 0.0

# Função chamada a cada frame. 'delta' é o tempo decorrido desde o último frame.
func _process(delta):
	# Atualiza o parâmetro do shader chamado "progress" com o valor da variável 'Progress'.
	# 'material' é a propriedade que se refere ao material do ColorRect.
	# 'set' altera a propriedade específica no shader.
	material.set("shader_parameter/progress", Progress)
