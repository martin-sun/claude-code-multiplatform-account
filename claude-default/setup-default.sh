#!/bin/bash

# Official Anthropic Claude API 初始化脚本
# Configure Claude Code to use official Anthropic API

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

echo "🚀 正在配置 Claude Code 使用官方 Anthropic API..."

# 检查必要的环境变量
if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "❌ 错误: 请设置 ANTHROPIC_API_KEY 环境变量"
    echo "💡 提示: 在 .env 文件中添加 ANTHROPIC_API_KEY=你的_API_KEY"
    echo "💡 获取 API Key: https://console.anthropic.com/"
    exit 1
fi

# 设置官方 Anthropic API
# 注意: 不设置 ANTHROPIC_BASE_URL，使用默认官方端点
export ANTHROPIC_AUTH_TOKEN="$ANTHROPIC_API_KEY"

# 创建 Claude 配置目录
mkdir -p /home/claude/.claude

# 创建 settings.json 配置文件
# 对于官方 API，只需要设置 ANTHROPIC_AUTH_TOKEN
cat > /home/claude/.claude/settings.json << EOF
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "$ANTHROPIC_API_KEY"
  }
}
EOF

# 设置文件权限
chown -R claude:claude /home/claude/.claude

echo "✅ 官方 Anthropic Claude API 配置完成!"
echo "📋 配置信息:"
echo "   - 使用官方 Anthropic API 端点"
echo "   - API Key: ${ANTHROPIC_API_KEY:0:8}..."
echo ""
echo "💡 提示: Claude Code 将使用默认的 claude-sonnet-4 模型"
echo "💡 您可以在对话中使用 /model 命令切换其他模型"

# 启动 Claude Code
echo "🎯 启动 Claude Code..."
exec claude
