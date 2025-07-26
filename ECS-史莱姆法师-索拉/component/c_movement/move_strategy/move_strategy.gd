@abstract class_name MoveStrategy
extends Node

var binding_entity: Entity

@export var blackboard: ContainerBlackboard
@abstract func _check_and_init()
@abstract func _update(_delta: float)
