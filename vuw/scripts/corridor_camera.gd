extends Camera2D


@onready var player = get_tree().get_first_node_in_group("player")

@export var min_x: int
@export var max_x: int

func _process(_delta: float) -> void:
	position.x = player.position.x + player.velocity.x / 100
	position.x = clamp(position.x, min_x, max_x)
