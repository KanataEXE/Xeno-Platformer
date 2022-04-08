extends Area2D

signal level_cleared

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players"):
		emit_signal("level_cleared")
		$PickUpSFX.play()
