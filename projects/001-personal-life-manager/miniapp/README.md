# 拾记小程序（miniapp）

拾记的小程序版本，使用 **uni-app（Vue 3 + TypeScript + Vite）** 开发。微信小程序首发，工程保留 `mp-toutiao` 与 H5 编译目标，便于后续扩展抖音等多平台。

- 设计基线：`archive/app-flutter/screenshots/01-首页.png` ~ `04-我的.png`
- 已完成：首页、分类、日程、我的 4 个 Tab，微信原生自定义 TabBar，未移植页面的统一占位页
- 详细移植说明：见 [PORTING.md](./PORTING.md)

## 环境要求

| 依赖 | 要求 |
|---|---|
| Node.js | **>= 22.12**（`@dcloudio/uni-cli-shared` 要求；本机使用 `D:/nvm/v22.20.0/npm.cmd`） |
| 微信开发者工具 | 预览与真机调试 |
| Python 3 | 仅资源生成脚本使用（Pillow、fonttools） |

> 本机在 Git Bash 下使用固定 Node 路径，避免默认 Node 版本过低导致构建失败。

## 常用命令

在 `miniapp/` 目录执行：

| 命令 | 作用 |
|---|---|
| `npm run dev:mp-weixin` | 微信小程序开发构建（watch，输出 `dist/dev/mp-weixin`） |
| `npm run build:mp-weixin` | 微信小程序生产构建（输出 `dist/build/mp-weixin`） |
| `npm run dev:h5` / `npm run build:h5` | H5 预览 / 构建，用于视觉比对 |
| `npm run dev:mp-toutiao` / `npm run build:mp-toutiao` | 抖音小程序构建目标（尚未验证） |
| `npm run type-check` | `vue-tsc` 类型检查 |
| `npm run icons` | 从 Flutter MaterialIcons 重新生成图标字体子集与 `icons.ts` |
| `npm run tabbar` | 重新生成微信原生 custom-tab-bar 的 WXSS（内嵌图标字体） |
| `npm run images` | 重新生成 WebP 背景图与缩略图资源 |

Git Bash 示例：

```bash
cd miniapp
"D:/nvm/v22.20.0/npm.cmd" run build:mp-weixin
```

## 微信小程序运行

1. **配置 AppID**：把真实微信小程序 AppID 填入 `src/manifest.json` 的 `mp-weixin.appid`。当前值为 `touristappid` 占位。
2. 构建：`npm run build:mp-weixin`。
3. 打开微信开发者工具，导入 `dist/build/mp-weixin`。
   也可使用 CLI：
   ```bash
   "D:/微信web开发者工具/cli.bat" open --project "<绝对路径>/dist/build/mp-weixin"
   ```

> ⚠️ 当前验证阻塞：本机开发者工具 CLI 对 `touristappid` 返回 `不存在此 AppID（code 10）`，需替换为真实 AppID 后才能完成开发者工具/真机验收。

## H5 预览（视觉验收）

```bash
npm run build:h5
python -m http.server 5317 --directory dist/build/h5
# 浏览器打开 http://127.0.0.1:5317/
```

H5 仅用于视觉比对。预览时自动模拟 44px 状态栏，便于与 `archive/app-flutter/screenshots` 对齐；真实小程序读取系统状态栏。

## 目录结构

```
miniapp/
├── src/
│   ├── App.vue                 # 全局页面样式
│   ├── pages.json              # 页面与 tabBar 配置（custom: true）
│   ├── manifest.json           # 平台配置（微信 appid 在此）
│   ├── uni.scss                # 设计令牌：色板、渐变、圆角、阴影、dp()
│   ├── pages/                  # home / category / schedule / profile / placeholder
│   ├── components/             # 15 个共享组件（玻璃卡片、图标、导航、记录行等）
│   ├── custom-tab-bar/         # 微信原生自定义 TabBar（js/wxml/wxss/json）
│   ├── utils/
│   │   ├── layout.ts           # 设计宽 426dp → rpx 换算
│   │   ├── nav.ts              # 状态栏、胶囊避让
│   │   ├── router.ts           # 4 Tab + 二级路由登记表
│   │   └── tabbar.ts           # 微信自定义 TabBar 高亮同步
│   └── static/images/          # WebP 背景图、头像、缩略图、logo
├── scripts/                    # 图标字体、图片、custom-tab-bar 生成脚本
└── dist/build/mp-weixin/       # 微信小程序生产产物
```

## 设计与实现约定

- **尺寸**：设计稿宽度 426dp；`dp(v) = v × 750 / 426 rpx`，样式统一通过 `uni.scss` 的 `dp()` 生成。
- **图标**：Material Icons 子集 144 个，WOFF2 12.1KB（base64 内嵌）。Flutter 的 codepoint 多数超出 BMP，`icons.ts` 必须用 `String.fromCodePoint(0x...)` 生成，禁止写成 `\uXXXX`（会被截断）。
- **图片**：4 个 Tab 背景使用 `设计图/*背景.png`，其余小图从归档 App 原图导出 WebP（852w、质量 78），`src/static/images` 约 281KB。
- **背景**：`bg_*.webp` 为整屏背景美术（含标题插画文字），4 个 Tab 使用设计图导出的背景层；H5 预览额外模拟 44px 状态栏，使布局与设计图基线一致。
- **微信 TabBar**：`tabBar.custom = true`，原生组件在 `src/custom-tab-bar/`；页面内 `glass-nav-bar` 仅在其他平台（`#ifndef MP-WEIXIN`）渲染。修改图标字体后需执行 `npm run tabbar` 同步 WXSS。
- **胶囊避让**：`getNavMetrics()` 在微信下通过 `wx.getMenuButtonBoundingClientRect()` 计算右侧预留宽度。

## 当前验证状态（2026-11-20）

| 项目 | 状态 |
|---|---|
| `npm run build:h5` | 通过 |
| `npm run build:mp-weixin` | 通过（产物约 704KB / 100+ 文件） |
| H5 375×812 四 Tab 与 `设计图/` 比对 | 通过（人工视觉逐页核对，截图与并排对照见 `screenshots/`） |
| 微信开发者工具 / 真机 | **未完成**，等待真实 AppID |
| 抖音小程序 | 未验证 |

## 已知差异与待办

- 仅完成 4 个 Tab 与占位页；搜索、设置、详情、保险箱等二级页面尚未移植（`utils/router.ts` 的 `PORTED` 为空）。
- 高级会员横幅按设计图保留；`PRODUCT_DESIGN.md` 中移除横幅、Tab 更名等提案尚未确认，未落地。
- H5 的 44px 状态栏为预览模拟值，真实小程序读取系统状态栏。
- 微信自定义 TabBar 尚未经过开发者工具实测，需在配置 AppID 后重点验证高亮同步、玻璃模糊降级和底部安全区。
- 4 个 Tab 的背景层与设计稿中的插画存在约 10px 级位置/缩放差（设计稿与独立导出的背景 PNG 不完全一致），需设计提供透明 hero/插画分层素材才能 100% 消除。
