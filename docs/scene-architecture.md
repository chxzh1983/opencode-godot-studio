# Scene Architecture Guide

How to organize your Godot 2D scenes for maintainability and scalability.

## Directory Structure

```
src/
├── main/
│   └── main.tscn              # Game entry point
├── entities/
│   ├── player/
│   │   ├── player.tscn
│   │   └── player.gd
│   └── enemies/
│       ├── enemy.tscn
│       ├── enemy.gd
│       └── goblin/
│           └── goblin.tscn
├── components/
│   ├── health_component.gd
│   ├── hitbox.gd
│   ├── hurtbox.gd
│   └── state_machine.gd
├── systems/
│   ├── game_manager.gd
│   ├── level_manager.gd
│   └── spawn_manager.gd
├── ui/
│   ├── hud/
│   │   └── hud.tscn
│   ├── menus/
│   │   └── main_menu.tscn
│   └── pause_menu.tscn
└── utilities/
    ├── constants.gd
    └── helpers.gd

assets/
├── sprites/
├── scenes/
│   ├── levels/
│   │   └── level_01.tscn
│   └── checkpoints/
└── tilesets/
    └── level_tileset.tres
```

## Scene Composition Principles

### 1. Single Responsibility
Each scene should do one thing well.

```
Good:
Player (CharacterBody2D) - handles player ONLY
├── Sprite2D
├── CollisionShape2D
├── AnimationPlayer
└── StateMachine

Not Good:
Player (CharacterBody2D) - too many responsibilities
├── Sprite2D
├── CollisionShape2D
├── HealthComponent (should be separate)
├── InventoryComponent (should be separate)
├── AttackComponent (should be separate)
```

### 2. Composition over Inheritance
Use child nodes, not inheritance chains.

```
Instead of:
Enemy <- GoblinEnemy <- BossGoblinEnemy (deep inheritance)

Use composition:
Enemy (base scene)
├── GoblinData (Resource)
├── BossModifier (Component)
```

### 3. Self-Contained Scenes
Scenes should work when instanced.

```gdscript
# collectible.tscn can be placed anywhere
# It handles its own collision and logic
# No dependencies on parent scene

collectible.tscn:
Collectible (Area2D)
├── Sprite2D
├── CollisionShape2D
└── collectible.gd (self-contained)
```

## Node Naming Conventions

| Node Type | Naming | Example |
|----------|--------|---------|
| Scene root | PascalCase | `Player` |
| Child nodes | PascalCase | `Sprite2D`, `CollisionShape2D` |
| Script | Same as root | `player.gd` for `Player.tscn` |

## Group Usage

### Group Naming
- Use prefixes: `enemies_`, `players_`, `interactables_`
- Use suffixes: `_walk`, `_idle`, `_ground`

```gdscript
# Add to enemy
add_to_group("enemies")
add_to_group("enemies_walkable")

# Find all enemies
get_tree().get_nodes_in_group("enemies")
```

## Scene Instancing Pattern

```gdscript
# Level loads entities via scenes/
@export var enemy_scene: PackedScene

func _spawn_enemy() -> void:
    var enemy: CharacterBody2D = enemy_scene.instantiate()
    enemy.position = Vector2(100, 200)
    add_child(enemy)
```

## Prefab Management

### Variation via Exports
```gdscript
# enemy.tscn
class_name Enemy
extends CharacterBody2D

@export var enemy_data: EnemyData  # Resource with stats

@export var health_modifier: float = 1.0

var actual_health: int:
    get: return int(enemy_data.health * health_modifier)
```

### Different enemy types from same scene
```gdscript
# In level editor
# Place enemy.tscn twice

# First instance:
#   enemy_data = goblin_data.tres
#   health_modifier = 1.0

# Second instance:
#   enemy_data = goblin_data.tres
#   health_modifier = 2.0  # Boss!
```

## Autoload Usage

Use sparingly. Only for truly global:

```gdscript
# events.gd - YES
signal game_paused
signal level_completed
signal player_died

# game_manager.gd - OK
# Global game state

# NOT autoload (use scene instance):
# - EnemyManager (per level)
# - UIManager (per scene)
```

## Common Scene Trees

### Player
```
Player (CharacterBody2D)
├── Graphics (Node2D)
│   ├── Sprite2D
│   └── Shadow (Sprite2D)
├── Collision (CollisionShape2D)
├── Camera2D
├── AnimationPlayer
├── StateMachine
│   ├── IdleState
│   ├── RunState
│   └── JumpState
├── HealthComponent
├── Hurtbox
│   └── CollisionShape2D
└── Weapons (Node2D)
    └── Hitbox (Area2D)
```

### Enemy
```
Enemy (CharacterBody2D)
├── Graphics (Node2D)
│   └── Sprite2D
├── Collision (CollisionShape2D)
├── AnimationPlayer
├── StateMachine
├── HealthComponent
├── Hurtbox (Area2D)
└── Hitbox (Area2D)
    └── CollisionShape2D
```

### Level
```
Main (Node2D)
├── TileMap
├── Player (Instantiated)
├── Enemies (Node2D)
│   └── Enemy (Instantiated x3)
├── Collectibles (Node2D)
│   ├── Coin x5
│   └── HealthPack x2
├── Camera2D
├── CanvasLayer (UI)
│   └── HUD
├── AudioStreamPlayer (music)
├── Checkpoints (Node2D)
└── DeathZone (Area2D)
```

---

*See also: godot-2d-patterns.md*