#!/bin/bash

# GLM-4.5 初始化脚本
# 基于 Z.AI 的 Claude Code 配置方案

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

echo "🚀 正在配置 Claude Code 连接 GLM-4.5..."

# 检查必要的环境变量
if [ -z "$ZAI_API_KEY" ]; then
    echo "❌ 错误: 请设置 ZAI_API_KEY 环境变量"
    echo "💡 提示: 在 .env 文件中添加 ZAI_API_KEY=你的_ZAI_API_KEY"
    exit 1
fi

# 设置 Z.AI 的 Anthropic 兼容端点
export ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic"
export ANTHROPIC_AUTH_TOKEN="$ZAI_API_KEY"

# 设置推荐的模型配置
export ANTHROPIC_MODEL="glm-4.5"
export ANTHROPIC_SMALL_FAST_MODEL="glm-4.5-air"

# 创建 Claude 配置目录
mkdir -p /home/claude/.claude

# 创建 settings.json 配置文件
cat > /home/claude/.claude/settings.json << EOF
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.z.ai/api/anthropic",
    "ANTHROPIC_AUTH_TOKEN": "$ZAI_API_KEY",
    "ANTHROPIC_MODEL": "glm-4.5",
    "ANTHROPIC_SMALL_FAST_MODEL": "glm-4.5-air"
  }
}
EOF

echo "✅ GLM-4.5 配置完成!"
echo "📋 配置信息:"
echo "   - Base URL: https://api.z.ai/api/anthropic"
echo "   - 主模型: glm-4.5"
echo "   - 快速模型: glm-4.5-air"
echo "   - API Key: ${ZAI_API_KEY:0:8}..."

# 启动 Claude Code
echo "🎯 启动 Claude Code..."
exec claude
