# termux-theme

Fast interactive theme picker for Termux.

It gives you the workflow the official Termux:Styling plugin is missing:

- browse themes with `fzf`
- preview colors live while moving through the list
- keep your most-used themes at the top
- press Enter to apply
- press Esc or Ctrl-C to restore the previous theme

No Android plugin, no APK signing, no Play Store, no repeated menu tapping.

## Install

In Termux:

```sh
curl -fsSL https://raw.githubusercontent.com/dianedef/termux-theme/main/install.sh | sh
```

Then run:

```sh
termux-theme
```

The installer copies:

- the command to `$PREFIX/bin/termux-theme`
- bundled themes to `~/.termux/themes`

It also installs `fzf` with `pkg install -y fzf` if needed.

## Usage

```text
Up/Down or search  preview live
Enter              apply selected theme
Esc/Ctrl-C         restore previous theme
```

The live preview works by temporarily copying the selected theme to:

```text
~/.termux/colors.properties
```

and asking Termux to reload its style without recreating the activity.

Each time you apply a theme with Enter, its local usage counter is incremented
in:

```text
~/.termux/theme-usage.tsv
```

Themes are shown by most-used first, then alphabetically.

## Add A Theme

Drop a Termux-compatible theme file into:

```text
~/.termux/themes/name.properties
```

Expected format:

```properties
foreground=#f8f8f2
background=#282a36
cursor=#f8f8f2

color0=#000000
color1=#ff5555
color2=#50fa7b
color3=#f1fa8c
color4=#bd93f9
color5=#ff79c6
color6=#8be9fd
color7=#bfbfbf
color8=#4d4d4d
color9=#ff6e67
color10=#5af78e
color11=#f4f99d
color12=#caa9fa
color13=#ff92d0
color14=#9aedfe
color15=#e6e6e6
```

## Included Themes

This repo ships with a curated set of popular terminal palettes:

- Catppuccin Latte, Frappe, Macchiato, Mocha
- Dracula
- Gruvbox Dark and Light
- Nord
- TokyoNight Dark and Day
- Solarized Dark and Light
- One Dark
- Rose Pine, Moon, Dawn
- Monokai
- Material
- Ubuntu
- White on Black

See [ATTRIBUTIONS.md](ATTRIBUTIONS.md) for upstream sources and license notes.

## Requirements

- Termux on Android
- `fzf`
- shell access to `~/.termux/colors.properties`

The script intentionally does not manage fonts.

## License

GPLv3 only, matching the bundled theme source material.
