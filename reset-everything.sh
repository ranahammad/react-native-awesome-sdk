#!/bin/bash
set -e

echo "============================"
echo " 🔄 React Native Full Reset Script"
echo "============================"

# Clean JS deps
echo "🧹 Cleaning node_modules, Yarn cache, and lockfiles..."
rm -rf node_modules example/node_modules .yarn/cache yarn.lock example/yarn.lock

# Clean iOS deps
echo "🧹 Cleaning iOS Pods and build artifacts..."
rm -rf example/ios/Pods example/ios/Podfile.lock example/ios/build

# Clean Android deps
echo "🧹 Cleaning Android builds..."
rm -rf example/android/.gradle example/android/build example/android/app/build

# Clean Metro/Watchman cache
echo "🧹 Cleaning Metro cache and Watchman..."
watchman watch-del-all || true
rm -rf $TMPDIR/metro-cache $TMPDIR/react-native-packager-cache-*

# Clean Xcode DerivedData
echo "🧹 Cleaning Xcode DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData
cd example/ios
xcodebuild clean
cd ../..

# Reinstall JS deps
echo "📦 Reinstalling dependencies with Yarn..."
yarn install

# Reinstall Pods
echo "📦 Installing CocoaPods..."
cd example/ios
pod install --repo-update
cd ../..

# Verify iOS linking
echo "🔍 Verifying iOS SDK linking..."
if grep -q "react-native-awesome-sdk" example/ios/Podfile.lock; then
  echo "✅ Found react-native-awesome-sdk in Podfile.lock (iOS linking OK)"
else
  echo "❌ react-native-awesome-sdk not found in Podfile.lock!"
  echo "   👉 Make sure your Podfile has: pod 'react-native-awesome-sdk', :path => '../..'"
fi

# Verify Android linking
echo "🔍 Verifying Android SDK linking..."
if grep -q "react-native-awesome-sdk" example/android/settings.gradle && grep -q "react-native-awesome-sdk" example/android/app/build.gradle; then
  echo "✅ Found react-native-awesome-sdk in Android Gradle files (Android linking OK)"
else
  echo "❌ react-native-awesome-sdk not found in Android Gradle files!"
  echo "   👉 Check example/android/settings.gradle and app/build.gradle for proper linking"
fi

echo ""
echo "🚀 Full reset complete!"
echo "👉 In one terminal: cd example && yarn start --reset-cache"
echo "👉 In another: cd example && yarn ios   (or yarn android)"
echo "============================"
