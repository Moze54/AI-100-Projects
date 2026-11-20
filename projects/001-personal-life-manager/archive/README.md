# 归档区

本目录保存已停止开发的历史工程，仅作参考与追溯，不参与当前产品迭代。

## app-flutter：拾记 Flutter Android 工程（已冻结）

- 归档日期：2026-11-20
- 归档原因：产品形态调整为小程序（微信首发，后续抖音等多平台），Flutter App 版本不再继续开发
- 工程状态：静态 UI 阶段，共 35 个页面，无数据层与网络层
- 保留内容：`lib/`（Dart 源码）、`android/`（Android 工程）、`assets/images/`（设计素材原图）、`screenshots/`（35 张实机截图）、`test/`、`pubspec.*`、`dist/`（最后一版 APK 与预览图）
- 已清理：`build/`、`.dart_tool/`、`.idea/`、`android/.gradle` 等构建产物

### 运行方式（仅供追溯，需 Flutter 3.50 环境）

```bash
cd app-flutter
flutter pub get
flutter run          # 连接 Android 设备或模拟器
flutter build apk    # 产物输出到 build/
```

### 与当前工程的关系

- 视觉基准：`screenshots/01-首页.png` 至 `04-我的.png` 是小程序 4 Tab 的还原对照依据
- 设计素材：`assets/images/` 是 `miniapp/src/static/images/` 的原始来源
- 交互参考：所有页面结构与间距以 `lib/` 源码为准

当前开发工程见仓库根目录 `miniapp/`。
