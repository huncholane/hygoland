# Hygoland

🌀 Personal dotfiles for a Hyprland-based setup. Everything is rooted in `~` and tracked using a `.gitignore` whitelist.

## ✨ Features

* **Hyprland** WM with configs inspired by [JaKooLit](https://github.com/JaKooLit)
* **Neovim** (LazyVim-based) with:

  * LeetCode plugin for daily practice
  * Custom tweaks and plugin loadout
* **WezTerm** with Vim-style pane movement
* **Tmux**:

  * Vim-style navigation
  * `resurrect` + `continuum` for session save/restore
* **Oh My Zsh** shell setup

## 📁 Structure

Dotfiles are stored directly in `$HOME`, tracked with a whitelist `.gitignore`. No symlinks or special folders.

## 🚀 Setup

```bash
git clone https://github.com/youruser/hygoland.git ~
cd ~
# install dependencies manually or add a bootstrap script
```

> Uses `direnv`, `zsh`, `tmux`, `wezterm`, `nvim`, `Hyprland`, and more.
