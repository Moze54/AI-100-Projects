# 拾记 App → 小程序移植说明

本文记录 Flutter App 到 uni-app 小程序的还原口径、组件映射、当前进度和后续移植步骤。设计基线为归档工程的截图与源码：

- 截图：`archive/app-flutter/screenshots/01-首页.png` ~ `04-我的.png`
- 源码：`archive/app-flutter/lib/pages/*.dart`、`lib/theme.dart`
- 背景素材：`archive/app-flutter/assets/images/bg_*.png`

## 1. 尺寸与视觉口径

| 项目 | App（Flutter） | 小程序（uni-app） |
|---|---|---|
| 设计宽度 | 426dp | 426dp（`src/utils/layout.ts`） |
| 尺寸单位 | dp | `dp(v) = v × 750 / 426 rpx`（`uni.scss`） |
| 主色 | `#1B2D55` / `#4A87F8` | 同名 SCSS 变量 `$navy` / `$primary` |
| 卡片 | `GlassCard`（白玻璃 + 模糊 + 投影） | `<glass-card>` 组件 |
| 图标 | Material Icons | 144 个图标子集字体（`app-icon`） |
| 背景 | 整屏 `bg_*.png` | 同图转 WebP，`<bg-layer>` 铺满 |

**关键约定**：Flutter 的 Material codepoint 多数为 5 位（如 `0xf7f5`），JS 不能用 `\uXXXX` 表示；`src/components/app-icon/icons.ts` 由 `scripts/gen-icons.py` 以 `String.fromCodePoint()` 生成。

## 2. 组件映射

| Flutter | 小程序组件 | 说明 |
|---|---|---|
| `GlassCard` | `glass-card` | 圆角、内边距通过 `radius` / `pad` 传入 |
| `RoundGlassButton` | `glass-icon-btn` | 顶栏圆形按钮，支持红点 |
| `GradientIconBox` | `gradient-icon-box` | 渐变圆角图标底座 |
| `ChipIcon` | `chip-icon` | 今日卡片日期胶囊 |
| `SectionHeader` | `section-header` | 图标 + 标题 + 右侧“更多” |
| 记录行 | `record-tile` | 缩略图、标题、副标题、更多按钮 |
| `AddFab` | `add-fab` | 蓝色渐变悬浮按钮 |
| `GlassNavBar` | `glass-nav-bar` | H5/抖音等平台的自绘底栏 |
| AppBar 部分 | `page-header` | 首页/分类/日程顶栏 |
| 页面背景 | `bg-layer` | 整屏背景图 |
| 二级页骨架 | `sub-page-scaffold` / `sub-page-header` / `sub-page-bottom-bar` | 占位页与后续二级页复用 |
| 渐变胶囊按钮 | `gradient-pill-button` | 二级页主操作 |

## 3. 页面进度

| App 页面 | 小程序页面 | 状态 |
|---|---|---|
| 首页 | `pages/home/index` | 已还原 |
| 分类 | `pages/category/index` | 已还原 |
| 日程 | `pages/schedule/index` | 已还原 |
| 我的 | `pages/profile/index` | 已还原 |
| 其他 30 个二级页 | `pages/placeholder/index` | 统一占位，待逐页移植 |

4 个 Tab 以 `设计图/` 四张页面设计图为唯一视觉基线（归档 App 截图仅参考）。已还原内容包含：设计图背景层、玻璃卡片、渐变图标、统计卡/云空间环、周历选中态、时间线、纪念日/待办、功能宫格、会员横幅、设置列表、底部独立退出登录按钮、FAB、底部导航。

## 4. 平台差异

| 差异点 | 处理方式 |
|---|---|
| 状态栏 | 真实小程序读取 `statusBarHeight`；H5 模拟 44px 以便与设计图对齐 |
| 微信胶囊 | `getNavMetrics()` 通过 `wx.getMenuButtonBoundingClientRect()` 计算右侧避让 |
| 底部导航 | 微信使用原生 `custom-tab-bar`（`tabBar.custom = true`）；H5 等平台使用页面内 `glass-nav-bar`（`#ifndef MP-WEIXIN`） |
| TabBar 高亮 | 微信页面的 `onShow` 调用 `useTabBarActive(n)` → `getTabBar().setData({ active })` |
| 通知 | App 的本地通知在小程序改为订阅消息/云端推送（待业务接入） |
| 字体 | 使用系统字体；App 的自定义字体未强绑，避免包体增大 |

## 5. 如何移植一个新的二级页

1. 在 `src/pages/<name>/index.vue` 新建页面，优先复用 `sub-page-scaffold` 与现有组件。
2. 在 `src/pages.json` 的 `pages` 数组注册路径。
3. 在 `src/utils/router.ts` 的 `ROUTES` 中确认/新增 key，并把该 key 加入 `PORTED`。
4. 所有入口仍通过 `go(key, title)` 跳转；加入 `PORTED` 后自动从占位页切换为真实页面。
5. 4 个 Tab 按 `设计图/` 逐值还原；其余二级页按 `archive/app-flutter/lib/pages/<page>.dart` 还原；新增图标先加入 `scripts/gen-icons.py` 的 used 列表并运行 `npm run icons`。

## 6. 验证清单

- [x] `build:h5` 成功
- [x] `build:mp-weixin` 成功
- [x] H5 375×812 下 4 个 Tab 与 `设计图/` 逐页比对
- [x] 占位页、顶栏搜索/设置入口、返回交互
- [ ] 微信开发者工具打开 `dist/build/mp-weixin`（需真实 AppID）
- [ ] 微信真机：自定义 TabBar 高亮、安全区、玻璃模糊、iOS/Android 字体与滚动
- [ ] 抖音小程序适配与真机验证

## 7. 已知风险

- 微信 `custom-tab-bar` 为原生组件，未经过开发者工具实测；重点检查 `getTabBar()` 是否存在、四个 Tab 是否只有一个高亮、底部安全区是否重复叠加。
- `backdrop-filter` 在部分低端 Android WebView 不支持，已保留半透明白底作为降级。
- H5 预览的 44px 状态栏仅用于对齐设计图，不代表真实设备状态栏高度。
- `pages.json` 的 `tabBar.custom` 为跨平台共享配置，抖音端的自定义 TabBar 机制不同，扩展抖音时需单独适配。
- 4 个 Tab 的背景层与设计稿中的插画存在约 10px 级位置/缩放差（设计稿与独立导出的背景 PNG 不完全一致），需设计提供透明 hero/插画分层素材。
