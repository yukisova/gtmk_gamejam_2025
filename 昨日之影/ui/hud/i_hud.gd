##@editing:	Sora
##@describe:	Hud类
@abstract class_name IHud
extends CanvasLayer

@abstract func _refresh()

## 在游戏实体加载完毕，正式进入GamingNormal状态时运行
@abstract func _initialize()
