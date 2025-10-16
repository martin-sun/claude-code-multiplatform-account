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

echo "🚀 正在配置 Claude Code..."

# 创建 Claude 配置目录
mkdir -p /home/claude/.claude

# 检查是否设置了 API Key（两种认证模式）
if [ -z "$ANTHROPIC_API_KEY" ]; then
    # 模式 1: 账户订阅模式 (Pro/Max/Team)
    echo ""
    echo "✅ 使用账户订阅模式 (Claude Pro/Max/Team)"
    echo "📋 配置信息:"
    echo "   - 认证方式: 账户登录 (OAuth)"
    echo "   - 适用订阅: Claude Pro ($20/月) 或 Max ($100-200/月)"
    echo ""
    echo "💡 启动后请执行以下步骤:"
    echo "   1. 输入命令: /login"
    echo "   2. 浏览器会自动打开登录页面"
    echo "   3. 使用您的 Claude 账户登录"
    echo "   4. 登录成功后即可使用订阅额度"
    echo ""
    echo "⚠️  注意: 如需使用 API Key 模式，请在 .env 文件中设置 ANTHROPIC_API_KEY"

    # 不设置任何环境变量，让 Claude Code 使用默认的 OAuth 流程
    # 不创建 settings.json，避免干扰账户登录
else
    # 模式 2: API Key 模式（按量付费）
    echo ""
    echo "✅ 使用 API Key 模式 (按量付费)"
    echo "📋 配置信息:"
    echo "   - 认证方式: API Key"
    echo "   - 计费方式: 按 API 使用量付费"
    echo "   - API Key: ${ANTHROPIC_API_KEY:0:8}..."
    echo ""

    # 设置官方 Anthropic API
    # 注意: 不设置 ANTHROPIC_BASE_URL，使用默认官方端点
    export ANTHROPIC_AUTH_TOKEN="$ANTHROPIC_API_KEY"

    # 创建 settings.json 配置文件
    # 对于官方 API，只需要设置 ANTHROPIC_AUTH_TOKEN
    cat > /home/claude/.claude/settings.json << EOF
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "$ANTHROPIC_API_KEY"
  }
}
EOF

    echo "💡 提示: Claude Code 将使用默认的 claude-sonnet-4 模型"
    echo "💡 您可以在对话中使用 /model 命令切换其他模型"
fi

# 设置文件权限
chown -R claude:claude /home/claude/.claude

# 创建启动脚本
cat > /tmp/start-default.sh << 'ENDSCRIPT'
#!/bin/bash

# 启动 Claude Code
echo "🎯 启动 Claude Code..."
exec claude
ENDSCRIPT

# 设置执行权限
chmod +x /tmp/start-default.sh
chown claude:claude /tmp/start-default.sh

# 确保所有文件都属于 claude 用户
chown -R claude:claude /home/claude

# 以 claude 用户身份启动 Claude Code
exec su -c "/tmp/start-default.sh" claude
