extends Node

@export var energy: float = 100
@export var energy_capacity: float = 100
@export var damage: float  = 10.0
@export var bullet_speed: float  = 200
@export var fire_rate: float  = 0.1
@export var number: int =0
@export var max_jumps: int = 2
@export var man:int=4

func _process(delta: float) -> void:
	if man==1:
		energy+=20
		man=4
		get_tree().change_scene_to_file("res://scenes/corridor.tscn")
	if number>11:
		get_tree().change_scene_to_file("res://scenes/win_scene.tscn")
