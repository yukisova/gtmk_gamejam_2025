## @editing: Sora [br]
## @describe: 玩家的站立(播放对应的动画) [br]
## @filename: state_idle.gd
@tool
extends StateHfsm

@export var vector_move: MoveStrategy
@export var c_texture: C_Texture

func _enter():
	pass

func _update(_delta: float) -> void:
	super._update(_delta)
	
	var vector = vector_move.move_vector as Vector2
	if (!vector.is_zero_approx()):
		state_transition.emit(get_transition_state())
