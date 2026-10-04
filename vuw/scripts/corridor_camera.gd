extends Camera2D


@onready var player = get_tree().get_first_node_in_group("player")


func _process(_delta: float) -> void:
	position.x = player.position.x + player.velocity.x / 100
	position.x = clamp(position.x, 272, 1992)
