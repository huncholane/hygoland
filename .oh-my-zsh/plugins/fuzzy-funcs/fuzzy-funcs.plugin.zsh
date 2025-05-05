# Fuzzy cd
fcd() {
  local base="${1/#\~/$HOME}"
  local dir
  dir=$(find "${base:-.}" -type d 2>/dev/null | fzf --height=90% \
    --reverse \
    --border \
    --preview 'ls -l --color=always {} 2>/dev/null | head -50' \
    --preview-window=right:50%:wrap \
    --prompt="📁 cd into: " \
    --marker="👉" \
    --color=prompt:italic:underline,pointer:bold:blue \
  )
  [[ -n "$dir" ]] && cd "$dir"
}

# Fuzzy yay installer
fyi() {
  local package
  package=$(yay -Slq | fzf --height=90% \
    --reverse \
    --border \
    --preview 'yay -Qi {} 2>/dev/null' \
    --preview-window=right:50%:wrap \
    --prompt="🔍 Select a package: " \
    --marker="👉" \
    --color=prompt:italic:underline,pointer:bold:green \
    --info=inline
  )

  if [[ -n "$package" ]]; then
    # Install the selected package
    yay -S "$package" && notify-send "✔️ Package installed: $package"
  else
    # Handle cancel or no package selected
    notify-send "❌ No package selected."
  fi
}

# Fuzzy yay delete/remove
fyd() {
  local package
  package=$(yay -Qeq | fzf --height=90% \
    --reverse \
    --border \
    --preview 'yay -Qi {}' \
    --preview-window=right:50%:wrap \
    --prompt="❌ Select a package to remove: " \
    --marker="👉" \
    --color=prompt:italic:underline,pointer:bold:red \
    --info=inline
  )

  if [[ -n "$package" ]]; then
    # Confirm removal before proceeding
    echo "Are you sure you want to remove $package? [y/N]"
    read confirm
    if [[ "$confirm" == [Yy] ]]; then
      yay -Rdd "$package" && notify-send "✔️ Package removed: $package"
    else
      notify-send "❌ Package removal cancelled."
    fi
  else
    # Handle cancel or no package selected
    notify-send "❌ No package selected."
  fi
}

# Fuzzy executables
fex() {
  local executable
  # The timeout is to prevent gui help menus
  executable=$(compgen -c | grep -v '^_' | fzf --height=90% \
    --reverse \
    --border \
    --preview 'echo "Help for {}:"; timeout 0.01s {} --help' \
    --preview-window=right:50%:wrap \
    --prompt="🔧 Select an executable to get help: " \
    --marker="👉" \
    --color=prompt:italic:underline,pointer:bold:green \
    --info=inline
  )

  if [[ -n "$executable" ]]; then
    # Execute --help for the selected executable
    $executable --help && notify-send "✔️ Help for '$executable' displayed"
  else
    # Handle cancel or no executable selected
    notify-send "❌ No executable selected."
  fi
}

# Fuzzy Mic Test (ftm)
ftm() {
  local mic
  mic=$(pactl list short sources | fzf --prompt="🎤 Select Mic: " --height=40% --reverse | awk '{print $2}')
  [[ -z "$mic" ]] && echo "❌ Cancelled" && return

  echo "🎧 Testing $mic... Press Ctrl+C to stop."
  pw-cat --record --target "$mic" --rate 48000 --channels 1 --format s16 - | pw-play -
}
