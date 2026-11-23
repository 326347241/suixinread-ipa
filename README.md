# 随心所阅 · Flutter 源码工程

基于 `随心所阅-3.1.520.ipa`（Bundle ID `com.niki.xxread`）逆向分析还原的 iOS 阅读器 UI 高保真复刻工程。

## 说明

本工程是**界面与交互的高保真还原**，包含：

- 底部四 Tab 导航（首页 / 书库 / 发现 / 我的）+ 悬浮 AI 胶囊
- 阅读器：正文排版、字号/行距调节、5 套纸张、12 种翻页动效、目录抽屉
- AI 对话页：13 家模型切换、对话气泡、推荐卡片
- 完整数据模型与 8 套主题配色（逆向自 IPA 内 `assets/skins`）

不含原 App 的书源引擎、云同步、支付等后端服务逻辑。

## 🚀 免 Mac 构建 IPA（推荐）

工程已内置 GitHub Actions 配置（`.github/workflows/build-ipa.yml`），可用 GitHub 免费提供的 macOS 云主机自动构建 IPA，**无需自己的 Mac**。

1. 在 GitHub 新建一个仓库（公开或私有均可），把本 `flutter_app` 目录的内容推送上去：
   ```bash
   cd flutter_app
   git init
   git add .
   git commit -m "init"
   git remote add origin https://github.com/你的用户名/你的仓库.git
   git push -u origin main
   ```
2. 打开仓库的 **Actions** 标签页，等待 `Build iOS IPA` 工作流自动运行完成。
3. 进入该次运行记录，在页面底部 **Artifacts** 处下载 `随心所阅-3.1.520-ipa`（即 IPA 文件）。

> 说明：默认构建为**未签名 IPA**（`--no-codesign`），可用于验证安装（需通过 AltStore / Sideloadly / 巨魔等侧载，或用自己的 Apple 开发者证书重签）。若要用证书正式签名，在 workflow 的构建步骤中配置 P12 证书与描述文件即可。

## 在 Mac 上编译运行

> 当前交付环境为 Windows，无法生成可安装的 `.ipa`。以下步骤需在 **macOS + Xcode** 上完成。

### 1. 安装 Flutter SDK

```bash
# 使用 fvm 或官方方式安装 Flutter 3.2+
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:$(pwd)/flutter/bin"
flutter doctor    # 确认 Xcode / CocoaPods 全部通过
```

### 2. 生成 iOS 原生工程脚手架

本仓库的 `lib/` Dart 源码是完整的，但 `ios/Runner.xcodeproj` 需要用 Flutter 工具生成（无法手工编写）。在项目根目录执行：

```bash
flutter create --platforms=ios .
```

这会自动补齐 `ios/Runner.xcodeproj`、`Podfile`、AppDelegate 等文件，并保留现有的 `lib/` 与 `ios/Runner/Info.plist`。

### 3. 安装依赖并运行

```bash
flutter pub get
open ios/Runner.xcworkspace    # 在 Xcode 中配置签名
flutter run                     # 或直接在 Xcode 中 Run
```

### 4. 打包 IPA

```bash
flutter build ipa --release
# 产物位于 build/ios/ipa/
```

## 目录结构

```
lib/
├── main.dart                 # 应用入口
├── theme/app_theme.dart      # 主题配色 / 8 套皮肤 / 翻页动效
├── models/book.dart          # 数据模型
├── data/mock_data.dart       # 书籍 / 章节 / AI 模型数据
├── widgets/common.dart       # 通用组件
└── screens/
    ├── main_shell.dart       # 主框架（Tab + 悬浮胶囊）
    ├── home_screen.dart      # 首页
    ├── library_screen.dart   # 书库
    ├── discover_screen.dart  # 发现
    ├── ai_screen.dart        # AI 对话
    ├── profile_screen.dart   # 我的
    └── reader_screen.dart    # 阅读器（核心）
assets/
├── images/                   # App 图标 / 启动图（提取自 IPA）
└── Backgrounds/              # 8 套主题背景（提取自 IPA）
```

## 与高保真原型的关系

同目录下的 `prototype/index.html` 是纯 Web 实现的可交互原型，与 Flutter 工程的页面结构、配色、数据一一对应。可先在浏览器中确认效果，再对照实现原生版本。
