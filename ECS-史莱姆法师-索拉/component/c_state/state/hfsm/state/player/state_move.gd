## SORA @editing: Sora [br]
## @describe: 玩家的移动(播放对应的动画)
## @filename: state_move
@tool
extends StateHfsm

@export var vector_move: MoveStrategy
@export var c_texture: C_Texture

func _enter():
	pass
	#c_texture.animation_player.get_animation("people_action/walking").loop_mode = Animation.LOOP_LINEAR
	#c_texture.animation_player.play("people_action/walking")

func _update(delta: float) -> void:
	var vector = vector_move.move_vector as Vector2
	if (vector.is_zero_approx()):
		state_transition.emit(get_transition_state())

func _exit():
	pass
	#var c_a = c_texture.animation_player.current_animation
	#c_texture.animation_player.get_animation(c_a).loop_mode = Animation.LOOP_NONE
	
	#await c_texture.animation_player.animation_finished
	#c_texture.animation_player.stop()
