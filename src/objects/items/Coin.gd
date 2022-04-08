extends Area2D

export var score: int

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players"):
		GameData.score += 10
		$PickUpSFX.play()
		$AnimationPlayer.play("fade_out")
		yield($AnimationPlayer, "animation_finished")
		queue_free()
