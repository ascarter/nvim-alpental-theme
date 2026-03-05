# Copilot Instructions — nvim-alpental-theme

## Build

Requires [veneer-theme](https://github.com/ascarter/veneer-theme) (`cargo install --git https://github.com/ascarter/veneer-theme`) and [just](https://just.systems) (`brew install just`).

```sh
just build   # generate colors/alpental.lua from src/alpental.lua.tera
just clean   # remove generated colors/ directory
```

There are no tests or linters.

## Architecture

Alpental is a theme family that targets multiple editors from a shared palette. This repo is the Neovim variant; [zed-alpental-theme](https://github.com/ascarter/zed-alpental-theme) is the Zed variant. Both share an identical `veneer.toml` and the same `veneer` code-generation pipeline — only the Tera templates differ per editor.

The pipeline works as follows:

1. **`veneer.toml`** — Single source of truth for the palette. Defines light/dark surface colors, text colors, semantic accents (info/success/warning/error), and ANSI 16 mappings. Values can cross-reference other keys (e.g., `"colors.light.text_primary"`). This file must stay in sync across all Alpental editor repos.
2. **`src/alpental.lua.tera`** — [Tera](https://keats.github.io/tera/) template that produces the Neovim Lua colorscheme. Uses `{{ }}` placeholders resolved against the flattened palette from `veneer.toml`.
3. **`colors/alpental.lua`** — Generated output. **Do not edit by hand**; always regenerate with `just build`.

The `veneer` CLI reads `veneer.toml`, flattens/resolves cross-references, and renders each `.tera` template in `src/` into the output directory (`colors/` for Neovim, `themes/` for Zed).

## Conventions

- **Monochrome syntax philosophy**: Syntax highlighting uses only foreground grays (`fg`, `fg_sec`, `fg_tert`) plus italic/bold — no color on language constructs. Color is reserved for diagnostics, diffs, search, tags, and UI chrome. This philosophy is shared across all Alpental variants.
- **Palette key naming**: Surface colors use `bg`/`bg_alt`/`bg_sec`/`bg_tert`; text uses `fg`/`fg_sec`/`fg_tert`/`fg_inv`/`fg_disabled`. Semantic colors use `info`/`success`/`warning`/`error` with `_sec` variants.
- **Alpha blending**: Computed highlight backgrounds (search, selection, diff) use a `blend(fg, bg, alpha)` helper with per-variant alpha values stored in the palette table. Dark mode uses higher alpha values than light mode.
- When adding new highlight groups, follow the existing sectioned layout (Core UI → Syntax → Treesitter → LSP → Diagnostics → Git → plugin groups) and use the `hi(name, opts)` wrapper.
- When modifying palette colors in `veneer.toml`, consider the impact on sibling repos (e.g., `zed-alpental-theme`) that share the same palette.
