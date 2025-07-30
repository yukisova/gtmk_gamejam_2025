# 项目模板与协作规定

## 基本情况

---

1. 目前基于Godot4.5 beta3测试版，原因是MacOs只有在4.5版本才可以正常支持游戏调试窗口，如果不方便可以再改。
2. 本项目为GMTK GameJam 2025准备的开源仓库。
3. 目前的ECS框架只是个人所理解的ECS，因此有非常多可能有些不可理喻的缺陷，可以之后慢慢改。
4. ECS框架内所包含的插件:
	- TodoManager(管理含有Todo关键字的注释项，正式开肝时需要基于此进行协作开发)
	- TaskKanban(Kanban插件，用于跟其他人确认各自的当前开发部分，避免出现项目冲突)
	- DialogueManager(对话交互逻辑基于此进行设计)
	- Rapier2D\_高速版(优化Godot自身的2d物理引擎，保留用)

## 代码规范

---

### 命名规范

- 文件名，变量名，方法名: python式命名: `function_name`
- 场景树节点名，类名: 大驼峰式命名: `NodeName`
- 常量名: 全大写python式: `CONST_NAME`
- 枚举量: 汉字: `你好` (保留意见,主要是用的很多)
- TODO关键字: 没想好

### 脚本编辑规范

- `## @editing:`写明当前脚本的主要编辑者，主要编辑者确定后，若要切换编辑者，必须要得到原编辑者的确定方可修改`@editing`
- `## @describe:`写明该脚本的主要用处，
- `## @filename:`未使用`class_name`语句的脚本，一般是仅限于实现类，为此，需要以`脚本文件名 --> 实现场景`的形式进行标注
- `#region :后编辑者: 代码功能说明` 由后编辑者编写，标明以下`region`框选代码部分由本人所写。具体说明插入部分代码的用途，方便主要编辑者进行功能的鉴定与维护
- `## BETA` 明确说明当前部分代码功能冻结，除bug修复外不允许插入新的逻辑，并由主要编辑者对代码的新增逻辑进行维护，并评定筛选后编辑者pr的代码，在完成评定后将审察后的代码去除标注用的`#region`注释，替换为`## `

```gdscript
## BETA
## @editing: Sora
## @describe: 测试用的类,
## @filename: beta.gd --> target_entity.tscn
class_name ClassName

@export var variant_name: String ## 测试用的变量名

#region :Umo: 新建一个保留用的新函数
func new_func():
    pass
#endregion
```

### 场景编辑规范

- 为了避免因为文件冲突而导致的场景文件损坏，应当在kanban中明确说明场景文件的编辑者，不同时间段，同一个场景只可允许**一个人**进行编辑
- 场景的组织应当高度遵循场景规范，尽量使用已经存在的子场景进行组合

### GitHub分支规范

- main: 用于最终合并的正式版本，最终的项目应当以`develop_xxx -->|合并| develop_test --> beta -->|修改| main`的合并步骤进行项目协作
- develop_test: 即dev版本，每个协作成员可以自主设定一个develop_xxx(个人名称，建议与`@editing:`使用的名字一致)的子分支在dev版本的基础上进行开发，但应当勤合并至develop_test，这一点可以进一步商议
- beta: dev版本的合并分支，用于规范化dev阶段的内容，保证协作的效果，在下一轮之前以注释关键字的方式冻结代码
- 目前为了避免代码的混乱，以**半个小时**为基准进行一次代码的提交与合并，commit格式如下:
```git commit
测试提交3_Sora: <本次提交的内容与修复的功能> ## 在dev_xxx中的
冻结提交3: <本次修复的功能> ## 在beta中的
提交3: <本次提交的内容与修复的功能> ## 在main中的
```

### 素材制作规范

为了减少工作量, 图像目前拟以最简单的方式进行设计，以下流程基于Aseprite
1. 图像以16像素为基础单位进行设计（比如瓦片是16x16，人物是16x32,）， 在完成绘制之后使用 精灵-->精灵尺寸 将其缩放3倍，
2. 图像应有3个版本(原尺寸aseprite, 缩放尺寸aseprite, 全图png)，在没有压缩大小的需求下可以保留
## 文件系统框架

---

- addons :: 插件
- asset :: 图像素材
- component :: C，实体所用到的各种组件，部分组件的功能还可以用于其他方面，例如状态机
	- c_texture: 用于显示目标实体的纹理，目前主要有AnimatedSprite和Sprite+AnimationPlayer两个版本
	- c_action: 集合规定目标实体的可能行为，例如死亡后掉落
	- c_camera: 聚焦于目标实体的摄像机，与InputReactor属性类似，规定了镜头的移动策略
	- c_collision: 实体所扩展出的一系列Area碰撞体，例如角色的HurtBox和子弹的HitBox，还有NPC用于交互的InteractBox
	- c_input_reactor: 实体的控制器，搭载该组件的实体可以进行控制，并由位于s_player_static内的InputListener进行监听
	 - c_interactable: 实体的交互组件，主要用于陷阱和NPC，分为主动交互和被动交互
	 - c_navigation: 实体的导航用组件，目前没有想好具体的分化，主要用于AI的寻路与攻击目标的定位
	 - c_state: 实体的状态机组件，目前包含专门用于角色连续行为的hfsm各用于AI行为的pda
	 - c_status: 实体的状态组件，包含了实体本身的各种数值信息，比如玩家的血量，在此基础上提供了status_extension用于扩展
- cutscene :: TODO 游戏的过场剧情脚本，考虑放在resource中
- entity :: E，游戏中所显示的，除了TileMap以外的所有PhysicsBody都应当使用该框架
- system :: S，游戏中的各种系统，以单例的形式进行组织，对它们的初始化需要进行严格的定义
	- s_audio_master: 音频总线管理器，用于播放BGM与SFX，并确保不会过于吵闹，目前游戏框架内主要使用的是基于AudioStream的无空间概念的音频流
	- s_game_state: 游戏状态管理器，用于严格限定不同情况下的系统显示与玩家控制,
	- s_global_config: 游戏配置加载器，用于初始化游戏的基础设置信息，例如玩家的键位，显示的方式，游戏的音频音量
	- s_load_save: 游戏存档管理器，用于加载，保存与管理游戏的存档，UNFINISH
	- s_map_data: 游戏地图加载器，用于加载，重载，卸载，调整游戏的地图内容
	- s_object_pool: 游戏对象池，目前只想到了存放玩家的子，UNFINISH
	- s_player_static: 玩家实体静态调用器，方便在游戏里让NPC等实体快速调用玩家的信息，但有很高的可扩展可能
	- s_signal_bus: 全局信号总线，仅存放需要广泛调用的信号
	- s_ui_spawner: UI管理器，用于管理，对接UI与HUD，UNFINISH
- resource :: 游戏中所用到的场景模板，序列化数据，以及插件支持的文件
	- custom_resource: 自定义的序列化Resource类tres文件(会需要很多)
	- plugin_resource: 插件支持的Resource类，例如DialogueManager的dialogue文件
	- node_template: 场景模板，例如地图
	- resource_template: 引擎内置的序列化Resource类tres文件，例如各种tileset
	- shader: 着色器
- scene :: 包含游戏的启动器，启动Logo(这个可以慢慢来)，以及游戏的正式运行框架Main，还有方便进行调用的静态地图打包
- ui :: 游戏的ui，包括hud和ui两种,以及各种Control类的组件
- util :: 静态工具，主要有静态方法集，以及提前定义的常量列表，方便调用，如果性能有问题可以进一步讨论
