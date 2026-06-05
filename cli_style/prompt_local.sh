setopt PROMPT_SUBST

# Tokyo Night Night palette
BLACK="%F{#1a1b26}"
RED="%F{#f7768e}"
GREEN="%F{#9ece6a}"
YELLOW="%F{#e0af68}"
MAGENTA="%F{#bb9af7}"
CYAN="%F{#7dcfff}"
WHITE="%F{#c0caf5}"

B_BLACK="%K{#1a1b26}"
B_RED="%K{#f7768e}"
B_GREEN="%K{#9ece6a}"
B_YELLOW="%K{#e0af68}"
B_MAGENTA="%K{#bb9af7}"
B_CYAN="%K{#7dcfff}"
B_WHITE="%K{#c0caf5}"

BACKGOUND="%F{#24283b}"
B_BACKGOUND="%K{#24283b}"

DARK="%F{#16161e}"
B_DARK="%K{#16161e}"

COMMENT="%F{#565f89}"
B_COMMENT="%K{#565f89}"

SKY="%F{#a1c0e6}"
VIOLET="%F{#6a7cb6}"
MAUVE="%F{#c1b5d6}"
BLUE="%F{#3d5497}"

RESET="%f%k"

# Display name
DISPLAY_NAME="nouhaazz"

# Utility Functions
clone-from() {
    if [[ -z "$1" || -z "$2" ]]; then
        echo "Usage: clone-from <user> <repo>"
        return 1
    fi
    git clone "git@github.com:$1/$2.git"
}

# Git branch function
git_branch() {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [[ -n "$branch" && "$branch" != "HEAD" ]] && echo "$branch"
}

# Build prompt
build_prompt() {
    local branch branch_display branch_plain
    local currentDir venv_display venv_plain
    local time_str left_plain right_plain
    local left_len right_len pad_len padding

    # Git branch
    branch=$(git_branch)
    if [[ -n "$branch" ]]; then
        branch_display="  ${VIOLET} ${branch}${RESET}"
        branch_plain="   ${branch}"
    else
        branch_display=""
        branch_plain=""
    fi

    # Current directory
    currentDir="${PWD/#$HOME/~}"
    [[ "$currentDir" != "~" ]] && currentDir="${currentDir:t}"
    [[ -z "$currentDir" ]] && currentDir="~"

    # Virtual environment
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv_display="${MAUVE}⟡${VIRTUAL_ENV:t}⟡ "
        venv_plain="⟡${VIRTUAL_ENV:t}⟡ "
    else
        venv_display=""
        venv_plain=""
    fi

    # Time
    time_str=$(date +"%d,%H:%M")

    # Calculate padding for right-align
    left_plain="╭─ ${venv_plain}${DISPLAY_NAME} ❯ "
    right_plain="  ${currentDir}${branch_plain}  ${time_str}"

    left_len=${#left_plain}
    right_len=${#right_plain}
    pad_len=$(( COLUMNS - left_len - right_len ))
    (( pad_len < 1 )) && pad_len=1
    padding=$(printf '%*s' "$pad_len" '')

    # Line 1: name + padding + dir + branch + time
    # Line 2: input prompt
    PROMPT="${COMMENT}╭─ ${venv_display}${MAUVE}${DISPLAY_NAME} ${WHITE}❯${RESET}${padding}${BLUE}  ${currentDir}${RESET}${branch_display}  ${SKY}${time_str}${RESET}
${COMMENT}╰─${WHITE}❯${RESET} "

    RPROMPT=""
}

precmd() { build_prompt }
