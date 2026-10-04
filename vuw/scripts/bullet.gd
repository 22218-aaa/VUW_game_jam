extends Area2D


var damage = 0.0 
var speed: Vector2
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	position += speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("damaged"):
		body.damaged(damage)
	
	
	queue_free()
