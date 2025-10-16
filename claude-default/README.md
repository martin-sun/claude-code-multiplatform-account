# Official Anthropic Claude API Configuration

[中文说明](#中文说明) | [English](#english)

---

## English

### Overview

This configuration allows you to use Claude Code CLI with the official Anthropic Claude API. This is useful when you want to:

- Use the latest Claude models (Opus, Sonnet, Haiku)
- Have consistent access to all Claude features
- Use your Anthropic API subscription

### Prerequisites

- Docker and Docker Compose
- Anthropic API Key from [Anthropic Console](https://console.anthropic.com/)

### Setup

1. **Get your Anthropic API Key**
   - Visit [Anthropic Console](https://console.anthropic.com/)
   - Sign in or create an account
   - Navigate to API Keys section
   - Create a new API key

2. **Configure environment variables**
   ```bash
   cd claude-default
   cp .env.example .env
   # Edit .env and add your ANTHROPIC_API_KEY
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
# Required: Your Anthropic API Key
ANTHROPIC_API_KEY=your_anthropic_api_key_here

# Optional: Claude Code version
CLAUDE_VERSION=latest

# Optional: Auto-update on startup
AUTO_UPDATE_CLAUDE=false

# Optional: Workspace path
WORKSPACE_PATH=../../your-project
```

### Available Models

When using the official API, you have access to all Claude models:

- **claude-opus-4** - Most capable model
- **claude-sonnet-4** - Balanced performance and speed (default)
- **claude-sonnet-4.5** - Enhanced Sonnet version
- **claude-haiku-4** - Fastest model

You can switch models during your session using the `/model` command.

### Pricing

Official Anthropic API uses pay-as-you-go pricing. Check the [Anthropic Pricing Page](https://www.anthropic.com/pricing) for current rates.

### Troubleshooting

**Problem**: Authentication errors
- **Solution**: Verify your API key is correct and active in the Anthropic Console

**Problem**: Model not available
- **Solution**: Check your API key has access to the requested model

**Problem**: Rate limiting
- **Solution**: Check your usage limits in the Anthropic Console

---

## 中文说明

### 概述

此配置允许您使用官方 Anthropic Claude API 运行 Claude Code CLI。适用于以下场景：

- 使用最新的 Claude 模型（Opus、Sonnet、Haiku）
- 获得所有 Claude 功能的一致访问
- 使用您的 Anthropic API 订阅

### 前置要求

- Docker 和 Docker Compose
- 从 [Anthropic 控制台](https://console.anthropic.com/)获取的 API 密钥

### 配置步骤

1. **获取 Anthropic API 密钥**
   - 访问 [Anthropic Console](https://console.anthropic.com/)
   - 登录或创建账户
   - 进入 API Keys 部分
   - 创建新的 API 密钥

2. **配置环境变量**
   ```bash
   cd claude-default
   cp .env.example .env
   # 编辑 .env 文件，填入你的 ANTHROPIC_API_KEY
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
# 必填：您的 Anthropic API 密钥
ANTHROPIC_API_KEY=your_anthropic_api_key_here

# 可选：Claude Code 版本
CLAUDE_VERSION=latest

# 可选：启动时自动更新
AUTO_UPDATE_CLAUDE=false

# 可选：工作空间路径
WORKSPACE_PATH=../../your-project
```

### 可用模型

使用官方 API 时，您可以访问所有 Claude 模型：

- **claude-opus-4** - 最强大的模型
- **claude-sonnet-4** - 平衡性能和速度（默认）
- **claude-sonnet-4.5** - 增强版 Sonnet
- **claude-haiku-4** - 最快的模型

您可以在会话期间使用 `/model` 命令切换模型。

### 定价

官方 Anthropic API 使用按使用量付费的定价模式。请查看 [Anthropic 定价页面](https://www.anthropic.com/pricing)了解当前费率。

### 常见问题

**问题**：认证错误
- **解决方案**：验证您的 API 密钥是否正确且在 Anthropic 控制台中处于活动状态

**问题**：模型不可用
- **解决方案**：检查您的 API 密钥是否有权访问请求的模型

**问题**：速率限制
- **解决方案**：在 Anthropic 控制台中检查您的使用限制
