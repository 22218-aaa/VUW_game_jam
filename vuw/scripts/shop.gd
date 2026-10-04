extends Node2D


@onready var player = get_tree().get_first_node_in_group("player")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$Control.visible=true


func _on_button_2_pressed() -> void:
	$Control.visible=false


func _on_attack_pressed() -> void:
	player.damaged(10)
	player.damage += 10


func _on_capacity_pressed() -> void:
	player.damaged(5)
	player.energy_capacity += 8
