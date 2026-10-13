# =========================
# Options
# =========================
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS

# =========================
# History
# =========================
# XDG state directory
: ${XDG_STATE_HOME:="$HOME/.local/state"}
HISTFILE="$XDG_STATE_HOME/zsh/history"

HISTSIZE=100000
SAVEHIST=100000

# 多终端共享历史（同时负责追加和同步）
setopt SHARE_HISTORY

# 去重
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# 清理多余空格
setopt HIST_REDUCE_BLANKS

# 保存时间戳
setopt EXTENDED_HISTORY

# 避免历史记录目录不存在
if ! mkdir -p -- "${HISTFILE:h}"; then
  print -u2 -- "zsh: cannot create history directory: ${HISTFILE:h}"
fi

# =========================
# Completion
# =========================
: ${XDG_CACHE_HOME:="$HOME/.cache"}

ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"
ZSH_COMPCACHE="$ZSH_CACHE_DIR/zcompcache"

# 提前创建缓存目录
if ! mkdir -p -- "$ZSH_CACHE_DIR" "$ZSH_COMPCACHE"; then
  print -u2 -- "zsh: cannot create completion cache directory"
fi

# 初始化补全系统
autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"

# 大小写不敏感
# down -> Downloads
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Za-z}' \
  'r:|[._-]=* r:|=*'

# 补全菜单
zstyle ':completion:*' menu select

# 彩色补全
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# 补全缓存
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$ZSH_COMPCACHE"

# =========================
# Completion Enhancement
# =========================

# 参数补全时，目录名使用末尾 /
setopt AUTO_PARAM_SLASH

# 补全选项时自动显示候选项
setopt AUTO_LIST

# cd 专用补全
zstyle ':completion:*:*:cd:*' tag-order \
  local-directories directory-stack path-directories files

# 菜单补全反向选择
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

# 清理临时变量
unset ZSH_CACHE_DIR ZSH_COMPDUMP ZSH_COMPCACHE
