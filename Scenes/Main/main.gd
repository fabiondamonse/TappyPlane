extends Control
@onready var high_score_label: Label = $marginContainer/highScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	high_score_label.text = "%04d" % ScoreManager.highScore 

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump", false):
		GameManager.loadGameScene()
