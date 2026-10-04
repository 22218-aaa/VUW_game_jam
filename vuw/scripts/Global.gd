extends Node

@export var energy: float = 100
@export var energy_capacity: float = 100
@export var damage: float  = 10.0
@export var bullet_speed: float  = 200
@export var fire_rate: float  = 0.1
@export var number: int =0
@export var max_jumps: int = 2
@export var man:int=48

func _process(delta: float) -> void:
	if energy<=0:
		get_tree().reload_current_scene()
	if man==44 or man ==40 or man==36 or man == 32 or man ==28 or man ==24 or man ==20 or man == 16 or man==12 or man ==8 or man==4:
		get_tree().change_scene_to_file("res://scenes/corridor.tscn")
