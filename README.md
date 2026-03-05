# nvim-alpental-theme

Minimal Neovim color scheme focused on typography.

## Prerequisites
- Install the [veneer-theme](https://github.com/ascarter/veneer-theme) CLI used to build the theme assets:
  ```sh
  cargo install --git https://github.com/ascarter/veneer-theme
  ```
- Install [just](https://just.systems) for running the task recipes:
  ```sh
  brew install just
  ```

## Build
- Generate the compiled theme files:
  ```sh
  just build
  ```
The output ends up in `colors/` and can be linked or copied into your Neovim config.

## Justfile tasks
- `just build` (default): Create `colors/alpental.lua` from `src/alpental.lua.tera` using `veneer`.
- `just clean`: Remove the generated `colors/` directory.