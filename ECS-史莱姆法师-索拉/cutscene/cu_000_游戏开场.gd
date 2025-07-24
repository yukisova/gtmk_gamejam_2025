extends Cutscene

func _start():
	pass

## 入场之后，先要进行基础故事开场的说明
func 过场1_玩家苏醒(_context: Dictionary):
	var checklist = ["玩家实体","洞穴滤镜"]
	var check_info = cutscene_dependencies_check(checklist, _context)
	if !check_info.is_empty():
		push_error("依赖项", check_info, "缺失，需要检查传入参数")
		return
	
	## 镜头一，询问玩家控制信息
	## 1. 视角缩小，
	var player = Main.s_player_static.player_static
	var c_camera = player.list_base_components[IComponent.ComponentName.c_camera] as C_Camera
	c_camera.camera.zoom = Vector2(5,5) ## 对视野进行缩小
	
	## 2. 黑色场景_需要使用滤镜之类
	var canvas_modulate = _context["洞穴滤镜"] as CanvasModulate
	canvas_modulate.color = Color(0.1,0.1,0.1)
	
	
