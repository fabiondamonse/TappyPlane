extends Node2D
class_name Game

const PIPES = preload("uid://bqg0grsmdtn5o")
const MARGIN = 150

@onready var pipeSpawnTimer: Timer = $pipeSpawnTimer
@onready var upper_point: Marker2D = $upperPoint
@onready var lower_point: Marker2D = $lowerPoint

static var _viewPortRect: Rect2

static func getViewPortRect() -> Rect2:
	return _viewPortRect
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateViewPort()
	get_viewport().size_changed.connect(updateViewPort)
	spawnPipes()
	
func updateViewPort() -> void:
	_viewPortRect = get_viewport_rect()
	
func _enter_tree() -> void:
	SignalHub.onPlaneDie.connect(onPlaneDied)


func spawnPipes() -> void:
	var pipes: Pipes = PIPES.instantiate()
	var y_pos: float = randf_range(upper_point.position.y, lower_point.position.y)
	pipes.position = Vector2(_viewPortRect.end.x + MARGIN, y_pos)
	add_child(pipes)
	
func _on_timer_timeout() -> void:
	spawnPipes()


func _on_plane_plane_hit_borders() -> void:
	pipeSpawnTimer.stop()

func onPlaneDied() -> void:
	get_tree().paused = true
