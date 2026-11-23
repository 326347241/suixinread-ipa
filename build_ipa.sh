#!/bin/bash
# 随心所阅 · 一键编译 IPA 脚本
# 在 macOS 上运行（本机或 GitHub Actions 云主机均可）
set -e

cd "$(dirname "$0")"

echo "=========================================="
echo " 随心所阅 3.1.520 · IPA 构建脚本"
echo "=========================================="

# 1. 环境检查
if [[ "$(uname)" != "Darwin" ]]; then
  echo "❌ 错误：此脚本必须在 macOS 上运行（当前: $(uname)）"
  echo "   iOS 应用只能由 macOS + Xcode 编译，这是 Apple 的限制。"
  exit 1
fi
if ! command -v flutter >/dev/null 2>&1; then
  echo "❌ 错误：未找到 Flutter，请先安装 Flutter SDK 并加入 PATH"
  exit 1
fi
echo "✅ 环境检查通过：$(sw_vers -productName) $(sw_vers -productVersion)"

# 2. 生成干净的 iOS 工程脚手架（避免覆盖源码）
echo "📦 生成 iOS 工程脚手架..."
rm -rf buildios
flutter create --platforms=ios --org com.niki --project-name suixin_read buildios

# 3. 注入本项目源码与资源
cp -R lib/. buildios/lib/
mkdir -p buildios/assets
cp -R assets/. buildios/assets/
cp pubspec.yaml buildios/pubspec.yaml
cp ios/Runner/Info.plist buildios/ios/Runner/Info.plist
echo "✅ 源码注入完成"

# 4. 安装依赖
echo "📥 安装依赖..."
cd buildios
flutter pub get
cd ios && pod install --repo-update && cd ..

# 5. 编译 IPA
echo "🔨 编译 Release IPA（无签名）..."
flutter build ipa --release --no-codesign

echo "=========================================="
echo "✅ 构建完成！IPA 文件位置："
ls -lh build/ios/ipa/*.ipa
echo "=========================================="
