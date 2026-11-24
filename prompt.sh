
setopt PROMPT_SUBST

# Tokyo Night Night palette

BLACK="%F{#1a1b26}"
RED="%F{#f7768e}"
GREEN="%F{#9ece6a}"
YELLOW="%F{#e0af68}"
BLUE="%F{#7b80b8}"
MAGENTA="%F{#bb9af7}"
CYAN="%F{#7dcfff}"
WHITE="%F{#c0caf5}"

B_BLACK="%K{#1a1b26}"
B_RED="%K{#f7768e}"
B_GREEN="%K{#9ece6a}"
B_YELLOW="%K{#e0af68}"
B_BLUE="%K{#7b80b8}"
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

# Utility Functions

clone-from() {
    if [[ -z "$1" || -z "$2" ]]; then
        echo "Usage: clone-from <user> <repo>"
        return 1
    fi
    git clone "git@github.com:$1/$2.git"
}

# Git branch

git_branch() {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [[ -n "$branch" && "$branch" != "HEAD" ]] && echo "$branch"
}

PROMPT_STATUS="[%F{%(?.green.red)}%(?.✓.✗)${RESET}]"
PROMPT_HOUR=" %D{%d},%D{%H:%M}"
PROMPT_USER_HOST="(${BLUE}%n@%m${RESET})"
PROMPT_PATH="${BLUE}%~${RESET}"

# Build prompt
RPROMPT_PREFIX=$'%{\e[1A%}'
RPROMPT_SUFFIX=$'%{\e[1B%}'

build_prompt() {
    local branch currentDir venv_display
    local left_part right_part

    # Git branch
    branch=$(git_branch)

    if [[ -n "$branch" ]]; then
        PROMPT_BRANCH=" : $branch"
    else
        PROMPT_BRANCH=" "
    fi

    # Command status
    STATUS="%(?.❯.❮)"

    # Current directory
    currentDir="${PWD/#$HOME/~}"
    currentDir="${currentDir:t}"
    [[ -z "$currentDir" ]] && currentDir="~"

    # Virtual environment
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv_display="⟡ ${VIRTUAL_ENV:t} ⟡ | "
    else
        venv_display=""
    fi

    # Original V1 padded bubbles

    # First line: left section
    left_part="${COMMENT}╭─${BACKGOUND}${B_BACKGOUND} ${MAUVE}${venv_display}${USER} %k${BACKGOUND}"
    DirBubble="${BACKGOUND}${B_BACKGOUND} ${BLUE}  ${currentDir} %k${BACKGOUND}"
    BranchBubble="${BACKGOUND}${B_BACKGOUND} ${VIOLET}${PROMPT_BRANCH} %k${BACKGOUND}"
    TimeBubble="${BACKGOUND}${B_BACKGOUND} ${SKY}${PROMPT_HOUR} %k${BACKGOUND}"

	# Left side + second line
	PROMPT="${left_part}
${COMMENT}╰─${WHITE}❯${RESET} "

	RPROMPT="${RPROMPT_PREFIX}${DirBubble} ${BranchBubble} ${TimeBubble}${RESET}${RPROMPT_SUFFIX}"
}
precmd() { build_prompt }


