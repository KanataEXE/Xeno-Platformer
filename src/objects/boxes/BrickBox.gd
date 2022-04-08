extends StaticBody2D
class_name BrickBox

func hit() -> void:
	$Sprite.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	$BrickParticles.emitting = true
	$HitSFX.play()
	yield(get_tree().create_timer(3.0), "timeout")
	queue_free()
