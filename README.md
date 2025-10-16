# Claude Code Multi-Provider Docker Launcher

**🚀 Multi-Platform** | **👥 Multi-Account** | **🐳 Docker-Based** | **🔄 Easy Switch**

### Switch Between Multiple AI Platforms and Accounts with Ease

[中文文档](#中文文档) | [English](#english)

---

## English

### Overview

This project provides a Docker-based launcher for [Claude Code CLI](https://github.com/anthropics/claude-code) that supports multiple AI providers. You can choose from:

- **Claude** (Official Anthropic API) - Access to all official Claude models
- **Kimi K2** (Moonshot AI) - Cost-effective Chinese alternative
- **GLM-4.5** (Z.AI) - Another cost-effective Chinese alternative

### Why This Project?

Claude Code CLI is an excellent tool for AI-assisted software development, but it officially only supports Anthropic's Claude API. Additionally:

- **Claude Pro** subscription has limited usage that may not be sufficient for intensive development work
- **Claude Max** offers 5x more usage but might be more than needed and comes at a higher cost
- **Limited Flexibility**: You're locked into Anthropic's pricing tiers

This project solves these problems by:

1. **Cost-Effective Alternatives**: Use Chinese AI providers (Kimi K2, GLM-4.5) with flexible pricing
2. **Multiple Provider Support**: Set up multiple provider accounts to distribute usage across different services
3. **Easy Switching**: Switch between different providers based on your needs and budget
4. **Unified Interface**: Same Claude Code CLI experience across all providers
5. **No Vendor Lock-in**: Not limited to a single provider's pricing or usage limits

### Project Structure

```
.
├── docker-compose.base.yml    # Shared base configuration
├── Dockerfile                 # Common Docker image definition
├── start.sh                   # Interactive service launcher
├── claude-default/           # Official Anthropic Claude
│   ├── docker-compose.yml
│   ├── setup-default.sh
│   ├── .env.example
│   └── claude-data/          # Claude data directory
├── claude-kimi/              # Kimi K2 configuration
│   ├── docker-compose.yml
│   ├── setup-kimi.sh
│   ├── .env.example
│   └── claude-data/          # Kimi data directory
└── claude-glm/               # GLM-4.5 configuration
    ├── docker-compose.yml
    ├── setup-glm.sh
    ├── .env.example
    └── claude-data/          # GLM data directory
```

### Prerequisites

- Docker and Docker Compose
- API key from one of the supported providers:
  - [Anthropic Console](https://console.anthropic.com/) for official Claude
  - [Moonshot AI Platform](https://platform.moonshot.cn/) for Kimi K2
  - [Z.AI](https://api.z.ai/) for GLM-4.5

### Quick Start

#### Option 1: Interactive Launcher (Recommended)

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd claude-code
   ```

2. **Configure your provider**

   For Official Claude:
   ```bash
   cd claude-default
   cp .env.example .env
   # Edit .env and add your ANTHROPIC_API_KEY
   ```

   For Kimi K2:
   ```bash
   cd claude-kimi
   cp .env.example .env
   # Edit .env and add your KIMI_API_KEY
   ```

   For GLM-4.5:
   ```bash
   cd claude-glm
   cp .env.example .env
   # Edit .env and add your ZAI_API_KEY
   ```

3. **Run the launcher**
   ```bash
   ./start.sh
   ```

4. **Select your service**
   - Choose `1` for Kimi K2
   - Choose `2` for GLM-4.5
   - Choose `3` for Claude (Official Anthropic)
   - Choose `4` to exit

#### Option 2: Direct Launch

Launch a specific service directly:

```bash
# For Official Claude
./start.sh default

# For Kimi K2
./start.sh kimi

# For GLM-4.5
./start.sh glm
```

Or use Docker Compose directly:

```bash
# For Official Claude
cd claude-default
docker compose run --rm -it claude

# For Kimi K2
cd claude-kimi
docker compose run --rm -it claude

# For GLM-4.5
cd claude-glm
docker compose run --rm -it claude
```

### Configuration

Each service has its own `.env` file for configuration:

#### Official Claude (.env in claude-default/)

```bash
# Anthropic API Key (Required)
ANTHROPIC_API_KEY=your_anthropic_api_key_here

# Claude Code Version (Optional)
CLAUDE_VERSION=latest

# Auto-update on startup (Optional)
AUTO_UPDATE_CLAUDE=false

# Workspace Path (Optional)
WORKSPACE_PATH=../../your-project
```

#### Kimi K2 (.env in claude-kimi/)

```bash
# Kimi K2 API Key (Required)
KIMI_API_KEY=your_kimi_api_key_here

# Claude Code Version (Optional)
CLAUDE_VERSION=latest

# Auto-update on startup (Optional)
AUTO_UPDATE_CLAUDE=false

# Workspace Path (Optional)
WORKSPACE_PATH=../../your-project
```

#### GLM-4.5 (.env in claude-glm/)

```bash
# Z.AI API Key (Required)
ZAI_API_KEY=your_zai_api_key_here

# Claude Code Version (Optional)
CLAUDE_VERSION=latest

# Auto-update on startup (Optional)
AUTO_UPDATE_CLAUDE=false

# Workspace Path (Optional)
WORKSPACE_PATH=../../your-project
```

### Usage

Once inside the Claude Code CLI:

1. Chat with the AI for coding assistance
2. Use slash commands like `/help`, `/clear`, etc.
3. The AI can read, write, and edit files in your workspace
4. Exit by typing `/exit` or pressing Ctrl+D

### How It Works

1. **Base Configuration**: `docker-compose.base.yml` defines common settings
2. **Service Extension**: Each provider's `docker-compose.yml` extends the base service
3. **Setup Scripts**: Automatically configure Claude Code settings for each provider
4. **API Proxying**: Each setup script configures the appropriate API endpoints

### Supported Models

#### Official Claude (Anthropic)
- **claude-opus-4** - Most capable model
- **claude-sonnet-4** - Balanced performance and speed (default)
- **claude-sonnet-4.5** - Enhanced Sonnet version
- **claude-haiku-4** - Fastest model

#### Kimi K2 (Moonshot AI)
- Main Model: `moonshot-v1-32k`
- Fast Model: `moonshot-v1-32k`

#### GLM-4.5 (Z.AI)
- Main Model: `glm-4.5`
- Fast Model: `glm-4.5-air`

### Troubleshooting

**Problem**: Container fails to start
- **Solution**: Ensure your `.env` file exists and contains valid API keys

**Problem**: API authentication errors
- **Solution**: Verify your API key is correct and has sufficient credits

**Problem**: Permission errors
- **Solution**: The container runs as user `claude` (UID 1001). Ensure your workspace is accessible

**Problem**: Claude Code version mismatch
- **Solution**: Set `AUTO_UPDATE_CLAUDE=true` in `.env` or specify a version with `CLAUDE_VERSION`

### Contributing

Contributions are welcome! To add support for a new provider:

1. Create a new directory: `claude-{provider}/`
2. Add `docker-compose.yml` extending `claude-base`
3. Create a `setup-{provider}.sh` script
4. Update `Dockerfile` to copy the setup script
5. Update `start.sh` to include the new provider

### License

This project is provided as-is for educational and development purposes.

### Acknowledgments

- [Claude Code](https://github.com/anthropics/claude-code) by Anthropic
- [Moonshot AI](https://www.moonshot.cn/) for Kimi API
- [Z.AI](https://z.ai/) for GLM API

---

## 中文文档

# Claude Code 多平台多账户启动器

**🚀 多平台支持** | **👥 多账户管理** | **🐳 Docker 部署** | **🔄 灵活切换**

### 轻松在多个 AI 平台和账户间切换

---

### 项目概述

本项目为 [Claude Code CLI](https://github.com/anthropics/claude-code) 提供了基于 Docker 的启动器，支持多个 AI 服务商。您可以选择：

- **Claude** (Anthropic 官方 API) - 访问所有官方 Claude 模型
- **Kimi K2** (月之暗面) - 性价比高的国内替代方案
- **GLM-4.5** (智谱 AI) - 另一个性价比高的国内替代方案

### 为什么需要这个项目？

Claude Code CLI 是一个优秀的 AI 辅助开发工具，但官方仅支持 Anthropic 的 Claude API。此外：

- **Claude Pro** 订阅的使用量限制可能无法满足高强度开发需求
- **Claude Max** 提供 5 倍使用量，但可能超出实际需求且价格更高
- **灵活性受限**：只能使用 Anthropic 的定价方案

本项目通过以下方式解决了这些问题：

1. **性价比更高**：使用国内 AI 服务商（Kimi K2、GLM-4.5），定价更灵活
2. **多账户支持**：可配置多个服务商账户，在不同服务间分散使用量
3. **灵活切换**：根据需求和预算在不同服务商间切换
4. **统一体验**：在所有服务商间使用相同的 Claude Code CLI 界面
5. **无供应商锁定**：不受限于单一服务商的定价或使用量限制

### 项目结构

```
.
├── docker-compose.base.yml    # 共享基础配置
├── Dockerfile                 # 通用 Docker 镜像定义
├── start.sh                   # 交互式服务启动器
├── claude-default/           # Anthropic 官方 Claude
│   ├── docker-compose.yml
│   ├── setup-default.sh
│   ├── .env.example
│   └── claude-data/          # Claude 数据目录
├── claude-kimi/              # Kimi K2 配置
│   ├── docker-compose.yml
│   ├── setup-kimi.sh
│   ├── .env.example
│   └── claude-data/          # Kimi 数据目录
└── claude-glm/               # GLM-4.5 配置
    ├── docker-compose.yml
    ├── setup-glm.sh
    ├── .env.example
    └── claude-data/          # GLM 数据目录
```

### 前置要求

- Docker 和 Docker Compose
- 以下服务商之一的 API 密钥：
  - [Anthropic 控制台](https://console.anthropic.com/) - 官方 Claude
  - [月之暗面开放平台](https://platform.moonshot.cn/) - Kimi K2
  - [智谱 AI](https://api.z.ai/) - GLM-4.5

### 快速开始

#### 方式一：交互式启动器（推荐）

1. **克隆仓库**
   ```bash
   git clone <your-repo-url>
   cd claude-code
   ```

2. **配置服务商**

   使用官方 Claude：
   ```bash
   cd claude-default
   cp .env.example .env
   # 编辑 .env 文件，填入你的 ANTHROPIC_API_KEY
   ```

   使用 Kimi K2：
   ```bash
   cd claude-kimi
   cp .env.example .env
   # 编辑 .env 文件，填入你的 KIMI_API_KEY
   ```

   使用 GLM-4.5：
   ```bash
   cd claude-glm
   cp .env.example .env
   # 编辑 .env 文件，填入你的 ZAI_API_KEY
   ```

3. **运行启动器**
   ```bash
   ./start.sh
   ```

4. **选择服务**
   - 选择 `1` 使用 Kimi K2
   - 选择 `2` 使用 GLM-4.5
   - 选择 `3` 使用 Claude (Anthropic 官方)
   - 选择 `4` 退出

#### 方式二：直接启动

直接启动指定服务：

```bash
# 启动官方 Claude
./start.sh default

# 启动 Kimi K2
./start.sh kimi

# 启动 GLM-4.5
./start.sh glm
```

或直接使用 Docker Compose：

```bash
# 使用官方 Claude
cd claude-default
docker compose run --rm -it claude

# 使用 Kimi K2
cd claude-kimi
docker compose run --rm -it claude

# 使用 GLM-4.5
cd claude-glm
docker compose run --rm -it claude
```

### 配置说明

每个服务都有自己的 `.env` 配置文件：

#### 官方 Claude 配置 (claude-default/.env)

```bash
# Anthropic API 密钥（必填）
ANTHROPIC_API_KEY=your_anthropic_api_key_here

# Claude Code 版本（可选）
CLAUDE_VERSION=latest

# 启动时自动更新（可选）
AUTO_UPDATE_CLAUDE=false

# 工作空间路径（可选）
WORKSPACE_PATH=../../your-project
```

#### Kimi K2 配置 (claude-kimi/.env)

```bash
# Kimi K2 API 密钥（必填）
KIMI_API_KEY=your_kimi_api_key_here

# Claude Code 版本（可选）
CLAUDE_VERSION=latest

# 启动时自动更新（可选）
AUTO_UPDATE_CLAUDE=false

# 工作空间路径（可选）
WORKSPACE_PATH=../../your-project
```

#### GLM-4.5 配置 (claude-glm/.env)

```bash
# Z.AI API 密钥（必填）
ZAI_API_KEY=your_zai_api_key_here

# Claude Code 版本（可选）
CLAUDE_VERSION=latest

# 启动时自动更新（可选）
AUTO_UPDATE_CLAUDE=false

# 工作空间路径（可选）
WORKSPACE_PATH=../../your-project
```

### 使用方法

进入 Claude Code CLI 后：

1. 与 AI 对话获取编码帮助
2. 使用斜杠命令，如 `/help`、`/clear` 等
3. AI 可以读取、写入和编辑工作空间中的文件
4. 输入 `/exit` 或按 Ctrl+D 退出

### 工作原理

1. **基础配置**：`docker-compose.base.yml` 定义了通用设置
2. **服务扩展**：每个服务商的 `docker-compose.yml` 扩展基础服务
3. **设置脚本**：自动为每个服务商配置 Claude Code 设置
4. **API 代理**：每个设置脚本配置相应的 API 端点

### 支持的模型

#### 官方 Claude (Anthropic)
- **claude-opus-4** - 最强大的模型
- **claude-sonnet-4** - 平衡性能和速度（默认）
- **claude-sonnet-4.5** - 增强版 Sonnet
- **claude-haiku-4** - 最快的模型

#### Kimi K2 (月之暗面)
- 主模型：`moonshot-v1-32k`
- 快速模型：`moonshot-v1-32k`

#### GLM-4.5 (智谱 AI)
- 主模型：`glm-4.5`
- 快速模型：`glm-4.5-air`

### 常见问题

**问题**：容器启动失败
- **解决方案**：确保 `.env` 文件存在且包含有效的 API 密钥

**问题**：API 认证错误
- **解决方案**：验证 API 密钥是否正确且有足够的额度

**问题**：权限错误
- **解决方案**：容器以 `claude` 用户（UID 1001）运行，确保工作空间可访问

**问题**：Claude Code 版本不匹配
- **解决方案**：在 `.env` 中设置 `AUTO_UPDATE_CLAUDE=true` 或通过 `CLAUDE_VERSION` 指定版本

### 贡献

欢迎贡献！添加新服务商支持的步骤：

1. 创建新目录：`claude-{provider}/`
2. 添加扩展 `claude-base` 的 `docker-compose.yml`
3. 创建 `setup-{provider}.sh` 脚本
4. 更新 `Dockerfile` 以复制设置脚本
5. 更新 `start.sh` 以包含新服务商

### 许可证

本项目按原样提供，用于教育和开发目的。

### 致谢

- [Claude Code](https://github.com/anthropics/claude-code) by Anthropic
- [月之暗面](https://www.moonshot.cn/) 提供 Kimi API
- [智谱 AI](https://z.ai/) 提供 GLM API
