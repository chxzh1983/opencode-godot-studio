# Godot 2D Patterns Reference

Quick reference for common Godot 2D patterns. Based on Claude Code Game Studios best practices.

## Project Setup

### Recommended Project Settings
```
Display/Window/Size/Viewport Width: 640 (or 1280)
Display/Window/Size/Viewport Height: 360 (or 720)
Display/Window/Stretch/Mode: viewport
Display/Window/Stretch/Aspect: keep
Rendering/Textures/Default Texture Filter: nearest (for pixel art)
Rendering/2D/Pixel Snap: On (for pixel art)
```

### Input Map (Project Settings → Input Map)
```gdscript
# Add these actions:
jump: Space key
move_left: A or Left arrow
move_right: D or Right arrow
attack: J or Z
```

## Player Character Template

```gdscript
# player.gd
class_name Player
extends CharacterBody2D

signal health_changed(current: int, maximum: int)
signal died

@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var max_health: int = 100

@onready var sprite := $Sprite2D
@onready var animation_player := $AnimationPlayer

var _current_health: int
var _velocity_y: float = 0.0
var _is_jumping := false

const GRAVITY := 980.0

func _ready() -> void:
    _current_health = max_health

func _physics_process(delta: float) -> void:
    var direction := Input.get_axis("move_left", "move_right")
    velocity.x = direction * speed
    
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity
        _is_jumping = true
    
    if not is_on_floor():
        velocity.y += GRAVITY * delta
    else:
        velocity.y = 0.0
        _is_jumping = false
    
    move_and_slide()
    _update_animation()

func _update_animation() -> void:
    if velocity.x != 0:
        sprite.scale.x = sign(velocity.x)
    
    if not is_on_floor():
        animation_player.play("jump")
    elif velocity.x != 0:
        animation_player.play("run")
    else:
        animation_player.play("idle")

func take_damage(amount: int) -> void:
    _current_health = max(0, _current_health - amount)
    health_changed.emit(_current_health, max_health)
    
    if _current_health <= 0:
        died.emit()
```

## Enemy Template

```gdscript
# enemy.gd
class_name Enemy
extends CharacterBody2D

@export vardamage := 10
@export var health := 30
@export var speed := 100.0
@export var patrol_distance := 100.0

var _start_position: Vector2
var _direction := 1

func _ready() -> void:
    _start_position = global_position

func _physics_process(delta: float) -> void:
    velocity.x = speed * _direction
    move_and_slide()
    
    if global_position.x > _start_position.x + patrol_distance:
        _direction = -1
    elif global_position.x < _start_position.x - patrol_distance:
        _direction = 1
```

## State Machine

```gdscript
# state_machine.gd
class_name StateMachine
extends Node

signal state_changed(old_state: String, new_state: String)

@export var current_state: State

var states: Dictionary = {}

func _ready() -> void:
    for child in get_children():
        if child is State:
            states[child.name] = child
            child.state_machine = self
    
    if current_state:
        current_state.enter()

func _process(delta: float) -> void:
    if current_state:
        current_state.update(delta)

func _physics_process(delta: float) -> void:
    if current_state:
        current_state.physics_update(delta)

func transition_to(state_name: String) -> void:
    var new_state: State = states.get(state_name)
    if new_state and new_state != current_state:
        var old := current_state
        if current_state:
            current_state.exit()
        current_state = new_state
        current_state.enter()
        state_changed.emit(old.name if old else "", state_name)
```

```gdscript
# state.gd
class_name State
extends Node

var state_machine: StateMachine

func enter() -> void:
    pass

func exit() -> void:
    pass

func update(_delta: float) -> void:
    pass

func physics_update(_delta: float) -> void:
    pass
```

## Collectibles

```gdscript
# collectible.gd
class_name Collectible
extends Area2D

@export var value := 1
@export var collect_sound: AudioStream

func _ready() -> void:
    area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
    if area is Player or area.has_method("collect"):
        area.collect(value)
        queue_free()
```

## Combat (Hitbox/Hurtbox)

```gdscript
# hitbox.gd
class_name Hitbox
extends Area2D

@export var damage := 10

func _ready() -> void:
    area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
    if area is Hurtbox:
        area.receive_hit(damage)
```

```gdscript
# hurtbox.gd
class_name Hurtbox
extends Area2D

signal hit_received(damage: int)

@export var invincibility_time: float = 0.5

var _is_invincible := false

func _ready() -> void:
    area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
    if area is Hitbox and not _is_invincible:
        receive_hit(area.damage)

func receive_hit(damage: int) -> void:
    _is_invincible = true
    hit_received.emit(damage)
    await get_tree().create_timer(invincibility_time).timeout
    _is_invincible = false
```

## Camera

```gdscript
# camera.gd
extends Camera2D

@export var target: Node2D
@export var smooth_time: float = 0.3

const OFFSET := Vector2(0, -50)

func _physics_process(_delta: float) -> void:
    if target:
        var target_pos := target.global_position + OFFSET
        global_position = global_position.lerp(target_pos, smooth_time)
```

## Checkpoints

```gdscript
# checkpoint.gd
class_name Checkpoint
extends Area2D

@export var checkpoint_id: int = 0

@onready var sprite := $Sprite2D

var _activated := false

func _ready() -> area_entered.connect(_on_player_entered)
    if not _activated:
        sprite.modulate.a = 0.5

func _on_player_entered(area: Area2D) -> void:
    if area is Player and not _activated:
        _activated = true
        sprite.modulate.a = 1.0
        SaveSystem.set_last_checkpoint(checkpoint_id)
```

## UI (HUD)

```gdscript
# hud.gd
class_name HUD
extends CanvasLayer

@onready var health_bar := $HealthBar
@onready var score_label := $Score/Label
@onready var coin_counter := $Coins/Label

func _ready() -> void:
    Player.connect_signal(PlayerSignalBus.health_changed, _on_health_changed)
    Player.connect_signal(PlayerSignalBus.coins_changed, _on_coins_changed)

func _on_health_changed(current: int, maximum: int) -> void:
    health_bar.value = float(current) / maximum * 100

func _on_coins_changed(count: int) -> void:
    coin_label.text = str(count)
```

## Signal Bus (Global Events)

```gdscript
# events.gd
extends Node

signal player_damaged(amount: int, current: int)
signal player_died
signal coin_collected(total: int)
signal checkpoint_reached(checkpoint_id: int)
signal level_completed
```

Add as Autoload: `Events` (Project → Project Settings → Autoload)

## Save System

```gdscript
# save_system.gd
extends Node

const SAVE_PATH := "user://save_game.dat"

var _data: Dictionary = {
    "health": 100,
    "coins": 0,
    "checkpoint": 0,
    "unlocks": []
}

func _ready() -> void:
    load_game()

func save_game() -> void:
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    file.store_var(_data)
    file.close()

func load_game() -> void:
    if FileAccess.file_exists(SAVE_PATH):
        var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
        _data = file.get_var()
        file.close()

func get_value(key: String, default = null):
    return _data.get(key, default)

func set_value(key: String, value) -> void:
    _data[key] = value
    save_game()
```

## Common Imports

```gdscript
# At top of file
extends Node

const MOVE_SPEED := 200.0
const JUMP_VELOCITY := -350.0
const GRAVITY := 980.0
```

---

*See also: scene-architecture.md, input-handling.md*