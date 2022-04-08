extends StaticBody2D
class_name CoinBox

export var coin_amount: int = 3
export var score: int

func hit() -> void:
	if coin_amount > 0:
		GameData.score += score
		$HitSFX.play()
		$AnimationPlayer.play("hit")
		yield($AnimationPlayer, "animation_finished")
		coin_amount -= 1
		if coin_amount <= 0:
			$AnimationPlayer.play("run_out")
