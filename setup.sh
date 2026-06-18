#!/usr/bin/env bash

# Check mandatory applications
[ ! -x "$(command -v fish)" ] && echo "ERROR: fish is not installed in the system" && exit -1
[ ! -x "$(command -v git)" ] && echo "ERROR: git is not installed in the system" && exit -1
[ ! -x "$(command -v jj)" ] && echo "ERROR: jj is not installed in the system" && exit -1
[ ! -x "$(command -v nvim)" ] && echo "ERROR: nvim is not installed in the system" && exit -1
[ ! -x "$(command -v stow)" ] && echo "ERROR: stow is not installed in the system" && exit -1
[ ! -x "$(command -v curl)" ] && echo "ERROR: curl is not installed in the system" && exit -1

# Packages to be installed
packages=(
  agents
  bat
  fish
  ghostty
  delta
  git
  lumen
  jj
  nvim
  opencode
  starship
  tmux
)

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
  bold=$(tput bold 2>/dev/null || true)
  dim=$(tput dim 2>/dev/null || true)
  green=$(tput setaf 2 2>/dev/null || true)
  red=$(tput setaf 1 2>/dev/null || true)
  cyan=$(tput setaf 6 2>/dev/null || true)
  reset=$(tput sgr0 2>/dev/null || true)
else
  bold=""
  dim=""
  green=""
  red=""
  cyan=""
  reset=""
fi

# Run the stow command
stow_it() {
  package="$1"

  stow --no-folding -vR "$package" --ignore='(^|\W)\.gitkeep($|\W)' --ignore='(^|\W).DS_Store($|\W)'
}

total=${#packages[@]}
current=0
failed_packages=()

printf "%s> Stowing %s packages%s\n\n" "$bold" "$total" "$reset"

failed=0

# Install everything
for package in "${packages[@]}"; do
  current=$((current + 1))
  output=$(stow_it "$package" 2>&1)
  status=$?
  changes=0

  if [ -n "$output" ]; then
    while IFS= read -r line; do
      [ -n "$line" ] && changes=$((changes + 1))
    done <<< "$output"
  fi

  if [ "$status" -eq 0 ]; then
    printf "%s[%2s/%2s]%s %sOK%s     %-10s %s%s stow operations%s\n" "$dim" "$current" "$total" "$reset" "$green" "$reset" "$package" "$cyan" "$changes" "$reset"
  else
    printf "%s[%2s/%2s]%s %sFAILED%s %-10s %s%s stow operations%s\n" "$dim" "$current" "$total" "$reset" "$red" "$reset" "$package" "$cyan" "$changes" "$reset"

    while IFS= read -r line; do
      printf "  %s\n" "$line"
    done <<< "$output"

    printf "\n"
    failed=1
    failed_packages+=("$package")
  fi
done

printf "\n"

if [ "$failed" -eq 0 ]; then
  printf "%sDone.%s Stowed %s packages successfully.\n" "$green" "$reset" "$total"
else
  printf "%sDone with failures.%s %s/%s packages failed: %s\n" "$red" "$reset" "${#failed_packages[@]}" "$total" "${failed_packages[*]}"
fi

exit "$failed"
