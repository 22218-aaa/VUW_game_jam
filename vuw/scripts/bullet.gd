extends Area2D


var damage = 0.0 
var speed: Vector2

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += speed * delta


func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.has_method("damaged"):
		body.damaged(damage)
	
	
	queue_free()
