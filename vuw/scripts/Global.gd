extends Node

@export var energy: float = 100
@export var energy_capacity: float = 100
@export var damage: float  = 10.0
@export var bullet_speed: float  = 200
@export var fire_rate: float  = 0.1

@export var max_jumps: int = 2

func _process(delta: float) -> void:
	if energy<=0:
		get_tree().reload_current_scene()
