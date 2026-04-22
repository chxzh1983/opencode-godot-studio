<p align="center">
  <h1>OpenCode Game Studio - Godot 2D</h1>
  <p>Turn your OpenCode session into a game development studio with specialized AI agents for Godot 2D game development.</p>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/OpenCode-Game%20Studio-Godot%202D-blue" alt="OpenCode Game Studio">
  <img src="https://img.shields.io/badge/Godot-4.x-478061" alt="Godot 4.x">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License MIT">
</p>

---

## What Is This?

A professional game development studio framework for **OpenCode** + **Godot 4 (2D)**. Inspired by [Claude Code Game Studios](https://github.com/Donchitos/Claude-Code-Game-Studios), adapted for OpenCode.

This template gives you:
- **5 specialized AI agents** (director, game designer, Godot dev, artist, QA)
- **Studio workflow** with collaboration protocols
- **Godot 2D patterns** and best practices
- **Scene architecture** templates

## Why Use This?

Building a game solo with AI is powerful — but a single chat session has no structure. This template solves that by giving your AI session the structure of a real game studio:

- Specialized agents for different roles
- Clear decision workflows
- Code standards enforced
- QA process included

## Quick Start

### Prerequisites

- [OpenCode](https://opencode.ai) installed
- [Godot 4.x](https://godotengine.org) (2D renderer)

### Installation

```bash
# Clone this template
git clone https://github.com/YOUR_USERNAME/opencode-godot-studio.git my-game
cd my-game

# Open in OpenCode
opencode
```

### Usage

Once in OpenCode:

1. Run `/init` to initialize the project
2. Choose an agent to work with (use `@agent-name`)
3. Follow the workflow in `AGENTS.md`

## Project Structure

```
my-game/
├── AGENTS.md                    # Project rules and workflow
├── opencode.json               # OpenCode configuration
├── .opencode/
│   └── agents/               # Agent definitions
│       ├── director.md       # Creative/technical lead
│       ├── gamedesigner.md   # Game design
│       ├── godot-dev.md     # Godot 2D programming
│       ├── artist.md       # 2D art and visuals
│       └── qa.md          # Testing and QA
├── docs/                      # Reference documentation
│   ├── godot-2d-patterns.md
│   └── scene-architecture.md
├── src/                       # Game source code
├── assets/                    # Sprites, audio, shaders
└── design/                   # Game design documents
```

## Team Roles

| Agent | Role | Description |
|-------|------|-------------|
| `director` | Creative/Technical Lead | Vision, decisions, architecture |
| `gamedesigner` | Game Design | Mechanics, systems, level design |
| `godot-dev` | Programmer | GDScript implementation |
| `artist` | Artist | 2D assets, visual direction |
| `qa` | QA | Testing, bug finding |

## Agent Collaboration

### Example Workflow

```
You: "I want to add a double jump ability"

@gamedesigner: "What's the double jump?
- Jump height: 2 tiles or 3?
- Can chain with wall jump?
- Any cooldown?"

[Discussion about design]

@godot-dev: "Implementation approach:
- Option A: Simple (reset velocity)
- Option B: Full air jump counter

Which do you prefer?"

[You decide]

@godot-dev implementations
@qa tests the feature
```

## Godot 2D Best Practices

### Scene Architecture

```gdscript
# Use proper node types
extends CharacterBody2D  # For player/enemies
extends Area2D           # For triggers/pickups
```

### GDScript Standards

```gdscript
# Always use static typing
var speed: float = 200.0

# Use signals for communication
signal health_changed(current: int, maximum: int)

# Export for configurable values
@export var max_health: int = 100
```

See `docs/godot-2d-patterns.md` for more patterns.

## Documentation

- [AGENTS.md](AGENTS.md) - Project rules and workflow
- [docs/godot-2d-patterns.md](docs/godot-2d-patterns.md) - Code patterns
- [docs/scene-architecture.md](docs/scene-architecture.md) - Scene structure

## Customization

This is a template. Feel free to customize:

- Add/remove agents in `.opencode/agents/`
- Modify workflow in `AGENTS.md`
- Add Godot-specific patterns to `docs/`

## Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT License - See [LICENSE](LICENSE).

## Credits

- Inspired by [Claude Code Game Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)
- Built for [OpenCode](https://opencode.ai) and [Godot](https://godotengine.org)

---

<p align="center">Made with OpenCode + Godot</p>