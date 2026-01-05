extends Node2D

class_name Pipes
const SPEED: float = 120.0
const OFFSCREEN: float = 100.0
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $visibleOnScreenNotifier2d
@onready var laser: Area2D = $laser

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= SPEED * delta
	
	if position.x < get_viewport_rect().position.x - OFFSCREEN:
		die()

func die() -> void:
	set_process(false)
	queue_free()	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	die()


func onPipesBodyEntered(body: Node2D) -> void:
	if body is PlaneBody:
		body.die()


func _on_laser_body_entered(body: Node2D) -> void:
	if body is PlaneBody:
		laser.body_entered.disconnect(_on_laser_body_entered)
		SignalHub.onPointScored.emit()
