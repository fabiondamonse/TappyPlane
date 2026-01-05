extends Node

const GAME = preload("uid://dp3exvoivxotb")
const MAIN = preload("uid://27ncrxigcvil")
const SIMPLE_TRANSITION = preload("uid://c1s14ylfns0vr")
const COMPLEX_TRANSITION = preload("uid://b12ek1wnlkl72")

var nextScene: PackedScene

func addComplex() -> void:
	var ct = COMPLEX_TRANSITION.instantiate()
	add_child(ct)

func loadGameScene() -> void:
	nextScene = GAME
	addComplex()
	#get_tree().change_scene_to_packed(SIMPLE_TRANSITION)
	
func loadMainScene() -> void:
	nextScene = MAIN
	addComplex()
	#get_tree().change_scene_to_packed(SIMPLE_TRANSITION)
