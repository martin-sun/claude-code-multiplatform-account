# Official Anthropic Claude API Configuration

[中文说明](#中文说明) | [English](#english)

---

## English

### Overview

This configuration allows you to use Claude Code CLI with official Anthropic authentication. **Two modes are supported**:

#### Mode 1: Account Subscription (Recommended for Pro/Max Users)
- Use your Claude Pro/Max subscription
- No additional API charges
- Login via `/login` command in Claude Code
- **Pricing**: Pro $20/month, Max $100-200/month

#### Mode 2: API Key (For Developers)
- Pay-as-you-go API pricing
- Bypass subscription limits
- Use API key for authentication
- **Pricing**: Based on API usage (see [Anthropic Pricing](https://www.anthropic.com/pricing))

### Prerequisites

- Docker and Docker Compose
- **For Mode 1**: Claude Pro/Max account from [claude.ai](https://claude.ai)
- **For Mode 2**: API Key from [Anthropic Console](https://console.anthropic.com/)

### Setup

#### For Mode 1: Account Subscription (Pro/Max Users)

1. **Configure environment**
   ```bash
   cd claude-default
   cp .env.example .env
   # Leave ANTHROPIC_API_KEY commented out (default)
   ```

2. **Start the service**
   ```bash
   ./start.sh default
   ```

3. **Login to your account**
   - After Claude Code starts, type: `/login`
   - Your browser will open automatically
   - Sign in with your Claude Pro/Max account
   - Return to terminal and start using!

#### For Mode 2: API Key (Developers)

1. **Get your API Key**
   - Visit [Anthropic Console](https://console.anthropic.com/)
   - Create an API key

2. **Configure environment**
   ```bash
   cd claude-default
   cp .env.example .env
   # Uncomment and set ANTHROPIC_API_KEY in .env
   ```

3. **Start the service**

   From the project root:
   ```bash
   ./start.sh
   # Select option 3: Claude (Official Anthropic)
   ```

   Or directly:
   ```bash
   ./start.sh default
   ```

   Or using Docker Compose:
   ```bash
   cd claude-default
   docker compose run --rm -it claude
   ```

### Configuration Details

The `.env` file contains:

```bash
# Authentication Mode Selection:
# - Leave commented for Account Subscription mode (Pro/Max)
# - Uncomment for API Key mode (pay-as-you-go)
# ANTHROPIC_API_KEY=your_anthropic_api_key_here

# Optional: Claude Code version
CLAUDE_VERSION=latest

# Optional: Auto-update on startup
AUTO_UPDATE_CLAUDE=false

# Optional: Workspace path
WORKSPACE_PATH=../../your-project
```

**Important**: If `ANTHROPIC_API_KEY` is set, Claude Code will use API billing instead of your subscription quota!

### Available Models

When using the official API, you have access to all Claude models:

- **claude-opus-4** - Most capable model
- **claude-sonnet-4** - Balanced performance and speed (default)
- **claude-sonnet-4.5** - Enhanced Sonnet version
- **claude-haiku-4** - Fastest model

You can switch models during your session using the `/model` command.

### Pricing

Official Anthropic API uses pay-as-you-go pricing. Check the [Anthropic Pricing Page](https://www.anthropic.com/pricing) for current rates.

### Rebuilding the Image

**Important**: If you've updated this configuration or if you're experiencing issues with authentication modes, you may need to rebuild the Docker image:

```bash
cd claude-default
docker compose build --no-cache
```

This ensures the latest setup scripts are included in the image.

### Troubleshooting

**Problem**: Still shows "API Key required" error even though it's commented out
- **Solution**: The Docker image may contain an old setup script. Rebuild the image:
  ```bash
  cd claude-default
  docker compose build --no-cache
  ```

**Problem**: Need to login but can't find `/login` command
- **Solution**: Make sure `ANTHROPIC_API_KEY` is NOT set in `.env` file. Restart the service.

**Problem**: Using subscription but being charged for API
- **Solution**: Remove or comment out `ANTHROPIC_API_KEY` from `.env` file

**Problem**: Authentication errors (API Key mode)
- **Solution**: Verify your API key is correct and active in the Anthropic Console

**Problem**: Model not available
- **Solution**: Check your API key has access to the requested model (or use subscription mode)

**Problem**: Rate limiting
- **Solution**: Check your usage limits in Anthropic Console or switch to subscription mode

---

## 中文说明

### 概述

此配置允许您使用官方 Anthropic 认证方式运行 Claude Code CLI。**支持两种模式**：

#### 模式 1：账户订阅模式（推荐给 Pro/Max 用户）
- 使用您的 Claude Pro/Max 订阅
- 无额外 API 费用
- 通过 Claude Code 中的 `/login` 命令登录
- **定价**：Pro $20/月，Max $100-200/月

#### 模式 2：API Key 模式（开发者）
- 按使用量付费的 API 定价
- 突破订阅限制
- 使用 API 密钥认证
- **定价**：基于 API 使用量（参见 [Anthropic 定价](https://www.anthropic.com/pricing)）

### 前置要求

- Docker 和 Docker Compose
- **模式 1**：[claude.ai](https://claude.ai) 的 Claude Pro/Max 账户
- **模式 2**：[Anthropic 控制台](https://console.anthropic.com/)的 API 密钥

### 配置步骤

#### 模式 1：账户订阅模式（Pro/Max 用户）

1. **配置环境**
   ```bash
   cd claude-default
   cp .env.example .env
   # 保持 ANTHROPIC_API_KEY 注释掉（默认）
   ```

2. **启动服务**
   ```bash
   ./start.sh default
   ```

3. **登录您的账户**
   - Claude Code 启动后，输入：`/login`
   - 浏览器会自动打开
   - 使用您的 Claude Pro/Max 账户登录
   - 返回终端即可开始使用！

#### 模式 2：API Key 模式（开发者）

1. **获取 API 密钥**
   - 访问 [Anthropic Console](https://console.anthropic.com/)
   - 创建 API 密钥

2. **配置环境**
   ```bash
   cd claude-default
   cp .env.example .env
   # 取消注释并设置 .env 中的 ANTHROPIC_API_KEY
   ```

3. **启动服务**

   从项目根目录：
   ```bash
   ./start.sh
   # 选择选项 3: Claude (Official Anthropic)
   ```

   或直接启动：
   ```bash
   ./start.sh default
   ```

   或使用 Docker Compose：
   ```bash
   cd claude-default
   docker compose run --rm -it claude
   ```

### 配置详情

`.env` 文件包含：

```bash
# 认证模式选择：
# - 保持注释以使用账户订阅模式（Pro/Max）
# - 取消注释以使用 API Key 模式（按量付费）
# ANTHROPIC_API_KEY=your_anthropic_api_key_here

# 可选：Claude Code 版本
CLAUDE_VERSION=latest

# 可选：启动时自动更新
AUTO_UPDATE_CLAUDE=false

# 可选：工作空间路径
WORKSPACE_PATH=../../your-project
```

**重要**：如果设置了 `ANTHROPIC_API_KEY`，Claude Code 将使用 API 计费而不是您的订阅额度！

### 可用模型

使用官方 API 时，您可以访问所有 Claude 模型：

- **claude-opus-4** - 最强大的模型
- **claude-sonnet-4** - 平衡性能和速度（默认）
- **claude-sonnet-4.5** - 增强版 Sonnet
- **claude-haiku-4** - 最快的模型

您可以在会话期间使用 `/model` 命令切换模型。

### 定价

官方 Anthropic API 使用按使用量付费的定价模式。请查看 [Anthropic 定价页面](https://www.anthropic.com/pricing)了解当前费率。

### 重建镜像

**重要**：如果您更新了配置或遇到认证模式问题，可能需要重新构建 Docker 镜像：

```bash
cd claude-default
docker compose build --no-cache
```

这可以确保最新的设置脚本被包含在镜像中。

### 常见问题

**问题**：即使注释掉了 API Key 仍显示"需要 API Key"错误
- **解决方案**：Docker 镜像可能包含旧的设置脚本。重新构建镜像：
  ```bash
  cd claude-default
  docker compose build --no-cache
  ```

**问题**：需要登录但找不到 `/login` 命令
- **解决方案**：确保 `.env` 文件中**没有**设置 `ANTHROPIC_API_KEY`。重启服务。

**问题**：使用订阅但被收取 API 费用
- **解决方案**：从 `.env` 文件中删除或注释掉 `ANTHROPIC_API_KEY`

**问题**：认证错误（API Key 模式）
- **解决方案**：验证您的 API 密钥是否正确且在 Anthropic 控制台中处于活动状态

**问题**：模型不可用
- **解决方案**：检查您的 API 密钥是否有权访问请求的模型（或切换到订阅模式）

**问题**：速率限制
- **解决方案**：在 Anthropic 控制台中检查您的使用限制或切换到订阅模式
