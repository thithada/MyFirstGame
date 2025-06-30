extends CanvasLayer

signal start_game
#แสดงผลคะแนน
func display_score(score):
	$ScoreLabel.text = str(score)

func display_status(massage):
	$StatusLabel.text = massage
	$StatusLabel.show()
	$StatusTimer.start()

func _on_game_start_button_pressed() -> void:
	$GameStartButton.hide()
	start_game.emit()

func _on_status_timer_timeout() -> void:
	$StatusLabel.hide()

func display_gameover():
	display_status("แพ้แล้วไอโง่ ")
	await  $StatusTimer.timeout
	$StatusLabel.text = "My Game 2D"
	$StatusLabel.show()
	$GameStartButton.show()
