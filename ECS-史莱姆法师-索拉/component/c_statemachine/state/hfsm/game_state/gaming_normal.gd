## 游戏的进行状态，该状态下
## 1. 运行游戏逻辑，玩家可以进行移动
## 2. 显示玩家的hud
## 退出条件：
## 1. 暂停信号
## 2. 进入过场剧情
@tool
class_name GamingStateNormal
extends StateHfsm

func _enter():
	SUiSpawner.current_hud[&""]._refresh()
	SUiSpawner.current_hud[&""].show()
	

func _exit():
	SUiSpawner.current_hud[&""].hide()
