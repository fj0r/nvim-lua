#!/bin/bash
# Neovim 内置包管理器 - Git 垃圾回收脚本
git reflog expire --all --expire=now && git gc --prune=now --aggressive

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_ROOT="$(dirname "$SCRIPT_DIR")"

# 清理 plugins 目录中的 git 仓库
wd="$CONFIG_ROOT/plugins"
if [ -d "$wd" ]; then
    for i in $(sh -c "ls -d $wd/*/"); do
        pushd $i > /dev/null
        echo "GC: $i"
        git reflog expire --all --expire=now && git gc --prune=now --aggressive
        popd > /dev/null
    done
fi

# 清理 pack 目录中的符号链接（不需要 GC，因为是符号链接）
echo "Git GC 完成!"
