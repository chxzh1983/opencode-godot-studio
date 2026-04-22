<p align="center">
  <h1>OpenCode 游戏工作室 - Godot 2D</h1>
  <p>使用专业的 AI 智能体团队，让您的 OpenCode 会话变身为完整的游戏开发工作室，专为 Godot 2D 游戏开发而设计。</p>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/OpenCode-Game%20Studio-Godot%202D-blue" alt="OpenCode Game Studio">
  <img src="https://img.shields.io/badge/Godot-4.x-478061" alt="Godot 4.x">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="MIT License">
</p>

---

## 这是什么？

**OpenCode 游戏工作室** 是一套专为 **OpenCode** + **Godot 4 (2D)** 设计的专业游戏开发工作室框架。灵感来源于 [Claude Code Game Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)，针对 OpenCode 进行了适配。

此模板为您提供：
- **5 个专业化 AI 智能体**（总监、游戏设计师、Godot 开发者、美术、QA）
- **工作室工作流程** 协作规范
- **Godot 2D 最佳实践** 代码模式
- **场景架构** 模板

## 为什么要使用它？

独自用 AI 开发游戏很强大，但单独的聊天会话缺乏结构。此模板通过赋予您的 AI 会话一个真实游戏工作室的结构来解决这个问题：

- 针对不同角色的专业化智能体
- 清晰的决策工作流程
- 代码规范强制执行
- 包含 QA 测试流程

## 快速开始

### 环境要求

- 安装 [OpenCode](https://opencode.ai)
- 安装 [Godot 4.x](https://godotengine.org)（2D 渲染器）

### 安装

```bash
# 克隆此模板
git clone https://github.com/chxzh1983/opencode-godot-studio.git my-game
cd my-game

# 在 OpenCode 中打开
opencode
```

### 使用方法

进入 OpenCode 后：

1. 运行 `/init` 初始化项目
2. 使用 `@智能体名称` 选择要协作的 AI 智能体
3. 按照 `AGENTS.md` 中的工作流程进行

## 项目结构

```
my-game/
├── AGENTS.md                    # 项目规则和工作流程
├── opencode.json               # OpenCode 配置
├── .opencode/
│   └── agents/               # 智能体定义
│       ├── director.md       # 创意/技术总监
│       ├── gamedesigner.md   # 游戏设计
│       ├── godot-dev.md     # Godot 2D 编程
│       ├── artist.md       # 2D 美术和视觉
│       └── qa.md          # 测试和 QA
├── docs/                      # 参考文档
│   ├── godot-2d-patterns.md
│   └── scene-architecture.md
├── src/                       # 游戏源码
├── assets/                    # 精灵图、音频、着色器
└── design/                   # 游戏设计文档
```

## 团队角色

| 智能体 | 角色 | 描述 |
|-------|------|------|
| `director` | 创意/技术总监 | 愿景、决策、架构 |
| `gamedesigner` | 游戏设计 | 机制、系统、关卡设计 |
| `godot-dev` | 程序员 | GDScript 实现 |
| `artist` | 美术 | 2D 资源、视觉方向 |
| `qa` | 测试 | 测试、找 bug |

## 智能体协作示例

```
您："我想添加二段跳技能"

@gamedesigner："请问二段跳的具体设计：
- 跳跃高度：2 格还是 3 格？
- 能和墙壁跳连招吗？
- 有冷却时间吗？"

[讨论设计细节]

@godot-dev："实现方案：
- 方案 A：简单（重置速度）
- 方案 B：完整空中跳跃计数器

您更喜欢哪个？"

[您做出决定]

@godot-dev 实现功能
@qa 测试功能
```

## Godot 2D 最佳实践

### 场景架构

```gdscript
# 使用正确的节点类型
extends CharacterBody2D  # 玩家/敌人
extends Area2D           # 触发器/拾取物
```

### GDScript 规范

```gdscript
# 始终使用静态类型
var speed: float = 200.0

# 使用信号进行通信
signal health_changed(current: int, maximum: int)

# 使用 @export 导出可配置值
@export var max_health: int = 100
```

更多代码模式请参阅 `docs/godot-2d-patterns.md`。

## 文档

- [AGENTS.md](AGENTS.md) - 项目规则和工作流程
- [docs/godot-2d-patterns.md](docs/godot-2d-patterns.md) - 代码模式
- [docs/scene-architecture.md](docs/scene-architecture.md) - 场景结构

## 自定义

这是一个模板。请随意自定义：

- 在 `.opencode/agents/` 中添加/删除智能体
- 修改 `AGENTS.md` 中的工作流程
- 在 `docs/` 中添加 Godot 特定模式

## 贡献

欢迎贡献！请参阅 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 许可证

MIT 许可证 - 请参阅 [LICENSE](LICENSE)。

## 致谢

- 灵感来源于 [Claude Code Game Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)
- 为 [OpenCode](https://opencode.ai) 和 [Godot](https://godotengine.org) 构建

---

<p align="center">Made with OpenCode + Godot</p>