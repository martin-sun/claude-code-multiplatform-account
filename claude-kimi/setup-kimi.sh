#!/bin/bash

# 显示当前 Claude Code 版本
echo "=========================================="
echo "当前 Claude Code 版本:"
claude --version 2>/dev/null || echo "Claude Code 未正确安装"
echo "=========================================="

# 检查并更新 Claude Code（如果启用）
if [ "$AUTO_UPDATE_CLAUDE" = "true" ]; then
  echo "AUTO_UPDATE_CLAUDE 已启用，检查 Claude Code 更新..."
  npm update -g @anthropic-ai/claude-code
  echo "更新后的版本:"
  claude --version 2>/dev/null || echo "Claude Code 未正确安装"
  echo "=========================================="
else
  echo "AUTO_UPDATE_CLAUDE 未启用，跳过自动更新"
  echo "提示: 设置 AUTO_UPDATE_CLAUDE=true 以启用自动更新"
  echo "=========================================="
fi

# 创建必要的目录并设置权限
mkdir -p /home/claude/.claude
mkdir -p /home/claude/.config
mkdir -p /home/claude/.local/share
chown -R claude:claude /home/claude

# 创建符号链接，将settings.json链接到claude.json
ln -sf /home/claude/.claude/settings.json /home/claude/.claude/claude.json 2>/dev/null || true

# 创建或更新.claude.json文件
cat > /home/claude/.claude/.claude.json << ENDCONFIG
{
  "hasCompletedOnboarding": true,
  "hasTrustDialogAccepted": true,
  "theme": "dark"
}
ENDCONFIG

# 备份原始文件
cp /home/claude/.claude/.claude.json /home/claude/.claude/.claude.json.backup 2>/dev/null || true

# 显示配置目录内容
echo "配置目录内容:"
ls -la /home/claude/.claude/

# 设置 Claude 环境变量
export CLAUDE_SKIP_ONBOARDING=true
export CLAUDE_CONFIG_FILE=/home/claude/.claude/settings.json

# 设置 Kimi K2 环境变量
if [ ! -z "$KIMI_API_KEY" ]; then
  echo "配置 Kimi K2 环境变量..."
  
  # 设置环境变量 - 使用正确的变量名
  export ANTHROPIC_BASE_URL="https://api.moonshot.cn/anthropic/"
  export ANTHROPIC_AUTH_TOKEN="$KIMI_API_KEY"
  
  # 将环境变量添加到 .bashrc 文件
  cat > /home/claude/.bashrc << ENDBASHRC
# Claude Code environment variables
export ANTHROPIC_BASE_URL=https://api.moonshot.cn/anthropic/
export ANTHROPIC_AUTH_TOKEN=$KIMI_API_KEY
export CLAUDE_SKIP_ONBOARDING=true
export CLAUDE_CONFIG_FILE=/home/claude/.claude/settings.json
ENDBASHRC
  
  # 设置正确的权限
  chown claude:claude /home/claude/.bashrc
  
  # 标记已安装
  touch /home/claude/.kimi-cc-installed
  echo "Kimi K2 集成配置完成"
else
  echo "未提供 Kimi API Key，跳过 Kimi K2 集成配置"
fi

# 显示环境变量
echo "环境变量:"
echo "CLAUDE_CONFIG_DIR=$CLAUDE_CONFIG_DIR"
echo "HOME=$HOME"
echo "KIMI_API_KEY=[已配置]" # 不显示实际的API Key

# 如果配置了Kimi K2，显示其环境变量
if [ ! -z "$ANTHROPIC_AUTH_TOKEN" ]; then
  echo "ANTHROPIC_BASE_URL=$ANTHROPIC_BASE_URL"
  echo "ANTHROPIC_AUTH_TOKEN=[已配置]" # 不显示实际的API Key
  echo "注意: 已自动配置Kimi K2 API，无需手动切换模型"
fi

# 创建一个启动脚本
cat > /tmp/start-kimi.sh << ENDSCRIPT
#!/bin/bash

# 加载环境变量
source /home/claude/.bashrc

# 显示当前使用的API端点
echo "当前使用的API端点: \$ANTHROPIC_BASE_URL"
echo "使用的认证令牌: \$ANTHROPIC_AUTH_TOKEN (已隐藏实际值)"

# 启动Claude Code
claudeCmd="claude"
echo "启动: \$claudeCmd"
exec \$claudeCmd
ENDSCRIPT

# 设置执行权限
chmod +x /tmp/start-kimi.sh
chown claude:claude /tmp/start-kimi.sh

# 确保所有文件都属于claude用户
chown -R claude:claude /home/claude

# 以claude用户身份启动Claude Code
echo "启动Claude Code (使用Kimi K2 API)..."
exec su -c "/tmp/start-kimi.sh" claude
