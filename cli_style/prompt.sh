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

# Util Functions

clone-from() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: clone-from <user> <repo>"
        return 1
    fi
    git clone "git@github.com:$1/$2.git"
}

# prompt   

git_branch() {
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [[ -n $branch ]] && echo "$branch"
}

PROMPT_STATUS="[%F{%(?.green.red)}%(?.✓.✗)${RESET}]"
PROMPT_HOUR=" %D{%d},%D{%H:%M}"
PROMPT_USER_HOST="(${BLUE}%n@%m${RESET})"
PROMPT_PATH="${BLUE}%~${RESET}"

build_prompt() {
    branch=$(git_branch)
    if [[ -n $branch ]]; then
        PROMPT_BRANCH=" : $branch"
    else
        PROMPT_BRANCH=" "
    fi

    STATUS="%(?.❯.❮)"

    currentDir="${PWD/#$HOME/~}"
    currentDir="${currentDir:t}"
    DirBubble="${BACKGOUND}${B_BACKGOUND} ${BLUE}  ${currentDir} %k${BACKGOUND}"
    BranchBubble="${BACKGOUND}${B_BACKGOUND} ${VIOLET}${PROMPT_BRANCH} %k${BACKGOUND}"
    TimeBubble="${BACKGOUND}${B_BACKGOUND} ${SKY}${PROMPT_HOUR} %k${BACKGOUND}"

     PROMPT="${BACKGOUND}${B_BACKGOUND} ${MAUVE}$USER ${STATUS}%k${BACKGOUND}${RESET} "

     RPROMPT="${DirBubble} ${BranchBubble} ${TimeBubble}${RESET}"
}

precmd() { build_prompt }
