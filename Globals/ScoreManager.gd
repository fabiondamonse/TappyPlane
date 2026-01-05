extends Node

const SCORE_PATH: String = "user://tappy.tres"

var _highScore: int = 0
var highScore: int:
	get:
		return _highScore
	set(value):
		if value > _highScore:
			_highScore = value
			saveHighScore()

func _ready() -> void:
	loadHighScore()
	
func saveHighScore() -> void:
	var hsr: HighScoreResource = HighScoreResource.new()
	hsr._highScore = _highScore
	ResourceSaver.save(hsr, SCORE_PATH)

func loadHighScore() -> void:
	if ResourceLoader.exists(SCORE_PATH) == true:
		var hsr: HighScoreResource = ResourceLoader.load(SCORE_PATH)
		if hsr:
			_highScore = hsr._highScore
