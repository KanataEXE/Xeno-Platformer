extends Area2D

export var speed := 750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node):
	if !body.is_in_group("boxes"):
		if body.has_method("hit"):
			body.hit()
	queue_free()

func _on_LifeTimer_timeout():
	queue_free()
