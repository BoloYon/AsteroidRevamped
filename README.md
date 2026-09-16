# Asteroids: Revamped Prototype

This is the rebuilt prototype of Asteroids, a 2D arcade game developed in **Godot 4** with **GDScript**. I restarted the project to replace the original prototype's tightly connected systems with a more reusable entity and handler architecture.

> **Project status:** Paused prototype. The core gameplay systems and presentation were implemented, but the project was not developed into a finished release.

## Features

- Reusable entity hierarchy for players, asteroids, and projectiles
- Shared base-class behavior for damageable entities
- Handler framework separating movement, health, damage, targeting, weapons, and death behavior
- Super Root scene and global managers for shared game-state coordination
- Keyboard movement, mouse-directed aiming, shooting, and collision handling
- Player targeting used by the asteroid spawning system
- Reload timing with animated reload-bar feedback
- Player health HUD connected to the rebuilt health system
- Impact particles when projectiles strike asteroids
- Asteroid death particles that detach into heated red shards, cool to the normal asteroid color, and fade away
- Main menu plus persistent pause and death interfaces
- Cinematic death sequence with global slow motion, a red vignette, an expanding terminal panel, typed text, and rerun or exit options
- Interface audio for hovering, terminal movement, typing, prompts, and death-screen buttons
- Restart flow that restores the normal time scale and reloads the simulation

## Built With

- [Godot Engine 4](https://godotengine.org/)
- GDScript

## Running the Project

1. Install a compatible Godot 4 release.
2. Clone or download the project repository.
3. In Godot, select **Import** and open `project.godot`.
4. Run the project with `F5` or the **Run Project** button.

## Architecture

The revamped prototype organizes gameplay around reusable entities and specialized handlers. Shared behavior lives higher in the entity hierarchy, while focused handlers manage responsibilities such as movement, targeting, health, weapons, particles, and death. This made the rebuilt version easier to extend without concentrating every behavior inside one large script.

## What I Practiced

This rebuild helped me practice inheritance, reusable class design, event-driven communication, global game-state management, UI sequencing, particle lifecycles, audio feedback, and controlling real-time presentation with `Engine.time_scale`.

## Earlier Prototype

The original prototype explored a different set of systems, including Astrynite currency, purchasable upgrades, wave and boss progression, asteroid splitting, health decay and regeneration, and run statistics. Its repository is documented separately so the features of the two prototypes are not combined.
