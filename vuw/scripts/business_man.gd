extends Area2D


@export var phrases: Array[String]

@onready var label: Label = $Label


func _ready() -> void:
	label.text = ""


func _on_body_entered(_body: Node2D) -> void:
	label.text = phrases.pick_random()


func _on_body_exited(_body: Node2D) -> void:
	label.text = ""
