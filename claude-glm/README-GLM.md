# glm-4.6 配置说明

## 环境变量配置

请在 `claude-z` 目录下创建 `.env` 文件，内容如下：

```bash
# Z.AI glm-4.6 配置
ZAI_API_KEY=你的_ZAI_API_KEY
```

## 使用步骤

1. **获取 Z.AI API Key**
   - 登录 Z.AI 后台 (https://z.ai)
   - 生成 API Key

2. **订阅 GLM Coding Plan**
   - 确保已订阅 GLM Coding Plan (Lite/Pro 都行)
   - 这是专供 Claude Code 等编码工具使用的计划

3. **配置环境变量**
   - 将 `.env` 文件中的 `你的_ZAI_API_KEY` 替换为实际的 API Key

4. **启动服务**
   ```bash
   cd claude-z
   docker-compose up --build
   ```

## 验证配置

启动后，在 Claude Code 终端中输入 `/status` 查看当前模型配置，应该显示：
- 主模型: glm-4.6
- 快速模型: glm-4.6-air

## 模型切换（可选）

如需临时切换到 Air 版本，可修改 `claude-data/settings.json` 中的 `ANTHROPIC_MODEL` 为 `glm-4.6-air`。


