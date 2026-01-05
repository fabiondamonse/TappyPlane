extends CharacterBody2D

class_name PlaneBody

const JUMP_POWER: float = -350.0
signal planeHitBorders
#signal onPlaneDie

var _gravity: float = ProjectSettings.get("physics/2d/default_gravity")
@onready var flyAnimationPlayer: AnimationPlayer = $animationPlayer
@onready var planeAnimatedSprite2d: AnimatedSprite2D = $animatedSprite2d
@onready var audio_engine_sound: AudioStreamPlayer = $audioEngineSound



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	
	fly(delta)
	move_and_slide()
	if is_on_floor():
		planeHitBorders.emit()
		die()

# Fly function
func fly(delta: float) ->void:
	velocity.y += _gravity * delta
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_POWER
		flyAnimationPlayer.play("jump")	

# die function when hitting floor and walls
func die() ->void:
	audio_engine_sound.stop()
	planeAnimatedSprite2d.stop()
	set_physics_process(false)
	SignalHub.onPlaneDie.emit()
