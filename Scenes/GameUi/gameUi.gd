extends Control

class_name GameUi
const GAME_OVER = preload("uid://wjnyhwhbyrd")

@onready var labelGameOver: Label = $marginContainer/labelGameOver
@onready var labelPressSpace: Label = $marginContainer/labelPressSpace
@onready var timer: Timer = $timer
@onready var labelScore: Label = $marginContainer/labelScore
@onready var sound: AudioStreamPlayer = $sound


var _score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_score = 0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Exit", false):
		GameManager.loadMainScene()
	elif labelPressSpace.visible == true && event.is_action_pressed("jump"):
		ScoreManager.highScore = _score
		GameManager.loadMainScene()

func _enter_tree() -> void:
	SignalHub.onPlaneDie.connect(onPlaneDied)
	SignalHub.onPointScored.connect(pointScored)


func onPlaneDied() -> void:
	sound.stop()
	sound.stream = GAME_OVER
	sound.play()
	labelGameOver.show()
	timer.start()


func _on_timer_timeout() -> void:
	labelGameOver.hide()
	labelPressSpace.show()

func pointScored() -> void:
	sound.play()
	_score += 1
	labelScore.text = "%04d" % _score
	
