# Game Project - Godot 2D Studio

This is a Godot 2D game project built with OpenCode. The project follows a studio-based workflow with specialized agents for different roles.

## Quick Start

1. 双击运行 `other/Godot_v4.5.1-stable_win64.exe`
2. 点击"导入"选择 `project/project.godot`
3. 点击"运行"测试基础功能

## Project Structure

```
my-game/                          # 框架根目录（保持干净）
├── .opencode/                    # Agent 定义
│   └── agents/                   # 智能体配置
├── project/                      # 开发的应用/游戏（所有项目文件放这里）
│   ├── project.godot            # Godot 项目配置
│   ├── src/                     # 游戏源码 (GDScript)
│   ├── assets/                  # 游戏资源（图片、音效等）
│   ├── design/                  # 游戏设计文档
│   ├── export/                  # 导出配置
│   └── icon.svg                 # 项目图标
├── other/                       # 临时文件（下载、缓存等）
│   └── .godot/                  # Godot 缓存目录
├── docs/                        # 框架技术文档
├── assets/                      # 框架预设资源（可选）
└── tests/                       # 测试套件（可选）
```

### Directory Rules

**重要：所有项目文件必须放在 `project/` 目录下**

| 文件类型 | 存放位置 |
|---------|---------|
| Godot 项目配置 | `project/project.godot` |
| 游戏源码 | `project/src/` |
| 游戏资源 | `project/assets/` |
| 游戏设计文档 | `project/design/` |
| 导出配置 | `project/export/` |
| 下载的引擎/工具 | `other/` |
| Godot 缓存 | `other/.godot/` |

**禁止在根目录创建项目文件**

## Game Type
- **Engine**: Godot 4.x (2D)
- **Genre**: 2D platformer/action

## Team Roles

| Role | Agent | Description |
|------|-------|-------------|
| Creative/Technical Lead | director | Vision, decisions, architecture |
| Game Design | gamedesigner | Mechanics, systems, level design |
| Programming | godot-dev | Godot 2D implementation |
| Art | artist | 2D assets, visual direction |
| Quality | qa | Testing, bug finding, balance |

## Decision Workflow

Before making any significant decision, follow this protocol:

1. **Identify the question** - What decision needs to be made?
2. **Gather context** - Read relevant design docs
3. **Present options** - 2-3 choices with trade-offs
4. **Recommend** - Clear recommendation with reasoning
5. **User decides** - Wait for approval before proceeding

## Game Design Principles

### pillars
Every game has 3-5 non-negotiable pillars that guide all decisions:
1. **Fun first** - If it's not fun, change it
2. **Player always right** - Design for how players actually play
3. **Simple but deep** - Easy to learn, hard to master

### Anti-pillars (What This Game Is NOT)
- No pay-to-win mechanics
- No grinding for progression
- No tutorials longer than 5 minutes

### Design Process
1. Start with a prototype (test the core mechanic)
2. Iterate based on feedback
3. Document decisions in design/
4. Code follows design, design follows vision

## Godot 2D Standards

### Scene Architecture
- Use `CharacterBody2D` for player/enemies
- Use `Area2D` for detection zones
- Use `Node2D` for containers
- One scene = one responsibility

### GDScript Conventions
```gdscript
extends CharacterBody2D

class_name Player

signal health_changed(current: int, maximum: int)

@export var speed: float = 200.0
@export var max_health: int = 100

var _current_health: int

func _ready() -> void:
    _current_health = max_health

func _physics_process(delta: float) -> void:
    var direction := Input.get_axis("move_left", "move_right")
    velocity.x = direction * speed
    move_and_slide()
```

### Input Handling
- Use Godot's built-in Input Map project settings
- Access via `Input.get_action_strength()` or `Input.is_action_pressed()`
- Never hardcode keycodes

### Signals
- Define signals at top of script: `signal health_changed(new_value: int)`
- Use signal bus for global events (create `Events.gd` autoload)
- Connect in `_ready()`: `health_changed.connect(_on_health_changed)`

## Code Review Checklist

Before marking code as complete, verify:

- [ ] Static typing used throughout
- [ ] No `func _process()` for game logic (physics in `_physics_process`)
- [ ] Scene follows Godot node hierarchy
- [ ] No memory leaks (queue_free() called)
- [ ] Variables named with snake_case
- [ ] Classes named with PascalCase

## Asset Standards

### Sprites
- Source: assets/sprites/
- Format: PNG with alpha
- Pixels per unit: 64px = 1 tile (standard)
- Naming: `player_idle_01.png`, `enemy_goblin_walk_*.png`

### Scenes (.tscn)
- Self-contained and reusable
- Root node matches filename
- Group related nodes under parents

## Collaboration Protocol

This is NOT an autonomous system. Every agent follows:

1. **Ask questions** before assuming
2. **Present options** with trade-offs
3. **User decides** - final call always
4. **Draft first** - show work before finalizing
5. **Get approval** - don't write without "yes"

## Workflow Reference

### Starting a Feature
```
User: "I want to add a dash ability"

1. gamedesigner: "What's the dash? Instant teleport or movement?"
2. gamedesigner: "How far? How often? Any cooldown?"
3. [Design documented]
4. godot-dev: Proposes implementation
5. User approves
6. godot implementations
```

### Reporting Issues
When you find a problem:
1. Describe what's wrong
2. Explain why it's a problem
3. Suggest fix or ask how to proceed

## QA Testing

Before marking any feature complete:
- Playtest the feature (really play it)
- Test edge cases (0 health, max speed, etc.)
- Check frame rate drops
- Verify saves persist correctly

---

*This project follows the studio model from Claude Code Game Studios, adapted for OpenCode + Godot 2D*