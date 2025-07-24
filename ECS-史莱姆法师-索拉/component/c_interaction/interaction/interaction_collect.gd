## 拾取交互
extends Interaction

func _on_interact_activated(_component: IComponent):
	print("被收集了")
	
	_component.component_owner.queue_free.call_deferred()
