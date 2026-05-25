#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
workspace_root="$(cd "$script_dir/.." && pwd)"

print_header() {
  printf '\nCyber Project Workspace Menu\n'
  printf 'Workspace: %s\n\n' "$workspace_root"
}

pause() {
  printf '\nPress Enter to continue...'
  read -r _
}

slugify() {
  printf '%s' "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//'
}

read_project_inputs() {
  read -r -p 'Project name: ' project_name
  if [[ -z "$project_name" ]]; then
    printf 'Project name is required.\n' >&2
    return 1
  fi

  read -r -p 'GitHub remote URL (optional, press Enter to skip): ' remote_url
}

create_red_team_project() {
  read_project_inputs || return
  "$workspace_root/scripts/create-red-team-project.sh" "$project_name" "$remote_url"
}

create_blue_team_project() {
  read_project_inputs || return
  "$workspace_root/scripts/create-blue-team-project.sh" "$project_name" "$remote_url"
}

project_repos() {
  find "$workspace_root/project" -mindepth 3 -maxdepth 3 -type d -name .git 2>/dev/null \
    | sed 's#/.git$##' \
    | sort
}

list_project_repos() {
  local repo_count=0
  while IFS= read -r repo_dir; do
    repo_count=$((repo_count + 1))
    printf '%s. %s\n' "$repo_count" "${repo_dir#$workspace_root/}"
  done < <(project_repos)

  if [[ "$repo_count" -eq 0 ]]; then
    printf 'No project repositories found under project/red-team or project/blue-team.\n'
  fi
}

select_project_repo() {
  mapfile -t repos < <(project_repos)

  if [[ "${#repos[@]}" -eq 0 ]]; then
    printf 'No project repositories found.\n' >&2
    return 1
  fi

  printf '\nProject repositories:\n'
  for index in "${!repos[@]}"; do
    printf '%s. %s\n' "$((index + 1))" "${repos[$index]#$workspace_root/}"
  done

  read -r -p 'Choose project number: ' choice
  if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#repos[@]} )); then
    printf 'Invalid project selection.\n' >&2
    return 1
  fi

  selected_repo="${repos[$((choice - 1))]}"
}

show_status() {
  printf '\nWorkspace repo:\n'
  git -C "$workspace_root" status --short --branch

  printf '\nProject repos:\n'
  while IFS= read -r repo_dir; do
    printf '\n%s\n' "${repo_dir#$workspace_root/}"
    git -C "$repo_dir" status --short --branch
    git -C "$repo_dir" remote -v || true
  done < <(project_repos)
}

set_project_remote() {
  select_project_repo || return
  read -r -p 'GitHub remote URL: ' remote_url
  if [[ -z "$remote_url" ]]; then
    printf 'Remote URL is required.\n' >&2
    return 1
  fi

  if git -C "$selected_repo" remote get-url origin >/dev/null 2>&1; then
    git -C "$selected_repo" remote set-url origin "$remote_url"
  else
    git -C "$selected_repo" remote add origin "$remote_url"
  fi

  printf 'Origin set for %s\n' "${selected_repo#$workspace_root/}"
  git -C "$selected_repo" remote -v
}

commit_and_push_repo() {
  local repo_dir="$1"
  local label="$2"

  printf '\n%s\n' "$label"
  git -C "$repo_dir" status --short --branch

  if [[ -n "$(git -C "$repo_dir" status --short)" ]]; then
    read -r -p 'Commit message: ' commit_message
    if [[ -z "$commit_message" ]]; then
      printf 'Commit message is required when changes exist.\n' >&2
      return 1
    fi
    git -C "$repo_dir" add -A
    git -C "$repo_dir" commit -m "$commit_message"
  else
    printf 'No local changes to commit.\n'
  fi

  if git -C "$repo_dir" rev-parse --abbrev-ref --symbolic-full-name '@{u}' >/dev/null 2>&1; then
    git -C "$repo_dir" push
  elif git -C "$repo_dir" remote get-url origin >/dev/null 2>&1; then
    git -C "$repo_dir" push -u origin main
  else
    printf 'No origin remote configured. Use menu option 7 first.\n'
  fi
}

commit_and_push_workspace() {
  commit_and_push_repo "$workspace_root" 'Workspace repository'
}

commit_and_push_project() {
  select_project_repo || return
  commit_and_push_repo "$selected_repo" "Project repository: ${selected_repo#$workspace_root/}"
}

show_next_steps() {
  printf '\nRecommended next steps\n'
  printf '1. Complete project/red-team/rubber-ducky/scope.md for your Pi Pico lab.\n'
  printf '2. Run only the harmless text-entry baseline first.\n'
  printf '3. Push USB HID Detection after creating its dedicated GitHub repo.\n'
  printf '4. Capture sanitized evidence under each project repo evidence/ folder.\n'
  printf '5. Keep project repos separate from the workspace repo.\n'
}

main_menu() {
  while true; do
    print_header
    printf '1. Create red-team project repo\n'
    printf '2. Create blue-team project repo\n'
    printf '3. List project repos\n'
    printf '4. Show workspace and project status\n'
    printf '5. Commit and push workspace repo\n'
    printf '6. Commit and push a project repo\n'
    printf '7. Set or update project GitHub remote\n'
    printf '8. Show recommended next steps\n'
    printf '9. Exit\n\n'
    read -r -p 'Choose an option: ' menu_choice

    case "$menu_choice" in
      1) create_red_team_project; pause ;;
      2) create_blue_team_project; pause ;;
      3) list_project_repos; pause ;;
      4) show_status; pause ;;
      5) commit_and_push_workspace; pause ;;
      6) commit_and_push_project; pause ;;
      7) set_project_remote; pause ;;
      8) show_next_steps; pause ;;
      9) exit 0 ;;
      *) printf 'Invalid option.\n'; pause ;;
    esac
  done
}

main_menu